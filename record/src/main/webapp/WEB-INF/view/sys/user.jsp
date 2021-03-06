<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/public/inc.jsp"%>
<html>
<head>
<title>用户管理</title>
</head>
<body>
</br>
     <a href="${pageContext.request.contextPath}/toSign.do"
						class="layui-btn layui-btn-warm layui-btn-radius ">添加用户</a>
	&nbsp	&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp				
	 <a href="${pageContext.request.contextPath}/toSetting.do"
	                    class="layui-btn layui-btn-normal layui-btn-radius"><i class="layui-icon layui-icon-return"></i>返回</a>  
	                    </br></br>
	<table class="layui-hide" id="user" lay-filter="users"></table>


</body>
 <script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit" >编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
 
layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element'], function(){
  var laydate = layui.laydate //日期
  ,laypage = layui.laypage //分页
  layer = layui.layer //弹层
  ,table = layui.table //表格
  ,carousel = layui.carousel //轮播
  ,upload = layui.upload //上传
  ,element = layui.element; //元素操作
  
  
  
  //执行一个 table 实例
  table.render({
    elem: '#user'
    ,id: 'id'
    ,url: '${pageContext.request.contextPath}/toGetUser.do' //数据接口
    ,page: true //开启分页
    ,cols: [[ //表头
      {field: 'username', title: '用户名', width:'20%',  fixed: 'left'}
      ,{field: 'department', title: '部门', width:'17%'}
      ,{field: 'roleId', title: '角色', width:'17%'}
      ,{field: 'lastLoginDate', title: '最后登录日期', width:'20%'} 
      ,{fixed: 'right', width: '24%', align:'center', toolbar: '#barDemo'}
    ]]
  });
  
  //监听工具条
  table.on('tool(users)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
    var data = obj.data //获得当前行数据
    ,layEvent = obj.event; //获得 lay-event 对应的值
    if(layEvent === 'detail'){
      layer.msg('查看操作');
    } else if(layEvent === 'del'){
      layer.confirm('真的要删除吗', function(index){
    	  var id=data.id;
    	  console.log(id);
    	  $.ajax({
    		  type:'post',
    		  url:'${pageContext.request.contextPath}/deleteUser.do?id='+id,
    		  succsess:function(res){
    			  layer.msg(res);
    		  }
    	  }); 
        obj.del(); //删除对应行（tr）的DOM结构
        layer.close(index);
        //向服务端发送删除指令
      });
    } else if(layEvent === 'edit'){
      //console.log(data.id);
      var userid=data.id;
      layer.open({
    	  type: 1,
    	  skin: 'layui-layer-rim', //加上边框
          offset: ['40px','230px'], 
          resize:false,
          move: false,
          closeBtn:2,
    	  area: ['600px', '400px'], //宽高
    	  content: '<iframe scrolling="auto" frameborder="0"  src="${pageContext.request.contextPath}/'
				+ 'toPersonal.do?id='+userid+'" style="width:560px;height:380px;"></iframe>'
    	}); 
    }
  });
  
})
  </script>
</html>