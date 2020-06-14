<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="manage_Qmail_AddMailIdiograph, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register TagPrefix="ZL" TagName="UserGuide" Src="~/Manage/I/ASCX/UserGuide.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>签名管理</title>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
  <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
    <table width="100%" border="0" cellpadding="2" cellspacing="1" class="table table-striped table-bordered table-hover">
      <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdleft td_l"><strong>签名标签：</strong></td>
        <td><asp:TextBox ID="txtName" runat="server" class="form-control" style="max-width:350px;"></asp:TextBox></td>
      </tr>
      <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdleft"><strong>签名内容：</strong></td>
        <td>
            <asp:TextBox ID="txtContext" class="text_500" Height="150" runat="server" TextMode="MultiLine" ></asp:TextBox>
            <%=Call.GetUEditor("txtContext",2) %>
        </td>
      </tr>
      <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
        <td class="tdleft"><strong>签名状态：</strong></td>
        <td><asp:RadioButtonList ID="rblState" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="True" Selected="true">启用</asp:ListItem>
            <asp:ListItem Value="False">禁用</asp:ListItem>
          </asp:RadioButtonList></td>
      </tr>
      <tr class="tdbg">
        <td colspan="2" align="center"><asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="提  交" OnClick="Button1_Click" /></td>
      </tr>
    </table>
  </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>
