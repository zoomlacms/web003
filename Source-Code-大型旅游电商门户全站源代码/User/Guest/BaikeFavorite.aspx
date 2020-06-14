<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Guest_BaikeFavorite, App_Web_wdy2krpc" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>百科收藏</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
     <div id="pageflag" data-nav="index" data-ban="baike"></div>
    <div class="container margin_t10">
<ol class="breadcrumb">
	<li>您现在的位置：<a href="/"><%= Call.SiteName%></a></li>
    <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
    <li class="active">百科收藏</li>
	<div class="clearfix"></div>
</ol>
        </div>
<div class="container">
<div class="us_seta">
<table class="table table-bordered table-striped table-hover">
    <tr class="title">
        <td>已收藏词条</td>
        <td>收藏时间</td>
    </tr>
    <ZL:ExRepeater ID="Repeater_baike" PagePre="<tr><td colspan='2' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>" runat="server" OnItemDataBound="Repeater_baike_ItemDataBound">
        <ItemTemplate>
            <tr onmouseover="this.className='tdbgmouseover'" onmouseout="this.className='tdbg'" class="tdbg">
                <td style="width: 70%; line-height: 22px; padding-left: 10px;">
                    <%--<a href='/Guest/Baike/Details.aspx?soure=manager&tittle=<%#Server.UrlEncode(Eval("Tittle").ToString()) %>' target="_blank" ><%# Eval("Tittle")%></a><br />--%>
                    <a href='/Guest/Baike/Details.aspx?soure=manager&tittle=<%#Server.UrlEncode(getTitle(Eval("InfoID").ToString())) %>' target="_blank"><%#getTitle(Eval("InfoID").ToString())%></a>
                </td>
                <td style="width: 28%; line-height: 22px; padding-left: 10px;"><%#Convert.ToDateTime(Eval("FavoriteDate")).ToString("yyyy-MM-dd")%></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate></FooterTemplate>
    </ZL:ExRepeater>
</table>
</div>
    </div>
</asp:Content>