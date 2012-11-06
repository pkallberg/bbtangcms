$(function($) {
  $("#question_identity_list").change(function() {
    $.ajax({url: '/questions/update_timelines',
    data: 'identity_id=' + this.value,
    dataType: 'script'})
  });
});
$(function($) {
  $("#question_timeline_list").change(function() {
    $.ajax({url: '/questions/update_categories',
    data: 'timeline_id=' + this.value,
    dataType: 'script'})
  });
}); 
