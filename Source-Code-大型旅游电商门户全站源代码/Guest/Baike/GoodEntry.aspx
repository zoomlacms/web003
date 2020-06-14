<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Guest/Baike/Baike.master" clientidmode="Static" inherits="Guest_GoodEntry, App_Web_ay0tfihc" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>词条分类-<%Call.Label("{$SiteName/}"); %>百科</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container">
<ol class="breadcrumb margin_top10">
<li>您的位置：<a href="/">网站首页</a></li>
<li><a href="/Baike" target="_self">百科中心</a></li>
<li class="active">词条列表</li>
</ol>
<div>
<table class="table table-bordered">
<asp:Repeater runat="server" ID="Classification">
<ItemTemplate> 
<tr><td><h2><a href="Details.aspx?soure=manager&tittle=<%#Server.UrlEncode(Eval("Tittle").ToString()) %>" target="_blank"><%#Eval("Tittle")%></a> <%#Eval("AddTime","{0:yyyy-MM-dd}") %></h2></td></tr>
</tbody>
</ItemTemplate>
</asp:Repeater>
</table>
</div>
<asp:Literal runat="server" ID="createbaike" Visible="false"></asp:Literal>
<div class="text-center">共有词条<asp:Label ID="AllNum" runat="server" Text=""></asp:Label>个
<asp:Label runat="server" ID="Toppage"></asp:Label>
<asp:Label runat="server" ID="Nextpage"></asp:Label>
<asp:Label runat="server" ID="Downpage"></asp:Label>
<asp:Label runat="server" ID="Endpage"></asp:Label>
页次：<asp:Label ID="Nowpage" runat="server"></asp:Label>/<asp:Label ID="PageSize" runat="server" ></asp:Label>页<asp:Label ID="Lable1" runat="server"></asp:Label>个记录/页 转到第<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"></asp:DropDownList>页
</div>
</div>
</asp:Content>