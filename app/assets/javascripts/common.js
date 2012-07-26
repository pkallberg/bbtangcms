jQuery(document).ready(function($){
    jQuery('#flashes').find(jQuery('.close')).click(function(){
    /*$("#flashes").hide()*/
    jQuery("#flashes").remove();
  });
});
