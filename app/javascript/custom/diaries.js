$(document).ready(function(){
  $('#consult-button').on('click', function(){
    $.ajax({
      url: './chat.json',
      type: 'POST',
      data:{
        input: $('#consult-content').val()
      },
      dataType: 'json'
    })
    .done((data) => {
      let data_stringify = JSON.stringify(data);
      let data_json = JSON.parse(data_stringify);
      let answer_for_consult = data_json["response"];
      $('#result-for-consult').text(answer_for_consult);
    })
    .fail((data) => {
      $('#result-for-consult').text("もう一度相談し直してください。");
    });
  });
});
