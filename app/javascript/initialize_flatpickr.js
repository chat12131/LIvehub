document.addEventListener("turbolinks:load", () => {
  flatpickr("[class='flatpickr']", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    disableMobile: true,
    'locale': 'ja'
  });
});
