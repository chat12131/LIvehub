document.addEventListener("turbolinks:load", function() {
    $('#category_selector').on('change', function() {
        const selectedText = $('#category_selector option:selected').text();
        console.log('Selected:', selectedText);

        if (selectedText === 'その他') {
            $('#new-categories').css('display', 'block ');
        } else {
            $('#new-categories').css('display', 'none');
        }
    });
});
