<%@ page language="C#" autoeventwireup="true" inherits="manage_Flex_AddTemplate, App_Web_0jgz2ctt" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
        <link type="text/css" href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
        <title>Flex管理系统</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
     <table class="table table-striped table-bordered table-hover">
        <tr align="center">
            <td colspan="2" class="spacingtitle">
                <strong>
                    <asp:Label ID="LblTitle" runat="server" Text="添加礼品" Font-Bold="True"></asp:Label>
                </strong>
            </td>
        </tr>
        <tr>
            <td class="tdleft td_l" >
                <strong>礼品名称：</strong>
            </td>
            <td  >
                <asp:TextBox ID="Mu_Title" runat="server" CssClass="form-control" Width="290px"></asp:TextBox>
            </td>
        </tr>
                <tr>
            <td class="tdleft" >
                <strong>所属产品：</strong>
            </td>
            <td  >
                <asp:DropDownList ID="Mu_PClass" runat="server" AutoPostBack="True" Width="150" CssClass="form-control" onselectedindexchanged="Mu_PClass_SelectedIndexChanged"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Mu_PClass" ErrorMessage="所属产品不能为空!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="tdleft" >
                <strong>礼品所属分类：</strong>
            </td>
            <td  >
                <asp:DropDownList ID="Mu_Class" CssClass="form-control" Width="150" runat="server"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Mu_Class" ErrorMessage="分类不能为空!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="tdleft" >
                <strong>模板类型：</strong>
            </td>
            <td  >
                <asp:RadioButtonList ID="Mu_ModelTemp" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="1" Selected="True">页面模板</asp:ListItem>
                    <asp:ListItem Value="0">成套模板</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="tdleft" >
                <strong>页面类型：</strong>
            </td>
            <td  >
                <asp:RadioButtonList ID="Mu_PageType" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="0" Selected="True">单页</asp:ListItem>
                    <asp:ListItem Value="1">拼页</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="tdleft" >
                <strong>用户是否允许修改：</strong>
            </td>
            <td  >
                 <input type="checkbox" runat="server" id="Mu_UserChange" class="switchChk"  checked="checked" />
            </td>
        </tr>
        
        <tr>
            <td class="tdleft" >
                <strong>背景图片(小图)：</strong>
            </td>
            <td  >
                <asp:TextBox ID="Mu_BackImg" CssClass="form-control" runat="server" Width="290px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="背景小图不能为空!" ControlToValidate="Mu_BackImg"></asp:RequiredFieldValidator>
                <br />
                <iframe id="Upload_pic" src="/Common/FileUpload.aspx" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="30" scrolling="no"></iframe>
            </td>
        </tr>
        
        <tr>
            <td class="tdleft" >
                <strong>背景图片(大图)：</strong>
            </td>
            <td  >
                <asp:TextBox ID="txt_Image1" CssClass="form-control" runat="server" Width="290px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ErrorMessage="背景大图不能为空!" ControlToValidate="txt_Image1"></asp:RequiredFieldValidator>
                <br />
                <iframe id="Iframe1" src="/Common/FileUpload.aspx?FieldName=Image1" marginheight="0" marginwidth="0" frameborder="0" width="100%" height="30" scrolling="no"></iframe>
            </td>
        </tr>
        <tr>
            <td class="tdleft" >
                <strong>排序：</strong><br />(越大排越前)</td>
            <td  >
                <asp:TextBox ID="Mu_Num" CssClass="form-control text_300" runat="server" Text="0"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Mu_Num" ErrorMessage="排序不能为空!"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
        <tr class="tdbg">
            <td style="text-align: center" colspan="2">
                <asp:Button ID="EBtnSubmit" class="btn btn-primary" Text="下一步" runat="server" onclick="EBtnSubmit_Click" />
                <input name="BtnCancel" type="button" class="btn btn-primary" onclick="javascript: window.location.href = 'FlexTemplate.aspx'" value=" 取消 " />
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hiddenid" />
    <script type="text/javascript">
        function DealwithUploadPic(url, id) {
            $("#" + id).val(url);
        }
    </script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
        <script type="text/javascript" src="/dist/js/bootstrap-switch.js"></script>
</asp:Content>