

$(document).ready(function() {
  AOS.init( {
      
  }); 
});

// mouse event that allows for smooth scrolling
$('a.smooth-scroll')
.click(function(event) {
 
  if (
    location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
    && 
    location.hostname == this.hostname
  ) {

    // Figure out element to scroll to; figured from stackoverflow
    var goal = $(this.hash);
    goal = goal.length ? goal : $('[name=' + this.hash.slice(1) + ']');


    // Does it exist?
    if (goal.length) {

      // Allows an event animation to occur
      event.preventDefault();
      $('html, body').animate({
        scrollTop: goal.offset().top
      }, 1000, function() {
        //Want to reset the animation


        // Changing the focus
        //Causing a form event
        var $goal = $(goal);
        $goal.focus();
        if ($goal.is(":focus")) { // Checking if the goal was focused
          return false;
        } else {
          $goal.focus(); // Set focus again
        };
      });
    }
  }
});
