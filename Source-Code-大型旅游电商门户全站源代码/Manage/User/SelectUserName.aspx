<%@ page language="C#" autoeventwireup="true" inherits="manage_User_SelectUserName, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>查询用户</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
      <table class="table table-striped table-bordered table-hover">
    <tr class="tdbg">
      <td align="center" colspan="7" class="title" width="100%"> 客 户 列 表 </td>
    </tr>
    <tr class="tdbg">
      <td align="center" class="tdbgleft" style="height: 24px;  font-weight: bold">选择</td>
      <td align="center" class="tdbgleft" style="height: 24px;  font-weight: bold">ID</td>
      <td align="center" class="tdbgleft" style="height: 24px; font-weight: bold">会员名称</td>
      <td align="center" class="tdbgleft" style="height: 24px; font-weight: bold">会员组别</td>
      <td align="center" class="tdbgleft" style="height: 24px;  font-weight: bold">操作</td>
    </tr>
    <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
      <ItemTemplate>
        <tr>
          <td align="center" style="height: 24px;"><asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("UserName") %>' />
            <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("UserID") %>' />
            <asp:CheckBox ID="chkSel" runat="server" /></td>
          <td align="center" style="height: 24px;"><%#Eval("UserID")%></td>
          <td align="center" style="height: 24px;"><%#Eval("UserName")%></td>
          <td align="center" style="height: 24px;"><%#Eval("GroupID", "{0}") == "1" ? "普通会员" : "企业会员"%></td>
          <td align="center" style="height: 24px;"><a href="SelectUserName.aspx?menu=select&id=<%#Eval("UserID") %>">选择</a></td>
        </tr>
      </ItemTemplate>
    <FooterTemplate></FooterTemplate>
    </ZL:ExRepeater>
    <tr class="tdbg">
      <td class="tdbg" style="height: 24px;" colspan="5"><asp:CheckBox ID="CheckSelectAll" runat="server" AutoPostBack="True" OnCheckedChanged="CheckSelectAll_CheckedChanged" Text="全选" />
        <asp:Button ID="btnSelect" runat="server" class="btn btn-primary" OnClick="btnSelect_Click" OnClientClick="if(!IsSelectedId()){alert('请选择用户');return false;}else{return true;}" Text="批量投递用户" Width="134px" /></td>
    </tr>
  </table>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script type="text/javascript" src="../../JS/Dialog.js"></script>
    <script>
        function onstr() {
            parent.Dialog.close();
        }
    function setvalue(objname, valuetxt) {
        var mainright = top.frames["main_right"];
        //mainright.frames[parent.nowWindow].document.getElementById(objname).value = valuetxt;
        mainright.setValues(objname, valuetxt);
        }
</script>
</asp:Content>




