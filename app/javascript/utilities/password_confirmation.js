document.addEventListener('turbolinks:load', function() {
  var confirm = document.querySelector('.confirmation')

  if (confirm) {
    confirm.addEventListener('input', function () {
      var password = document.getElementById("user_password").value;
      var confirmation = document.getElementById("user_password_confirmation").value;

      if (password == confirmation) {
        document.querySelector('.octicon-check').classList.remove('not-confirmed');
        document.querySelector('.octicon-check').classList.add('confirmed');
      }
    });
  }
})



