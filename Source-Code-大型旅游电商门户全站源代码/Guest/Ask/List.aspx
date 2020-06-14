<%@ page language="C#" autoeventwireup="true" validaterequest="false" masterpagefile="~/Guest/Ask/Ask.master" inherits="Guest_AnswerList, App_Web_0d0sqtu3" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>问题列表-<%Call.Label("{$SiteName/}"); %>问答</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container"> 
<ol class="breadcrumb">  
<li>您的位置：<a href="/">网站首页</a></li>
<li><a href="/Ask">问答中心</a></li>
<li class="active"><a href="List.aspx?strWhere=&QueType=">我要回答</a></li>
</ol>
</div>


<div class="container">
<ul class="list-inline">
<li class="on"><a title="问答首页" href="#" class="btn btn-primary btn_guest">问答首页</a> </li>
<li><a title="问答之星" href="Star.aspx" class="btn btn-primary btn_guest">问答之星</a></li>
<li><a title="分类大全" href="Classification.aspx" class="btn btn-primary btn_guest">分类大全</a></li>
<li><a href="List.aspx?strWhere=<%=Server.HtmlEncode(Request["strWhere"]) %>&QueType=<%=Server.HtmlEncode(Request["QueType"]) %>" class="btn btn-primary btn_guest">待完善问题</a></li>
<!-- <li><a title="知识专题" href="Topic.aspx class="btn btn-primary btn_guest"">知识专题</a></li>-->
</ul>
</div>

<div class="container">
<div class="question_count">
<span class="count">最佳回答采纳率:</span><span class="adopt" ><%=getAdoption() %></span><br />
<span class="count">已解决问题数:</span><span class="countques" ><% =getSolvedCount() %></span><br />
<span class="count">待解决问题数:</span><span class="countques" ><% =getSolvingCount() %></span>
</div>
<div id="move">
<span class="count">当前在线:</span><%=getLogined() %><br />
<span class="count">注册用户:</span><%=getUserCount() %><br />
</div>
<ul class="nav nav-tabs">
<li id="all_li"><a href="list.aspx?QueType=<%=Request.QueryString["QueType"] %>">全部问答</a></li>
<li id="wait_li"><a href="list.aspx?type=1&QueType=<%=Request.QueryString["QueType"] %>">待完善问题</a></li>
</ul>
<div class="asklist">
<ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="当前没有问题!!" 
OnPageIndexChanging="EGV_PageIndexChanging">
<Columns>
<asp:TemplateField>
<ItemTemplate>
<h3><a href="MyAnswer.aspx?ID=<%#Eval("ID")%>"><%#Eval("Qcontent")%></a></h3>
<div class="abstract bar_other_l"><%#getanswer(Convert.ToInt32(Eval("ID","{0}")))%></div>
<div class="fs"><%# Getname(Eval("isNi", "{0}"),Eval("UserName", "{0}"),Eval("UserID", "{0}"))%>--<%#Eval("AddTime", "{0:yyyy-MM-dd}")%><a href="List.aspx?QueType=<%# Eval("QueType")%>&strWhere="><%#gettype(Convert.ToInt32(Eval("QueType","{0}")))%></a></div>
</ItemTemplate>
</asp:TemplateField>
</Columns>
</ZL:ExGridView>
</div>
</div>
<script>
    function show() {
        var div = document.getElementById("show");
        if (div.style.display == "none") {
            div.style.display = "block";
        }
    }
    $().ready(function () {
        var type = <%=Type %>;
        if(type==1)
            $("#wait_li").addClass('active');
        else
            $("#all_li").addClass('active');
    });
</script>
</asp:Content>

