<%@ page language="C#" autoeventwireup="true" inherits="Manage_APP_AppTlpOnline, App_Web_el4xf40j" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
 <iframe src="http://app.zoomla.cn/App/AppTlp/MyTlpList.aspx" style="width:100%;height:100%; border:none;"></iframe>
        <script>
            $(function () {
                $('iframe').height($(parent.document).find('#main_right').height() - 20);
            })
        </script>
</asp:Content>
