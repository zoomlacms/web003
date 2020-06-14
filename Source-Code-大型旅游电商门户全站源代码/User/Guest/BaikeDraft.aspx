<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Guest_BaikeDraft, App_Web_wdy2krpc" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>草稿箱</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="pageflag" data-nav="index" data-ban="baike"></div>
<div class="container margin_t10">   
<ol class="breadcrumb">
	<li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
    <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
    <li class="active">词条草稿箱 </li>
	<div class="clearfix"></div>
</ol>
    </div> 
<div class="container">
<div class="us_seta">
<table class="table table-bordered table-striped table-hover">
    <tr class="title">
        <td>词条</td>
        <td>添加时间</td>
    </tr>
    <ZL:ExRepeater ID="Repeater_baike" PagePre="<tr><td colspan='2' class='text-center'>" PageEnd="</td></tr>" runat="server">
        <ItemTemplate>
            <tr onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'" class="tdbg">
                <td style="width: 70%; line-height: 22px; padding-left: 10px;">
                    <a href='/Guest/Baike/Details.aspx?soure=manager&tittle=<%#Server.UrlEncode(Eval("Tittle").ToString()) %>' target="_blank"><%# Eval("Tittle")%></a>
                </td>
                <td style="width: 26%; padding-left: 10px;"><%--<label runat="server" id="lbstatus"></label>--%><%#Convert.ToDateTime(Eval("EditTime")).ToString("yyyy-MM-dd")%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate></FooterTemplate>
    </ZL:ExRepeater>
</table>
</div>
</div>
</asp:Content>