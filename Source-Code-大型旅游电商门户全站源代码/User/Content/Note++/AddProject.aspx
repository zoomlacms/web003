<%@ page language="C#" autoeventwireup="true" inherits="User_Content_Note_AddProject, App_Web_yddzbnlz" masterpagefile="~/Plat/Main.master" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/SFileUp.ascx" TagPrefix="ZL" TagName="SingleUp" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>项目管理</title>
<script src="/Plugins/Ueditor/ueditor.config.js"></script>
<script src="/Plugins/Ueditor/ueditor.all.min.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<ol class="breadcrumb">
    <li><a href="/Plat/Blog/">能力中心</a></li>
    <li><a href="ProList.aspx">项目列表</a></li>
    <li class="active"><a href="<%=Request.RawUrl %>">项目管理</a></li>
</ol>
<ul class="nav nav-tabs margin_t5">
    <li class="active"><a href="#tabs0" data-toggle="tab">基本信息</a></li>
  <%--  <li><a href="#tabs1" data-toggle="tab">流程进度</a></li>--%>
</ul>
<div class="tab-content">
    <div class="tab-pane active" id="tabs0">
        <table class="table table-bordered table-striped">
            <tr><td class="td_m">名称：</td><td>
                <asp:TextBox runat="server" ID="ProName_T" CssClass="form-control text_300" />
                <asp:RequiredFieldValidator runat="server" ID="V1" ControlToValidate="ProName_T" Display="Dynamic" ForeColor="Red" ErrorMessage="项目名称不能为空" SetFocusOnError="true" />
           </td></tr>
            <tr><td>等级：</td><td>
                 <label><input type="radio" value="A+" name="zlevel_rad" />A+</label>
                 <label><input type="radio" value="A" name="zlevel_rad" />A</label>
                 <label><input type="radio" value="B+" name="zlevel_rad" />B+</label>
                 <label><input type="radio" value="B" name="zlevel_rad" checked="checked" />B</label>
                 <label><input type="radio" value="C" name="zlevel_rad" />C</label>
            </td></tr>
            <tr><td>类型：</td><td>
               <label><input type="checkbox" value="web" name="ztype_chk" checked="checked" />网站</label>
               <label><input type="checkbox" value="app" name="ztype_chk" />APP</label>
               <label><input type="checkbox" value="desktop" name="ztype_chk" />桌面应用</label>
            </td></tr>
            <tr><td>状态：</td><td>
               <label><input type="radio" value="0" name="zstatus_rad" checked="checked" />进行中</label>
               <label><input type="radio" value="-1" name="zstatus_rad" />暂停</label>
               <label><input type="radio" value="99" name="zstatus_rad" />已完结</label>
            </td></tr>
            <tr>
                <td>网址：</td>
                <td>
                    <asp:TextBox runat="server" ID="WebSite_T" CssClass="form-control m715-50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>封面图片：</td>
                 <td>
                     <ZL:SingleUp ID="TopImg_Up" FType="Img" IsNull="true" runat="server" />
                 </td>
            </tr>
            <tr>
                <td>联系信息：</td>
                <td>
                    <asp:TextBox runat="server" ID="Contact_T" TextMode="MultiLine" CssClass="form-control m715-50" style="height:120px;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>附件：</td>
                <td>
                    <input type="button" value="添加附件" id="upfile_btn" class="btn btn-info" />
                    <div style="margin-top: 10px;" id="uploader" class="uploader">
                        <ul class="filelist"></ul>
                    </div>
                    <asp:HiddenField runat="server" ID="Attach_Hid" />
                </td>
            </tr>
            <tr>
                <td>备注：</td>
                <td>
                    <asp:TextBox runat="server" ID="Remark_T" TextMode="MultiLine" CssClass="m715-50" style="height:200px;"></asp:TextBox>
                    <%=Call.GetUEditor("Remark_T",2) %>
                </td>
            </tr>
            <tr><td></td><td><asp:Button runat="server" ID="Save_Btn" OnClick="Save_Btn_Click" Text="确认保存" CssClass="btn btn-primary" /> <a href="ProList.aspx" class="btn btn-primary">返回列表</a></td></tr>
        </table>
    </div> 
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/ICMS/ZL_Common.js"></script>
<script src="/JS/Controls/ZL_Webup.js"></script>
<script src="/JS/SelectCheckBox.js"></script>
<script>
    $(function () {
        ZL_Webup.config.json.ashx = "action=OAattach";
        $("#upfile_btn").click(ZL_Webup.ShowFileUP);
    })
    function AddAttach(file, ret, pval) { return ZL_Webup.AddAttach(file, ret, pval); }
</script>
</asp:Content>