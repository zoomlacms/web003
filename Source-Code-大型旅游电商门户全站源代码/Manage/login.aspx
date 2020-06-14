<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.Manage.login, App_Web_vdm1nh5v" masterpagefile="~/Common/Common.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/IE6.ascx" TagName="IE6" TagPrefix="IE6" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>管理登录</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<IE6:IE6 runat="server" />
<center style="background:url(<%=Call.GetRandomImg()%>);background-position: center;left:0;top:0;right:0;bottom:0; position: absolute; background-repeat:no-repeat;background-size:cover;">
<div class="manage_login">
<ul class="list-unstyled">
<li class="manage_logo"><img src="<%:Call.LogoUrl%>" class="img-thumbnail" alt="<%:Call.SiteName%>_后台管理系统" /></li>
<li><i class="fa fa-user"></i>
<asp:TextBox ID="TxtUserName" TabIndex="1" runat="server" size="20"  class="form-control input-control" autocomplete="off" 
placeholder="帐户" onkeydown="return GetEnterCode('focus','TxtPassword');" autofocus="true"/></li>
<li><i class="fa fa-lock"></i>
<asp:TextBox ID="TxtPassword" runat="server" TabIndex="2" TextMode="Password" MaxLength="18" 
    class="form-control input-control" autocomplete="off" placeholder="密码" onkeydown="return GetEnter();" /><br />
<asp:RequiredFieldValidator ID="p1" runat="server" ControlToValidate="TxtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="True" ErrorMessage="密码不能为空!" />
</li>
<li id="safecode" runat="server"><asp:TextBox ID="TxtAdminValidateCode"  runat="server" MaxLength="6" class="form-control input-control" size="20" /></li>
<li id="CodeLi" runat="server" visible="false">
   <asp:TextBox ID="VCode" runat="server" class="form-control input-control" MaxLength="6" TabIndex="3" autocomplete="off" placeholder="验证码" onkeydown="return GetEnterCode('click','IbtnEnter');"/>
   <img id="VCode_img" runat="server" title="点击刷新验证码" class="code" style="float:right; width:130px; height:34px; "/>
   <input type="hidden" id="VCode_hid" name="VCode_hid" />
   <div class="clearfix"></div>
</li>
<li id="ZnCode_Li" runat="server" visible="false">
<asp:TextBox ID="ZnCode_T" CssClass="form-control input-control" runat="server" placeholder="动态口令"></asp:TextBox>
</li>
<li>
<%--    <asp:Button runat="server" ID="IbtnEnter" CssClass="btn btn-info apply_btn" Text="登录" OnClientClick="" OnClick="IbtnEnter_Click"/>--%>
    <input type="button" id="IbtnEnter" class="btn btn-info apply_btn" value="登录" onclick="return ajaxlogin();" />
    <asp:Button runat="server" ID="RealBtn" style="display:none;" OnClick="IbtnEnter_Click" />
</li>

<li><a href="AccountForm.aspx" visible="false" id="test_Link" runat="server" class="btn btn-default apply_btn" target="_blank">申请测试帐号</a></li> 
<li> 
<a href="/" target="_blank" title="首页"><span class="glyphicon glyphicon-home"></span></a>
<a href="/Help.html" target="_blank" title="帮助"><span class="glyphicon glyphicon-globe"></span></a>
<a href="http://help.zoomla.cn/Database/" target="_blank" title="数据字典"><span class="glyphicon glyphicon-book"></span></a>
</li>
</ul>
</div>
</center>
<div class="bolang1 footimg" style="bottom: -30.8598px;"></div>
<div class="bolang2 footimg" style="bottom: -0.831503px;"></div>
<%--<nav class="navbar navbar-default navbar-fixed-bottom logfoot" role="navigation"></nav>--%>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style type="text/css">
    .popover{width:300px; text-align:center;}
