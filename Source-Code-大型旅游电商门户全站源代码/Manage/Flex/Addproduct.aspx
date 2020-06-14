<%@ page language="C#" autoeventwireup="true" inherits="manage_Flex_AddProteat, App_Web_touwknnf" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
        <title>添加产品</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table  class="table table-striped table-bordered table-hover">
        <tr align="center">
            <td colspan="2" class="spacingtitle">
                <strong>
                    <asp:Label ID="LblTitle" runat="server" Text="添加产品" Font-Bold="True"></asp:Label>
                </strong>
            </td>
        </tr>
        <tr>
            <td class="tdleft td_l">
                <strong>产品名称：</strong>
            </td>
            <td style="text-align: left; ">
                <asp:TextBox ID="productname" class="form-control" runat="server" Width="280px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="productname" ErrorMessage="产品名称不能为空!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
        
        <tr>
            <td  class="tdleft">
                <strong>产品类型：</strong></td>
            <td  style="text-align: left; ">
                <asp:DropDownList ID="p_Type" CssClass="form-control" Width="150" runat="server">
                    <asp:ListItem Value="0">选择分类</asp:ListItem>
                    <asp:ListItem Value="1">像册类</asp:ListItem>
                    <asp:ListItem Value="2">礼品类</asp:ListItem>
                    <asp:ListItem Value="3">其他类</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td  class="tdleft">
                <strong>是否为双面：</strong></td>
            <td  style="text-align: left; ">
                <asp:DropDownList ID="p_DoublePage" CssClass="form-control" Width="150" runat="server">
                    <asp:ListItem Value="0">选择</asp:ListItem>
                    <asp:ListItem Value="2">单面</asp:ListItem>
                    <asp:ListItem Value="3">双面</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        
        <tr>
            <td  class="tdleft">
                <strong>公用Flex模板：</strong></td>
            <td  style="text-align: left; ">
                <asp:DropDownList ID="p_IspageTemplate" CssClass="form-control" Width="150" runat="server">
                    <asp:ListItem Value="0">选择模板</asp:ListItem>
                    <asp:ListItem Value="1">像册模板</asp:ListItem>
                    <asp:ListItem Value="2">其他模板</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td  class="tdleft">
                <strong>排序：</strong></td>
            <td  style="text-align: left; ">
                <asp:TextBox ID="p_num" class="form-control" runat="server" Width="91px">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="p_num" ErrorMessage="排序不能为空!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr id="Encrypt" runat="server">
            <td  class="tdleft">
                <strong>产品说明：</strong>
            </td>
            <td  style="text-align: left; ">
                <asp:TextBox ID="p_info" class="form-control" runat="server" Height="101px" TextMode="MultiLine" Width="507px"></asp:TextBox>
            </td>
        </tr>
        <tr class="tdbg">
            <td style="text-align: center" colspan="2" class="style2">
                <asp:Button ID="EBtnSubmit" class="btn btn-primary" Text="保存" runat="server" OnClick="EBtnSubmit_Click" />&nbsp;&nbsp;
                <a class="btn btn-primary" href="productManage.aspx" >取消</a>  
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hiddenid" />
</asp:Content>