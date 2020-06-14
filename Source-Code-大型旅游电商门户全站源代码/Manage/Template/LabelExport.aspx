<%@ page language="C#" autoeventwireup="true" enableviewstatemac="false" inherits="ZoomLa.WebSite.Manage.Template.LabelExport, App_Web_m22flkqc" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>标签升级</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="panel panel-info">
        <div class="panel-heading"><i class="fa fa-flag"> 标签升级</i></div>
        <div class="panel-body">
            <div>升级标签：</div>
            <div>升级状态：<span style="color: Red"><asp:Label ID="Remind_L" runat="server"></asp:Label></span></div>
        </div>
        <div class="panel-footer">
            <asp:Button ID="OldVerUP_Btn" runat="server" class="btn btn-info" Text="早期标签升级" OnClick="Button1_Click" />
            <asp:Button ID="GlobalUP_Btn" runat="server" class="btn btn-primary" Text="国际版标签升级" OnClick="GlobalUP_Btn_Click" />
        </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
</asp:Content>
