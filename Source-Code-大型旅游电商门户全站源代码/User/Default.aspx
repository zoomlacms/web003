<%@ page language="C#" autoeventwireup="true" inherits="User_Default, App_Web_jvhma4wn" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %><!DOCTYPE html>
<%@ Register Src="~/User/ASCX/DefaultTop.ascx" TagName="UserMenu" TagPrefix="ZL" %><!DOCTYPE html>
<%@ Register Src="~/Manage/I/ASCX/UserInfoBar.ascx" TagPrefix="ZL" TagName="UserBar" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>会员中心</title>
<link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="/dist/css/font-awesome.min.css"/>
<link type="text/css" rel="stylesheet" href="/App_Themes/User.css" />
<link href="/Template/Travel/style/global.css?id=20150909" rel="stylesheet"/>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/dist/js/bootstrap.min.js"></script> 
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top user_nav">
<div class="container">
<!-- Brand and toggle get grouped for better mobile display -->
<div class="navbar-header">
<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="sr-only">Toggle navigation</span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="/"><img src="<%:Call.LogoUrl %>" alt="<%:Call.SiteName %>" /></a>
</div>
<!-- Collect the nav links, forms, and other content for toggling -->
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav" style="padding-left:80px;">
<li class="active"><a href="/User/">主页</a></li>
<li><a href="/User/Content/MyContent.aspx?NodeID=2">我的记忆</a></li>
<li><a href="/User/Content/MyContent.aspx?NodeID=4">我的影像</a></li>
<!--<li><a href="/Ask">问答</a></li>-->
<!--<li><a href="/User/Content/CommentList.aspx">点评</a></li>-->
</ul>
<form action="/Class_28/NodeElite.aspx" class="navbar-form navbar-left" role="search" method="get" target="_blank">
<div class="form-group">
<input type="text" class="form-control" placeholder="关键词…" name="K" />
</div>
<button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button>
</form>
<ul class="nav navbar-nav navbar-right">
<li><button type="button" class="btn btn-primary" onClick="SinIn();">签到</button></li>
<li class="dropdown">
<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">消息 <span class="caret"></span></a>
<ul class="dropdown-menu" role="menu">
<li></li>
<li><a href="/user/Message/Message.aspx">我的消息</a></li>
</ul>
</li>
<li class="dropdown">
<a href="#" class="dropdown-toggle user_face" data-toggle="dropdown" role="button" aria-expanded="false"><%Call.Label("{ZL.Label id=\"获取当前用户头像\" /}");%> <span class="caret"></span></a>
<ul class="dropdown-menu" role="menu" style="right:-5px;">
<li><span></span></li>
<li><a href="/User/"><i class="fa fa-home"></i> 我的主页</a></li>
<li><a href="/User/Content/AddContent.aspx?ModelID=46&NodeID=2"><i class="fa fa-edit"></i> 发表游记</a></li>
<!--<li><a href="/Ask"><i class="fa fa-question-circle"></i> 我的问答</a></li>-->
<li><a href="/User/UserFriend/Default.aspx"><i class="fa fa-users"></i> 我的好友</a></li>
<li><a href="/User/Content/MyFavori.aspx?type=1"><i class="fa fa-heart"></i> 我的收藏</a></li>
<!--<li><a href="/User/Order/OrderList.aspx"><i class="fa fa-shopping-cart"></i> 我的订单</a></li>-->
<li><a href="/User/LogOut.aspx"><i class="fa fa-sign-out"></i> 安全退出</a></li>
</ul>
</li>
</ul>
</div><!-- /.navbar-collapse -->
</div><!-- /.container-fluid -->
</nav>
<div style="height:60px;"></div>
<div class="myuser_body">
<div class="container">
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="myuser_left">
<%Call.Label("{ZL.Label id=\"输出当前登录用户信息\" /}");%>

<div class="myuser_left_s">
<input type="text" class="form-control" placeholder="搜索我的文章" />
<button type="button" class="btn btn-default"><i class="fa fa-search"></i></button>
</div><!--myuser_left_s end-->

<div class="myuser_left_g">
<div class="myuser_left_gt">我的关注</div>
<div class="row padding10">
<ul>
<%Call.Label("{ZL.Label id=\"获取当前用户好友列表\" ClassName=\"col-lg-4 col-md-3 col-sm-3 col-xs-12 padding5\" ShowNum=\"6\" /}");%>
</ul>
</div>
<div class="text-right"><a href="/User/UserFriend/Default.aspx">更多>></a></div>
</div><!--myuser_left_g end-->
<div class="myuser_left_f">
<div class="myuser_left_ft">最近访客</div>
<div class="row padding10">
<ul>
<%Call.Label("{ZL.Label id=\"输出当前用户最近访客列表\" ShowNum=\"8\" /}");%>
</ul>
</div>
<div class="myuser_left_fb"><span>累计访问<b><%Call.Label("{ZL.Label id=\"输出当前用户累计访问数\" /}");%></b></span><span>今日<b><%Call.Label("{ZL.Label id=\"输出当前用户今日访问数\" /}");%></b></span></div>
</div><!--myuser_left_f end-->
</div>
</div>

<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
<div class="myuser_right">
<div class="myuser_right_t">
<ul>
<li><a href="/User/Content/Note/note.aspx?id=0&nodeid=2"><span><i class="fa fa-edit"></i></span>写游记</a></li>
<li><a href="/User/Content/AddContent.aspx?ModelID=3&NodeID=4"><span><i class="fa fa-photo"></i></span>发图片</a></li>
<li><a href="/Ask" target="_blank"><span><i class="fa fa-commenting" style="margin-top:0;"></i></span>问达人</a></li>
<div class="clearfix"></div>
</ul>
</div>

