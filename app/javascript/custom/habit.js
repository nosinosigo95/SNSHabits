document.addEventListener("turbolinks:load", function() {
  $('.button-link').click(function(event){
    event.preventDefault();
  });
  $('.button-addition').click('turbolinks:click', function(event){
    event.preventDefault();
  });
  $('.button-removal').click('turbolinks:click', function(event){
    event.preventDefault();
  });
  $('.button-addition').click('turbolinks:click' , function(){
    $('.hidden-url-input-parts').first().addClass('displayed-url-input-parts');
    $('.hidden-url-input-parts').first().removeClass('hidden-url-input-parts');
    $('.hidden-button').first().removeClass('hidden-button');
  });
  $('.button-removal').click('turbolinks:click', function(){
    let index = $('.button-removal').index(this);
    $('.inline-block-input-parts').eq(index).val('');
    $('.inline-block-input-parts').eq(index).addClass('hidden-url-input-parts');
    $('.inline-block-input-parts').eq(index).removeClass('displayed-url-input-parts');
    $('.button-removal').eq(index).addClass('hidden-button');
  });

  $('.related-habits .card').hide();
  $('.related-habits .card').first().show();
});

