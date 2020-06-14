<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Info_Cash, App_Web_l01vgzbl" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="WebUserControlTop.ascx" TagName="WebUserControlTop" TagPrefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>申请提现</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container margin_t5">
	<ol class="breadcrumb">
        <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
        <li class="active">申请提现</li> 
    </ol>
</div>
    <div class="us_seta" style="margin-top: 10px;" id="manageinfos" runat="server">
        <uc1:WebUserControlTop ID="WebUserControlTop1" runat="server" />
    </div>
    <div class="us_seta" style="margin-top: 10px; height: 28px; line-height: 28px; padding-left: 10px;" id="Div1" runat="server">
        <asp:Label ID="Label8" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
     <asp:Label ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
     <asp:Label ID="Label3" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
     <asp:Label ID="Label6" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
     你已申请的金额为：<asp:Label ID="Label7" runat="server"></asp:Label>元
     <asp:HiddenField ID="Hiddenhaochu" runat="server" />
        <asp:HiddenField ID="Hiddenzong" runat="server" />
        <asp:HiddenField ID="HiddenUser" runat="server" />
        <asp:HiddenField ID="HiddenOld" runat="server" />
    </div>
    <br />
    <div class="us_seta" style="height: 0px; clear: both;" id="manageinfo" runat="server">
        <h1 style="text-align: center"></h1>
    </div>
    <table class="table table-striped table-bordered table-hover">
        <tr>
            <td colspan="2" class="text-center">申请提现</td>
        </tr>
        <tr>
            <td class="text-right">您的当前余额为：</td>
            <td>
                <span>￥</span><asp:Label ID="Ymoney" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right">选择您的银行账户：</td>
            <td>
                <asp:Label ID="Label1" runat="server" Width="124px"></asp:Label><asp:Label ID="Label4" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right">开户人：</td>
            <td>
                <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="text-right">申请金额：</td>
            <td>
                <asp:TextBox ID="TextBox3" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    runat="server" ErrorMessage="申请金额必须为数字" Display="Dynamic"
                    ControlToValidate="TextBox3" ValidationExpression="^([+-]?)\d*[.]?\d*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ErrorMessage="申请金额不能为空" Display="Dynamic" ControlToValidate="TextBox3"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="text-right">确认金额：</td>
            <td>
                <asp:TextBox ID="TextBox4" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2"
                    runat="server" ErrorMessage="确认金额必须为数字" Display="Dynamic"
                    ControlToValidate="TextBox4" ValidationExpression="^([+-]?)\d*[.]?\d*$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                    ErrorMessage="确认金额不能为空" ControlToValidate="TextBox4"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="text-center">
                <asp:Button ID="ImageButton1" CssClass="btn btn-primary" runat="server" OnClick="ImageButton1_Click1" Text="提交申请" />
            </td>
        </tr>
    </table>
</asp:Content>