<div class="myuser_youji">
<div class="myuser_youji_t">我的记忆</div>
<ul class="media-list">
<%Call.Label("{ZL.Label id=\"输出当前用户游记列表\" NodeID=\"2\" TitleNum=\"60\" ShowNum=\"3\" SysNum=\"240\" /}");%>
</ul>
<!--<div class="text-center"><a href="#">显示更多<i class="fa fa-angle-down"></i></a></div>-->
</div><!--myuser_youji end-->




</div><!--myuser_right end-->
</div>

</div>
</div>
<form id="form1" runat="server">
<div class="u_info" hidden>
<div class="container">
<div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 u_face">
<a href="/User/Info/UserInfo.aspx"><asp:Image ID="imgUserPic" AlternateText="" onerror="this.src='/images/userface/noface.gif'" runat="server" /></a>
<ZL:UserBar ID="UserBar_U" runat="server" Width="100" />
</div>
<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 u_syn">
<ul class="list-unstyled">
<li>
<ul class="list-unstyled">
<li><i class="glyphicon glyphicon-user"></i>会员名称：<asp:Label ID="UserNameLb" runat="server" Text=""></asp:Label></li>
<li>等级： <asp:Literal id="LvIcon_Li" runat="server"></asp:Literal> <asp:Label ID="UserLvLb" runat="server" Text=""></asp:Label></li>
<li>加入时间：<asp:Label ID="UserRegTimeLb" runat="server" Text=""></asp:Label></li>
</ul>
</li>
<li><i class="glyphicon glyphicon-map-marker"></i>地址：<asp:Label ID="UserAddressLb" runat="server" Text=""></asp:Label></li>
<li><i class="glyphicon glyphicon-edit"></i>个性签名：<asp:Label ID="UserSignLb" runat="server" Text=""></asp:Label></li>
<li>
<ul class="list-unstyled">
<li><i class="glyphicon glyphicon-usd"></i><a href="/PayOnline/SelectPayPlat.aspx" target="_blank">余额：<asp:Label ID="UserYeLb" runat="server" Text=""></asp:Label></a></li>
<li>银币：<asp:Label ID="UserJbLb" runat="server" Text=""></asp:Label></li><li>积分：<asp:Label ID="UserJfLb" runat="server" Text=""></asp:Label></li>
</ul>
</li>
</ul>
</div>
</div>
</div>
<div class="u_site margin_t5" hidden>
<div class="container">
<ol class="breadcrumb">
<li><a href="/User/">会员中心</a></li>
<li class="active">功能引导</li>
</ol>
</div>
</div> 
<div class="container" hidden>  
<div class="u_menu">
    <asp:Literal ID="UserApp_Li" runat="server" EnableViewState="false"></asp:Literal>
<div class="clearfix"></div>
</div>
</div> 
<div class="u_menu_more text-center" hidden>
<a href="javascript:;" id="more_btn" title="点击显示更多">More <i class="fa fa-angle-double-down"></i></a>
</div>
<div class="user_menu_sub" hidden> 
<ul class="list-unstyled text-center">
<asp:Literal runat="server" ID="onther_lit" EnableViewState="false"></asp:Literal>
</ul>
<div class="clearfix"></div>
</div>  
<%Call.Label("{ZL.Label id=\"全站底部\"/}");%>
</form>
</body>
</html>
<script> 
$().ready(function (e) {//菜单颜色配置
	var colorArr=new Array('#c47f3e','#669933','#27a9e3','#f05033','#990066','#9999FF','#E48632','#990000','#22afc2','#6633FF','#9900FF','#1FA67A');
	var count=$(".user_menu_sub li").length;
	for(var i=0; i<count; i++){
		$(".user_menu").eq(i).css("background",colorArr[i%12]);	
	}
    if ($(".user_menu_sub li").length < 1)
        $(".u_menu_more").remove();
})
$("#mimenu_btn").click(function(e) { 
	if($(".user_mimenu_left").width()>0){ 
 		$(".user_mimenu_left ul").fadeOut(100);
		$(".user_mimenu_left").animate({width:0},200); 	
	}
	else{ 
		$(".user_mimenu_left").animate({width:150},300); 
		$(".user_mimenu_left ul").fadeIn();
	}
});
//会员菜单更多显示/隐藏
$("#more_btn").click(function(e) {
	if($(".user_menu_sub").css("display")=="none"){  
	    $(".user_menu_sub").slideDown();
		$(this).find("i").removeClass("fa-angle-double-down");
		$(this).find("i").addClass("fa-angle-double-up");
	}
	else {  
	    $(".user_menu_sub").slideUp(200); 
		$(this).find("i").removeClass("fa-angle-double-up");
		$(this).find("i").addClass("fa-angle-double-down");
	}
});
//会员搜索
$("#sub_btn").click(function(e) { 
    if($("#key").val()=="")
		alert("搜索关键字为空!");
	else
		window.location="/User/SearchResult.aspx?key="+escape($("#key").val());	
});
//搜索回车事件
function IsEnter(obj) {
	if (event.keyCode == 13) {
		$("#sub_btn").click(); return false;
	}
}
function SinIn(e) {
	$.post("/API/UserSinIn.ashx?action=sinin", { localtion: "1" }, function (data) {
	if (data == "-1") { alert("你今天已签过到了"); }
	else if (data != "" && data != "-1") { alert("签到成功！") }
	else { alert("您尚未登录！！"); }
	});
}
</script>