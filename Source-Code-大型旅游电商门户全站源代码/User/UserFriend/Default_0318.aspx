<%@ page language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_UserFriend_Default, App_Web_rfb2ma1k" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="../UserZone/WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc2" %>
<%@ Register Src="WebUserControlMessage.ascx" TagName="WebUserControlMessage" TagPrefix="uc1" %>
<%@ Register Src="WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc3" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>好友管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="pageflag" data-nav="index" data-ban="zone"></div>
<div class="margin_t5">
<ol class="breadcrumb">
<li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
<li class="active">我的好友<a href="/User/UserZone/UserQuestFriend.aspx">[添加好友]</a></li>
</ol>
</div>
<uc2:webusercontroltop ID="WebUserControlTop2" runat="server" />
<div class="margin_t5">
<div style="margin-bottom: 10px;">
<asp:TextBox ID="UNameSkey_T" CssClass="form-control text_md" runat="server" placeholder="好友名称"></asp:TextBox>
<asp:Button ID="UNameSkey_Btn" runat="server" CssClass="btn btn-primary" Text="搜索" OnClick="UNameSkey_Btn_Click" />
</div>
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false"
OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand"
CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="尚无好友数据">
<Columns>
<asp:TemplateField HeaderText="头像">
<ItemTemplate>
<img src="<%#Eval("salt") %>" onerror="this.src='/Images/userface/noface.gif';" class="img50" />
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField HeaderText="用户名" DataField="UserName" />
<asp:BoundField HeaderText="昵称" DataField="HoneyName" />
<asp:TemplateField HeaderText="操作" ItemStyle-CssClass="td_l">
<ItemTemplate>
<asp:LinkButton runat="server" ToolTip="删除好友" CommandArgument='<%#Eval("UserID") %>' CommandName="del2" CssClass="option_style" OnClientClick="return confirm('确定删除吗?');"><i class="fa fa-recycle"></i>删除</asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
</Columns>
</ZL:ExGridView>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
</asp:Content>
