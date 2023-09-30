document.addEventListener('turbolinks:load', function() {
  const ticketStatusRadios = document.querySelectorAll('input[name="live_schedule[ticket_status]"]');
  const ticketSaleDateField = document.querySelector('input[name="live_schedule[ticket_sale_date]"]');
  const ticketPriceField = document.querySelector('input[name="live_schedule[ticket_price]"]');
  const drinkPriceField = document.querySelector('input[name="live_schedule[drink_price]"]');

  function updateFormFields() {
    if (!ticketSaleDateField || !ticketPriceField || !drinkPriceField) {
      return;
    }

    let selectedValue;
    ticketStatusRadios.forEach(radio => {
      if (radio.checked) {
        selectedValue = radio.value;
      }
    });

    const visibleFields = [];

    if (selectedValue === "未購入") {
      ticketSaleDateField.parentElement.style.display = 'block';
      visibleFields.push(ticketSaleDateField.parentElement);
    } else {
      ticketSaleDateField.parentElement.style.display = 'none';
    }

    if (selectedValue === "チケットレス") {
      ticketPriceField.parentElement.style.display = 'none';
    } else {
      ticketPriceField.parentElement.style.display = 'block';
      visibleFields.push(ticketPriceField.parentElement);
    }

    visibleFields.push(drinkPriceField.parentElement);


    if (visibleFields.length === 1) {
      visibleFields[0].classList.remove('col-md-4');
      visibleFields[0].classList.add('col-md-6', 'mx-auto');
    } else if (visibleFields.length === 2) {
      visibleFields.forEach(field => {
          field.classList.remove('col-md-4', 'mx-auto');
          field.classList.add('col-md-6');
      });
    } else {
      visibleFields.forEach(field => {
          field.classList.remove('col-md-6', 'mx-auto');
          field.classList.add('col-md-4');
      });
    }

    flatpickr("[class='flatpickr']", {
      enableTime: true,
      dateFormat: "Y-m-d H:i",
      disableMobile: true,
      'locale': 'ja'
    });
  }

  ticketStatusRadios.forEach(radio => {
    radio.addEventListener('change', updateFormFields);
  });

  const ticketStatusSpans = document.querySelectorAll('.btn-radio');
  ticketStatusSpans.forEach(span => {
    span.addEventListener('click', function() {
      const radio = span.querySelector('input[type="radio"]');
      radio.click();
    });
  });

  updateFormFields();
});
