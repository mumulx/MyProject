<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!--导航开始-->
<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<!--小屏幕导航按钮和logo-->
		<div class="navbar-header">
			<button class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="<%=basePath%>index.jsp" class="navbar-brand" style="font-family: '华文行楷'">三维模型质量检查</a>
		</div>
		<!--小屏幕导航按钮和logo-->
		<!--导航-->
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav navbar-left">
				<li><a href="<%=basePath%>index.jsp">首页</a></li>
				<li><a href="<%=basePath%>teamProject/team.jsp">个人中心</a></li>
				<li><a href="<%=basePath%>fileupload/fileupload.jsp">提交检查</a></li>
				<li><a href="<%=basePath%>testrecord/testrecord.jsp">测试记录</a></li>
				<li><a href="<%=basePath%>Notice/frontlist">站内通知</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<%
					String user_name = (String) session.getAttribute("user_name");
					if (user_name == null) {
				%>
				<li><a href="#" onclick="register();"><i
						class="fa fa-sign-in"></i>&nbsp;&nbsp;注册</a></li>
				<li><a href="#" onclick="login();"><i class="fa fa-user"></i>&nbsp;&nbsp;登录</a></li>

				<%
					} else {
				%>
				<li class="dropdown"><a id="dLabel" type="button"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<%=session.getAttribute("user_name")%> <span class="caret"></span>
				</a>
					<ul class="dropdown-menu" aria-labelledby="dLabel">
						<li><a href="<%=basePath%>index.jsp"><span
								class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;首页</a></li>

						<li><a href="<%=basePath%>teamProject/team.jsp"><span
								class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;个人中心</a></li>

						<li><a href="<%=basePath%>fileupload/fileupload.jsp"><span
								class="glyphicon glyphicon-file"></span>&nbsp;&nbsp;提交检查</a></li>

						<li><a href="<%=basePath%>UserInfo/userInfo_frontModify.jsp"><span
								class="glyphicon glyphicon-list-alt"></span>&nbsp;&nbsp;提交记录</a></li>

						<li><a href="<%=basePath%>index.jsp"><span
								class="glyphicon glyphicon-th-large"></span>&nbsp;&nbsp;我的团队</a></li>
					</ul></li>
				<li><a href="<%=basePath%>logout.jsp"><span
						class="glyphicon glyphicon-off"></span>&nbsp;&nbsp;退出</a></li>
				<%
					}
				%>
			</ul>

		</div>
		<!--导航-->
	</div>
</nav>
<!--导航结束-->


<div id="loginDialog" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" id="loginDialog_close" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">
					<i class="fa fa-key"></i>&nbsp;系统登录
				</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="loginForm" id="loginForm"
					enctype="multipart/form-data" method="post" class="mar_t15">

					<div class="form-group">
						<label for="login_username" class="col-md-3 text-right">登录账号:</label>
						<div class="col-md-8">
							<input type="text" id="login_username" name="login_username"
								class="form-control" placeholder="账号为注册联系电话">
						</div>
					</div>

					<div class="form-group">
						<label for="login_password" class="col-md-3 text-right">登录密码:</label>
						<div class="col-md-8">
							<input type="password" id="login_password" name="login_password"
								class="form-control" placeholder="请输入登录密码">
						</div>
					</div>
					<div class="form-group">
						<label for="login_authCode" class="col-md-3 text-right">验证码</label>
						<div class="col-md-8">
							<div class="input-group" style="z-index: 9999">
						  			<input type="text" class="form-control" placeholder="请输入验证码" aria-describedby="basic-addon2" id="login_authCode" name="login_authCode">
						  			<span class="input-group-addon" style="padding: 0 0" id="basic-addon2"><a href="javascript:reloadCheckImg();" onclick="reloadCheckImg()"> <img  id="login_authCode_img" src="<%=basePath%>/authCode.jsp"/></a></span>
							</div>
						</div>
					</div>
				</form>
				<style>
