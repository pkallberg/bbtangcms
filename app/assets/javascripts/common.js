jQuery(document).ready(function($){
    jQuery('#flashes').find(jQuery('.close')).click(function(){
    /*$("#flashes").hide()*/
    jQuery("#flashes").remove();
  });
});

$(document).ready(function(){
  window.setInterval('GetData()', 60000);
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
