// Витрина v2 — «обновлённая» версия для приёмки.
const SLOTS = ['Пн 10:00', 'Пн 15:30', 'Вт 11:00', 'Ср 09:30', 'Чт 16:00', 'Пт 12:30'];
const STORE_KEY = 'vitrina-v2-bookings';

let chosen = null;

function readBookings() {
  try {
    return JSON.parse(localStorage.getItem(STORE_KEY)) || [];
  } catch (e) {
    return [];
  }
}

function takenSlots() {
  return new Set(readBookings().map(function (b) { return b.slot; }));
}

function renderSlots() {
  const taken = takenSlots();
  const box = document.getElementById('slots');
  box.innerHTML = '';
  SLOTS.forEach(function (slot) {
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.className = 'slot'
      + (slot === chosen ? ' selected' : '')
      + (taken.has(slot) ? ' taken' : '');
    btn.textContent = slot;
    btn.addEventListener('click', function () {
      chosen = slot;
      renderSlots();
    });
    box.appendChild(btn);
  });
}

document.getElementById('booking-form').addEventListener('submit', function (e) {
  e.preventDefault();
  const name = document.getElementById('name').value.trim();
  const note = document.getElementById('confirmation');
  note.hidden = false;
  if (!name) {
    note.className = 'confirmation error';
    note.textContent = 'Напишите, как к вам обращаться — без имени заявка не уйдёт.';
    return;
  }
  if (!chosen) {
    note.className = 'confirmation error';
    note.textContent = 'Выберите окно.';
    return;
  }
  const bookings = readBookings();
  bookings.push({ name: name, slot: chosen });
  localStorage.setItem(STORE_KEY, JSON.stringify(bookings));
  note.className = 'confirmation';
  note.textContent = 'Спасибо! Мы получили вашу заявку.';
  chosen = null;
  renderSlots();
});

renderSlots();
