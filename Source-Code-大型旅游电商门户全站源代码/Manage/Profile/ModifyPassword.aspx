<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.ModifyPassword, App_Web_2af4rwv0" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title><%=Resources.L.修改密码 %></title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
  <div>
    <table class="table table-bordered table-hover">
      <tr>
        <td colspan="2" style="text-align:center;"><strong><%=Resources.L.修改密码 %></strong></td>
      </tr>
        <tr>
            <td class="td_l"><strong><%=Resources.L.当前管理员 %>：</strong></td>
            <td>
                <asp:Label ID="AdminName_L" runat="server"></asp:Label>
            </td>
        </tr>
      <tr>
        <td><strong><%=Resources.L.输入旧密码 %>：</strong></td>
        <td><asp:TextBox ID="TxtOldPassword" class="form-control text_md" runat="server" TextMode="Password" onkeydown="return GetEnterCode('focus','TxtPassword');"/>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TxtOldPassword" runat="server" ErrorMessage="<%$Resources:L,原密码不能为空 %>" Display="Dynamic" /></td>
      </tr>
      <tr>
        <td><strong><%=Resources.L.输入新密码 %>：</strong></td>
        <td><asp:TextBox ID="TxtPassword" class="form-control text_md" runat="server" TextMode="Password" onkeydown="return GetEnterCode('focus','TxtPassword2');"/>
          <asp:RequiredFieldValidator ID="ValrUserPassword" ControlToValidate="TxtPassword"
                    runat="server" ErrorMessage="<%$Resources:L,新密码不能为空 %>" Display="Dynamic" />
          <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TxtPassword" ErrorMessage="<%$Resources:L,管理员密码字符数要在6到18之间 %>" ValidationExpression="\S{6,18}" SetFocusOnError="True" Display="None"></asp:RegularExpressionValidator>
          <asp:CompareValidator ID="VNotEquel" runat="server" Operator="NotEqual" ControlToValidate="TxtPassword" ControlToCompare="TxtOldPassword" ErrorMessage="<%$Resources:L,新密码不能与旧密码一致 %>"></asp:CompareValidator>
      </tr>
      <tr>
        <td><strong><%=Resources.L.重复新密码 %>：</strong></td>
        <td><asp:TextBox ID="TxtPassword2" class="form-control text_md" runat="server" TextMode="Password" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="TxtPassword2"
                    runat="server" ErrorMessage="<%$Resources:L,确认密码不能为空 %>" Display="Dynamic" />
          <asp:CompareValidator ID="CompareValidator1" ControlToValidate="TxtPassword2" ControlToCompare="TxtPassword" ErrorMessage="<%$Resources:L,新密码和确认密码不一致 %>" runat="server" /></td>
      </tr>
      <tr>
        <td colspan="2" class="modifypwd_td"><asp:Button ID="BtnSubmit" runat="server" class="btn btn-primary" Text="<%$Resources:L,修改 %>" OnClick="BtnSubmit_Click" />
          <asp:Button ID="BtnCancle" class="btn btn-primary" runat="server" Text="<%$Resources:L,重写 %>" OnClick="BtnCancle_Click" ValidationGroup="BtnCancel" />
          <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" /></td>
      </tr>
    </table>
  </div>
    <script>
        $().ready(function () {
            $("#TxtOldPassword").focus();
        });
    </script>
</asp:Content>
