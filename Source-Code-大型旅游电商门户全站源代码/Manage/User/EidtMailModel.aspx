<%@ page language="C#" autoeventwireup="true" inherits="manage_User_EidtMailModel, App_Web_ywbtvq50" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>邮件模板</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
<table class="table table-striped table-bordered table-hover">
  <tr class="tdbg">
    <td colspan="2" align="center" class="spacingtitle" > 编辑邮件模板</td>
  </tr>
  <tr style="width: 100%" class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
    <td style="white-space: normal; " class="tdleft td_l" ><strong>邮件标题：</strong></td>
    <td>
        <asp:TextBox ID="txtTitle" runat="server" Width="580px" class="form-control" ></asp:TextBox>
        </td>
  </tr>
  <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
    <td style="white-space: normal;  height: 69px;" class="tdleft" ><strong>邮件内容：</strong><br />
      (请在内容中使用<br />
      {UserName},{Url}<br />
      两个关键字符)</td>
       <td><asp:TextBox ID="txtContext" runat="server" TextMode="multiLine" Rows="15" class="form-control" style="max-width:580px"></asp:TextBox></td>
  </tr>
  <tr style="width: 100%" class="tdbg">
    <td colspan="2" align="center"><asp:Button ID="Button1" runat="server" Text="提  交"  class="btn btn-primary"/></td>
  </tr>
</table>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
</asp:Content>
