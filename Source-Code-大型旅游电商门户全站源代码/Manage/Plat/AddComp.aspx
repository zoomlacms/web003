<%@ page language="C#" autoeventwireup="true" inherits="Manage_Plat_AddComp, App_Web_hw5o12ej" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/SFileUp.ascx" TagName="SFile" TagPrefix="ZL" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>公司管理</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-bordered  ">
        <tr>
            <td class="td_m text-right">公司名称:</td>
            <td>
                <asp:TextBox ID="CompName_T" runat="server" CssClass="form-control text_300"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">Logo:</td>
            <td><ZL:SFile FType="Img" ID="Logo_SFile" runat="server" /></td>
        </tr>
        <tr>
            <td class="text-right">创建人:</td>
            <td><asp:TextBox CssClass="form-control text_300" runat="server" ID="CUser_T" ></asp:TextBox> </td>
        </tr>
        <tr>
            <td class="text-right">企业邮箱:</td>
            <td><asp:TextBox runat="server" ID="EMail_T" CssClass="form-control text_300"></asp:TextBox></td>
        </tr>
         <tr>
             <td class="text-right">公司网址:</td>
             <td><asp:TextBox runat="server" ID="CompHref_T" CssClass="form-control text_300"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="text-right">公司详情:</td>
            <td>
                <asp:TextBox runat="server" ID="CompDesc_T" CssClass="form-control text_300" TextMode="MultiLine" Height="120"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">创建时间:</td>
            <td>
                <asp:TextBox runat="server" onclick="WdatePicker({ dateFmt: 'yyyy-MM-dd HH:mm:ss' })" ID="CDate_T" CssClass="form-control text_300"></asp:TextBox>
            </td>
        </tr>
       
        <tr>
            <td></td>
            <td><asp:Button ID="Save_Btn" runat="server" OnClientClick="return checkdata();" CssClass="btn btn-primary" OnClick="Save_Btn_Click" Text="保存" /> <a href="CompList.aspx" class="btn btn-primary">返回</a></td>
        </tr>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/JS/ZL_Regex.js"></script>
<script>
    function checkdata() {
        if (!ZL_Regex.isEmail($("#EMail_T").val())) { alert("邮箱地址有误!"); return false; }
        return true;
    }
</script>
</asp:Content>
