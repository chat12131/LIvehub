document.addEventListener('turbolinks:load', function() {
  const editables = document.querySelectorAll('.editable-member');

  editables.forEach(editable => {
    const nameElem = editable.querySelector('.member-name');
    const editField = editable.querySelector('.member-edit-field');
    const deleteBtn = editable.querySelector('.member-delete');

    nameElem.addEventListener('click', function() {
      nameElem.classList.add('d-none');
      editField.classList.remove('d-none');
      deleteBtn.classList.remove('d-none');
      editField.focus();
    });

    editField.addEventListener('blur', function() {
      const memberId = editable.getAttribute('data-id');
      const newValue = editField.value;

      fetch(`/members/${memberId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify({
          member: {
            name: newValue
          }
        })
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          nameElem.textContent = newValue;
          nameElem.classList.remove('d-none');
          editField.classList.add('d-none');
          deleteBtn.classList.add('d-none');
        }
      });
    });

    deleteBtn.addEventListener('click', function() {
      const memberId = editable.getAttribute('data-id');

      fetch(`/members/${memberId}`, {
        method: 'DELETE',
        headers: {
          'Accept': 'application/json'
        }
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          editable.remove();
        }
      });
    });
  });
});
