<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Guest/Ask/Ask.master" inherits="Guest_MoreProblems, App_Web_0d0sqtu3" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>问题列表-<%Call.Label("{$SiteName/}"); %>问答</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container">
<ol class="breadcrumb">  
<li>您的位置：<a href="/">网站首页</a></li>
<li><a href="/Ask">问答中心</a></li>
<li class="active">搜索列表</li>
</ol>
<div class="alert alert-danger" role="alert">
最佳回答采纳率:<%=getAdoption() %>，已解决问题数:<% =getSolvedCount() %>，待解决问题数:<% =getSolvingCount() %>，当前在线:</span><%=getLogined() %>，注册用户:<%=getUserCount() %>
</div>
</div>
<div class="container">
<div class="ask_Resolved">
<div class="ask_Resolved_t">问题列表</div>
<div class="ask_Resolved_c">
<div class="ask_Resolved_cr">
<ul class="list-unstyled">
<asp:Repeater runat="server" ID="repSearch"><ItemTemplate>                                            
<li>
<strong><%#getcount(Eval("ID", "{0}"))%>回答</strong>
<a target="_self" href="SearchDetails.aspx?ID=<%#Eval("ID")%>"><%#Eval("Qcontent")%></a>
<span>[<a target="_self" href="List.aspx?QueType=<%#Eval("QueType")%>&strwhere="><%#gettype(Eval("QueType","{0}"))%></a>]</span>
</li>
</ItemTemplate></asp:Repeater>
<div class="clearfix"></div>
</ul>
<div style="text-align:center">共<asp:Label ID="AllNum" runat="server" Text=""></asp:Label>条记录
<asp:Label runat="server" ID="Toppage"></asp:Label>
<asp:Label runat="server" ID="Nextpage"></asp:Label>
<asp:Label runat="server" ID="Downpage"></asp:Label>
<asp:Label runat="server" ID="Endpage"></asp:Label>
页次：<asp:Label ID="Nowpage" runat="server"></asp:Label>/<asp:Label ID="PageSize" runat="server" ></asp:Label>页<asp:Label ID="Lable1" runat="server"></asp:Label>条记录/页 转到第<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" ></asp:DropDownList>页
</div>
</div>
</div>
</div>
</div>
</asp:Content>