jQuery(document).ready(function($){
    jQuery('#flashes').find(jQuery('.close')).click(function(){
    /*$("#flashes").hide()*/
    jQuery("#flashes").remove();
  });
});

$(document).ready(function(){
  window.setInterval('GetData()', 60000);
    $('.carousel').carousel()
});

function GetData(){
  $.ajax({
    type: "GET",
    url: "/common/lastest_log",
    dataType: "script",
    success: function(result) {
        console.log("SUCCESS");
        console.log(result);
    },
    error: function(result) {
        console.log("ERROR");
        console.log(result);
    }
  });
}

// link Tooltips

$(document).ready(function() {
  var $links;
  $links = $('body').find('a[rel=tooltip]');
  $links.each(function(i, e) {
    var $e;
    $e = $(e);
    var title = $links[i].getAttribute("title");
    if (title == "" || title == null  ){
      return $e.attr('title', $e.attr('href'));
    }
  });
  return $links.tooltip();
});

// popover

$(document).ready(function() {
  var $links;
  $links = $('body').find('a[rel=popover]');
  $links.each(function(i, e) {
    var $e;
    $e = $(e);
    var title = $links[i].getAttribute("title");
    if (title == "" || title == null  ){
      $e.attr('title', $e.text());
    }
    var data_content = $links[i].getAttribute("data-content");
    if (data_content == "" || data_content == null  ){
      return $e.attr('data-content', $e.attr('href'));
    }
  });
  return $links.popover(
    {html : true});
  //return $links.tooltip();
});
