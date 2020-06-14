<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="ZoomLa.WebSite.User.MessageSend, App_Web_onzfdifg" clientidmode="Static" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>发送短消息</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="pageflag" data-nav="index" data-ban="pub"></div>
<div class=" margin_t5">
<ol class="breadcrumb">
<li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
<li><a href="Message.aspx">消息中心</a></li>
<li class="active">发送短消息</li>
<div class="clearfix"></div>
</ol>
</div>
<div class="btn-group">
<a href="MessageSend.aspx" class="btn btn-primary">新消息</a>
<a href="Message.aspx" class="btn btn-primary">收件箱</a>
<a href="MessageOutbox.aspx" class="btn btn-primary">发件箱</a>
<a href="MessageDraftbox.aspx" class="btn btn-primary">草稿箱</a>
<a href="MessageGarbagebox.aspx" class="btn btn-primary">垃圾箱</a>
<a href="Mobile.aspx" class="btn btn-primary">手机短信</a>
</div>
<div class="us_seta" style="margin-top: 10px;">
<table class="table_li table-border">
<tr>
<td class="text-right">收件人：</td>
<td class="tdRight">
<asp:TextBox CssClass="form-control text_md" ID="TxtInceptUser" runat="server" style="margin-right:10px;" />
<asp:HiddenField ID="HiddenUser" runat="server" />
<button type="button" onclick="ShowSelUser(1)" class="btn btn-primary">选择</button>
</td>
</tr>
<tr>
<td class="text-right">抄送人：</td>
<td class="tdRight">
<asp:TextBox CssClass="form-control text_md" ID="ccUserT" runat="server" style="margin-right:10px;"/>
<asp:HiddenField ID="HiddenCCUser" runat="server" />
<button type="button" onclick="ShowSelUser(2)" class="btn btn-primary">选择</button>
</td>
</tr>
<tr>
<td class="text-right">邮件标题：</td>
<td class="tdRight">
<asp:TextBox ID="TxtTitle" CssClass="form-control text_md" runat="server" />
<%-- <asp:RequiredFieldValidator ID="ValrTitle" runat="server" ControlToValidate="TxtTitle" ErrorMessage="邮件标题不能为空" Display="Dynamic">*</asp:RequiredFieldValidator>--%>
</td>
</tr>
<tr>
<td class="text-right">内容：</td>
<td>
<asp:TextBox ID="EditorContent" runat="server" TextMode="MultiLine" Width="100%" Height="300px" ClientIDMode="Static">
</asp:TextBox>
<%--  <asp:RequiredFieldValidator ID="ValrContent" runat="server" ControlToValidate="EditorContent" ErrorMessage="短消息内容不能为空" Display="Dynamic">*</asp:RequiredFieldValidator>--%>
</td>
</tr>
<tr id="hasFileTR" runat="server" visible="true">
<td class="text-right">已上传文件：<asp:HiddenField runat="server" ID="hasFileData" ClientIDMode="Static" />
</td>
<td id="hasFileTD" runat="server"></td>
</tr>
<tr>
<td style="text-align: right;width:10%;" >
附件：   
</td>
<td colspan="7">
<table id="attachTB">
<tr>
<td>
<input type="file" name="fileUPs" class="fileUP" /><input type="button" class="btn btn-xs btn-info" value="删除" onclick="delAttach(this);" /><input type="button" class="btn btn-xs btn-primary" value="再加个附件" onclick="    addAttach();" />
</td>
</tr>
</table>
</td>
</tr>
<tr>
<td></td>
<td>
<asp:Button ID="BtnSend" runat="server" Text="发送" OnClick="BtnSend_Click" OnClientClick="return SendConfirm();" class="btn btn-primary" />
<asp:Button ID="Button1" runat="server" Text="存草稿" OnClick="Button1_Click" class="btn btn-primary" />
<asp:Button ID="BtnReset" runat="server" Text="清除" OnClick="BtnReset_Click" class="btn btn-primary" />
</td>
</tr>
</table>
</div>
<div class="alert alert-success">
<i class="fa fa-lightbulb-o"></i>
提示：系统支持以MessageSend.aspx?name=[用户名]&content=[内容]方式get将站内信发送,如:MessageSend.aspx?name=admin&content=站内信
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script src="/JS/ICMS/ZL_Common.js"></script>
    <%=Call.GetUEditor("EditorContent",2) %>
    <script>
        var uptr = '<tr><td><input type="file" name="fileUP" class="fileUP" /><input type="button" class="btn btn-xs btn-info" value="删除" onclick="delAttach(this);" /></td></tr>';
        function addAttach() {
            $("#attachTB").append(uptr);
        }
        function delAttach(obj) {
            $(obj).parent().remove();
        }
        function delHasFile(v, obj) {
            rv = $("#hasFileData").val().replace(v + ",", "");
            $("#hasFileData").val(rv)
            $(obj).parent().remove();
        }
        function ShowSelUser(n) {
            var url = "";
            if (n == 1)
                url = "/Mis/OA/Mail/SelGroup.aspx?Type=AllInfo#ReferUser";
            else
                url = "/Mis/OA/Mail/SelGroup.aspx?Type=AllInfo#CCUser";
            comdiag.maxbtn = false;
            ShowComDiag(url, "选择用户");
        }
        function UserFunc(json, select) {
            var uname = "";
            var uid = "";
            for (var i = 0; i < json.length; i++) {
                uname += json[i].UserName + ",";
                uid += json[i].UserID + ",";
            }
            if (uid) uid = uid.substring(0, uid.length - 1);
            if (select == "ReferUser") {
                $("#TxtInceptUser").val(uname);
                $("#HiddenUser").val(uid);
            }
            if (select == "CCUser") {
                $("#ccUserT").val(uname);
                $("#HiddenCCUser").val(uid);
            }
            CloseComDiag();
        }
        function SendConfirm() {
            rece = $("#TxtInceptUser").val();
            if (rece == "") { alert('未选定收件人!'); return false; }
            title = $("#TxtTitle").val();
            if (title == "") { alert('邮件标题不能为空!'); return false; }

            if (confirm('确定要发送该邮件吗')) {
                disBtn(this, 3000); return true;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>