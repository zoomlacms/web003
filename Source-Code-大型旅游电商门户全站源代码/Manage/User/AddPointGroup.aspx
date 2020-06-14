<%@ page language="C#" autoeventwireup="true" inherits="manage_User_AddPointGroup, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register TagPrefix="ZL" TagName="UserGuide" Src="~/Manage/I/ASCX/UserGuide.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <script src="/JS/Common.js"></script>
    <title><%=Resources.L.添加积分等级 %> </title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
    <asp:HiddenField runat="server" ID="LNav_Hid" Value="<%$Resources:L,添加积分等级 %>" />
    <table width="100%" cellpadding="2" cellspacing="1" class="table table-striped table-bordered table-hover">
        <tr style="display: none;">
            <td class="spacingtitle" colspan="2" align="center">
                <asp:Literal ID="LTitle" runat="server" Text="<%$Resources:L,添加积分等级 %>"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: auto"><strong>><%=Resources.L.积分等级 %>：</strong></td>
            <td>
                <asp:TextBox class="form-control pull-left text_md" ID="txtPointGroup" runat="server" />
                <font color="red" style="float: left; padding: 5px;">*</font>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" Text="<%$Resources:L,积分等级不能为空 %>" ControlToValidate="txtPointGroup"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: auto"><strong><%=Resources.L.积分值 %>：</strong></td>
            <td>
                <asp:TextBox class="form-control pull-left" ID="txtPoint" runat="server" Style="width: auto">0</asp:TextBox>
                <span style="float: left; padding: 5px">(<%=Resources.L.用户多少积分可升级为此等级 %>)</span>
                <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="<%$Resources:L,请输入有效数据 %>" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" ControlToValidate="txtPoint"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="text-right" style="width: auto"><strong><%=Resources.L.备注 %>：</strong></td>
            <td>
                <asp:TextBox class="form-control" ID="TxtDescription" runat="server" TextMode="MultiLine" Style="max-width: 372px" Height="61px" />
            </td>
        </tr>
        <tr>
            <td class="text-right"><strong><%=Resources.L.等级图片 %>：</strong></td>
            <td>
                <asp:TextBox ID="txt_imgUrl" runat="server" class="form-control text_md" ></asp:TextBox> <span id="imgIcon"></span>
            </td>             
        </tr>
        <tr>
            <td colspan="2" style="padding-left: 19%">
                <asp:HiddenField ID="HdnGroupID" runat="server" />
                <asp:Button ID="EBtnSubmit" class="btn btn-primary" Text="<%$Resources:L,保存设置 %>" OnClick="EBtnSubmit_Click" runat="server" />
                <input name="Cancel" type="button" class="btn btn-primary" id="Cancel" value="<%=Resources.L.返回列表 %>" onclick="location.href = 'PointGroup.aspx'" />
            </td>
        </tr>
    </table>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script type="text/javascript" src="/JS/Plugs/IconSelector.js"></script>
    <script>
        $(function () {
            var iconsel = new iconSelctor("txt_imgUrl");
        });
        
    </script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/Common.js"></script>
     
</asp:Content>