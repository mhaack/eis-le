import { readFileSync, existsSync } from 'node:fs';
import { createServer } from 'node:http';
import { resolve, extname } from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = fileURLToPath(new URL('.', import.meta.url));

// Load env from project root .env
const envPath = resolve(__dirname, '..', '.env');
if (!existsSync(envPath)) {
  console.error('Missing .env file at project root');
  process.exit(1);
}
const env = Object.fromEntries(
  readFileSync(envPath, 'utf8')
    .split('\n')
    .filter(l => l && !l.startsWith('#'))
    .map(l => { const i = l.indexOf('='); return [l.slice(0, i), l.slice(i + 1)]; })
);

const SUPABASE_URL = env.SUPABASE_URL;
const SUPABASE_KEY = env.SUPABASE_SERVICE_KEY;

if (!SUPABASE_URL || !SUPABASE_KEY) {
  console.error('Missing SUPABASE_URL or SUPABASE_SERVICE_KEY in .env');
  process.exit(1);
}

const MIME = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
};

const PORT = parseInt(process.argv[2] || '8080', 10);

createServer(async (req, res) => {
  // CORS (not needed for same-origin, but just in case)
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', '*');
  res.setHeader('Access-Control-Allow-Methods', '*');
  if (req.method === 'OPTIONS') { res.writeHead(204); res.end(); return; }

  // API proxy: /api/* → Supabase REST API
  if (req.url.startsWith('/api/')) {
    const supaPath = req.url.slice(4); // strip /api prefix
    const targetUrl = `${SUPABASE_URL}/rest/v1${supaPath}`;

    // Collect body
    const chunks = [];
    for await (const chunk of req) chunks.push(chunk);
    const body = Buffer.concat(chunks);

    // Forward headers, inject auth
    const headers = {
      'apikey': SUPABASE_KEY,
      'Authorization': `Bearer ${SUPABASE_KEY}`,
      'Content-Type': 'application/json',
      'Prefer': req.headers['prefer'] || '',
    };

    // Forward Accept and Range headers for Supabase queries
    if (req.headers['accept']) headers['Accept'] = req.headers['accept'];
    if (req.headers['range']) headers['Range'] = req.headers['range'];

    try {
      const upstream = await fetch(targetUrl, {
        method: req.method,
        headers,
        body: ['GET', 'HEAD'].includes(req.method) ? undefined : body,
      });

      // Forward response headers
      const contentType = upstream.headers.get('content-type') || 'application/json';
      const contentRange = upstream.headers.get('content-range');
      res.setHeader('Content-Type', contentType);
      if (contentRange) res.setHeader('Content-Range', contentRange);

      res.writeHead(upstream.status);
      const respBody = await upstream.text();
      res.end(respBody);
    } catch (err) {
      res.writeHead(502, { 'Content-Type': 'application/json' });
      res.end(JSON.stringify({ error: err.message }));
    }
    return;
  }

  // Static files
  let filePath = req.url === '/' ? '/index.html' : req.url;
  filePath = resolve(__dirname, '.' + filePath);

  // Security: don't serve files outside admin/
  if (!filePath.startsWith(__dirname)) {
    res.writeHead(403); res.end('Forbidden'); return;
  }

  try {
    const content = readFileSync(filePath);
    const mime = MIME[extname(filePath)] || 'application/octet-stream';
    res.writeHead(200, { 'Content-Type': mime });
    res.end(content);
  } catch {
    res.writeHead(404);
    res.end('Not found');
  }
}).listen(PORT, () => {
  console.log(`\n  eisleipzig Admin running at http://localhost:${PORT}\n`);
});
