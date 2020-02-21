<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.mumulx.entity.Area" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>用户添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>UserInfo/frontlist">用户管理</a></li>
  			<li class="active">添加用户</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="userInfoAddForm" id="userInfoAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
					 <label for="userInfo_user_name" class="col-md-2 text-right">学号:</label>
					 <div class="col-md-8"> 
					 	<input type="text" id="userInfo_user_name" name="userInfo.user_name" class="form-control" placeholder="请输入学号">
					 </div>
				  </div> 
				  <div class="form-group">
				  	 <label for="userInfo_password" class="col-md-2 text-right">登录密码:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_password" name="userInfo.password" class="form-control" placeholder="请输入登录密码">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_areaObj_areaId" class="col-md-2 text-right">所在学院:</label>
				  	 <div class="col-md-8">
					    <select id="userInfo_areaObj_areaId" name="userInfo.areaObj.areaId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_name" class="col-md-2 text-right">姓名:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_name" name="userInfo.name" class="form-control" placeholder="请输入姓名">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_sex" class="col-md-2 text-right">性别:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_sex" name="userInfo.sex" class="form-control" placeholder="请输入性别">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_userPhoto" class="col-md-2 text-right">学生照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="userInfo_userPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="userInfo_userPhoto" name="userInfo.userPhoto"/>
					    <input id="userPhotoFile" name="userPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_birthdayDiv" class="col-md-2 text-right">出生日期:</label>
				  	 <div class="col-md-8">
		                <div id="userInfo_birthdayDiv" class="input-group date userInfo_birthday col-md-12" data-link-field="userInfo_birthday" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="userInfo_birthday" name="userInfo.birthday" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_telephone" class="col-md-2 text-right">联系电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_telephone" name="userInfo.telephone" class="form-control" placeholder="请输入联系电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="userInfo_address" class="col-md-2 text-right">家庭地址:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="userInfo_address" name="userInfo.address" class="form-control" placeholder="请输入家庭地址">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxUserInfoAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#userInfoAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
//用户选择图片后更新img地址
$(document).ready(function() {
	$("#userPhotoFile").change(function(){
		var file = this.files[0];//获取文件信息
        if (window.FileReader)
        {
            var reader = new FileReader();
            reader.readAsDataURL(file);
            //监听文件读取结束后事件    
            reader.onloadend = function (e) {
                $("#userInfo_userPhotoImg").attr("src",e.target.result);
            };
        }
	});
});

var basePath = "<%=basePath%>";
	//提交添加用户信息
	function ajaxUserInfoAdd() { 
		//提交之前先验证表单
		$("#userInfoAddForm").data('bootstrapValidator').validate();
		if(!$("#userInfoAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "UserInfo/add",
			dataType : "json" , 
			data: new FormData($("#userInfoAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#userInfoAddForm").find("input").val("");
					$("#userInfoAddForm").find("textarea").val("");
					window.location.href="<%=basePath%>index.jsp";
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
	
	
$(function() {
		
	//验证用户添加表单字段
	$('#userInfoAddForm').bootstrapValidator({
		feedbackIcons : {
			valid : 'glyphicon glyphicon-ok',
			invalid : 'glyphicon glyphicon-remove',
			validating : 'glyphicon glyphicon-refresh'
		},
		fields : {
			"userInfo.user_name" : {
				validators : {
					notEmpty : {
						message : "学号不能为空",
					},
					regexp : {
						regexp : /^[0-9]{10}$/,
						message : '学号是长度为10的数字'
					}
				}
			},
			"userInfo.password" : {
				validators : {
					notEmpty : {
						message : "登录密码不能为空",
					},
					regexp : {
						regexp : /^(\w){6,20}$/,
						message : '密码只能由6-20个字母、数字、下划线组成'
					}
				}
			},
			"userInfo.name" : {
				validators : {
					notEmpty : {
						message : "姓名不能为空",
					},
					regexp : {
						regexp : /^[\u4E00-\u9FA5A-Za-z0-9]+$/,
						message : '只能输入中文和英文和数字'
					}
				}
			},
			"userInfo.sex" : {
				validators : {
					notEmpty : {
						message : "性别不能为空",
					},
					regexp : {
						regexp : /^(男|女)$/,
						message : '性别只能为男或女'
					}
				}
			},
			
			"userInfo.birthday" : {
				validators : {
					notEmpty : {
						message : "出生日期不能为空",
					}
				}
			},
			"userInfo.telephone" : {
				validators : {
					notEmpty : {
						message : "联系电话不能为空",
					},
					regexp : {
						regexp : /^1(3|4|5|6|7|8|9)\d{9}$/,
						message : '电话格式不正确'
					}
				}
			},
			"userInfo.address" : {
				validators : {
					notEmpty : {
						message : "家庭地址不能为空",
					}
				}
			},
		}
	});
	//初始化所在学院下拉框值 
	$.ajax({
		url: basePath + "Area/listAll",
		type: "get",
		success: function(areas,response,status) { 
			$("#userInfo_areaObj_areaId").empty();
			var html="";
    		$(areas).each(function(i,area){
    			html += "<option value='" + area.areaId + "'>" + area.areaName + "</option>";
    		});
    		$("#userInfo_areaObj_areaId").html(html);
    	}
	});
	//出生日期组件
	$('#userInfo_birthdayDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#userInfoAddForm').data('bootstrapValidator').updateStatus('userInfo.birthday', 'NOT_VALIDATED',null).validateField('userInfo.birthday');
	});
	
});
	
</script>
</body>
</html>
