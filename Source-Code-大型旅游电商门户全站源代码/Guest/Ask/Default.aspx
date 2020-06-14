<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Guestbook_Ask" MasterPageFile="~/Guest/Ask/Ask.master"  EnableViewStateMac="false"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>问答中心首页</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container myask_top">
<div class="row">
<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 myask_top_l">
<div class="myask_top_lt">
<div class="pull-left">
<a href="/ask">问答首页</a><span></span>
<a href="/Guest/Ask/MyAnswerlist.aspx">我的回答<i class="fa fa-caret-down"></i></a><span></span>
<a href="/Item/112.aspx">查看如何使用</a>
</div>
<div class="pull-right"><a href="/Guest/Ask/Add.aspx?strWhere=" class="btn btn-primary btn-lg"><i class="fa fa-question-circle"></i> 我要提问</a></div>
<div class="clearfix"></div>
</div>
<div class="myask_top_ls">


<form id="form1" action="Ask" method="post">
<div id="input-group">
<input name="ctl00$txtAsk" tabindex="1" class="form-control" id="txtAsk" style="vertical-align: middle;" onmouseover="this.focus()" type="text" autocomplete="off"></div>
<button id="btnSearch" type="submit" name="ctl00$btnSearch" class="btn btn-default"><i class="fa fa-search"></i></button>
</form>


</div>
<div class="myask_top_lh">
<div class="myask_top_lht">热门问题</div>
<div class="myask_top_lhf">
<div class="media">
<div class="media-left"><a href="#"><strong>208</strong><span>回答</span></a></div>
<div class="media-body">
<h4 class="media-heading"><a href="#">请提供一些贵州不知名但好玩的去处</a></h4>
<p>请提供一些贵州不知名但好玩的去处，好吃小店，好玩酒吧，有趣的展览，或者独特视角观景位置，或能真...</p>
</div>
</div>
</div>
<ul>
<%Call.Label("{ZL.Label id=\"输出为解决问题列表\" ShowNum=\"4\" TitleNum=\"60\" /}");%>
</ul>
</div>
</div>
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 myask_top_r">
<div class="myask_top_rt">
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
<!-- Indicators -->
<ol class="carousel-indicators">
<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
<li data-target="#carousel-example-generic" data-slide-to="1"></li>
<li data-target="#carousel-example-generic" data-slide-to="2"></li>
</ol>
<!-- Wrapper for slides -->
<div class="carousel-inner" role="listbox">
<div class="item active">
<a href="#"><img src="../../Template/Travel/style/images/ask_img.jpg" alt="" /></a>
</div>
<div class="item">
<a href="#"><img src="../../Template/Travel/style/images/ask_img.jpg" alt="" /></a>
</div>
<div class="item">
<a href="#"><img src="../../Template/Travel/style/images/ask_img.jpg" alt="" /></a>
</div>
</div>

<!-- Controls -->
<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
<span class="sr-only">Previous</span>
</a>
<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
<span class="sr-only">Next</span>
</a>
</div>
</div>
<div class="myask_top_ru">
<div class="media">
<div class="media-left media-middle"><a href="#"><img class="media-object" src="../../Template/Travel/style/images/userface.jpg" alt="..."></a></div>
<div class="media-body">
<h4 class="media-heading"><a href="#">zoujian592</a><span>LV.13</span></h4>
<p>已经帮助了13174人</p>
<p>已连续活跃<span>0</span><a href="#" class="btn btn-danger btn-sm">已签到</a></p>
</div>
</div>
<ul>
<li><a href="/Guest/Ask/MyAskList.aspx"><strong><%Call.Label("{ZL.Label id=\"输出当前用户提问总数\" /}");%></strong><br/>我的提问</a></li>
<li><a href="/Guest/Ask/MyAnswerlist.aspx"><strong><%Call.Label("{ZL.Label id=\"输出当前用户回答总数\" /}");%></strong><br/>我的回答</a></li>
</ul>
</div>
</div>
</div>
</div>

