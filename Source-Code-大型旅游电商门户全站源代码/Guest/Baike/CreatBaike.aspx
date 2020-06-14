<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Guest/Baike/Baike.master" clientidmode="Static" inherits="Guest_CreatBaike, App_Web_ay0tfihc" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>创建词条-<%Call.Label("{$SiteName/}"); %>百科</title> 
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container">
<ol class="breadcrumb margin_top10">
<li>您的位置：<a href="/">网站首页</a></li>
<li><a href="/Baike" target="_self">百科中心</a></li>
<li class="active">创建词条</li>
</ol>
    <h1>请输入你要创建的词条：</h1>
    <div class="input-group">
        <asp:TextBox runat="server" CssClass="form-control" ID="creatbai"></asp:TextBox>
        <span class="input-group-btn">
            <asp:Button runat="server" CssClass="btn btn-default" ID="save" Text="创建词条" OnClick="save_Click" />
        </span>
    </div>
   <asp:RequiredFieldValidator runat="server" ID="R1" ForeColor="Red" ErrorMessage="名称不能为空" ControlToValidate="creatbai" />
</div>
</asp:Content>
