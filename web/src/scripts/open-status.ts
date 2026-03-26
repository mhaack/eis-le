interface Period {
  open: { day: number; hour: number; minute?: number };
  close?: { day: number; hour: number; minute?: number };
}

export function isOpenNow(periods: Period[]): boolean {
  if (!Array.isArray(periods) || periods.length === 0) return false;
  const now = new Date();
  const berlin = new Date(now.toLocaleString('en-US', { timeZone: 'Europe/Berlin' }));
  const day = berlin.getDay();
  const mins = berlin.getHours() * 60 + berlin.getMinutes();

  return periods.some(p => {
    const openDay = p.open.day;
    const openMins = p.open.hour * 60 + (p.open.minute ?? 0);
    if (!p.close) return openDay === day;
    const closeDay = p.close.day;
    const closeMins = p.close.hour * 60 + (p.close.minute ?? 0);
    if (openDay === closeDay) {
      return day === openDay && mins >= openMins && mins < closeMins;
    }
    // wraps past midnight
    return (day === openDay && mins >= openMins) || (day === closeDay && mins < closeMins);
  });
}

export function renderAllOpenStatusPills(): void {
  document.querySelectorAll<HTMLElement>('[data-open-status]').forEach(el => {
    const periodsAttr = el.dataset.periods;
    if (!periodsAttr) return;
    try {
      const periods: Period[] = JSON.parse(periodsAttr);
      const open = isOpenNow(periods);
      el.textContent = open ? 'Geöffnet' : 'Geschlossen';
      el.classList.remove('hidden');
      if (open) {
        el.classList.add('bg-pistachio-bg', 'text-pistachio');
        el.classList.remove('bg-strawberry-bg', 'text-strawberry');
      } else {
        el.classList.add('bg-strawberry-bg', 'text-strawberry');
        el.classList.remove('bg-pistachio-bg', 'text-pistachio');
      }
    } catch {
      // Invalid JSON or missing data — leave hidden
    }
  });
}