<div class="myask_main">
<div class="container">
<div class="row">
<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 myask_main_l">
<div class="myask_main_lt">
<ul>
<li class="active"><a href="/Guest/Ask/List.aspx">所有问题</a></li>
<li><a href="/Guest/Ask/List.aspx">金牌回答</a></li>
<li><a href="/Guest/Ask/List.aspx">最多有用</a></li>
<li><a href="/Guest/Ask/List.aspx">最新问题</a></li>
<li><a href="/Guest/Ask/list.aspx?type=1&QueType=">待回答问题</a></li>
<div class="clearfix"></div>
</ul>
</div>
<div class="viewcon_ask_lc">
<ul>
<ZL:ExRepeater runat="server" ID="Repeater6" PageSize="10" PagePre="<li class='text-center'>" PageEnd="</li>">
<ItemTemplate>                                            
<li>
<div class="viewcon_ask_la">
<h3><span><a href="#"><img src="<%#GetUserFace(Eval("UserId","{0}")) %>" alt="<%#Eval("UserName")%>" onerror="javascript:this.src='/Images/userface/noface.gif';" /> <%#Eval("UserName")%></a></span><a href="/Guest/Ask/SearchDetails.aspx?ID=<%#Eval("ID")%>"><%#GetLeftString(Eval("Qcontent").ToString(),40) %></a>
</h3>
<%#Eval("Supplyment")%>
</div>
<div class="viewcon_ask_ls">
    <%#GetQueAnswer() %>
</div>
</li>
</ItemTemplate>
<FooterTemplate></FooterTemplate>
</ZL:ExRepeater>
</ul>
</div>
</div><!--myask_main_r end-->
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 myask_main_r">
<div class="viewcon_ask_hot">
<div class="viewcon_ask_ht"><i class="fa fa-bookmark"></i> 热门问题标签</div>
<div class="viewcon_ask_hc">
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(安顺)$}");%>" class="btn btn-default">安顺</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(黄果树瀑布)$}");%>" class="btn btn-danger">黄果树瀑布</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(黔东南)$}");%>" class="btn btn-default">黔东南</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(青岩古镇)$}");%>" class="btn btn-default">青岩古镇</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(赤水)$}");%>" class="btn btn-default">赤水</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(肇兴)$}");%>" class="btn btn-default">肇兴</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(遵义)$}");%>" class="btn btn-default">遵义</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(凯里)$}");%>" class="btn btn-default">凯里</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(贵阳)$}");%>" class="btn btn-default">贵阳</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(兴义)$}");%>" class="btn btn-default">兴义</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(荔波)$}");%>" class="btn btn-default">荔波</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(铜仁)$}");%>" class="btn btn-default">铜仁</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(安顺)$}");%>" class="btn btn-default">安顺</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(西江)$}");%>" class="btn btn-default">西江</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(镇远)$}");%>" class="btn btn-default">镇远</a>
<a href="/Guest/Ask/SearchList.aspx?strWhere=<%Call.Label("{$GetUrlencode(花溪)$}");%>" class="btn btn-default">花溪</a>
</div>
</div>

<div class="myask_range">
<div class="myask_range_t">排行榜<span class="pull-right"><a href="#" class="active">今日</a>|<a href="#">本周</a>|<a href="#">本月</a></span></div>
<div role="tabpanel">
<!-- Nav tabs -->
<ul class="nav nav-tabs" role="tablist">
<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">回答数</a></li>
<li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">采纳数</a></li>
<li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">最快回答数</a></li>
</ul>
<!-- Tab panes -->
<div class="tab-content">
<div role="tabpanel" class="tab-pane active" id="home">
<div class="myask_range_c">
<ul class="media-list">
<%Call.Label("{ZL.Label id=\"问答中心输出用户排行榜\" ShowNum=\"10\" /}");%>
</ul>
</div>
</div>
</div>
</div>
</div>
</div><!--myask_main_r end-->
</div>
</div>
</div><!--myask_main end-->


