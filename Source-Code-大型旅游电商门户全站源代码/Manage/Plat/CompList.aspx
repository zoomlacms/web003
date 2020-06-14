<%@ page language="C#" autoeventwireup="true" inherits="Manage_Plat_CompList, App_Web_hw5o12ej" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>公司管理</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
        OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand"
        CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate><input type="checkbox" name="idchk" value="<%#Eval("ID") %>" /></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Logo">
                <ItemTemplate><%#ComRE.Img_NoPic(Eval("CompLogo","")) %></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="名称">
                <ItemTemplate><a href="AddComp.aspx?ID=<%#Eval("ID") %>"><%#Eval("CompName") %></a></ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="创建人" DataField="UserName" />
            <asp:BoundField HeaderText="企业邮箱" DataField="Mails" />
            <asp:BoundField HeaderText="创建时间" DataField="CreateTime" DataFormatString="{0:yyyy年MM月dd日 HH:mm}" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a class="option_style" href="AddComp.aspx?id=<%#Eval("ID") %>"><i class="fa fa-pencil" title="修改"></i></a>
                    <asp:LinkButton runat="server" CssClass="option_style" CommandName="del2" CommandArgument='<%#Eval("ID") %>' OnClientClick="return confirm('确定要删除吗');"><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
    <asp:Button ID="Dels_Btn" runat="server" CssClass="btn btn-primary" Text="批量删除" OnClientClick="return confirm('是否确认删除?')" OnClick="Dels_Btn_Click" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>