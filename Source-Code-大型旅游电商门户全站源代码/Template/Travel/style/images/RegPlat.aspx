<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegPlat.aspx.cs" Inherits="User_RegPlat" ClientIDMode="Static" %><!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<title>用户注册</title>
<%Call.Label("{ZL:Boot()/}"); %>
<link href="/App_Themes/User.css" rel="stylesheet">
<style>
#Step1_Div .or2 a { color:#999;}
#Step1_Div #Email_T { margin-bottom:0;}
#Step1_Div a { margin:0; color:#989898;}
#Step1_Div a:hover { color:#ff7000;}
.user_login_box li .form-control { margin-top:10px; border-radius:0;}
</style>
<script src="/JS/ICMS/ZL_Common.js"></script>
<script type="text/javascript">
    function showme() {
        $("#Step2_Div").show();
        ShowMask();
    }
    function closeme() {
        $("#Step2_Div").hide();
        $("#MaskLayer_Div").hide();
    }
    function ShowMask() {
        var sw = $(window).width();
        var sh = $(window).height();
        $("#MaskLayer_Div").css({ "display": "", "position": "fixed", "background": "#000", "z-index": "1", "-moz-opacity": "0.5", "opacity": ".50", "filter": "alpha(opacity=50)", "width": sw, "height": sh });
    }
