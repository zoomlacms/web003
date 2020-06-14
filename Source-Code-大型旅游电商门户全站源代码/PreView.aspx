<%@ page language="C#" autoeventwireup="true" inherits="Plat_PreView, App_Web_a112wqfr" enableviewstate="false" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>文件预览</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div>
        <div runat="server" id="pdfDiv" visible="false">
            <embed id="pdfEmbed" class="precenter" src="<%=pdfUrl %>" <%=string.Format("style='width:{0}px;height:{1}px;'",viewWidth,viewHeight)%> type="application/pdf" />
        </div>
        <div id="imgDiv" runat="server" visible="false">
            <img src="<%=imgUrl %>" style="border: none;" />
        </div>
        <div id="generalDiv" runat="server" visible="false">
            <asp:Literal runat="server" ID="html_L"></asp:Literal>
        </div>
        <asp:TextBox runat="server" ID="ViewTxt" TextMode="MultiLine" CssClass="precenter" Visible="false"></asp:TextBox>
        <div runat="server" id="videoDiv">
            <div id="mediaplayer"></div>
        </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
    .precenter{margin:0 auto; display:block;border:1px solid #ccc;}
</style>
<script type="text/javascript" src="/JS/jquery.media.js"></script>
<script type="text/javascript" src="/User/Cloud/Jwplayer/jwplayer.js"></script>
<script type="text/javascript">
    $('.media').media({
                width: <%=viewWidth%>,
                height: <%=viewHeight%>,
                autoplay: true,
                //src: 'myBetterMovie.mov',
                //attrs: { attr1: 'attrValue1', attr2: 'attrValue2' }, // object/embed attrs 
                //params: { param1: 'paramValue1', param2: 'paramValue2' }, // object params/embed attrs 
                //caption: false // supress caption text 
            });
            function PlayVideo() {
                jwplayer("mediaplayer").setup({
                    flashplayer: "/User/Cloud/Jwplayer/Player.swf",
                    file: "<%:Request.QueryString["vpath"]%>",
                    autostart: true
                });
            }
</script>
</asp:Content>
