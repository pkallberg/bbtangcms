// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//

//= require jquery
//= require jquery_ujs
//= require jquery-ui
// require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-TW
//= require rails-timeago
//= require gritter
//= require kindeditor
//= require twitter/bootstrap

/*A gem to add gmail like form saving through sisyphus.js*/
//= require sisyphus
//To support IE6/7 users include jStorage as well
//= require jstorage
//= require sisyphus

//= require_tree .
$(window).load(function() {
    show();
});

function show() {
    $('#loading').remove();
    $('#container').fadeIn();
};

function load_spin() {
  var opts = {
    lines: 17, // The number of lines to draw
    length: 30, // The length of each line
    width: 5, // The line thickness
    radius: 20, // The radius of the inner circle
    corners: 1, // Corner roundness (0..1)
    rotate: 11, // The rotation offset
    color: '#B5B5B5', // #rgb or #rrggbb
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: true, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: 'auto', // Top position relative to parent in px
    left: 'auto' // Left position relative to parent in px
  };
  var target = document.getElementById('page_loading_process');
  var spinner = new Spinner(opts).spin(target);
}

jQuery(document).ready(function($){
  load_spin()
});


$(document).ready(function(){
console.log("refreshing styles...");
less.sheets.push(document.getElementById('application_css'));
less.refresh(true);
console.log("refreshed...");


less.autoRefresh = function(time)
{
    var sheets = [];
    for(var i = less.sheets.length; i--; )
        sheets.push(less.sheets[i].href);
    setInterval(
        function()
        {
            for(var i = sheets.length; i--; )
                less.sheets[i].href = sheets[i] + '?'+Math.random();
            console.log("refreshing styles...");
            less.refresh(1);
            console.log("refreshed...");
        },
        time || 1000
    );

    var fnImport = less.tree.Import;
    less.tree.Import = function(path, imports)
    {
        path.value += '?x='+Math.random();
        fnImport(path, imports);
    }
};
});
