document.addEventListener('DOMContentLoaded', function() {
  var inputFile = document.querySelector('.custom-file-input');
  if (inputFile) {
    inputFile.addEventListener('change', function(e) {
      var fileName = e.target.files[0].name;
      var nextSibling = e.target.nextElementSibling;
      nextSibling.innerText = fileName;
    });
  }
});
