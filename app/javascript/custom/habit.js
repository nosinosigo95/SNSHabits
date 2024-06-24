$(document).ready(function(){
  $('.button-link').click(function(event){
    event.preventDefault();
  });
  $('.button-addition').click("turbo:load", function(){
    $('.hidden-url-input-parts').first().addClass('displayed-url-input-parts');
    $('.hidden-url-input-parts').first().removeClass('hidden-url-input-parts');
    $('.hidden-button').first().removeClass('hidden-button');
  });
  $('.button-removal').click("turbo:load", function(){
    let index = $('.button-removal').index(this);
    $('.inline-block-input-parts').eq(index).val('');
    $('.inline-block-input-parts').eq(index).addClass('hidden-url-input-parts');
    $('.inline-block-input-parts').eq(index).removeClass('displayed-url-input-parts');
    $('.button-removal').eq(index).addClass('hidden-button');
  });
  $('.left-arrow').click("turbo:load",function(event){
    event.preventDefault();
  });
  $('.right-arrow').click("turbo:load", function(event){
    event.preventDefault();
  });

  $('.related-habits .card').hide();
  $('.related-habits .card').first().show();
});
