$(document).ready(function(){
  
  $('#btn_read_more').click(function () {
    $('#dots').hide();
    $('#more_text').css('display', 'inline');
    $('#btn_read_more').css('display', 'none');
    $('#hide_read_more').css('display', 'inline-block');
    $('#short_text').css('display', 'none');
  });

  $('#hide_read_more').click(function (){
    $('#dots').show();
    $('#btn_read_more').css('display', 'inline-block');
    $('#hide_read_more').css('display', 'none');
    $('#more_text').css('display', 'none');
    $('#short_text').css('display', 'inline');
  });
  
  // $('#minus').click(function(e){
  //   var current_value = $('.input-count-book').val();
  //   if (current_value > 1) {
  //     var new_value = Number(current_value) - 1;
  //     $('.input-count-book').val(new_value);
  //   }
  // })

  // $('#plus').click(function(e){
  //   var current_value = $('.input-count-book').val();
  //   if (current_value < gon.bookQuantity) {
  //     var new_value = Number(current_value) + 1;
  //     $('.input-count-book').val(new_value);
  //   }
  // })  

})
