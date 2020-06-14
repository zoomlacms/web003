<%@ page title="" language="C#" autoeventwireup="true" inherits="User_Guest_AskComment, App_Web_wdy2krpc" masterpagefile="~/User/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title>我的评论</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="pageflag" data-nav="index" data-ban="ask"></div>
    <div class="container margin_t10">
	<ol class="breadcrumb">
    	<li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">我的评论</li>
		<div class="clearfix"></div>
    </ol>
    </div>
<div class="container">
    <div class="us_seta">
        <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
        OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True"
        CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="问题">
                <ItemTemplate>
                    <a href="/Guest/Ask/SearchDetails.aspx?ID=<%#Eval("AskID") %>" target="_blank"><%#Eval("QContent") %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="答案">
                <ItemTemplate>
                    <%#Eval("AnswerContent") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="评论内容">
                <ItemTemplate>
                    <%#Eval("Content") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="日期" DataField="AddTime" DataFormatString="{0:yyyy年MM月dd日 HH:mm}" />
        </Columns>
    </ZL:ExGridView>
    </div>
</div> 
</asp:Content>
