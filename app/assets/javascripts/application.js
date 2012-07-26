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
// require prototype
// require prototype_ujs
// require effects
// require dragdrop
// require controls
//= require twitter/bootstrap
//= require kindeditor
//= require_tree .
//jQuery.noConflict();

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
//jQuery(document).ready(function($){
//    less.autoRefresh(time = 600000);
//});
