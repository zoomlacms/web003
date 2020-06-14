<%@ page title="" language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Content_Release, App_Web_cx3lrdec" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
    <title>批量添加</title>
    <script src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script src="/Plugins/Ueditor/ueditor.all.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="pageflag" data-nav="content" data-ban="cnt"></div>
    <div class="container margin_t5">
        <ol class="breadcrumb">
            <li>您现在的位置：<a title="网站首页" href="/"><%= Call.SiteName%></a></li>
            <li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
            <li><a href="Mycontent.aspx?NodeID=<%= Request.QueryString["NodeID"]%>">投稿管理</a></li>
            <li class="active">批量添加</li>
        </ol>
         <div id="mainBody" style="margin-bottom:50px;"></div>
    </div>
    <div style="position:fixed;bottom:150px;text-align:center;background-color:#ccc;width:100%;padding:5px;">
        <input type="button" class="btn btn-primary" value="批量添加" id="batadd_btn" />
        <input type="button" class="btn btn-primary" value="新增一列" id="addrow_btn" />
    </div>
    <asp:HiddenField ID="Html_Hid" runat="server" />
    <div id="tlp" style="display:none;">
        <div class="panel panel-primary panel-item">
          <div class="panel-heading"><span class="glyphicon glyphicon-plane"></span><span class="margin_l5">添加内容</span></div>
          <div class="panel-body"></div>
             <table class="table table-bordered table-striped">
                 <tr><td class="text-right">标题</td><td><input type="text" class="form-control text_300" name="title_t" /></td></tr>
                 <tbody class="itemBody">
                     
                 </tbody>
             </table>
             </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/Design/JS/sea.js"></script>
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script src="/JS/ICMS/ZL_Common.js"></script>
    <script src="/JS/ZL_Content.js"></script>
    <script>
        $(function () {
            seajs.use(["base64"], function (base64) {
                $("#addrow_btn").click(function () {
                    AddRow();
                });
                function AddRow() {
                    $item = $($("#tlp").html());
                    var html = base64.decode($("#Html_Hid").val());
                    $item.find(".itemBody").append(html);
                    $("#mainBody").append($item);
                }
                $("#batadd_btn").click(function () {
                    comdiag.ShowMask("正在提交保存中,请等待,完成后将返回列表页");
                    postnum = 0;
                    var $items = $("#mainBody .panel-item");
                    for (var i = 0; i < $items.length; i++) {
                        var $form = $('<form>');
                        $form.append($($items[i]));
                        $.ajax({
                            type: "POST",
                            url: "BatAdd.aspx?ModelID=<%:ModelID%>&NodeID=<%:NodeID%>",
                            data: $form.serialize(),
                            //cache: true,
                            //async: false,
                            error: function (request) {
                                alert("提交保存失败");
                            },
                            success: function (data) {
                                postnum++;
                                if (postnum == i) { location = "MyContent.aspx?NodeID=<%:NodeID%>"; }
                                console.log(data);
                            }
                        });//ajax end;
                    }//for end;
                });
                AddRow();
            });
        });
        var postnum = 0;
    </script>
</asp:Content>
