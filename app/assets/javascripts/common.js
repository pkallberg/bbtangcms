function start_snow_storm() {
  var current_date = new Date();
  //获得当前月份0-11  
  //var current_month= current_date.getMonth(); 
  //获得当前年份4位年  
  //var current_year =currentDate.getFullYear(); 
  //求出本月第一天  
  var current_month = current_date.getMonth();
    
  if ([11,0,1,2,3].indexOf(current_month) >= 0)
  {
    snowStorm.autoStart = true;
    snowStorm.snowColor = '#99ccff'; // blue-ish snow!?
    //snowStorm.snowCharacter = '*';
    snowStorm.snowCharacter = '✻';
    snowStorm.flakeWidth = 15;
    snowStorm.flakeHeight = 15;
    snowStorm.vMaxX = 30;
    snowStorm.vMaxY = 30;
    snowStorm.flakesMax = 400;
    snowStorm.flakesMaxActive = 500;  // show more snow on screen at once
    snowStorm.useTwinkleEffect = true; // let the snow flicker in and out of view
    snowStorm.excludeMobile = false;
  } else {
    snowStorm.stop()
  }
  
}

jQuery(document).ready(function($){

  // start start_snow_storm
  start_snow_storm();
  
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

//
$(document).ready(function() {
  $('form div.form-actions a.btn').live("click",function() {
    $.sisyphus().manuallyReleaseData()
  });
});

// popover
/*
// when I update to bootstrap this cannot work fine
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
});*/
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
  $('[rel=popover]').popover({
    trigger: 'manual',
    animate: true,
    placement: 'right',
    offset: 5,
    html: true
  }).mouseenter(function(e){
    e.preventDefault();
    $(this).popover('show');
  })
  .mouseleave(function(e){
    e.preventDefault();
    $(this).popover('toggle');
  });
});
