<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<%@include file="/WEB-INF/pub/inc.jsp"%>
<title>邮件发送</title>

</head>
<body>
<div class="layui-form-item">
    <label class="layui-form-label">单行选择框</label>
    <div class="layui-input-block">
      <select name="interest" lay-filter="aihao">
        <option value=""></option>
        <option value="0">写作</option>
        <option value="1" selected="">阅读</option>
        <option value="2">游戏</option>
        <option value="3">音乐</option>
        <option value="4">旅行</option>
      </select>
    </div>
  </div>

<div class="mail">
	      <form id="sendMail" method="post">
	          <div>
	               <label>邮件主题：</label><input name="subject">
	               <label>邮件正文：</label><input name="context">
	          </div>
	          <div>
	             <label>收件人：</label><input name="sendName">
	             <label>收件人邮箱：</label><input name="receiveMailAccount">
	          </div>
	          <div>
	             <a href="javascript:;"
			     class="easyui-linkbutton" data-options="iconCls:'icon-save'"
			     onclick="send()">发送邮件</a>
	          </div>
	          
	         <input type="hidden" name="myEmailAccount" value="${user.myEmailAccount }">
	         <input type="hidden" name="myEmailPassword" value="${user.myEmailPassword }">
	         <input type="hidden" name="myEmailSMTPHost" value="${user.myEmailSMTPHost }">
	         <input type="hidden" name="username" value="${user.username }">
	      </form>
	
	</div>

</body>

<script type="text/javascript">

	function send(){
		$('#sendMail').form('submit', {
			onSubmit:function(){
				return $(this).form('enableValidation').form('validate');
			},
			url:'${pageContext.request.contextPath}/send.do',
		    success: function(r){  
		    	var s=$.parseJSON(r);
		    	if(s.success){
		    		showMsg('发送提示',s.msg);
		    	}else{
		    		showMsg('发送提示','发送失败');
		    	}
		    	}    
		}); 
	}

</script>
</html>