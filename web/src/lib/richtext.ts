import { FilterXSS } from 'xss';

// Tags the admin rich text editor (Quill) produces, plus legacy inline variants.
// xss is used instead of sanitize-html because it has no Node built-in deps —
// the Cloudflare prerender worker can't resolve `path`/`fs`.
const sanitizer = new FilterXSS({
  whiteList: {
    h2: [], h3: [], p: [], br: [],
    strong: [], em: [], u: [], b: [], i: [],
    ul: [], ol: [], li: [],
  },
  stripIgnoreTag: true,
  stripIgnoreTagBody: ['script', 'style'],
});

const HTML_TAG_RE = /<\/?[a-z][^>]*>/i;

function escapeHtml(text: string): string {
  return text
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

/**
 * Renders editorial rich text fields (e.g. our_review) to safe HTML.
 * HTML input is sanitized against a tag allowlist; plain text is escaped,
 * with blank lines becoming paragraphs and single newlines becoming <br>.
 */
export function renderRichText(text: string | null | undefined): string {
  if (!text) return '';
  if (HTML_TAG_RE.test(text)) {
    return sanitizer.process(text);
  }
  return text
    .split(/\n{2,}/)
    .map((block) => block.trim())
    .filter((block) => block.length > 0)
    .map((block) => `<p>${escapeHtml(block).replace(/\n/g, '<br>')}</p>`)
    .join('');
}
