<%@ page language="C#" autoeventwireup="true" inherits="test_diag_cutpic, App_Web_mihcwwjb" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>图片裁剪</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="wrap_div" runat="server" style="overflow-x:auto;">
        <img src="<%=ImgPath %>" id="photo" class="img-responsive" style="cursor: move;" />
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<link href="/Plugins/PicEdit/css/imgareaselect-default.css" rel="stylesheet" />
<script src="/Plugins/PicEdit/JS/jquery.imgareaselect.js"></script>
<%--<script src="/Plugins/PicEdit/JS/jquery.imgareaselect.pack.js"></script>--%>
<script>
    var cursele = { x1: 100, y1: 100, width: 1080, height: 360 };
    $(function () {
        var selectObj = $('#photo').imgAreaSelect({
            aspectRatio: "3:1",//裁剪框的宽高比
            fadeSpeed: 500,
            autoHide: false,
            handles: true,
            instance: true,
            autoHide: false,
            resizable:true,
            persistent: true,
            x1: 0, y1: 100, x2: 1080, y2: 460,
            onInit: function () {
                var w = $("#photo").width();
                var h = $("#photo").height();
                if (w < 1350 || h < 480) { alert("图像过小,请上传宽大于1350px,高大于480px的高清图"); parent.closeDiag(); return; }
            },
            onSelectEnd: function (img, selection) {
                cursele = selection;
            }
        });//photo end;
    });
    function cutpic() {
        $.post("CutPic.aspx", { action: "crop", "x1": cursele.x1, "y1": cursele.y1, width: cursele.width, height: cursele.height, vpath: $("#photo").attr("src") }, function (url) {
            //selectObj.cancelSelection();
            parent.cutok(url);
        })
    }
</script>
</asp:Content>