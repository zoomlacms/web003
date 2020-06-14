<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Common/Common.master" inherits="Common_DBFileUpload, App_Web_tqaa0d1h" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>文件入库</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div style="height:100%;width:100%;">
    <ZL:FileUpload ID="FupFile" runat="server" style="display:inline; line-height:10px;" /> 
    <asp:Button ID="BtnUpload" runat="server" Text="上传" CssClass="btn btn-info btn-xs" OnClick="BtnUpload_Click" />
    <asp:RequiredFieldValidator ID="ValFile" runat="server" ErrorMessage="请选择上传路径" ForeColor="Red" ControlToValidate="FupFile"></asp:RequiredFieldValidator>
    <asp:Label ID="LblMessage" runat="server" ForeColor="red"></asp:Label>
</div>
</asp:Content> 


