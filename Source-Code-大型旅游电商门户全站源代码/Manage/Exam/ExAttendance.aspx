<%@ page language="C#" autoeventwireup="true" inherits="manage_Question_ExAttendance, App_Web_hdcjfwq5" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
        <title>考试成绩管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
        <table  class="table table-striped table-bordered table-hover">
        <tr align="left" class="tdbg">
            <td >
                    选择考勤日期：开始时间：<asp:TextBox ID="TextBox1" runat="server" CssClass="l_input" Width="140" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });"></asp:TextBox>    结束结束：<asp:TextBox ID="TextBox2" runat="server" CssClass="l_input" Width="140" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd'});"></asp:TextBox> 
                考生姓名：<asp:TextBox ID="UserName" runat="server" CssClass="l_input"></asp:TextBox> <asp:Button ID="Button1" runat="server" Text="确定" CssClass="C_input" />
            </td>
        </tr>
    </table>
    <div class="clearbox">
    </div>
    <table class="table table-striped table-bordered table-hover">
        <tr align="center" class="title">
            <td width="2%">
                <asp:CheckBox ID="Checkall" onclick="javascript:CheckAll(this);" runat="server" />
            </td>
            <td width="10%">
                考生姓名
            </td>
            <td width="10%">
                登录时间
            </td>
            <td width="10%">
                当前位置<font color="#FFFFFF">(课程>>课件)</font>
            </td>
            
            <td width="6%" class="title">
                操作
            </td>
        </tr>
        <ZL:ExRepeater ID="RPT" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
            <ItemTemplate>
                <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'"
                    id="<%#Eval("AttID") %>" ondblclick="ShowTabs(this.id)">
                    <td height="22" align="center">
                        <input name="Item" type="checkbox" value='<%#Eval("AttID") %>' />
                    </td>
                    <td height="22" align="center">
                        <%#Eval("StuName")%>
                    </td>
                    <td height="22" align="center">
                        <%#Eval("LogTime")%>
                    </td>
                    <td height="22" align="center">
                        <%#getCousrewareNameByLocation(Eval("Location").ToString()) %>
                    </td>
                    <td height="22" align="center">
                        <a href="ExExamination.aspx?cid=<%#Eval("AttID")%>" class="option_style"><i class="fa fa-pencil" title="修改"></i></a> 
                        <a href="?menu=delete&cid=<%#Eval("AttID")%>" onclick="return confirm('确实要删除此学员?');" class="option_style"><i class="fa fa-trash-o" title="删除"></i>删除</a>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </table>
    <div>
        <asp:Button ID="Button3" class="btn btn-primary" runat="server" OnClientClick="return confirm('不可恢复性删除数据,你确定将该数据删除吗？');"
            Text="批量删除" OnClick="Button3_Click" /></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript">
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
    <script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
</asp:Content>