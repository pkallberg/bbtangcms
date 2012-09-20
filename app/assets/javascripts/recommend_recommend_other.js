$(function($) {
  $("#recommend_recommend_other_recommend_other_type").live("change",function() {
    $.ajax({url: '/recommend/recommend_others/update_field',
    data : {
      recommend_other_type : this.value,
      recommend_other_id : $("#recommend_recommend_other_id").val()
    },
    dataType: 'script'})

  });
});
