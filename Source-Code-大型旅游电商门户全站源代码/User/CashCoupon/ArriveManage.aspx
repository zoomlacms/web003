<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_CashCoupon_ArriveManage, App_Web_gsbxlsiq" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>优惠劵管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
 <div id="pageflag" data-nav="group" data-ban="ArriveManage"></div>
<div class="container margin_t5">
	<ol class="breadcrumb">
    	<li><a href="#"><%= Call.SiteName%></a></li>
        <li><a href="/User/">会员中心</a></li>
        <li><a href="/User/Info/UserInfo.aspx">账户管理</a></li>
        <li>优惠劵管理</li> 
    </ol>
</div>
    <div class="container">
    <div class="us_seta u_cnt" runat="server" id="DV_show">
        <table width="100%" cellpadding="2" cellspacing="1" class="table table-striped table-bordered table-hover">
            <tr>
                <td colspan="7" class="text-center">我的优惠劵</td>
            </tr>
            <tr>
                <td align="center" width="20%">编号</td>
                <td align="center" width="15%">密码</td>
                <td align="center" width="10%">金额</td>
                <td align="center" width="15%">生成时间</td>
                <td align="center" width="15%">到期时间</td>
                <td align="center" width="15%">使用时间</td>
                <td align="center" width="10%">状态 </td>
            </tr>
            <ZL:ExRepeater ID="Manufacturerslist" runat="server" PagePre="<tr><td colspan='7' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>" OnItemCommand="Manufacturerslist_ItemCommand" OnItemDataBound="Manufacturerslist_ItemDataBound">
                <ItemTemplate>
                    <tr class="tdbg" onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'">
                        <td height="24" align="center">
                            <asp:HiddenField ID="hfId" runat="server" Value='<%# Eval("id") %>' />
                            <%#Eval("arriveNO")%></td>
                        <td height="24" align="center">
                            <asp:HiddenField ID="hfpwd" runat="server" Value='<%# Eval("id") %>' />
                            <%#Eval("arrivePwd")%></td>
                        <td height="24" align="center"><%#Eval("amount")%></td>
                        <td height="24" align="center"><%#Eval("againTime", "{0:yyyy-MM-dd}")%></td>
                        <td height="24" align="center"><%#Eval("endTime", "{0:yyyy-MM-dd}")%></td>
                        <td height="24" align="center"><%#GetUseTime(Eval("useTime", "{0}"))%></td>
                        <td height="24" align="center">
                            <asp:Label ID="lblState" runat="server" Text='<%# GetState(Eval("State","{0}")) %>'></asp:Label></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate></FooterTemplate>
            </ZL:ExRepeater>
        </table>
    </div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script language="javascript" type="text/javascript" src="../../JS/SelectCheckBox.js"></script>
    <script language="javascript" type="text/javascript">
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