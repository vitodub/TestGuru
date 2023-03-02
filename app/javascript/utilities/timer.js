$(document).ready(function(){

  var time_left = $("#timer").data("time_left")
  
  function countDown() {   
    minutes = Math.floor(time_left / 60)
    seconds = Math.floor(time_left % 60)
    $("#timer").html("You have left " + minutes + "m " + seconds + "s ")
    time_left--

    if (time_left < 0) {
      window.location.href = $("#timer").data("result_path")
    }
  }

  if (time_left) {setInterval(countDown, 1000)}
});

