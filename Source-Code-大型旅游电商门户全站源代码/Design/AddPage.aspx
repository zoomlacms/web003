<%@ page language="C#" autoeventwireup="true" inherits="Design_AddPage, App_Web_hebe3frl" masterpagefile="~/Common/Common.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>新建页面</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-bordered table-striped">
        <tr><td class="td_m">访问路径：</td><td>
            <asp:TextBox runat="server" ID="Path_T" CssClass="form-control eng" MaxLength="50" />
            <asp:RequiredFieldValidator runat="server" ID="R1" ControlToValidate="Path_T" ErrorMessage="路径不能为空" ForeColor="Red" />
        </td></tr>
        <tr><td class="td_m">页面标题：</td><td>
            <asp:TextBox runat="server" ID="Title_T" CssClass="form-control" MaxLength="50" />
            <asp:RequiredFieldValidator runat="server" ID="R2"  ControlToValidate="Title_T" ErrorMessage="标题不能为空" ForeColor="Red" />
        </td></tr>
        <tr><td></td><td><asp:Button runat="server" ID="Save_Btn" CssClass="btn btn-primary" Text="新建页面" OnClick="Save_Btn_Click" /></td></tr>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script"></asp:Content>