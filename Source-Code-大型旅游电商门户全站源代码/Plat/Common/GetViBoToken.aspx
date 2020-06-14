<%@ page language="C#" autoeventwireup="true" inherits="Plat_Common_GetViBoToken, App_Web_der3fr05" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>用户绑定</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
      <div>绑定进行中,请稍等片刻</div>
        <div style="display:none;">
        <asp:HiddenField runat="server" ID="OpenID_Hid" />
        <asp:HiddenField runat="server" ID="Token_Hid" />
        <asp:Button runat="server" ID="QQBind_Btn" OnClick="QQBind_Btn_Click" /></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="<%:ZoomLa.Components.PlatConfig.QQKey %>" data-callback="true" charset="utf-8"></script>
    <script src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript">
        function QQBind() {
            QC.Login.getMe(function (openId, accessToken) {
                $("#OpenID_Hid").val(openId);
                $("#Token_Hid").val(accessToken);
                $("#QQBind_Btn").click();
            });
        }
        QQBind();
    </script>
</asp:Content>