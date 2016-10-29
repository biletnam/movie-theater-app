$(document).ready(function() {
  $(".well").on("click", ".view-orders-btn", function() {
    $(this).closest('.well').find('.orders-for-movie').fadeToggle();
  });
})