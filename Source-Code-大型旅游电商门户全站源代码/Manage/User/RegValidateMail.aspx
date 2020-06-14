<%@ page language="C#" autoeventwireup="true" inherits="manage_Qmail_RegValidateMail, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>邮件模板</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol id="BreadNav" class="breadcrumb navbar-fixed-top">
        <li><a href='<%=CustomerPageAction.customPath2 %>Main.aspx'><%=Resources.L.工作台 %></a></li>
        <li><a href="SubscriptListManage.aspx?menu=all">订阅管理</a></li><li><a href="RegValidateMail.aspx">邮件模板</a> <%--[<a href='EidtMailModel.aspx'>添加邮件模板</a>]--%></li>
         <div id="help" class="pull-right text-center"><a href="javascript::" id="sel_btn" class="help_btn"><i class="fa fa-search"></i></a></div>
        <div id="sel_box" class="padding5"> 
            <div class="input-group text_300" style="float:left;">
                <asp:TextBox ID="Search_T" CssClass="form-control" placeholder="模板名称" runat="server"></asp:TextBox>
                <div class="input-group-btn">
                    <asp:LinkButton runat="server" ID="Search_Btn" OnClick="Search_Btn_Click" CssClass="btn btn-default"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                </div>
            </div>
        </div>
    </ol>
    <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="20" EnableTheming="False"  
    CssClass="table table-striped table-bordered table-hover" OnRowCommand="EGV_RowCommand" EmptyDataText="当前没有信息!!" 
    OnPageIndexChanging="EGV_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="模板名称" />
            <asp:TemplateField HeaderText="修改时间">
                <ItemTemplate>
                    <%#Eval("LastWriteTime") %>
                    <input type="hidden" name="idchk" value="<%#Eval("Name") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreateTime" HeaderText="创建时间" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a href="EidtMailModel.aspx?tempname=<%#Eval("Name") %>"><i class="glyphicon glyphicon-cog"></i>配置</a>
                   <%-- <asp:LinkButton runat="server" OnClientClick="return confirm('是否确定删除!')" CommandName="Del" CommandArgument='<%#Eval("ID") %>'><i class="fa fa-trash"></i>删除</asp:LinkButton>--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<style>.allchk_l{display:none;}</style>
<script type="text/javascript" src="/js/Common.js"></script>
<script>
    $(function () {
        $("#EGV tr").dblclick(function () {
            if ($(this).find("[name=idchk]").val())
            { location.href = "EidtMailModel.aspx?tempname=" + $(this).find("[name=idchk]").val(); }
        });
        $("#sel_btn").click(function (e) {
            if ($("#sel_box").css("display") == "none") {
                $(this).addClass("active");
                $("#sel_box").slideDown(300);
            }
            else {
                $(this).removeClass("active");
                $("#sel_box").slideUp(200);
            }
        });
    });
</script>
</asp:Content>
