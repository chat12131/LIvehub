document.addEventListener('turbolinks:load', () => {
  flatpickr('.timepicker', {
    noCalendar: true,
    enableTime: true,
    dateFormat: 'H:i',
    disableMobile: true,
    'locale': 'ja'
  });
});
