<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>聚好看 |个性化电影推荐引擎</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->
	
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<link href="jRaty/jquery.raty.css" rel="stylesheet">
	<link href="css/m-buttons.min.css" rel="stylesheet">
    <link href="css/m-forms.min.css" rel="stylesheet">
    <link href="css/m-icons.min.css" rel="stylesheet">
    <link href="css/m-styles.min.css" rel="stylesheet">
    <link href="css/m-normalize.min.css" rel="stylesheet">
	<link href="css/piStyle.css" rel="stylesheet">

	<style type="text/css">
		.navbar .nav > li .dropdown-menu {
			margin: 0;
		}
		.navbar .nav > li:hover .dropdown-menu {
			display: block;
		}
	</style>

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-57-precomposed.png">
  <link rel="shortcut icon" href="img/favicon.png">
  
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<script type="text/javascript" src="js/scripts.js"></script>
	<script type="text/javascript" src="jRaty/jquery.raty.js"></script>
	<script type="text/javascript" src="js/m-dropdown.min.js"></script>
    <script type="text/javascript" src="js/m-radio.min.js"></script>
	<script type="text/javascript" src="js/jquery.capSlide.js"></script>
	<script type="text/javascript">
    	$(function(){//显示jqueryRaty评分插件
			$('.star').raty({
				path:"jRaty/images",
				size:100,
				number:5,
				score: function() {
					return $(this).attr('data-score');
				},
				
				//当用户点击分数的时候执行获取页面属性调用ajax函数
				click:function(score,evt){
					var userId = $('#userIdAnchor').val();
					var movieId = $('#movieIdAnchor').val();
					$.ajax({
						type:"GET",
						url:"myajax.do?method=insertRate&userId="+userId+"&movieId="+movieId+"&score="+score,
						contentType:"application/json",
						dataType:"json",
						success:function(data){
							
							if(data[0] == 'ok'){
								alert('感谢评分！');
								location.reload(true);
							}
						},
						error:function(XMLHttpRequest){
							alert("error");
						}
					});
				}
						
			});
		});
		//这里是图片的简介显示
		$(function(){
			$(".capslide_img_cont3").capslide({
				caption_color	: '#fff',
				caption_bgcolor	: '#000',
				overlay_bgcolor : 'blue',
				border			: '',
				showcaption	    : true
			});
		});
		//登录ajax
		$(function(){
			$("#loginSubmitBtn").click(function(){
				var inputname = $('#inputUsername').val();
				var inputpwd  =$('#inputPassword').val();
				$.ajax({
					type:"GET",
					url:"myajax.do?method=login&username="+inputname+"&pwd="+inputpwd,
					contentType:"application/json",
					dataType:"json",
					success:function(data){
						if(data[0] == null){
							$('#inputUsernameError').html('&nbsp; 用户名不存在！');
							setTimeout("showLoginError()",1000);
						}
						if(data[0] == 'error'){
							$('#inputPasswordError').html('&nbsp; 密码错误！');
							setTimeout("showPwdError()", 1000);
						}
						if(data[0] == 'ok'){
							location.reload(true);
							location.href="movie.do?method=index";
						}
					},
					error:function(XMLHttpRequest){
						alert("error");
					}
				});
			});
		});
		function showLoginError(){
			$('#inputUsernameError').html('');
		}
		function showPwdError(){
			$('#inputPasswordError').html('');
		}
		//注册ajax
		$(function(){
			$('#regiSendBtn').click(function(){
				var username = $('#regiuername').val();
				var pwd = $('#regipwd').val();
				$.ajax({
					type:"GET",
					url:"myajax.do?method=register&username="+username+"&pwd="+pwd,
					contentType:"application/json",
					dataType:"json",
					success:function(data){
						if(data[0] == 'ok'){
							$("#regiDivId").css("visibility","visible");
							setTimeout("regiTime()", 1500);
							//location.reload(true);
			self.location.href="movie.do?method=index";
						}
						if(data[0] == 'error'){
							$('#regiError').html('* 用户名已经存在!');
							setTimeout("showRegiError()", 1000);
						}
					},
					error:function(XMLHttpRequest){
						alert("error");
					}
				});
			});
		});
		function showRegiError(){
			$('#regiError').html('');
		}
		function regiTime(){
			$("#regiDivId").css("visibility","hidden");
		}
		//发表评论ajax
		$(function(){
			$('#sendConmmentId').click(function(){
				var comt = $('#conmmentContentId').val();
				var movieId = $('#movieIdAnchor').val();
				var userId = $('#userIdAnchor').val();
				$.ajax({
					type:"GET",
					url:"myajax.do?method=insertCommnet&userId="+userId+"&movieId="+movieId+"&commentContent="+comt,
					contentType:"application/json",
					dataType:"json",
					success:function(data){
						if(data[0] == 'ok'){
							$("#commnetDivId").css("visibility","visible");
							setTimeout("commentTime()", 1000);
						}
					},
					error:function(XMLHttpRequest){
						alert("error");
					}
				});
				
			});
		});
		function commentTime(){
			$("#commnetDivId").css("visibility","hidden");
			$('.cancelBtn').trigger("click");
		}
		//收藏
		$(function(){
			$('#collectionAId').click(function(){
				var movieId = $('#movieIdAnchor').val();
				var userId = $('#userIdAnchor').val();
				$.ajax({
					type:"GET",
					url:"myajax.do?method=insertCollection&userId="+userId+"&movieId="+movieId,
					contentType:"application/json",
					dataType:"json",
					success:function(data){
						if(data[0] == 'ok'){
							alert('收藏成功！！');
						}
						if(data[0] == 'error'){
							alert('您已经收藏过，不需要重复点击！');
						}
					},
					error:function(XMLHttpRequest){
						alert("error");
					}
				});
			});
		});
		//没兴趣
		$(function(){
			$('#disLikeId').click(function(){
				var movieId = $('#movieIdAnchor').val();
				var userId = $('#userIdAnchor').val();
				$.ajax({
					type:"GET",
					url:"myajax.do?method=insertDislike&userId="+userId+"&movieId="+movieId,
					contentType:"application/json",
					dataType:"json",
					success:function(data){
						if(data[0] == 'ok'){
							alert('添加成功！！');
						}
						if(data[0] == 'error'){
							alert('已经在不喜欢列表了，不需要重复添加！');
						}
					},
					error:function(XMLHttpRequest){
						alert("error");
					}
				});
			});
		});
		
		//搜索
		$(function(){
			$('#searchBtn').click(function(){
				var ss = $('#searchString').val();
				location.href="movie.do?method=search&hql="+ss;
			});
		});
		
		//urlLink
		$(function(){
			$('.urlLink').click(function(){
				var userId = $('#userIdAnchor').val();
				
				var movieId = $('#movieIdAnchor').val();
				if(userId != null){
					$.ajax({
						type:"GET",
						url:"myajax.do?method=watchLog&movieId="+movieId+"&userId="+userId,
						contentType:"application/json",
						dataType:"json",
						success:function(data){
							if(data[0] == 'ok'){
								
							}
							
						},
						error:function(XMLHttpRequest){
							alert("error");
						}
					});
				}
				
			});
		});
    </script>
