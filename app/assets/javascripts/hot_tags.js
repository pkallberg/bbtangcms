jQuery(document).ready(function($){
$('#tag_cloud_head a').click(function (e) {
    $('ul.nav-tabs li.active').removeClass('active');
    $(this).parent('li').addClass('active');
});
});
