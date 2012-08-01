$(document).ready(function(){

	// 展开/隐藏 列表
	$(".setting_subject_list h3").live("click", function(){
		parent=$(this).parent();
		if(parent.hasClass("open")){
			parent.removeClass("open");
			parent.addClass("close");
		}else{
			parent.removeClass("close");
			parent.addClass("open");
		}
	})
	
	// 添加举报理由
	$("#add-report-reason-btn").live("click", function(){
		value = $("#add-report-reason-txt").val();
		if(value.trim()==""){
			return;
		}
		$.post(
			"/admin/base_settings/add_report_reason",
			{value:value},
			function(data){
				if(data=="ok"){
					$("#add-report-reason-txt").val("");
					$("#report-reason-list").append("<option value="+value+">"+value+"</option>");
				}else{
					alert(data);
				}
			}
		);
	})
	
	// 删除选中的举报理由
	$("#delete-report-reason-btn").live("click", function(){
		values = $("#report-reason-list").val();
		if(values == null){
			alert("未选中任何项！");
			return;
		}
		if(!confirm("你确定要删除吗？\n删除将不可恢复！")){
			return;
		}
		$.post(
			"/admin/base_settings/delete_report_reason",
			{values:values},
			function(data){
				if(data=="ok"){
					for(index in values){
						$("#report-reason-list option[value='"+values[index]+"']").remove();
					}
				}else{
					alert(data);
				}
			}
		);
	})
	
	// 发送测试邮件
	$("#send-test-email").live("click", function(){
		address=$("#email_address").val().trim();
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/; //验证邮箱的正则表达式
		if(!reg.test(address))
    	{
        	alert("邮箱格式不对");
        	return;
    	}
    	smtp=$("#smtp_email_host").val().trim();
    	host=$("#email_host").val().trim();
    	port=$("#email_port").val().trim();
    	account=$("#email_account").val().trim();
    	password=$("#email_password").val().trim();
    	$("#send-test-email").val("发送中...");
    	$.post(
    		"/admin/email_settings/send_test_email",
    		{email:address, smtp:smtp, host:host, port:port, account:account, password:password},
    		function(data){
    			if(data=="ok"){
    				alert("测试邮件已发出，请注意查收！");
    				$("#send-test-email").val("发送测试邮件");
    			}else{
    				alert("发送错误！");
    				$("#send-test-email").val("发送测试邮件");
    			}
    		}
    	);
	})
});
