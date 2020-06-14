<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="User_MobileReg" MasterPageFile="~/Common/Master/Empty.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>用户注册-<%:Call.SiteName %></title>
<link href="/App_Themes/User.css" rel="stylesheet">
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<center style="background:url(/Template/Travel/style/images/userbg.jpg) ;background-position: center;left:0;top:0;right:0;bottom:0; position: absolute; background-repeat:no-repeat;background-size:cover;">
<div class="user_login_container clearbox">
<div class="user_login_box">
<div class="your_phone">
<div class="denglu">
<asp:TextBox runat="server" ID="Mobile_T" CssClass="form-control num" placeholder="手机号" Text="" />
<asp:TextBox runat="server" ID="VCode_T" CssClass="form-control" MaxLength="6" Width="160" placeholder="验证码" style="float:left;" />
<input type="button" value="获取验证码" class="btn btn-warning" onclick="SendMsg(this);" style="float:right; margin-top:15px;"/>
<div class="clearfix"></div>
<asp:TextBox runat="server" ID="Passwd_T" CssClass="form-control" placeholder="密码" TextMode="Password" />
<asp:TextBox runat="server" ID="ConfirmPasswd_T" CssClass="form-control" placeholder="确认密码" TextMode="Password" />
</div>
<div class="zhuce_box">
<div class="or1"><a href="RegPlat.aspx">或使用邮箱注册</a></div>
<asp:Button runat="server" ID="Sure_Btn" Text="注册用户" OnClick="Sure_Btn_Click" />
<p><span>注册视为同意</span>《<a href="/Item/2189.aspx" target="_blank" title="TO行用户使用协议">TO行用户使用协议</a>》</p>
</div>
<div class="mid_line"></div>
</div>
<div class="other_type">
<p>已有账户<a href="/User/Login.aspx">直接登陆</a>或使用第三方登录</p>
<ul>
<li><a href="https://api.weibo.com/oauth2/authorize?client_id=1849901260&redirect_uri=http%3A%2F%2Fwww.toxingbaike.com%2Fuser%2FAPPBack.aspx%3FType%3Dsina&response_type=code&display=default"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-weibo fa-stack-1x fa-inverse"></i></span><br/>新浪微博</a></li>
<li><a href="https://graph.qq.com/oauth/show?which=Login&display=pc&client_id=101300268&response_type=token&scope=all&redirect_uri=http://toxingbaike.com"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-qq fa-stack-1x fa-inverse"></i></span><br/>QQ</a></li>
<!--li><a href="#"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-weixin fa-stack-1x fa-inverse"></i></span><br/>微信</a></li-->
<!--li><a href="#"><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-renren fa-stack-1x fa-inverse"></i></span><br/>人人网</a></li-->
</ul>
</div>
</div>
</div>

<div class="input-group">
<span class="input-group-btn">
</span>
</div>
</center>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script src="/JS/Modal/APIResult.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<script src="/JS/ZL_ValidateCode.js"></script>
<script>
    $(function () {
        ZL_Regex.B_Num("num");
        //$("form").validate({});
        //$.validator.addMethod("phones", function (value) {
        //    return ZL_Regex.isMobilePhone(value);
        //}, "请输入正确的手机号码!");
    })
    function WaitFor(obj, time) {
        var text = obj.value;
        setTimeout(function () { obj.disabled = true; }, 50);
        var a = setInterval(
			function () {
			    time = time - 1;
			    obj.value = "请等待(" + time + ")秒";
			}, 1000);
        setTimeout(function () { obj.disabled = false; clearInterval(a); obj.value = text; }, time * 1000);
    }
    function SendMsg(obj) {
        var mobile = $("#Mobile_T").val();
        var passwd = $("#Passwd_T").val();
        var confpwd = $("#ConfirmPasswd_T").val();
        if (!ZL_Regex.isMobilePhone(mobile)) { alert("手机号码不正确"); return; }
        if (passwd != confpwd) { alert("密码与确认密码不匹配"); return; }
        WaitFor(obj, 30);
        $.post("/API/Mod/Mobile.ashx?action=mobilereg", { "mobile": mobile }, function (data) {
            var model = APIResult.getModel(data);
            if (APIResult.isok(model)) { console.log(model.retmsg); }
            else { alert(model.retmsg); }
        })
    }
    //function test()
    //{
    //    $.post("/API/Mod/Mobile.ashx?action=test", {  }, function (data) {
    //        var model = APIResult.getModel(data);
    //        console.log(model.retmsg);
    //    })
    //}
</script>
</asp:Content>