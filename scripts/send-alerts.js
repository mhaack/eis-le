/**
 * Reads the changes file written by weekly-update.js and sends an email
 * via Resend if anything meaningful changed.
 *
 * Run: node scripts/send-alerts.js
 */

import { readFileSync, existsSync } from 'fs';
import { Resend } from 'resend';

const CHANGES_FILE = '/tmp/eisleipzig-changes.json';
const ALERT_EMAIL = process.env.ALERT_EMAIL;
const FROM_EMAIL = 'updates@eisleipzig.de';

if (!ALERT_EMAIL) {
  throw new Error('Missing ALERT_EMAIL environment variable');
}

const resend = new Resend(process.env.RESEND_API_KEY);

function formatChange(c) {
  if (c.field === 'new_shop') {
    return `<li>Neues Eiscafe entdeckt: <b>${c.shop}</b> (als Entwurf angelegt)</li>`;
  }
  if (c.field === 'business_status') {
    return `<li><b>${c.shop}</b>: Geschaeftsstatus geandert → ${c.new}</li>`;
  }
  if (c.field === 'opening_hours') {
    return `<li><b>${c.shop}</b>: Offnungszeiten wurden aktualisiert</li>`;
  }
  return `<li><b>${c.shop}</b>: ${c.field} — ${c.old} → ${c.new}</li>`;
}

async function run() {
  if (!existsSync(CHANGES_FILE)) {
    console.log('No changes file found, nothing to send.');
    return;
  }

  const changes = JSON.parse(readFileSync(CHANGES_FILE, 'utf8'));

  if (changes.length === 0) {
    console.log('No changes detected, skipping email.');
    return;
  }

  const subject = `${changes.length} Anderung${changes.length === 1 ? '' : 'en'} bei Leipziger Eisdielen`;

  const html = `
    <h2>Wochentliches Eisdielen-Update</h2>
    <p>${changes.length} Anderung${changes.length === 1 ? '' : 'en'} entdeckt:</p>
    <ul>
      ${changes.map(formatChange).join('\n      ')}
    </ul>
    <p><small>Automatisch generiert von der eisleipzig.de Pipeline</small></p>
  `;

  const { error } = await resend.emails.send({
    from: FROM_EMAIL,
    to: ALERT_EMAIL,
    subject,
    html,
  });

  if (error) {
    console.error('Failed to send email:', error);
    process.exit(1);
  } else {
    console.log(`Alert sent to ${ALERT_EMAIL} (${changes.length} changes)`);
  }
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});
