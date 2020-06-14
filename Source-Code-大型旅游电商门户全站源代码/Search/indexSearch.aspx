<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.indexSearch, App_Web_luzxuv1c" enableviewstatemac="false" enableviewstate="false" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>全站搜索_<%=GetName()%></title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="Div1" runat="server">
<div class="container">
    <h1 class="search_logo"><a href="/"><img src="<%= Call.LogoUrl %>" alt="<%= Call.SiteName %>" class="img-responsive" /></a></h1>
    <div class="search_index">
    <div class="pull-left">
        <select name="ddlnode">
            <option value="-1">全部栏目</option>
            <asp:Literal ID="NodeHtml_Li" runat="server" EnableViewState="false"></asp:Literal>
        </select>
    </div>
        <div class="input-group" style="width:300px;">
            <asp:TextBox ID="TxtKeyword" runat="server" onclick="setEmpty(this)" onblur="settxt(this)" Text="请输入关键字" CssClass="form-control input-sm"></asp:TextBox>
            <span class="input-group-btn">
                <asp:Button ID="btnSearch" runat="server" Width="50" Text="搜索" OnClick="btnSearch_Click" CssClass="btn btn-default input-sm" />
            </span>
        </div><!-- /input-group -->
</div><div class="clearfix"></div>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script type="text/javascript">
        function setEmpty(obj) {
            if (obj.value == "请输入关键字") {
                obj.value = "";
            }
        }
        function settxt(obj) {
            if (obj.value == "") {
                obj.value = "请输入关键字";
            }
        }
</script>
</asp:Content>