'use strict';

// Preserve the existing Cloud Resume Challenge counter and Lambda endpoint.
const counter = document.querySelector('.counter-number');
async function updateCounter() {
  if (!counter) return;
  try {
    const response = await fetch(
      'https://bujk7hizyolll7qscxgtjcodpy0qzhzx.lambda-url.eu-west-1.on.aws/',
      { signal: AbortSignal.timeout(8000) }
    );
    if (!response.ok) throw new Error('Counter request failed');
    const data = await response.json();
    const count = typeof data === 'number' ? data : (/^\d+$/.test(data) ? Number(data) : NaN);
    if (!Number.isSafeInteger(count) || count < 0) throw new Error('Invalid count');
    counter.textContent = `Page views: ${count.toLocaleString('en-GB')}`;
  } catch {
    counter.textContent = 'Page views unavailable';
  }
}
updateCounter();

// Core CV content is always visible. These controls affect only native details.
const controls = document.querySelector('.detail-controls');
if (controls) {
  controls.hidden = false;
  for (const [id, open] of [['expand-all', true], ['collapse-all', false]]) {
    document.getElementById(id).addEventListener('click', () => {
      document.querySelectorAll('main details').forEach(detail => { detail.open = open; });
    });
  }
}
