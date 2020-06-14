<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Manage/I/Default.master" inherits="manage_AddOn_InputProcess, App_Web_tpyqsobo" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>导入流程</title>
<script>
function onstr() {
	parent.Dialog.close();
}
function setvalue(objname, valuetxt) {
	parent.document.getElementById(objname).value = valuetxt;
}
</script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-bordered table-hover table-responsive">
	<tr class="tdbg">
		<td colspan="3" class="title" width="100%">流 程 列 表</td>
	</tr>
	<tr>
		<td class="tdbgleft">ID</td>
		<td class="tdbgleft">流程名称</td>
		<td class="tdbgleft">操作</td>
	</tr>
	<ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='3' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
		<ItemTemplate>
			<tr>
				<td><%#Eval("WorkID")%></td>
				<td><%#Eval("WorkName")%></td>
				<td><a href="InputProcess.aspx?menu=select&id=<%#Eval("WorkID") %>">选择</a></td>
			</tr>
		</ItemTemplate>
        <FooterTemplate></FooterTemplate>
	</ZL:ExRepeater>
</table>
</asp:Content>