</head>
<body>
<!-- begin navbar row-->		
		<div class="row-fluid">
			<div class="span12">
				<div class="navbar navbar-inverse navbar-fixed-top">
				<div class="navbar-inner">
					<div class="container-fluid">
						<a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar"><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></a> 
                        <a href="main.do" class="brand">聚好看</a>
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav">
								<li><a href="movie.do?method=index">猜你喜欢</a></li>
								<li>
									<c:choose>
										<c:when test="${not empty username}">
											<a href="movie.do?method=toRatePage">评分</a>
										</c:when>
										<c:otherwise>
											<a href="#modal-container-login" data-toggle="modal">评分</a>
										</c:otherwise>
									</c:choose>
								</li>
								<!-- 
									<li>
										<c:choose>
											<c:when test="${not empty username}">
												<a href="#modal-container-notice" data-toggle="modal">消息通知 <span class="badge badge-warning">3</span></a>
											</c:when>
											<c:otherwise>
												<a href="#modal-container-login" data-toggle="modal">消息通知 <span class="badge badge-warning">3</span></a>
											</c:otherwise>
										</c:choose>
									</li>
								 -->
								<li>
									<a href="movie.do?method=toMovieclassifyPage" >电影分类</a>
								</li>
								<li class="dropdown">
									<a data-toggle="dropdown" class="dropdown-toggle active" href="#">我的主页<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<c:choose>
											<c:when test="${not empty username}">
												<li><a href="user.do?method=personalPage&userId=${userId }">我的收藏</a></li>
												<li><a href="user.do?method=personalPage&userId=${userId }">观影记录</a></li>
												<li><a href="user.do?method=personalPage&userId=${userId }">原创影评</a></li>
		                                        <li><a href="user.do?method=personalPage&userId=${userId }">好友管理</a></li>
		                                        <li><a href="user.do?method=personalPage&userId=${userId }">我的积分</a></li>
											</c:when>
											<c:otherwise>
												<li><a href="#modal-container-login" data-toggle="modal">我的收藏</a></li>
												<li><a href="#modal-container-login" data-toggle="modal">观影记录</a></li>
												<li><a href="#modal-container-login" data-toggle="modal">原创影评</a></li>
		                                        <li><a href="#modal-container-login" data-toggle="modal">好友管理</a></li>
		                                        <li><a href="#modal-container-login" data-toggle="modal">我的积分</a></li>
											</c:otherwise>
										</c:choose>
										
									</ul>
								</li>
							</ul>
  
  <!--begin navbar 右侧--> 
                            
							<ul class="nav pull-right" style="margin-left: 20px;">
								<c:choose>
									<c:when test="${empty sessionScope.username}">
										<li><a id="loginBtn" href="#modal-container-login" data-toggle="modal" >登陆</a></li>
                                		<li><a href="#modal-container-register" data-toggle="modal">注册</a></li>
									</c:when>
									<c:otherwise>
										<li class="dropdown">
											<a data-toggle="dropdown" class="dropdown-toggle" style="color:white;" href="#"><span class="icon-user icon-white"></span> ${username }<input id="userIdAnchor" type="hidden" value="${userId }"><strong class="caret"></strong></a>
											<ul class="dropdown-menu">
												<li><a href="user.do?method=personalPage&userId=${userId }">我的主页</a></li>
												<li class="divider"></li>
												<li><a href="user.do?method=logout" data-toggle="modal"><span class="icon icon-off"></span> 退出登录</a></li>
											</ul>
										</li>
									</c:otherwise>
								</c:choose>
								<li class="divider-vertical"></li>
								<li class="dropdown">
									<a data-toggle="dropdown" class="dropdown-toggle" href="#">友情链接<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<li><a href="http://cise.sdust.edu.cn/web2010/">信息学院</a></li>
										<li><a href="http://grdms.sdust.edu.cn:8081/">成绩查询网站</a></li>
										<li><a href="http://www.baidu.com">百度</a></li>
										<li class="divider"></li>
										<li><a href="#modal-container-sarcasm" data-toggle="modal">我要吐糟</a></li>
									</ul>
								</li>
							</ul>
