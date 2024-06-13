$(document).ready(function(){
  let first_url = $('input').filter('#good_habit_url');
  $(first_url).after('<input placeholder="例)https://www.youtube.com/" type="text" name="good_habit[url]" id="good_habit_url">')
});