</script>
</head>
<body class="PlatReg">
<form id="form1" runat="server">
<center style="background:url(/Template/Travel/style/images/userbg.jpg) ;background-position: center;left:0;top:0;right:0;bottom:0; position: absolute; background-repeat:no-repeat;background-size:cover;">
<div style="display:none" id="MaskLayer_Div"></div>  
<div runat="server" visible="false" id="Step1_Div">
<div class="user_login_container1 clearbox">
<div class="user_login_box">
<div class="your_phone">
<div class="denglu" style="margin-bottom:0;">
<asp:TextBox runat="server" ID="Email_T" placeholder="邮箱账号" type="email" class="form-control" />
<asp:RequiredFieldValidator runat="server" ID="s1" ControlToValidate="Email_T" Display="Dynamic" ErrorMessage="邮箱不能为空" ForeColor="Red" ValidationGroup="sg1" />
<asp:RegularExpressionValidator runat="server" ID="s2" ControlToValidate="Email_T" Display="Dynamic" ErrorMessage="邮箱格式不正确" ForeColor="Red" ValidationGroup="sg1" />
</div>
<div class="zhuce1_box">
<div class="or2"><a href="Register.aspx">或使手机号码注册</a></div>
<asp:Button runat="server" ID="Step1_Btn" Text="立即注册" OnClientClick="disBtn(this,3000);" OnClick="Step1_Btn_Click" CssClass="btn btn-warning" ValidationGroup="sg1" />
<a style="color:white; text-decoration:none; cursor:pointer;"><div class="zhuce"></div></a>
<p><span>注册视为同意</span>《<a href="/Item/2189.aspx" target="_blank" title="TO行用户使用协议">TO行用户使用协议</a>》</p>
</div>
<div class="mid_line"></div>
</div>
<div class="other_type">
<p>已有账户？<a href="/User/Login.aspx">直接登陆</a>或使用第三方登陆</p>
<ul>
<li><a href="api.weibo.com/oauth2/authorize?client_id=1849901260&redirect_uri=http%3A%2F%2Fwww.toxingbaike.com%2Fuser%2FAPPBack.aspx%3FType%3Dsina&response_type=code&display=default"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-weibo fa-stack-1x fa-inverse"></i></span><br/>新浪微博</a></li>
<li><a href="https://graph.qq.com/oauth/show?which=Login&display=pc&client_id=101300268&response_type=token&scope=all&redirect_uri=http://toxingbaike.com"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-qq fa-stack-1x fa-inverse"></i></span><br/>QQ</a></li>
<!--li><a href="#"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-weixin fa-stack-1x fa-inverse"></i></span><br/>微信</a></li-->
<!--li><a href="#"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-renren fa-stack-1x fa-inverse"></i></span><br/>人人网</a></li-->
</ul>
</div>
</div>
</div>
</div>
<div runat="server" id="Step2_Div" style="background-color:white;width:600px;border-radius:5px;position:absolute;top:40%;left:30%;padding-left:20px;padding:20px 20px 20px 20px;z-index:2;display:none;">
<div style="position:absolute;right:-20px;top:-20px;cursor:pointer;" title="关闭" onclick="closeme();" ><span class="glyphicon glyphicon-remove" style="color:white;"></span></div>
<div style="padding:0 0 20px 0;"><span>我们已经发送注册邮件到您的邮箱，请点击邮件中的激活链接完成注册。</span></div>
<div style="padding:0 0 20px 0;"><span style="font-size:20px;font-weight:bold;margin-left:10px;">请验证您的邮箱完成注册...</span></div>
<div>
<asp:HyperLink runat="server" Text="前往邮箱激活注册" CssClass="btn btn-primary" Target="_blank" ID="MailSite_A"  />
<span style="float:right;margin-top:15px;"><a href="#">重发邮件?</a><a href="#" style="margin-left:10px;">收不到邮件?</a></span></div>
</div>
<div runat="server" id="Step3_Div" visible="false"> 
<div class="user_login_container1 clearbox">
<div class="user_login_box">
<h4 style="margin-top:0; color:#999;" class="text-center"><i class="fa fa-user"></i><asp:Label runat="server" ID="UserName_L" /></h4>
<ul style="margin-bottom:0;">
<li>
<asp:TextBox runat="server" ID="TrueName_T" placeholder="真实姓名" CssClass="form-control" />
<asp:RequiredFieldValidator runat="server" ID="tr1" Display="Dynamic"  ForeColor="Red" ErrorMessage="真实姓名不能为空" ControlToValidate="TrueName_T" ValidationGroup="reg" />
</li>
<li runat="server" visible="false" id="compli" hidden><asp:TextBox runat="server" ID="CompName_T" placeholder="企业名称" CssClass="form-control" /></li>
<li hidden><asp:TextBox runat="server" ID="Post_T" placeholder="职位" CssClass="form-control"  /></li>
<li hidden>
<asp:TextBox runat="server" ID="Mobile_T" placeholder="手机" CssClass="form-control" />
<asp:RegularExpressionValidator runat="server" ID="m1" ForeColor="Red" ValidationExpression="" ErrorMessage="手机格式不正确" Display="Dynamic" ControlToValidate="Mobile_T" ValidationGroup="reg"/>
</li>
<li><asp:TextBox runat="server" ID="Pwd_T" placeholder="密码" CssClass="form-control" TextMode="Password"  />
<asp:RequiredFieldValidator runat="server" ID="pv1" Display="Dynamic"  ForeColor="Red" ErrorMessage="密码不能为空" ControlToValidate="Pwd_T" ValidationGroup="reg" />
<asp:RegularExpressionValidator runat="server" ID="pv2" ValidationExpression="^((.){6,15}$)" Display="Dynamic"  ForeColor="Red" ErrorMessage="密码最小6位，最大15位！" ControlToValidate="Pwd_T" ValidationGroup="reg" />
</li>
<li>
<asp:TextBox runat="server" ID="CPwd_T" placeholder="确认密码" CssClass="form-control" TextMode="Password" style="border-bottom:1px solid #ddd;"/><br />
<asp:RequiredFieldValidator runat="server" ID="v1" Display="Dynamic"  ForeColor="Red" ErrorMessage="确认密码不能为空" ControlToValidate="CPwd_T" ValidationGroup="reg" />
<asp:CompareValidator runat="server" ID="v2" ForeColor="Red" ErrorMessage="密码与确认密码不匹配" Display="Dynamic" ControlToCompare="Pwd_T" ControlToValidate="CPwd_T" ValidationGroup="reg" />
</li>
<li hidden><span><input type="checkbox" style="margin-right:5px;height:auto;width:auto;" checked="checked" />阅读并同意<a href="#" title="使用条款">《使用条款》</a></span></li>
<li style="margin-top:10px;"><asp:Button runat="server" ID="Sub_Btn" Text="完成注册" OnClientClick="disBtn(this,2000);" OnClick="Sub_Btn_Click" CssClass="btn btn-primary btn-block" ValidationGroup="reg"/></li>
</ul> 
</div>
</div>
</div>


</center>
</form>
</body>
</html>