<%@ page language="C#" autoeventwireup="true" inherits="manage_Polymeric_ClassManage, App_Web_o0gqinuy" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
        <title><%=Resources.L.聚合分类 %></title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-striped table-bordered table-hover">
        <tr align="center">
            <td class="title">
                
            </td>
            <td  class="title">
                <%=Resources.L.分类ID %>
            </td>
            <td class="style10">
                <%=Resources.L.分类名称 %>
            </td>
            <td class="style7">
                <%=Resources.L.排列顺序 %>
            </td>
            <td width="6%" class="title">
                 <%=Resources.L.操作 %>
            </td>
        </tr>
        <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'"
                    id="<%#Eval("ID") %>" ondblclick="ShowTabs(this.id)">
                    <td height="22" align="center">
                        <input name="Item" type="checkbox" value='<%#Eval("ID") %>' />
                    </td>
                    <td height="22" align="center">
                        <%#Eval("ID")%>
                    </td>
                    <td height="22" align="center">
                        <%#Eval("ClassName")%>
                    </td>
                    <td height="22" align="center">
                        <%#Eval("Orderid")%>
                    </td>
                    <td height="22" align="center">
                        <a href="AddClass.aspx?menu=edit&id=<%#Eval("ID")%>" class="option_style"><i class="fa fa-pencil" title="<%=Resources.L.修改 %>"></i></a> <a href="?menu=delete&id=<%#Eval("ID")%>" OnClick="return confirm('<%=Resources.L.确实要删除此信息 %>?');" class="option_style"><i class="fa fa-trash-o" title="<%=Resources.L.删除 %>"></i><%=Resources.L.删除 %></a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </table>
    <div>
        <asp:Button ID="Button3" class="btn btn-primary" runat="server" OnClientClick="return confirm('不可恢复性删除数据,你确定将该数据删除吗？');"
            Text="<%$Resources:L,批量删除 %>" /></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
     <script type="text/javascript">
         var tID = 0;
         var arrTabTitle = new Array("TabTitle0", "TabTitle1", "TabTitle2", "TabTitle3", "TabTitle4");
         var arrTabs = new Array("Div0", "Div1", "Div2", "Div3", "Div4");
         function ShowTabs(ID) {
             location.href = "Addclass.aspx?menu=edit&id=" + ID + "";
         }
         function CheckAll(spanChk)//CheckBox全选
         {
             var oItem = spanChk.children;
             var theBox = (spanChk.type == "checkbox") ? spanChk : spanChk.children.item[0];
             xState = theBox.checked;
             elm = theBox.form.elements;
             for (i = 0; i < elm.length; i++)
                 if (elm[i].type == "checkbox" && elm[i].id != theBox.id) {
                     if (elm[i].checked != xState)
                         elm[i].click();
                 }
         }
     </script>
</asp:Content>