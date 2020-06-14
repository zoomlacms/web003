<%@ page language="C#" autoeventwireup="true" inherits="Tools_TestPage, App_Web_yccdxo1t" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>页面性能测试</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
   <table class="table table-bordered table-striped">
       <tr><td class="tdleft td_m">目标页面：</td><td><input type="text" runat="server" id="url_t" class="form-control"/></td></tr>
       <tr><td>执行次数：</td><td><asp:TextBox runat="server" ID="Times_T" Text="1" /></td></tr>
       <tr><td>提示：</td><td><span id="remind_sp">准备就绪</span></td></tr>
       <tr><td></td><td><input type="button" value="开始" id="begin_btn" /></td></tr>
   </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/JS/Controls/DateHelper.js"></script>
    <script>
        $(function () {
            $("#begin_btn").click(function () {
                var url = $("#url_t").val() + "?t=" + Math.random();
                var stime = DateHelper.getDate();
                var etime = 0;
                $("#remind_sp").text("开始测试");
                $.post(url, { action: "test" }, function (data) {
                    etime = DateHelper.getDate();
                    //只到了秒级未到毫秒级
                    $("#remind_sp").text(DateHelper.getInterval(stime, etime)+"秒");
                });
            });
        })
        //多少次,总耗时,平均值
    </script>
</asp:Content>
