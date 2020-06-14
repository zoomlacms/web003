<%@ page language="C#" autoeventwireup="true" inherits="manage_User_Agent, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>管理员设置</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
  <div>
    <table class="table table-striped table-bordered table-hover">
      <tr class="tdbg">
        <td align="center" colspan="5" class="title" width="100%">代理商管理</td>
      </tr>
      <tr class="tdbg">
        <td align="center" class="tdbgleft" style="height: 24px; width:8%; font-weight:bold">ID</td>
        <td align="center" class="tdbgleft" style="height: 24px; font-weight: bold">代理商</td>
        <td align="center" class="tdbgleft" style="height: 24px; font-weight: bold">代理房间</td>
        <td align="center" class="tdbgleft" style="height:24px;   font-weight:bold">代理时间</td>
        <td align="center" class="tdbgleft" style="height: 24px;  font-weight: bold">操作</td>
      </tr>
      <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
        <ItemTemplate>
          <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
            <td align="center" style="height: 24px;"><%#Eval("ID")  %></td>
            <td align="center" style="height: 24px;"><%#GetName(Eval("UserID","{0}"))%></td>
            <td align="center" style="height: 24px;"><%#Eval("AgentRoomID")%></td>
            <td align="center" style=" height:24px;"><%#Eval("AgentTime")%></td>
            <td align="center" style="height: 24px;"><a href="?menu=delete&id=<%#Eval("ID")%>" onclick="return confirm('确实要删除此信息吗？');">删除</a></td>
          </tr>
        </ItemTemplate>
          <FooterTemplate></FooterTemplate>
      </ZL:ExRepeater>
    </table>
  </div>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="../../js/Drag.js"></script>
    <script type="text/javascript" src="../../js/Dialog.js"></script>
</asp:Content>