<div class="container hidden">
<div class="row">
<div class="padding5">
<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 padding2 margin_top20">
<div class="ask_class">
<div class="ask_class_t"><a href="/Guest/Ask/Classification.aspx" target="_blank">更多>></a>问题分类</div>
<table class="table table-bordered" id="ask_class_table">
<asp:Repeater ID="Repeater1" runat="server"  OnItemDataBound="Repeater1_ItemDataBound">
<ItemTemplate>
<tr>
<td class="ask_class_tl"><a href="/Guest/Ask/Classification.aspx?GradeID=<%#Eval("GradeID") %>" title="<%#Eval("GradeName") %>"><%#Eval("GradeName") %></a></td>
<td class="ask_class_tr">
<asp:Repeater ID="Repeater2" runat="server">
<ItemTemplate><a href="/Guest/Ask/Classification.aspx?ParentID=<%#Eval("ParentID") %>&GradeID=<%#Eval("GradeID") %>" title="<%#Eval("GradeName") %>"><%#Eval("GradeName") %></a></ItemTemplate>
</asp:Repeater>
</td>
</tr>
</ItemTemplate>
</asp:Repeater>
</table>
</div>
</div>
<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 padding2 margin_top20">
<div class="ask_Resolved">
<div class="ask_Resolved_t"><span><i class="fa fa-heart"></i>我们向您承诺：10分钟内给您满意的答复</span>已解决问题</div>
<div class="ask_Resolved_c">
<div class="row">
<div class="padding10">
<div>
<div class="ask_Resolved_cr">
<ul class="list-unstyled">
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="ask_hotsearch">
<div class="ask_hotsearch_t">热门搜索</div>
<div id="know">
<asp:Repeater runat="server" ID="Repeater11">
<ItemTemplate>
<a class="btn btn-warning btn_hot" target="_self" href="/Guest/Ask/List.aspx?QueType=<%#Eval("QueType")%>&strwhere="><%#gettype(Eval("QueType","{0}"))%><span></span></a>
</ItemTemplate>
</asp:Repeater>
</div>
<div class="ask_hotsearch_c">
<div class="row">
<ul class="list-unstyled">
<li class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="ask_hotsearch_ct"><span>电脑装机</span></div>
<div class="clearfix"></div>
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出指定问题分类最新问题\" ShowNum=\"4\" TitleNum=\"30\" QueType=\"402\" /}");%>
<div class="clearfix"></div>
</ul>
</li>
<li class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="ask_hotsearch_ct"><span>体育/运动</span></div>
<div class="clearfix"></div>
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出指定问题分类最新问题\" ShowNum=\"4\" TitleNum=\"30\" QueType=\"392\" /}");%>
<div class="clearfix"></div>
</ul>
</li>
<li class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
<div class="ask_hotsearch_ct"><span>商业/理财</span></div>
<div class="clearfix"></div>
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出指定问题分类最新问题\" ShowNum=\"4\" TitleNum=\"30\" QueType=\"394\" /}");%>
<div class="clearfix"></div>
</ul>
</li>
</ul>
</div>
</div>
</div>
<div class="ask_Wait">
<div class="ask_Wait_t"><a href="/Guest/ask/MoreProblems.aspx?type=1" target="_blank">更多<i class="fa fa-caret-right"></i></a>待解决问题</div>
<div class="ask_wait_c">
<!-- Nav tabs -->
<ul class="nav nav-tabs" role="tablist">
<li class="active"><a href="#ask_wait_c1" role="tab" data-toggle="tab">电脑装机</a></li>
<li><a href="#ask_wait_c2" role="tab" data-toggle="tab">硬件</a></li>
<li><a href="#ask_wait_c3" role="tab" data-toggle="tab">软件</a></li>
<li><a href="#ask_wait_c4" role="tab" data-toggle="tab">反病毒</a></li>
<li><a href="#ask_wait_c5" role="tab" data-toggle="tab">互联网</a></li>
</ul>
<!-- Tab panes -->
<div class="tab-content">
<div class="tab-pane active" id="ask_wait_c1">
<div class="ask_wait_cr">
<div class="row">
<div class="padding10">
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出待解决问题\" TitleNum=\"38\" ShowNum=\"12\" Type=\"402\" /}");%>
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
<div class="tab-pane" id="ask_wait_c2">
<div class="ask_wait_cr">
<div class="row">
<div class="padding10">
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出待解决问题\" TitleNum=\"38\" ShowNum=\"6\" Type=\"403\" /}");%>
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
<div class="tab-pane" id="ask_wait_c3">
<div class="ask_wait_cr">
<div class="row">
<div class="padding10">
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出待解决问题\" TitleNum=\"38\" ShowNum=\"6\" Type=\"404\" /}");%>
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
<div class="tab-pane" id="ask_wait_c4">
<div class="ask_wait_cr">
<div class="row">
<div class="padding10">
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出待解决问题\" TitleNum=\"38\" ShowNum=\"6\" Type=\"405\" /}");%>
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
<div class="tab-pane" id="ask_wait_c5">
<div class="ask_wait_cr">
<div class="row">
<div class="padding10">
<ul class="list-unstyled">
<%Call.Label("{ZL.Label id=\"输出待解决问题\" TitleNum=\"38\" ShowNum=\"6\" Type=\"406\" /}");%>
<div class="clearfix"></div>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class="hidden">
<div>最佳回答采纳率:<%=getAdoption() %> 已解决问题数:<% =getSolvedCount() %> 待解决问题数:<% =getSolvingCount() %></div>
<div>
积分排行榜
<asp:Repeater ID="Repeater10" runat="server"  OnItemDataBound="Repeater10_ItemDataBound">
<ItemTemplate>
<img align="absmiddle" src="/App_Themes/Guest/images/num1.gif" id="ph" runat="server"><a target="_blank" href="/ShowList.aspx?id=<%#Eval("UserID") %>"><%#Eval("UserName") %></a><img align="absmiddle" src="/App_Themes/Guest/images/up.gif"><%#Eval("GuestScore") %>
</ItemTemplate>
</asp:Repeater>
<asp:Repeater ID="Repeater9" runat="server" OnItemDataBound="Repeater9_ItemDataBound">
<ItemTemplate>
<img align="absmiddle" src="/App_Themes/Guest/images/num1.gif" id="ph" runat="server"> <a target="_blank" href="/ShowList.aspx?id=<%#Eval("UserID") %>"><%#Eval("UserName") %></a></span><img align="absmiddle" src="/App_Themes/Guest/images/up.gif"><%#Eval("GuestScore") %>
</ItemTemplate>
</asp:Repeater>
</div>
<div>
精彩推荐的问题
<asp:Repeater ID="Repeater3" runat="server"><ItemTemplate><a target="_self" href="SearchDetails.aspx?ID=<%#Eval("ID")%>"><%#GetLeftString(Eval("Qcontent").ToString(),25) %></a><span class="lei">[<a target="_self" href="AskList.aspx?QueType=<%#Eval("QueType")%>&strwhere="><%#gettype(Eval("QueType","{0}"))%></a>]<%#getcount(Eval("ID", "{0}"))%>回答</span></ItemTemplate></asp:Repeater>
大家都在问什么
<asp:Repeater ID="Repeater4" runat="server"><ItemTemplate><a target="_self" href="MyAnswer.aspx?ID=<%#Eval("ID")%>"><%#GetLeftString(Eval("Qcontent").ToString(),25) %></a>&nbsp;[<a target="_self" href="List.aspx?QueType=<%#Eval("QueType")%>&strwhere="><%#gettype(Eval("QueType","{0}"))%></a>]<%#getanswers(Eval("ID", "{0}"))%>回答</ItemTemplate></asp:Repeater>                       
悬赏求答案的问题
<asp:Repeater runat="server" ID="Repeater5"><ItemTemplate><img  alt=" " src="/App_Themes/Guest/images/TB2.gif" /><%#Eval("Score")%><a target="_self"  href="SearchDetails.aspx?ID=<%#Eval("ID")%>"><%#GetLeftString(Eval("Qcontent").ToString(),25) %>&nbsp;</a>[<a target="_self" href="AskList.aspx?QueType=<%#Eval("QueType")%>&strwhere="><%#gettype(Eval("QueType","{0}"))%>]</a><%#getanswers(Eval("ID", "{0}"))%>回答</ItemTemplate></asp:Repeater>
<asp:Repeater runat="server" ID="Repeater7" OnItemDataBound="Repeater7_ItemDataBound">
<ItemTemplate> 
<div class="rb_zj_mm">
<div class="rb_zj_mmc">
<div class='zjimg'><img src="/Images/InitHead.gif" width='50px' height='50px' /></div>
<div class='jbzl'>
<a href="/ShowList.aspx?id=<%#Eval("UserID")%>" target='_blank'><%#Eval("UserName")%></a><br/>
回答数:<%#getanswer(Eval("UserID","{0}"))%><br />
提问数:<%#getask(Eval("UserID","{0}"))%>
</div>
精选解答:
<a class="button1" id="fix" runat="server">向TA提问</a>
<asp:Repeater runat="server" ID="Repeater8"><ItemTemplate>                         
<ul>
<li><a href="SearchDetails.aspx?ID=<%#Eval("ID")%>" target='_blank' title=" "><%#Eval("Qcontent")%></a></li>
</ul></ItemTemplate></asp:Repeater>
</div>
</div>
</ItemTemplate>
</asp:Repeater>                 
</div>
</div>
<asp:HiddenField runat="server" ID="hfid" />
<script>
function showtop(type) {
    if (type == 'week') {
        document.getElementById("weektab").className = "on";
        document.getElementById("alltab").className = "";
        document.getElementById("weektop").style.display = "";
        document.getElementById("alltop").style.display = "none";
    } else {
        document.getElementById("weektab").className = "";
        document.getElementById("alltab").className = "on";
        document.getElementById("weektop").style.display = "none";
        document.getElementById("alltop").style.display = "";
    }
}
function supplyment() {
	var div = document.getElementById("divSupplyment");
	if (div.style.display == "none") {
		div.style.display = "block";
	}
	else {
		div.style.display = "none";
	}
}
function CheckDirty() {
	var TxtTTitle = document.getElementById("TxtTTitle").value;
	var TxtValidateCode = document.getElementById("TxtValidateCode").value;

	if (value == "" || TxtTTitle == "" || TxtValidateCode == "") {
		if (value == "") {
			var obj = document.getElementById("RequiredFieldValidator1");
			obj.innerHTML = "<font color='red'>内容不能为空！</font>";
		}
		else {
			var obj = document.getElementById("RequiredFieldValidator1");
			obj.innerHTML = "";
		}
		if (TxtTTitle == "") {
			var obj2 = document.getElementById("RequiredFieldValidator2");
			obj2.innerHTML = "<font color='red'>留言标题不能为空！</font>";
		}
		else {
			var obj2 = document.getElementById("RequiredFieldValidator2");
			obj2.innerHTML = "";
		}
		if (TxtValidateCode == "") {
			var obj3 = document.getElementById("sp1");
			obj3.innerHTML = "<font color='red'>验证码不能为空！</font>";
		} else {
			var obj3 = document.getElementById("sp1");
			obj3.innerHTML = "";
		}
		return false;
	}
	else {
		var obj = document.getElementById("RequiredFieldValidator1");
		obj.innerHTML = "";
		var obj2 = document.getElementById("RequiredFieldValidator2");
		obj2.innerHTML = "";
		var obj3 = document.getElementById("sp1");
		obj3.innerHTML = "";
		document.getElementById("EBtnSubmit2").click();
	}
}
</script>
</asp:Content>