<!-- 中间搜索部分-->                         
                            <ul class="nav pull-right">
                            	<form class="navbar-form navbar-left" onsubmit="return false;" >
                                	<div class="input-append">
                                    	<input id="searchString" class="form-control col-lg-6" placeholder="搜索影视相关的关键字" type="text"><button id="searchBtn" class="btn btn-info" type="button">搜索</button>
                                    </div>
                                </form>
                            </ul>
						</div>
					</div>
				</div>
			</div>
				
<!-- begin modal -->
		<!-- begin notice-->
					<div id="modal-container-notice" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h3 id="myModalLabel">
								新消息
							</h3>
						</div>
						<div class="modal-body">
							<p>
								<form class="form-horizontal">
									<textarea placeholder="请输入您要说的……" class="span12"></textarea>
									
								</form> 
							</p>
						</div>
						<div class="modal-footer">
							 <button class=" m-btn" data-dismiss="modal" aria-hidden="true">取消</button> <button class="m-btn purple">确定</button>
						</div>
					</div>
		<!-- end notice-->
		<!--begin sarcasm-->
					<div id="modal-container-sarcasm" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h3 id="myModalLabel">
								吐槽、建议
							</h3>
						</div>
						<div class="modal-body">
							<p>
								<form class="form-horizontal">
									<textarea class="span12" placeholder="请输入您要说的……"></textarea>
									
								</form> 
							</p>
						</div>
						<div class="modal-footer">
							  <button class=" m-btn" data-dismiss="modal" aria-hidden="true">取消</button> <button class="m-btn purple">提交</button>
						</div>
					</div>
		<!--end sarcasm-->
		<!--Login modal begin-->		
					<div id="modal-container-login" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h3 id="myModalLabel">
								用户登陆
							</h3>
						</div>
						<div class="modal-body">
							<p>
								<form class="form-horizontal">
									<div class="control-group">
										 <label class="control-label" for="inputEmail">用户名：</label>
										<div class="controls">
											<input id="inputUsername" type="text"><span style="color:red;margin-left: 5px;" id="inputUsernameError"></span>
										</div>
									</div>
									<div class="control-group">
										 <label class="control-label" for="inputPassword">密码：</label>
										<div class="controls">
											<input id="inputPassword" type="password"><span style="color:red;margin-left: 5px;" id="inputPasswordError"></span>
										</div>
									</div>
									
								</form> 
							</p>
						</div>
						<div class="modal-footer">
							  <button class=" m-btn" data-dismiss="modal" aria-hidden="true">取消</button> <button id="loginSubmitBtn" class="m-btn purple">登陆</button>
						</div>
					</div>
		<!--Login modal end--> 

		<!--Register modal begin-->		
					<div id="modal-container-register" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h3 id="myModalLabel">
								用户注册
								
							</h3>
						</div>
						<div class="modal-body">
							<p>
								<form class="form-horizontal">
									<div class="control-group">
										 <label class="control-label" for="inputEmail">Email：</label>
										<div class="controls">
											<input id="regiinputEmail" type="text">
										</div>
									</div>
									<div class="control-group">
										 <label class="control-label" for="inputEmail">用户名：</label>
										<div class="controls">
											<input id="regiuername" type="text">
											<span id="regiError" style="color:red;"></span>
										</div>
									</div>
									<div class="control-group">
										 <label class="control-label" for="inputPassword">密码：</label>
										<div class="controls">
											<input id="regipwd" type="password">
										</div>
									</div>
									<div id="regiDivId" style="visibility:hidden;margin-left: 150px;" class="alert alert-success span5">
									   <a href="#" class="close" data-dismiss="alert">&times;</a>
									   <strong style="text-align:center;">注册成功！</strong>
									</div>
									
								</form> 
							</p>
						</div>
						<div class="modal-footer">
							  <button class=" m-btn" data-dismiss="modal" aria-hidden="true">取消</button> <button id="regiSendBtn" class="m-btn purple">注册</button>
						</div>
					</div>
		<!--Register modal end--> 
		<!--begin comment-->
					<div id="modal-container-comment" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
							<h3 id="myModalLabel">
								想对这部电影说点什么……？
							</h3>
						</div>
						<div class="modal-body">
							<p>
								<form class="form-horizontal">
									<textarea id="conmmentContentId" class="span12" placeholder="请输入您的评价信息……"></textarea>
								</form> 
							</p>
							<div id="commnetDivId" style="visibility:hidden;" class="alert alert-success text-center span10">
							   <a href="#" class="close" data-dismiss="alert">&times;</a>
							   <strong style="text-align:center;">评论成功！</strong>
							</div>
						</div>
						<div class="modal-footer">
							  <button class=" m-btn cancelBtn" data-dismiss="modal" aria-hidden="true">取消</button> <button id="sendConmmentId" class="m-btn purple">发表评论</button>
						</div>
					</div>
		<!--end comment-->
		
		<!-- end modal-->
			</div>
		</div>
<!-- end navbar row-->
	<div class="container">
		<div class="span8 alert alert-warning" style="margin-top: 30px;">
		   <a href="#" class="close" data-dismiss="alert">
			  &times;
		   </a>
		   <strong>您还没有登陆，请点击 导航栏的右端的 <span style="color:red;">“登陆”</span> ，个性化推荐引擎会根据当下您的用户兴趣模型产生推荐！</strong>
		</div>
		
	</div>
<!-- end container-->

<!-- begin footer-->
	<div style="margin-top:600px;line-height:100px;width:100%;background-color:#1b2e44;">
		<div class="container">
            <h5 class="text-center" style="color:white;">Copynright2009山东科技大学 物联网实验室 鲁ICQ05002356号</h5>
            <h5 class="text-center" style="color:white;">山东省青岛经济技术开发区前湾港路579号 邮编266590</h5>
              
		</div>
	</div> 
<!-- end footer-->
</body>

























