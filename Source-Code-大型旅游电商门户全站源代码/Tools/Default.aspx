<%@ page language="C#" autoeventwireup="true" inherits="Tools_Default, App_Web_xtddbdid" masterpagefile="~/Common/Common.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>维护工具</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <style>
        #login_div li{margin-top:10px;text-align:center;}
        #login_div{margin-top:10%;}
    </style>
    <div id="login_div" runat="server" visible="false"> 
        <ul style="list-style:none; margin-left:30px;">
            <li><asp:TextBox ID="UserName_T" placeholder="用户名" runat="server" CssClass="form-control text_300"/></li>
            <li><asp:TextBox TextMode="Password" ID="UserPwd_T" placeholder="密码" runat="server" CssClass="form-control text_300"/></li>
            <li>
                <asp:TextBox ID="VCode" runat="server" placeholder="验证码" CssClass="form-control text_300 code"/>
                <img id="VCode_img" title="点击刷新验证码" class="code"  style="height:34px;"/>
                <asp:HiddenField runat="server" id="VCode_hid" />
            </li>
            <li><asp:Button ID="Login_Btn" runat="server" CssClass="btn btn-primary text_300" OnClick="Login_Btn_Click" Text="登录" /></li>
        </ul>
    </div>
    <div id="config_div" runat="server">
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <td class="td_l">配置文件检测:</td>
                <td><asp:Button ID="Check_Btn" runat="server" OnClick="Check_Btn_Click" Text="开始检测" /></td>
            </tr>
            <tr>
                <td>恢复发布配置:</td>
                <td><asp:Button ID="Update_Btn" runat="server" OnClick="Update_Btn_Click" Text="开始修复" /></td>
            </tr>
            <tr><td>关闭HTTPS</td><td><asp:Button runat="server" ID="Close_Btn" Text="关闭HTTPS" OnClick="Close_Btn_Click" /></td></tr>
            <tr><td>开发模式:</td><td><asp:Button runat="server" ID="Develop_Btn" Text="开启" OnClick="Develop_Btn_Click" /></td></tr>
        </table>
        <div class="alert alert-info" role="alert" runat="server" id="FileInfo_Div" visible="false">
            <table class="table">
                <thead>
                    <tr><td class="td_lg">文件名</td><td>是否存在</td></tr>
                </thead>
                <asp:Literal ID="Files_Li" runat="server" EnableViewState="false"></asp:Literal>
            </table>
        </div>
    </div>
    
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <style>.code{display:none;}</style>
    <script src="/JS/ZL_ValidateCode.js"></script>
    <script>
        function EnableCode() {
            if ($(".code").is(":hidden")) {
                $(".code").show();
                $("#VCode_img").click();
                $("#VCode").ValidateCode();
            }
        }
    </script>
</asp:Content>