<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Guest/Baike/Baike.master" clientidmode="Static" inherits="Guest_Baike_Class, App_Web_ay0tfihc" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>开放分类--<%Call.Label("{$SiteName/}"); %>百科</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container">
<ol class="breadcrumb margin_top10">
    <li>您的位置：<a href="/">网站首页</a></li>
    <li><a href="/Baike" target="_self">百科中心</a></li>
    <li class="active">按开放分类浏览</li>
</ol>
<div class="t1">按开放分类浏览</div>
<asp:Repeater ID="Repeater1" runat="server"  OnItemDataBound="Repeater1_ItemDataBound">
<ItemTemplate>
<dl class="categroy ft_l">
<dt><a name="renwu" href="Classification.aspx?ParentID=<%#Eval("ParentID") %>&GradeID=<%#Eval("GradeID") %>" title="<%#Eval("GradeName") %>"><%#Eval("GradeName") %></a></dt>
<dd>
<ul>
<asp:Repeater ID="Repeater2" runat="server">
<ItemTemplate>
<li class="listconList"><a href="Classification.aspx?ParentID=<%#Eval("ParentID") %>&GradeID=<%#Eval("GradeID") %>" title="<%#Eval("GradeName") %>"><%#Eval("GradeName") %></a></li> 
</ItemTemplate>
</asp:Repeater>
</ul>
<div class="k"></div>
</dd>
</dl>
</ItemTemplate>
</asp:Repeater>  
<div class="clearfix"></div> 
</div>
</asp:Content>
