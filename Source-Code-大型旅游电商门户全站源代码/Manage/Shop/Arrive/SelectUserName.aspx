<%@ page language="C#" autoeventwireup="true" inherits="manage_Shop_Arrive_SelectUserName, App_Web_r4uh5uu0" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>查询用户</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table width="100%" cellspacing="1" cellpadding="0" class="table table-striped table-bordered table-hover">
        <tr>
            <td class="text-center" colspan="7" class="title" style="width: 100%">客 户 列 表</td>
        </tr>
        <tr>
            <td class="text-center" font-weight: bold">ID</td>
            <td class="text-center" font-weight: bold">会员名称</td>
            <td class="text-center" font-weight: bold">会员组别</td>
            <td class="text-center" font-weight: bold">操作</td>
        </tr>
        <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='4' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr>
                    <td class="text-center">
                        <%#Eval("UserID")%>
                    </td>
                    <td class="text-center">
                        <%#Eval("UserName")%>
                    </td>
                    <td class="text-center">
                        <%#Eval("GroupID", "{0}") == "1" ? "普通会员" : "企业会员"%>
                    </td>
                    <td class="text-center">
                        <a href="SelectUserName.aspx?menu=select&id=<%#Eval("UserID") %>">选择</a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/Dialog.js"></script>
    <script type="text/javascript">
        function onstr() {
            window.opener = null;
            parent.Dialog.close();
        }
        function setvalue(objname, valuetxt) {
            var mainright = window.top.main_right;
            mainright.document.getElementById(objname).value = valuetxt;
        }
    </script>
</asp:Content>




