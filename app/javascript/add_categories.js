document.addEventListener("turbolinks:load", function() {

    function toggleNewCategoryField() {
        const selectedText = $('#category_selector option:selected').text();

        if (selectedText === 'その他') {
            $('#new-categories').css('display', 'block');
        } else {
            $('#new-categories').css('display', 'none');
        }
    }

    toggleNewCategoryField();

    $('#category_selector').on('change', toggleNewCategoryField);
});
