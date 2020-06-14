<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="User_login, App_Web_jvhma4wn" enableviewstatemac="false" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<link href="/App_Themes/User.css"rel="stylesheet" type="text/css"/>
<title>用户登录-<%:Call.SiteName %></title>
<style>
.user_login { padding-bottom:30px; position:relative; left:0; top:0; margin-left:0; width:auto; background:#fff;}
.login_type_div { background:url(../Template/Travel/style/images/userbg1.jpg) repeat-x bottom;}
.login_type_div a { display:block; float:left; width:50%; height:50px; line-height:50px; color:#505050; text-align:center;}
.login_type_div a:hover { color:#e65e42;}
.login_type_div a.active { background:url(../Template/Travel/style/images/userbg2.jpg) bottom repeat-x; color:#e65e42;}
.applgntype .btn { margin-bottom:10px;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<center style="background:url(/Template/Travel/style/images/userbg.jpg) ;background-position: center;left:0;top:0;right:0;bottom:0; position: absolute; background-repeat:no-repeat;background-size:cover;">

<div class="container" style="margin-top:15%;">
<div class="row">
<div class="col-lg-6 col-md-6 col-sm-8 col-xs-12 col-md-offset-3 col-sm-offset-3">
<!--<div class="text-center" style="margin-bottom:30px;"><a href="/"><img src="<%:Call.LogoUrl %>" alt="<%:Call.SiteName %>" /></a></div>-->
<div class="user_login">
<div class="row">
<div class="col-lg-8 col-md-6 col-sm-6 col-xs-12 user_login_l">
<div class="login_type_div">
<a href="login.aspx" id="ut"><i class="fa fa-user"></i> 用户名登录</a>
<a href="login.aspx?RegID=1" id="ut1"><i class="fa fa-envelope"></i> 使用邮箱登录</a>
<div hidden>
<a id="User_A" runat="server" href="login.aspx"><span class="glyphicon glyphicon-user"></span> 用户名登录</a>
<a id="EMail_A" href="login.aspx?RegID=1" runat="server"><span class="glyphicon glyphicon-envelope"></span> 使用邮箱登录</a>
<a id="ID_A" runat="server" href="login.aspx?RegID=2" class="hidden"><span class="glyphicon glyphicon-info-sign"></span> 使用ID登录</a>
</div>
<div class="clearfix"></div>
</div>
<ul>
<li><i class="fa fa-user"></i>
<asp:TextBox ID="TxtUserName" autofocus="true" placeholder="用户名" onblur="CheckUserCode()" runat="server" CssClass="form-control"></asp:TextBox>
<asp:HyperLink ID="hlReg" runat="server" NavigateUrl="~/User/login.aspx?RegID=1" title="E-mail登录"><span class="glyphicon glyphicon-envelope"></span></asp:HyperLink>
<asp:HyperLink ID="uidReg" runat="server"  NavigateUrl="~/User/login.aspx?RegID=2" title="用户ID登录"><span class="glyphicon glyphicon-align-justify"></span></asp:HyperLink>
</li>
<li><i class="fa fa-lock"></i><asp:TextBox ID="TxtPassword" placeholder="密码" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox></li>
<li><div class="form-group" visible="false" id="trVcodeRegister" runat="server">
<asp:TextBox ID="VCode" placeholder="验证码" MaxLength="6" runat="server" CssClass="form-control codestyle" style="display:inline;"></asp:TextBox>
<img id="VCode_img" title="点击刷新验证码" class="codeimg"  style="height:34px;margin-left:2px;width:25%;"/>
<input type="hidden" id="VCode_hid" name="VCode_hid" /></div></li>
<li id="usercode_li" style="display:none;">
<asp:TextBox ID="UserCode_T" runat="server" placeholder="动态口令" CssClass="form-control"></asp:TextBox>
</li>
<li class="margin_top0"><input type="checkbox" name="checkbox" checked="checked" id="checkbox" />记住登录<a href="/User/GetPassword.aspx" id="nopasswd">忘记密码？</a></li>
<li><asp:Button ID="btnLogin" CssClass="btn btn-info" OnClientClick="return ajaxlogin();" runat="server" Text="登 录" onclick="btnLogin_Click" /></li>
<li><a class="btn btn-default" id="reg_btn" href="Register.aspx">点此注册</a></li>
</ul>
</div>

<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 user_login_r">
<div runat="server" id="plat_li" style="margin-top:15px;">
<div>第三方平台登录：</div>
<div class="applgntype">
<asp:LinkButton ID="appSina" Visible="false" ToolTip="新浪" class="plat_sp" runat="server" OnClick="appSina_Click" CssClass="btn btn-danger btn-block"><i class="fa fa-weibo"></i> 新浪微博登录</asp:LinkButton>
<span id="qq_span" runat="server" title="腾迅" visible="false" class="plat_sp"><a href="#" runat="server" id="qq_a" class="btn btn-primary btn-block"><i class="fa fa-qq"></i> 腾讯账号登录</a></span>
<asp:LinkButton ID="appBaidu" Visible="false" ToolTip="百度" class="btn btn-warning btn-block" runat="server" OnClick="appBaidu_Click"><i class="fa fa-paw"></i> 百度账号登录</asp:LinkButton>
</div>
</div>
</div>
<!--user_login_r end-->
</div>
</div>
<!--user_login-->
<div id="main_s" style="display:none">
<ul>
<li style="color:green; font-size:14px; font-weight:bold">欢迎您！登录成功</li>
<li style="margin-top:25px;">系统将在 <span id="sec">3</span> 秒后自动跳转到<a href="MemoView.aspx">会员首页</a></li>
</ul>
</div>
</div>
</div>
</div>
</center>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script type="text/javascript" src="/JS/ZL_ValidateCode.js"></script>
<script type="text/javascript">
var sts = 3;//登录后跳转等待时间;单位：秒
function sucse(s, url) {
	if (s == 1) {//成功
		document.getElementById("main_l").style.display = "none";
		document.getElementById("main_s").style.display = "";
		document.getElementById("sec").innerHTML = sts;
		setInterval(loacationgoto, 1000);
	}
	else {
		document.getElementById("main_l").style.display = "";
		document.getElementById("main_s").style.display = "none";
	}
}
function BtnTj() {
	var username = document.getElementById("TxtUserName");
	var userpass = document.getElementById("TxtPassword");
	var VCode = document.getElementById("VCode");
	if (username.value == "") {
		username.focus();
		return false;
	}
	if (userpass.value == "") {
		userpass.focus();
		return false;
	}
	if (VCode && VCode.value == "") {
		VCode.focus();
		return false;
	}
	return true;
}
$(function () {
	setTimeout("CheckUserCode()", 500);
	$("#VCode").ValidateCode();
})
function CheckUserCode() {
	var bl = true;
	$.ajax({
		url: '/API/UserCheck.ashx',
		data: { action: 'CheckKey', uname: $("#TxtUserName").val() },
		type: 'POST',
		success: function (data) {
			if (data == '1') {
				$("#usercode_li").show();
				bl = false;
			} else {
				$("#usercode_li").hide();
			}
		}
	});
	return bl;
}
//登录
var loginflag = false;
function ajaxlogin() {
	if (BtnTj()) {
		if (!loginflag) {
			$.ajax({
				type: 'POST',
				data: { action: 'login', user: $("#TxtUserName").val(), pwd: $("#TxtPassword").val(), VCode_hid: $("#VCode_hid").val(), vcode: $("#VCode").val(), zncode: $("#UserCode_T").val() },
				success: function (data) {
					if (data != "True") {
						$("#btnLogin").popover({
							animation: true,
							placement: 'left',
							content: '<span style="color:red;"><span class="glyphicon glyphicon-info-sign"></span> ' + data + '!</span> <span style="color:#999">(双击隐藏)</span>',
							html: true,
							trigger: 'manual',
							delay: { show: 10000, hide: 100 }
						});
						$("#btnLogin").popover('show');
						$(".popover").dblclick(function () { $("#btnLogin").popover('destroy'); });
					} else {
						loginflag = true;
						$("#btnLogin").click();
					}
				}
			});
		}
	} else {
		return false;
	}
	return loginflag;
}
$("#mimenu_btn").click(function (e) {
	if ($(".user_mimenu_left").width() > 0) {
		$(".user_mimenu_left ul").fadeOut(100);
		$(".user_mimenu_left").animate({ width: 0 }, 200);
	}
	else {
		$(".user_mimenu_left").animate({ width: 150 }, 300);
		$(".user_mimenu_left ul").fadeIn();
	}
});
$().ready(function(e) {
    $("#ut<%Call.Label("{$GetRequest(RegID)$}");%>").addClass("active");
});
</script>
</asp:Content>