</style>
<link rel="stylesheet" href="/App_Themes/V3.css?id=20150520" />
<script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
<script type="text/javascript" src="/JS/ZL_ValidateCode.js"></script>
<script type="text/javascript" src="/JS/jquery.easing.js"></script>
<script>
    $(function () {
        if ($("#Apple_Hid").val() == "1") location = "default.aspx";
        $("#VCode").ValidateCode();
        if (self != top) { top.location = self.location; }
    })
    function GetEnter() {
        return $("#VCode").length > 0 ? GetEnterCode('focus', 'VCode') : GetEnterCode('click', 'IbtnEnter');
    }
    var loginflag = false;
    function ajaxlogin() {
        if (!loginflag) {
            $("#IbtnEnter").attr('disabled', 'disabled');
            $("#IbtnEnter").val('登录中..');
            $.post("", { action: 'login', user: $("#TxtUserName").val(), pwd: $("#TxtPassword").val(), VCode_hid: $("#VCode_hid").val(), vcode: $("#VCode").val(), zncode: $("#ZnCode_T").val() },
                function (data) {
                    $("#IbtnEnter").removeAttr('disabled');
                    if (data != "True") {
                        $("#IbtnEnter").val('登录');
                        $("#IbtnEnter").popover({
                            animation: true,
                            placement: 'bottom',
                            content: '<span style="color:red;"><span class="glyphicon glyphicon-info-sign"></span> ' + data + '!</span> <span style="color:#999">(双击隐藏)</span>',
                            html: true,
                            trigger: 'manual',
                            delay: { show: 10000, hide: 100 }
                        });
                        $("#IbtnEnter").popover('show');
                        $(".popover").dblclick(function () {
                            $("#IbtnEnter").popover('destroy');
                            event.preventDefault();
                        });
                        //setTimeout(function () { $("#IbtnEnter").popover('destroy'); }, 2000);
                    } else {
                        loginflag = true;
                        $("#RealBtn").click();
                    }
                });
            return loginflag;
        }
    }
    function PrePageInit() {
       <%-- $.post("<%:CustomerPageAction.customPath2%>Default.aspx");--%>
    }
    //-----------------------------------
    //波浪效果
    var yueAnimate = {
        lbyFun: function () {
            $(".bolang1").css({ "bottom": "-36px" });
            $(".bolang2").css({ "bottom": "0" });
            $(".bolang1").animate({
                "bottom": "0"
            }, 1500, 'easeInCubic');
            $(".bolang1").animate({
                "bottom": "-36px"
            }, 1500, 'easeInCubic');

            $(".bolang1").animate({
                "bottom": "0"
            }, 1500, 'easeInCubic');
            $(".bolang1").animate({
                "bottom": "-36px"
            }, 1500, 'easeInCubic');

            $(".bolang2").animate({
                "bottom": "-24px"
            }, 1000, 'easeInCubic');
            $(".bolang2").animate({
                "bottom": "0"
            }, 1000, 'easeInCubic');

            $(".bolang2").animate({
                "bottom": "-24px"
            }, 1000, 'easeInCubic');
            $(".bolang2").animate({
                "bottom": "0"
            }, 1000, 'easeInCubic');

            $(".bolang2").animate({
                "bottom": "-24px"
            }, 1000, 'easeInCubic');
            $(".bolang2").animate({
                "bottom": "0"
            }, 1000, 'easeInCubic');
        },

    }
    setInterval(yueAnimate.lbyFun, 6000);
    setInterval(yueAnimate.btntop, 2000);

    var gotoAnchor = function (selector, isauto) {
        var anchor = $(selector);
        if (anchor.length < 0) return;
        var $win = $(window);
        var $body = $(window.document.documentElement);
        var ua = navigator.userAgent.toLowerCase();
        if (ua.indexOf("webkit") > -1) {
            $body = $(window.document.body)
        }
        var pos = anchor.offset();
        if (isauto) {
            var t = pos.top - $win.scrollTop(); //相对于屏幕显示区
            var t2 = $win.height() - t;
            if (t2 < anchor.outerHeight()) {
                $body.animate({ "scrollTop": pos.top }, "normal");
            }
            return;
        }
        $body.animate({ "scrollTop": pos.top }, { queue: false, complete: function () { shubiao = true; } });
    }
    yueAnimate.lbyFun();
</script>
</asp:Content>