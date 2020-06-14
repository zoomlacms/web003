<%@ page language="C#" masterpagefile="~/Manage/I/Default.master" autoeventwireup="true" inherits="manage_AddOn_ProjectsType, App_Web_tpyqsobo" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title>项目分类管理</title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
    <ZL:ExGridView runat="server" ID="EGV" AllowPaging="true" AllowSorting="false" class="table table-striped table-bordered table-hover" 
         OnRowDataBound="EGV_RowDataBound" DataKeyNames="ProjectTypeID"
        OnPageIndexChanging="EGV_PageIndexChanging" AutoGenerateColumns="false" OnRowCommand="EGV_RowCommand" EmptyDataText="无相关数据！">
        <Columns>
            <asp:TemplateField HeaderText="选择">
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ProjectTypeID") %>"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="序号ID" DataField="ProjectTypeID" />
            <asp:TemplateField HeaderText="项目类型名称">
                <ItemTemplate>
                    <a href="ProjectsAddType.aspx?projecttypeID=<%#Eval("ProjectTypeID") %>"><%#Eval("ProjectTypeName") %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="项目类型简介">
                <ItemTemplate>
                    <%#Eval("ProjectTypeInfo") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="LbtnUpdate" runat="server" CommandArgument='<%#Eval("ProjectTypeID") %>' CommandName="Update" CssClass="option_style"><i class="fa fa-pencil" title="修改"></i></asp:LinkButton>
                    <asp:LinkButton ID="LbtnDel" runat="server" OnClientClick="return confirm('您确定要删除吗？')" CommandArgument='<%#Eval("ProjectTypeID") %>' CommandName="Del" CssClass="option_style"><i class="fa fa-trash-o" title="删除"></i>删除</asp:LinkButton> 
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
        <asp:Button runat="server" ID="BatDel_Btn" CssClass="btn btn-primary" Text="批量删除" OnClick="BatDel_Btn_Click" OnClientClick="return confirm('确定要删除所选内容吗?');" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script type="text/javascript" src="/js/Common.js"></script>
<script>
	function CheckAll(spanChk)//CheckBox全选
	{
		var oItem = spanChk.children;
		var theBox = (spanChk.type == "checkbox") ? spanChk : spanChk.children.item[0];
		xState = theBox.checked;
		elm = theBox.form.elements;
		for (i = 0; i < elm.length; i++)
			if (elm[i].type == "checkbox" && elm[i].id != theBox.id) {
				if (elm[i].checked != xState)
					elm[i].click();
			}
	}
</script>
</asp:Content>