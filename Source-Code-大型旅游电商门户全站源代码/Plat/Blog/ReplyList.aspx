c<%@ page language="C#" autoeventwireup="true" inherits="Plat_Blog_ReplyList, App_Web_gpjmatla" enableviewstate="false" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<form id="form1" runat="server">
<start>
<div class="reply_exinfo_div" id="bar_div" runat="server" visible="false">
    <div><strong><i class="fa fa-share-alt-square"></i> 社区信息</strong></div>
    <asp:Repeater runat="server" ID="Bar_RPT" EnableViewState="false">
        <ItemTemplate>
            <div style="padding-top:5px;border-bottom:1px dashed #ddd;">
                <div class="pull-left">
                    <img class="replyface" src="<%#Eval("UserFace") %>" onerror="this.src='/Images/userface/noface.gif';" />
                </div>
                <div class="pull-left" style="float: left; overflow: hidden; text-overflow: ellipsis;padding-left:5px;">
                   <a href="javascript:;"><%#Eval("CUName") %>：</a>
                </div>
                <div class="text-left"><%#ZoomLa.BLL.Helper.StrHelper.DecompressString(Eval("MsgContent","")) %></div>
                <div class="clearfix"></div>
                <div class="text-right" style="font-size:12px;"><%#Eval("CDate","{0:yyyy年MM月dd日 HH:mm}") %></div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<asp:Repeater runat="server" ID="ReplyList">
<ItemTemplate>
<div class="replyrow" id="msgitem-<%#Eval("ID") %>">
  <div class="pull-left"><img class="replyface" src="<%#Eval("UserFace") %>" onerror="this.src='/Images/userface/noface.gif';" /> </div>
  <div class="reply_body">
    <div class="reply_btnlist"><%#GetReplyStr(Eval("ReplyID")) %> </div>
    <div class="replybottom grayremind">
        <%#Convert.ToDateTime(Eval("CDate","{0:yyyy年MM月dd日 HH:mm}")) %>
        <%#Convert.ToInt32(Eval("CUser"))==UserID?"<span class='glyphicon glyphicon-trash' title='删除' onclick=\"PostDelMsg("+Eval("ID")+");\"></span>":"" %>
        <span class="glyphicon glyphicon-comment" title="回复" onclick="DisReplyOP(<%#Eval("Pid") %>,<%#Eval("ID") %>,'<%#Eval("CUName") %>');"></span>
  </div>
  <div class="replyspear"></div>
</div></div>
</ItemTemplate>
<FooterTemplate></FooterTemplate>
</asp:Repeater>
</start>
</form>
