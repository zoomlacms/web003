<%@ page language="C#" autoeventwireup="true" inherits="AppBack, App_Web_jvhma4wn" enableviewstatemac="false" masterpagefile="~/Common/Common.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>APP登录</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<center style="background: url(http://code.zoomla.cn/user_login.jpg); background-position: center; left: 0; top: 0; right: 0; bottom: 0; position: absolute; background-repeat: no-repeat; background-size: cover;">
<div class="user_mimenu">
<div class="navbar navbar-fixed-top" role="navigation">
	<button type="button" class="btn btn-default" id="mimenu_btn">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	</button>
	<div class="user_mimenu_left">
		<ul class="list-unstyled">
			<li><a href="/" target="_blank">首页</a></li>
			<li><a href="/Home" target="_blank">能力</a></li>
			<li><a href="/Index" target="_blank">社区</a></li>
			<li><a href="/Ask" target="_blank">问答</a></li>
			<li><a href="/Guest" target="_blank">留言</a></li>
			<li><a href="/Baike" target="_blank">百科</a></li>
			<li><a href="/Office" target="_blank">OA</a></li>
		</ul>
	</div>
	<div class="navbar-header">
		<button class="navbar-toggle in" type="button" data-toggle="collapse" data-target=".navbar-collapse">
			<span class="sr-only">移动下拉</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	</div>
</div>
</div>
<div class="user_login">
<h3><span class="glyphicon glyphicon-refresh"></span>请在这里完成注册绑定</h3>
<ul class="list-unstyled">
	<li>
		<i class="fa fa-user"></i>
		<asp:TextBox ID="UserName_T" placeholder="输入会员名" runat="server" CssClass="form-control text_max" />
		<asp:RegularExpressionValidator ID="R4" runat="server" ControlToValidate="UserName_T" ErrorMessage="不能包含特殊字符" ValidationExpression="^[^@#$%^&*()'?{}\[\];:]*$" Display="Dynamic" ForeColor="Red" ValidationGroup="Reg"/>
		<asp:RequiredFieldValidator ID="ValrTxtUserName" runat="server"  ErrorMessage="输入会员名!" ForeColor="Red" ControlToValidate="UserName_T" Display="dynamic" SetFocusOnError="True" ValidationGroup="Reg"/>
	</li>
	<li>
		<i class="fa fa-envelope"></i>
		<asp:TextBox ID="Email_T" placeholder="邮箱" CssClass="form-control text_max" runat="server" />
		<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ErrorMessage="输入会员名!" ForeColor="Red" ControlToValidate="Email_T" Display="dynamic" SetFocusOnError="True" ValidationGroup="Reg" />
		<asp:RegularExpressionValidator ID="RE2" runat="server" ControlToValidate="Email_T" Display="Dynamic" ForeColor="Red" ErrorMessage="邮件地址不规范"  ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ValidationGroup="Reg"/>
	</li>
	<li>
		<i class="fa fa-lock"></i>
		<asp:TextBox ID="UserPwd_T" placeholder="密码" runat="server" CssClass="form-control text_max" TextMode="Password" />
		<asp:RequiredFieldValidator ID="p1" runat="server" ControlToValidate="UserPwd_T" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ErrorMessage="密码不能为空!" ValidationGroup="Reg"/>
		<asp:RegularExpressionValidator ID="p2" runat="server" ControlToValidate="UserPwd_T" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ErrorMessage="密码最少6位!" ValidationExpression="^(([a-zA-Z0-9]){6,20}$)" ValidationGroup="Reg"/>
	</li>
	<li>
		<i class="fa fa-lock"></i>
		<asp:TextBox ID="ConfirmPwd_T" placeholder="确定密码" runat="server" CssClass="form-control text_300" TextMode="Password" />
		<asp:RequiredFieldValidator ID="cp1" runat="server" ControlToValidate="ConfirmPwd_T" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ErrorMessage="密码不能为空!" ValidationGroup="Reg"/>
		<asp:CompareValidator ID="req2" runat="server" ControlToValidate="ConfirmPwd_T" ControlToCompare="UserPwd_T"
			Operator="Equal" SetFocusOnError="false"  ErrorMessage="两次密码输入不一致" Display="Dynamic" ForeColor="Red" ValidationGroup="Reg"/>
	</li>
	<li class="text-center">
		<asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="提交" OnClick="Register_Click" ValidationGroup="Reg" />
	</li>
</ul>
</div>
</center>
<asp:Button runat="server" ID="QQAudit_Btn" OnClick="QQAudit_Btn_Click" Visible="false" style="display:none;" ValidationGroup="Audit"/>
<div runat="server" id="reg_div" style="margin:0 auto;width:500px;">
<asp:HiddenField ID="OpenID_Hid" runat="server" />
<asp:HiddenField ID="Token_Hid" runat="server" />
</div>
<div runat="server" visible="false" id="QQ_Div">
<asp:Literal runat="server" ID="Script_Lit"></asp:Literal>
<div>绑定进行中,请稍等片刻</div>
<div style="display: none;">
<asp:HiddenField runat="server" ID="QQ_OpenID_Hid" />
<asp:HiddenField runat="server" ID="QQ_Token_Hid" />
</div>
<script>
function QQBind() {
	QC.Login.getMe(function (openId, accessToken) {
		$("#QQ_OpenID_Hid").val(openId);
		$("#QQ_Token_Hid").val(accessToken);
		//$("#QQAudit_Btn").click();
		$.post("", { source: "qq", "openid": openId }, function (data) {
			if (data == 1) {
				location = "<%=targetUrl%>";
			}
			else {
				//注册绑定
				$("#QQ_Div").hide();
				$("#reg_div").show();
			}
		})
	});
}
</script>
</div>
<div runat="server" visible="false" id="WeChat_Div"></div>
<div runat="server" visible="false" id="Baidu_Div">
<%--        <script type="text/javascript" src="http://openapi.baidu.com/connect/js/v2.0/featureloader"></script>--%>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script>
    $(function () {
        $("#TxtUserName").focus();
        //$("#VCode").ValidateCode();
    });
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
</script>
</asp:Content>