<%@ page language="C#" autoeventwireup="true" inherits="manage_AddOn_SelectProjectName, App_Web_3fsbufm5" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>查询用户</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
     <table  class="table table-striped table-bordered table-hover">
        <tr class="tdbg">
            <td align="center" colspan="7" >
                客 户 列 表
            </td>
        </tr>
        <tr class="tdbg">
            <td align="center" class="tdbgleft" style="height: 24px; width: 5%; font-weight: bold">
                ID
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 15%; font-weight: bold">
                客户名称
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 10%; font-weight: bold">
                客户类别
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 15%; font-weight: bold">
                客户编号
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 10%; font-weight: bold">
                客户组别
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 15%; font-weight: bold">
                客户来源
            </td>
            <td align="center" class="tdbgleft" style="height: 24px; width: 10%; font-weight: bold">
                操作
            </td>
        </tr>
        <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='8' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr class="tdbg">
                    <td align="center" style="height: 24px;">
                        <%#Eval("Flow")%>
                    </td>
                    <td align="center" style="height: 24px;">
                        <a href="SelectProjectName.aspx?menu=select&id=<%#Eval("Flow") %>"><%#Eval("P_name")%></a>
                    </td>
                    <td align="center" style="height: 24px;">
                        <%#Eval("Client_Type","{0}")=="1"?"企业":"个人"%>
                    </td>
                    <td align="center" style="height: 24px;">
                        <%#Eval("Code")%>
                    </td>
                    <td align="center" style="height: 24px;">
                        <%#Eval("Client_Group")%>
                    </td>
                    <td align="center" style="height: 24px;">
                        <%#Eval("Client_Source")%>
                    </td>
                    <td align="center" style="height: 24px;">
                        <a href="SelectProjectName.aspx?menu=select&id=<%#Eval("Flow") %>">选择</a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript">
        function onstr() {
            parent.Dialog.close();
        }

        function setvalue(objname, valuetxt) {
            if (window.top != window.self) {
                $(parent.document).find("#" + objname).val(valuetxt);
                parent.CloseCurDiag();
                return;
            }
            var mainright = window.top.main_right;
            mainright.frames["main_right_" + parent.nowWindow].document.getElementById(objname).value = valuetxt;
        }
</script>
</asp:Content>