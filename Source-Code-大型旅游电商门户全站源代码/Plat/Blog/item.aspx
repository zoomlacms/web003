<%@ page language="C#" autoeventwireup="true" inherits="Plat_Blog_ContentDetail, App_Web_gpjmatla" masterpagefile="~/Plat/Main.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>文章信息</title>
<script type="text/javascript" src="/JS/JQueryAjax.js"></script>
<link type="text/css" rel="stylesheet" href="/App_Themes/Guest.css" />
<style>
.msg_left_div {padding-left:20px;min-width:100px;float:left;}
.msg_content_div {float:left;padding-top:10px;}
.ContentDiv { padding: 20px; padding-right: 5px; padding-bottom: 5px; border: 1px solid #ccc; margin-top: 10px; }
.createDate { color: #9a9a9a; font-size: 12px; }
.content { font-size: 15px; }
.content_operate { margin-top: 20px; text-align: right; color: #9a9a9a; }
.content_operate * { margin-right: 10px; display: inline; }
.comment_div { margin-top: 30px; background-color: #fafafa; float: left; width: 100%; }
.comment_div div { font-weight: 500; float: left; font-size: 20px; width: 50%; color: #9a9a9a; text-align: center; padding-top: 10px; padding-bottom: 10px; }
.comment_div div:hover { border-bottom: 3px solid #0066cc; cursor: pointer; }
.comment_selected { border-bottom: 3px solid #9a9a9a; }
.comment_content { float: left; margin-top: 20px; border-top: 1px solid #ddd; width: 100%; }
.comment_content .noneContent { color: #9a9a9a; font-size: 15px; }
.margintop10 { margin-top: 10px; }
.send_div { background: rgb(246, 246, 246); padding: 10px 10px 10px 30px; }
.userface_list { text-align: left; width: 100%; padding-left: 10px; }
.likeIcon { width: 20px; height: 20px; border-radius: 50%; cursor: pointer; }
.colorfix { color: #9a9a9a; }
.recommd { border: 1px solid #ccc; }
.likelist_ul li{margin-bottom:20px;}
.likelist_ul .likelist_img{padding:5px;}
.likelist_ul .likelist_content{padding:5px 20px;}
.likelist_ul .likelist_content .likelist_time{color:#999;font-size:12px;margin-top:5px;}
.likelist_ul .likelist_content .likelist_desc{margin-top:20px;color:#888;}
.likelist_ul .likelist_img img{width:70px;height:70px;border-radius:50px; cursor:pointer;}
.likeids_div_ul li img {width:70px;height:70px;}
/*图片*/
.thumbnail_img {width:auto;max-width:90%;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
  <div class="container-fluid">
    <ol class="breadcrumb">
      <li><a href="/">首页</a></li>
      <li><a href="/Plat/Blog/">能力中心</a></li>
      <li class="active">文章信息</li>
    </ol>
  </div>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-7 col-lg-7 col-sm-12 col-xs-12">
        <div class="ContentDiv">
            <div class="content">
                <asp:Literal runat="server" ID="Content_Lit"></asp:Literal>
            </div>
            <div class="margin_t5">
                <asp:Literal runat="server" ID="Attach_Lit"></asp:Literal>
            </div>
          <div class="content_operate"> <span class="createDate">
            <asp:Label ID="CDate_L" runat="server"></asp:Label>
            </span>
            <div title="点赞" style="cursor:pointer;" onclick="PostLike()"><span class="glyphicon glyphicon-thumbs-up"></span><%=GetUserLike() %></div>
            <span class='glyphicon glyphicon-send' title='转发' id='re_span' onclick="ShowForWard()"></span> </div>
        </div>
        <div class="comment_div">
          <div id="comm" onclick="showComms()" class="comment_selected">评论(<asp:Label ID="commCount_L" runat="server" />)</div>
          <div id="like" onclick="showLikes()">赞(<asp:Label ID="likeCount_L" runat="server" />)</div>
        </div>
        <div class="comment_content text-center">
          <div id="comm_div"> <span class="noneContent" id="Empty_Span_Comm" style="padding: 3px;" visible="false" runat="server">当前没有评论！</span>
            <asp:Repeater runat="server" ID="MsgRepeater" OnItemDataBound="MsgRepeater_ItemDataBound" EnableViewState="false">
              <ItemTemplate>
                  <div class="msgmain_div margintop10">
                      <div class="msg_left_div" style="min-width: 100px;">
                          <img class="imgface_mid" src="<%#Eval("UserFace") %>" onerror="this.src='/Images/userface/noface.gif';" title="<%#Eval("CUName") %>" onclick="ShowUser(<%#Eval("CUser") %>);" /><br />
                          <a href="javascript:ShowUserDiv('<%#Eval("CUser") %>')"><%#Eval("CUName") %></a>
                      </div>
                      <div class="msg_content_div text-left" style="margin-left: 5px;">
                          <div class="msg_content_article_div"><%#Eval("MsgContent")%></div>
                          <span class="content_date"><%#Convert.ToDateTime(Eval("CDate")).ToString("yyy年MM月dd日 hh:mm") %> </span>
                      </div>
                      <div class="clearfix"></div>
                  </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>
          <div id="likes_div" style="display: none;"> <span class="noneContent" id="Empty_Span_Like" style="margin-top:10px;display:inline-block;" visible="false" runat="server">当前无人点赞！</span>
            <div class="msgmain_div">
              <div class="userface_list">
                <ul class="likelist_ul"></ul>
                  <div class="clearfix"></div>
              </div>
            </div>
          </div>
        </div>
        <div>
          <asp:Literal runat="server" ID="MsgPage_L" EnableViewState="false"></asp:Literal>
        </div>
        <div class="clearfix"></div>
        <div class="send_div margintop10"> <span class="glyphicon glyphicon-comment colorfix"></span><strong class="colorfix">发表评论</strong>
          <div>
            <asp:TextBox ID="MsgContent_T" CssClass="margintop10 recommd atwho" Width="100%" Height="100" TextMode="MultiLine" runat="server"></asp:TextBox>
          </div>
          <div class="text-right margintop10">
            <asp:Button ID="sendButton" Text="评论" OnClick="sendButton_Click" CssClass="btn btn-primary" runat="server" />
          </div>
        </div>
      </div>
      <div class="col-md-5 col-lg-5"> </div>
    </div>
  </div>
  <asp:HiddenField ID="ids_Hid" runat="server" />
  <asp:HiddenField ID="UserInfo_Hid" runat="server" />
  <div class="right_InfoDiv" id="ShowUser_Div">
    <iframe style="width: 100%; border: 0px; height: 1000px;" id="ShowUser_if"></iframe>
  </div>
  <div style="display: none;" class="hidden_div"> <a href="javascript:;" data-toggle="modal" data-target="#forward_div" id="Forward_Btn"></a>
    <asp:HiddenField runat="server" ID="HiddenField1" />
  </div>
  <div class="modal" id="forward_div" style="position: fixed; top: 35%;">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          <span class="modal-title">内容转发</span> </div>
        <div class="modal-body">
          <div id="forward_his_div"> </div>
          <div id="forward_my_div" style="margin-top: 5px;">
            <asp:HiddenField runat="server" ID="Forward_ID_Hid" />
            <asp:TextBox runat="server" ID="ForMsg_Text" TextMode="MultiLine" Style="width: 100%; height: 100px; border-radius: 4px; border: 1px solid #ddd; padding-top: 5px; padding-left: 8px;" placeholder="说说转发理由吧!!"></asp:TextBox>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
          <asp:Button runat="server" ID="Froward_Btn" OnClick="Froward_Btn_Click" Text="转发" class="btn btn-primary" />
        </div>
      </div>
    </div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<link type="text/css" rel="stylesheet" href="/JS/atwho/jquery.atwho.css" />
<script type="text/javascript" src="/JS/atwho/jquery.atwho.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script type="text/javascript">
    LoadLikes();
    $(function () {
        $.post("/Plat/Common/Common.ashx", { action: "Plat_CompUser", value: "" }, function (data) { InitAt(data); });
        $("#MsgContent_T").keydown(function () {
            if (event.ctrlKey && event.keyCode == '13') {
                $("#sendButton").trigger("click");
            }
        });
    });
    function LoadLikes() {
        var tlp = "<li>"
        + "<div class=\"likelist_img pull-left\">"
        + "<img src=\"@salt\" onerror=\"this.src='/Images/nopic.gif'\" onclick='ShowUser(@CUser)' />"
        + "</div>"
        + "<div class=\"likelist_content pull-left\">"
        + "<div class=\"likelist_desc\"><a href=\"javascript:ShowUser(@CUser);\">@UserName</a> 赞了这条信息</div>"
        + "<div class=\"likelist_time\">@CDate</div>"
        + "</div>"
        + "<div class=\"clearfix\"></div>"
        + "</li>";
        $.post('', { action: "likelist", msgid: "<%=Mid %>" }, function (data) {
            var likelist = JSON.parse(data);
            var html="";
            for (var i = 0; i < likelist.length; i++) {
                html += tlp.replace(/@salt/g, likelist[i].salt).replace(/@UserName/g, likelist[i].UserName).replace(/@CDate/g, likelist[i].CDate).replace(/@CUser/g,likelist[i].CUser);
            }
            $("#likeCount_L").html(likelist.length);
            $(".likelist_ul").html(html);
        });
    }
    function showComms() {
        $("#comm_div").show();
        $("#likes_div").hide();
        $("#comm").attr("class", "comment_selected")
        $("#like").attr("class", "");

    }
    function showLikes() {
        $("#comm_div").hide();
        $("#likes_div").show();
        $("#comm").attr("class", "")
        $("#like").attr("class", "comment_selected");
    }
    function ShowForWard() {
        $("#Forward_ID_Hid").val(<%:Mid%>);
    var text = " 转发内容：<br />" + $(".ContentDiv").find(".content").text();
    $("#forward_his_div").html(text);
    $("#Forward_Btn").click();
}
function PostLike()//点赞
{
    var id = "<%:Mid%>";
    var tlp = "<li title='{0}' class='likeids_li'><a href='javascript:;'><img class='imgface_mid' src='{1}' /></a></li>", a = "";
    var $main = $(".likeids_div_ul");
    var uname = $("#UserInfo_Hid").val().split(':')[0];
    var likeobj = $main.find("li[title='" + uname + "']");
    if ($("#showlike_span").attr("data-init") == "1") {
        a = "ReLike";
        likeobj.remove();
        $("#showlike_span").hide();
        $("#showlike_span").attr("data-init", "0");
    }
    else {
        a = "AddLike";
        var uface = $("#UserInfo_Hid").val().split(':')[1];
        tlp = tlp.replace("{0}", uname).replace("{1}", uface);
        $main.append(tlp);
        $("#showlike_span").show();
        $("#showlike_span").attr("data-init", "1");
    }
    var num = $main.find(".likeids_li").length;
    if (num>0) {
        $("#Empty_Span_Like").hide();
    } else {
        $("#Empty_Span_Like").show();
    }
    $("#likeCount_L").text(num);
    PostToCS2("Default.aspx", a, id, function () { LoadLikes(); });
}
function ShowUserDiv(uid) {
    $("#ShowUser_Div").show();
    $("#ShowUser_if").attr("src", "/Plat/Common/UserDetail.aspx?ID=" + uid);
}
function ShowUser(uid) {
    var diag = new ZL_Dialog();
    diag.title = "用户信息";
    diag.maxbtn = false;
    diag.url = "../Common/UserDetail.aspx?ID=" + uid;
    diag.ShowModal();
}
    //-----AT
function InitAt(json) {
    json = eval(json);
    $(".atwho").atwho({
        tpl: "<li data-value='${atwho-at}${name}${suffix}'>${imageUrl}&nbsp;${name}</li>",
        at: "@",
        search_key: "name",
        title: "请选择要@的同事名称",
        data: json,
        limit: 8,
        max_len: 20,
        start_with_space: false,
        //data:jsonArr,
        callbacks: {
            remote_filter: function (query, callback)//@之后的语句
            {
                //callback(json);
            }
        }//callback
    });
}
function AddAT(uname, uid) {
    var v = $("#MsgContent_T").val();
    $("#MsgContent_T").val(v + "@" + uname + "[uid:" + uid + "]");
}
</script>
</asp:Content>