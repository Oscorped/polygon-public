// Витрина v1 — рабочая версия. Заявки живут в браузере (localStorage).
const SLOTS = ['Пн 10:00', 'Пн 15:30', 'Вт 11:00', 'Ср 09:30', 'Чт 16:00', 'Пт 12:30'];
const STORE_KEY = 'vitrina-bookings';

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
    btn.className = 'slot' + (slot === chosen ? ' selected' : '');
    btn.textContent = slot;
    if (taken.has(slot)) {
      btn.disabled = true; // занятое окно выбрать нельзя
    } else {
      btn.addEventListener('click', function () {
        chosen = slot;
        renderSlots();
      });
    }
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
    note.textContent = 'Выберите свободное окно.';
    return;
  }
  const bookings = readBookings();
  bookings.push({ name: name, slot: chosen });
  localStorage.setItem(STORE_KEY, JSON.stringify(bookings));
  note.className = 'confirmation';
  note.textContent = name + ', вы записаны: ' + chosen + '. Ждём вас!';
  chosen = null;
  renderSlots();
});

renderSlots();
