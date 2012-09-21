// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  if ($("#knowledge_body").length > 0){
  var editor = KindEditor.create(
    'textarea[id="knowledge_body"]',
    {
      width : '850px',
      height: '500px',
      uploadJson: '/kindeditor/upload',
      fileManagerJson: '/kindeditor/filemanager'
    }
    );
  }

  $("input").click(function(){
    if ($("#knowledge_body").length > 0){
      editor.sync('knowledge_body');
      // 同步数据后可以直接取得textarea的value
      body = document.getElementById('knowledge_body').value; // 原生API
      $("#knowledge_body").val(body);
    }
  });

});
