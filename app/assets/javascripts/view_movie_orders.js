$(document).ready(function() {
  $('.orders-for-movie').hide()

  $('.view-orders-btn').click(function(){
     $(this).next('.orders-for-movie').show();
  });
})