#bookTypeAddForm .form-group {
	margin-bottom: 10px;
	
}
</style>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" onclick="ajaxLogin();">登录</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<div id="registerDialog" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">
					<i class="fa fa-sign-in"></i>&nbsp;用户注册
				</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" name="registerForm" id="registerForm"
					enctype="multipart/form-data" method="post" class="mar_t15">

					 <div class="form-group">
						<label for="userInfo_user_name_header" class="col-md-3 text-right">昵称:</label>
						<div class="col-md-8">
							<input type="text" id="userInfo_user_name_header"
								name="userInfo.userName" class="form-control"
								placeholder="请输入昵称">
						</div>
					</div>
					<div class="form-group">
						<label for="userInfo_user_tel_header" class="col-md-3 text-right">联系电话:</label>
						<div class="col-md-8">
							<input type="text" id="userInfo_user_tel_header"
								name="userInfo.userTel" class="form-control"
								placeholder="请输入联系电话">
						</div>
					</div>

					<div class="form-group">
						<label for="userInfo_user_tel_header" class="col-md-3 text-right">验证码:</label>
						<div class="col-md-8">
							<div class="input-group" style="z-index: 9999">
								<input type="hidden" id="userSmsTel">
								<input id="userSms" name="userSms" type="text" class="form-control" placeholder="请输入短信验证码">
								<span class="input-group-btn">
									<button id="userSmsSend" class="btn btn-default" type="button">获取验证码</button>
								</span>
							</div>
						</div>
					</div>


					<div class="form-group">
						<label for="userInfo_user_pwd_header" class="col-md-3 text-right">登录密码:</label>
						<div class="col-md-8">
							<input type="password" id="userInfo_user_pwd_header" name="userInfo.userPwd"
								class="form-control" placeholder="密码由6-20个字母、数字、下划线组成">
						</div>
					</div>
					<div class="form-group">
						<label for="confirmPassword_header" class="col-md-3 text-right">确认密码:</label>
						<div class="col-md-8">
							<input type="password" id="confirmPassword_header" name="userInfo.confirmPassword" class="form-control" placeholder="确认密码">
						</div>
					</div>

					<div class="form-group">
						<label for="userInfo_user_email_header" class="col-md-3 text-right">电子邮箱:</label>
						<div class="col-md-8">
							<input type="text" id="userInfo_user_email_header" name="userInfo.userEmail"
								class="form-control" placeholder="xxx.xx@example.com">
						</div>
					</div>
					
					<div class="form-group">
						<label for="userInfo_user_birthdayDiv_header" class="col-md-3 text-right">出生日期:</label>
						<div class="col-md-8">
							<div id="userInfo_user_birthdayDiv_header"
								class="input-group date userInfo_user_birthday col-md-12"
								data-link-field="userInfo_birthday"
								data-link-format="yyyy-mm-dd">
								
								<input class="form-control" id="userInfo_user_birthday_header"
									name="userInfo.userBirthday" size="16" type="text" value=""
									placeholder="请选择出生日期" readonly> 
									
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-remove">
										</span>
									</span> 
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar">
										</span>
									</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="userInfo_user_sex_header" class="col-md-3 text-right">性别:</label>
						<div class="col-md-8" id="userInfo_user_sex_header" name="userInfo_user_sex_header">
							 <label class="radio-inline"> 
						  		<input type="radio" value='1' checked name="userInfo.userSex" />男
						 	  </label> 
						 	<label class="radio-inline">  
						  		<input type="radio" value="0" name="userInfo.userSex" /> 女
							 </label> 

						
						</div>
						
					</div>

					<div class="form-group">
						<label for="userInfo_user_address_header" class="col-md-3 text-right">家庭地址:</label>
						<div class="col-md-8">
							<input type="text" id="userInfo_user_address_header" name="userInfo.userAddress"
								class="form-control" placeholder="请输入家庭地址">
						</div>
					</div>
				</form>
				
				
				<style>
					#bookTypeAddForm .form-group {
						margin-bottom: 10px;
					}
				</style>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary"
					onclick="ajaxRegister();">注册</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>

<script>
var basePath = "<%=basePath%>";

function reloadCheckImg()
{
    $("#login_authCode_img").attr("src", basePath+"/authCode.jsp?t="+(new Date().getTime()));  //<img src="...">
}
function register() {
	$("#registerDialog input").val("");
	//为单选按钮赋值
	$("#userInfo_user_sex_header :radio:first").val("1");
	$("#userInfo_user_sex_header :radio:last").val("0");
	$("#registerDialog textarea").val("");
	$("#registerDialog img").attr("src","");
	$('#registerDialog').modal('show');
}


//提交添加用户信息
function ajaxRegister() {
	//提交之前先验证表单
	$("#registerForm").data('bootstrapValidator').validate();
	if(!$("#registerForm").data('bootstrapValidator').isValid()){
		return;
	}
	jQuery.ajax({
		type : "post",
		url : basePath + "UserInfo/add",
		dataType : "json" ,
		data: new FormData($("#registerForm")[0]) ,  
		processData: false,   // jQuery不要去处理发送的数据
		contentType: false,
		success : function(obj) {                                                                                                                                 
			if(obj.success){ 
				alert(obj.message);
				$("#registerForm").find("input").val("");
				$("#registerForm").find("textarea").val("");
				$('#registerDialog').modal('hide');
				window.location.href="<%=basePath%>index.jsp";
				
			} else {

				alert(obj.message);
			}
		}
	});
}

function login() {
	$("#loginDialog input").val("");
	$('#loginDialog').modal('show');
	reloadCheckImg();

}

