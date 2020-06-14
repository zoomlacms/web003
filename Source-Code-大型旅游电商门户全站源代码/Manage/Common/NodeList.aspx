<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Manage/I/Default.master" inherits="manage_Common_NodeList, App_Web_rhsyi005" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>节点选择</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="node_div">
        <asp:Literal runat="server" ID="NodeHtml_Lit" EnableViewState="false"></asp:Literal>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script>
        $(function () {
            $("[name='nodes']").click(function () {
                var nodename = $(this).attr('data-name');
                //var parentnode = $(this).closest("ul").parent();
                //if (parentnode.find('.list_span').length > 0) {//有父节点
                //    nodename = parentnode.find('.list_span').text() + ">>" + nodename;
                //}
                if (parent.ShowNode) { parent.ShowNode(nodename) }
                parent.SelNode($(this).val());
            });
        })
        function ShowChild(obj) {
            $obj = $(obj);
            if ($obj.prev().find('span').hasClass('glyphicon-folder-close')) {
                $obj.next().show();
                $obj.prev().find('span').removeClass('glyphicon-folder-close').addClass('glyphicon-folder-open');
            } else {
                $obj.next().hide();
                $obj.prev().find('span').removeClass('glyphicon-folder-open').addClass('glyphicon-folder-close');
            }
        }
    </script>
</asp:Content>