function ajaxLogin() {
	/*登录之前要先验证表单数据*/
	$("#loginForm").data('bootstrapValidator').validate();
	if(!$("#loginForm").data('bootstrapValidator').isValid()){
		return;
	}
	$.ajax({
		url : basePath + "UserInfo/frontLogin",
		type : 'post',
		dataType: "json",
		data : {
			"login_username" : $('#login_username').val(),
			"login_password" : $('#login_password').val(),
		}, 
		success : function (obj, response, status) {
			if (obj.success) {

			location.href = "<%=basePath%>index.jsp";
			} else {
				alert(obj.message);
			}
		}
	});
}
	$(function() {

		loginFormValidator();
		//登录表单点击叉号。仍然保持验证状态：验证销毁重构
		$('#loginDialog').on('hidden.bs.modal', function() {
			$("#loginForm").data('bootstrapValidator').destroy();
			$('#loginForm').data('bootstrapValidator', null);
			loginFormValidator();
		});

		registerFormValidator();
		//解决注册表单叉掉后，保持验证状态
		$('#registerDialog').on('hidden.bs.modal', function() {
			$("#registerForm").data('bootstrapValidator').destroy();
			$('#registerForm').data('bootstrapValidator', null);
			registerFormValidator();
		});

		/*发送短信验证码*/
		$("#userSmsSend").click(function () {
			var tel = $("#userInfo_user_tel_header").val();
			$.ajax({
				url : basePath + "UserInfo/sendSms",
				type : 'get',
				dataType: "json",
				data : {
					"userTel" :tel,
				},
				success : function (obj, response, status) {
					//console.log(obj);
					if (obj.success) {
						$("#userSmsSend").removeClass("btn-default");
						$("#userSmsSend").addClass("btn-success");
						$("#userSmsSend").text("五分钟内有效");
						$("#userSmsTel").val(tel);
					} else {
						alert(obj.message);
					}
				}
			});

		});

		/*小屏幕导航点击关闭菜单*/
		$('.navbar-collapse a').click(function(){
			$(this).css("background","lightgreen");
		    $('.navbar-collapse').collapse('hide');
		});
		new WOW().init();

		//验证用户添加表单字段
		function registerFormValidator(){

			$('#registerForm').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {

					"userInfo.userName" : {
						validators : {
							notEmpty : {
								message : "昵称不能为空",
							}
						}
					},"userInfo.userTel" : {
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
					"userSms" : {
						validators : {
							notEmpty : {
								message : "验证码不能为空",
							},stringLength: {
								min: 4,
								max: 4,
								message: '请输入四位验证码'
							},
							threshold : 3 ,
							remote: {
								//发起Ajax请求。
								url: "<%=basePath%>UserInfo/checkSmsCode",//验证地址
								data : function(validator) {
									return {
										userTel : $("#userSmsTel").val(),
										checkCode : $("#userSms").val()//
									};
								},
								message: '验证码错误',//提示消息
								delay :  1000,//设置1秒发起名字验证
								type: 'POST' //请求方式
							}
						}
					},
					"userInfo.userPwd" : {
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
					"userInfo.confirmPassword" : {
						validators : {
							notEmpty : {
								message : "验证密码不能为空",
							},
							regexp : {
								regexp : /^(\w){6,20}$/,
								message : '密码只能由6-20个字母、数字、下划线组成'
							},identical: {
								field: 'userInfo.userPwd',
								message: '2次密码不一致'
							}
						}
					},
					"userInfo.userEmail" : {
						validators : {
							notEmpty : {
								message : "电子邮箱不能为空",
							},
							regexp : {
								regexp : /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/,
								message : '电子邮箱格式不正确'
							}
						}
					},

					"userInfo.userBirthday" : {
						validators : {
							notEmpty : {
								message : "出生日期不能为空",
							}
						}
					},
					"userInfo.userAddress" : {
						validators : {
							notEmpty : {
								message : "家庭地址不能为空",
							}
						}
					},
				}
			});
		}
		function loginFormValidator(){
			//验证登录输入loginDialog
			$('#loginForm').bootstrapValidator({
				feedbackIcons : {
					valid : 'glyphicon glyphicon-ok',
					invalid : 'glyphicon glyphicon-remove',
					validating : 'glyphicon glyphicon-refresh'
				},
				fields : {
					"login_username" : {
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
					"login_password" : {
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
					"login_authCode" : {
						validators : {
							notEmpty : {
								message : "验证码不能为空",
							},stringLength: {
								min: 4,
								max: 4,
								message: '请输入四位验证码'
							},
							remote: {
								//发起Ajax请求。
								 url: "<%=basePath%>UserInfo/checkAuthCode",//验证地址
								 data:{checkcode:$('input[name="login_authCode"]').val() },
								 message: '验证码错误',//提示消息
								 delay :  1000,//设置1秒发起名字验证
								 type: 'POST' //请求方式
							 }
						}
					}
				}
			});

			//出生日期组件
			$('#userInfo_user_birthdayDiv_header').datetimepicker({
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
				$('#registerForm').data('bootstrapValidator').updateStatus('userInfo.userBirthday', 'NOT_VALIDATED',null).validateField('userInfo.userBirthday');
			});
		}
	});
</script>


