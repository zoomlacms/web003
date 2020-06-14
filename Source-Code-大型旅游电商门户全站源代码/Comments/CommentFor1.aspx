<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommentFor.aspx.cs" Inherits="ZoomLa.WebSite.Comment.CommentFor" EnableViewStateMac="false" MasterPageFile="~/Common/Master/Empty.master" Debug="true" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>发表评论</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<style>
.ping_score .fa-stack { cursor:pointer;}
.ping_score .fa-square { color:#dbdbdb; }
.ping_score .fa-stack.active .fa-square { color:#f59b00;}
#comment_sender { padding-left:30px; padding-right:30px; background:#ffa800; border:1px solid #ffa800; font-size:18px;}
.ping_score_c { font-size:0.8em;}
.ping_score_r { float:left; margin-left:15px; line-height:30px; color:#999;}
.viewcon_lun_t { margin-top:20px; margin-bottom:15px; color:#8c8b8b;}
.viewcon_lun_t span { font-size:25px; color:#333;}
.comment_list .media-left { padding-right:20px;}
.comment_list .media-left img { width:54px; height:54px;}
.comment_list .media-heading { font-size:14px;}
.comment_list .media-heading span.pull-left { line-height:24px; color:#f56c00;}

.comment_list_s { float:left; margin-left:10px; font-size:0.7em;}
.comment_list_s .fa-square { color:#dbdbdb; }
.comment_list_s .fa-stack.active .fa-square { color:#f59b00;}
.comment_list_z { float:right;}
.comment_list_z .fa-circle  { color:#ff9c07;}
.comm_btns .fa-stack { font-size:0.9em;}
.comment_list_h { text-align:right;}
.comment_list_h .btn { margin-right:0; background:#f5a100; border:1px solid #f5a100; border-radius:0;}
#toComment { float:none; padding:0;}
.comment_list_ct { color:#999;}
</style>
<div class="ping_div"></div>
    <div id="Comment">
    	<div style="background:#f5f5f5">
        	<div class="container">
                <div id="CommentInput" runat="server" style="margin-bottom: 20px; position: relative;" >
                    <div class="comment_list">
                        <ZL:ExRepeater ID="RPT" runat="server" PageSize="10" PagePre="<div class='text-center margin_t10'>" PageEnd="</div>">
                            <ItemTemplate>
                                <div class="media">
                                    <div class="media-left"><a href="#"><img class="media-object" src="<%# GetUserFace(Eval("UserID","{0}")) %>" alt="<%# GetUserName(Eval("UserID","{0}")) %>" onerror="javascript:this.src='/Images/userface/noface.gif';" /></a></div>
                                    <div class="media-body">
                                        <h4 class="media-heading">
                                        	<span class="pull-left"><%# GetUserName(Eval("UserID","{0}")) %></span>
                                            <div class="comment_list_s comment_list_s<%# Eval("Score")%>"></div>
                                            <div class="comment_list_z">
                                            	<span class="comm_btns support" data-id="<%#Eval("CommentID") %>" data-flag="1" onClick="Support(this)"><span class="count" style="color:#ff9d00;"><%#Eval("AgreeCount") %></span><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-thumbs-up fa-stack-1x fa-inverse"></i></span></span>
                                            	<span class="comm_btns support" data-id="<%#Eval("CommentID") %>" data-flag="-1" onClick="Support(this)"><span class="count" style="color:#ff9d00;"><%#Eval("DontCount") %></span><span class="fa-stack fa-lg"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-thumbs-down fa-stack-1x fa-inverse"></i></span></span>
                                            </div>
                                            <div class="clearfix"></div>
                                        </h4>
                                        <div class="comment_list_c">
                                        	<asp:Literal ID="Commment_Lit" runat="server" EnableViewState="false"></asp:Literal>
                                            <p><%#Convert.ToInt32(Eval("Audited"))==1? Eval("Contents"):"" %></p>
                                            <div class="comment_list_ct"><%# Eval("CommentTime") %></div>
                                        </div>
                                        <div class="comment_func">
                                        	<%#GetReport(Eval("ReprotIDS").ToString(),Eval("CommentID").ToString()) %>
                                    	</div>
                                        <div class="comment_list_h">
                                        	<span class="btn btn-warning btn-sm comm_btns" onclick='showHuiFu(this,<%#Eval("commentID") %>)'>回复</span>
                                        </div>
                                    </div>
                                </div>
                                
                            </ItemTemplate>
                            <FooterTemplate></FooterTemplate>
                        </ZL:ExRepeater>
                        <div class="hidden">评论总数：<asp:Label ID="Label1" runat="server" Text="0"></asp:Label></div>
                    </div>
                    <div class="Assis_Div">
                        <a class="info" id="setup" title="顶" href="javascript:;" onclick="ContentAssist(1)">
                            <i class="fa fa-thumbs-o-up"></i>
                            <span class="gray_9 info_count" id="asscount" runat="server">0</span>
                        </a>
                        <a class="info" id="setdown" title="踩" href="javascript:;" onclick="ContentAssist(-1)">
                            <i class="fa fa-thumbs-o-down"></i>
                            <span class="gray_9 info_count">
                                <asp:Label ID="CommCount_L" runat="server"></asp:Label></span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    	<div class="container">
        	<div class="viewcon_lun_t"><span>我要点评：</span>留下你的点评，帮助千千万万驴友~</div>
            <div id="Comment_List">
            	<div class="alert alert-info" id="nocoment" visible="false" runat="server" role="alert">信息所属栏目评论功能已关闭</div>
                <div class="alert alert-info" id="nologin" visible="false" runat="server" role="alert">您必须登录才能评论，请点击<a href="javascript:;" onclick="LoginUser()">登录</a></div>
                <div id="comentyes" visible="false" runat="server">
                    <div class="form-horizontal">
                        <div class="form-group ping_score">
                            <label for="inputPassword3" class="col-sm-2 control-label"><span style="color:#f00;">*</span>总体评价：</label>
                            <div class="col-sm-10">
                                <div class="ping_score_c pull-left">
                                    <span class="fa-stack fa-lg" onClick="SetScore('1',this);" data-toggle="tooltip" data-placement="top" title="千万别去"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-star fa-stack-1x fa-inverse"></i></span>
                                    <span class="fa-stack fa-lg" onClick="SetScore('2',this);" data-toggle="tooltip" data-placement="top" title="不推荐"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-star fa-stack-1x fa-inverse"></i></span>
                                    <span class="fa-stack fa-lg" onClick="SetScore('3',this);" data-toggle="tooltip" data-placement="top" title="一般般"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-star fa-stack-1x fa-inverse"></i></span>
                                    <span class="fa-stack fa-lg" onClick="SetScore('4',this);" data-toggle="tooltip" data-placement="top" title="值得一去"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-star fa-stack-1x fa-inverse"></i></span>
                                    <span class="fa-stack fa-lg" onClick="SetScore('5',this);" data-toggle="tooltip" data-placement="top" title="必须推荐"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-star fa-stack-1x fa-inverse"></i></span>
                                </div>
                                <div class="ping_score_r"><span>点击星星打分</span></div>
                                <input type="hidden" id="Score_Hd" value="1" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content_sender" class="col-sm-2 control-label"><span style="color:#f00;">*</span>评价：</label>
                            <div class="col-sm-10">
                                <textarea id="content_sender" onkeyup="upMaxLength()" runat="server" style="width: 100%; height: 120px" rows="4" maxlength="320" class="form-control" placeholder="详细、客观、真实，130字以上为佳！"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="content_sender" class="col-sm-2 control-label"><span style="color:#f00;">*</span>验证码：</label>
                            <div class="col-sm-10">
                                <asp:TextBox ID="VCodesender" placeholder="验证码" MaxLength="6" Width="100" runat="server" class="form-control" />
                                <img id="VCodesender_img" runat="server" title="点击刷新验证码" class="code" style="height: 34px;" />
                                <input type="hidden" id="VCodesender_hid" name="VCodesender_hid" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <asp:HiddenField ID="HdnTitle" runat="server" />
                                <asp:ValidationSummary ID="ValidationSummary1" ShowMessageBox="true" ShowSummary="false" runat="server" />
                                <button type="button" id="comment_sender" class="btn btn-warning" onclick="replyContent('sender')">提交评论</button>
                                <span id="reinfo_sender" style="color:#c00;"></span>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default" hidden>
                        <div class="CommentPK" style="display: none;">
                            <asp:RadioButtonList ID="RBLPK" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="1" Selected="True">我支持</asp:ListItem>
                                <asp:ListItem Value="0">我反对</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        
                        <div class="">
                            <span>评 分：</span><span>
                                <asp:DropDownList CssClass="form-control" Width="100" ID="DDLScore" runat="server">
                                    <asp:ListItem Value="1" Selected="True">1分</asp:ListItem>
                                    <asp:ListItem Value="2">2分</asp:ListItem>
                                    <asp:ListItem Value="3">3分</asp:ListItem>
                                    <asp:ListItem Value="4">4分</asp:ListItem>
                                    <asp:ListItem Value="5">5分</asp:ListItem>
                                </asp:DropDownList>
                            </span>
                        </div>
                    </div>
                </div>
    
            </div>
        </div>
    </div>
    <div id="boxCovers" style="display: none; position: absolute; top: 0px; left: 0px; z-index: 98; background: #b2b2b2;"></div>
    <div id="popupLogin" style="width: 300px; height: 200px; background: #fff; position: absolute; top: 250px; left: 350px; z-index: 99; border: #33ccff solid 3px; display: none;">
        <div id="LoginHead" class="ptitle"><span class="pspanl">用户登录</span><span id="lclose" class="pspanr">关闭</span></div>
    </div>
    <div id="toComment_box" class="hidden">
        <div id="toComment">
            <textarea id="content_reply" name="txtContent" class="form-control" placeholder="请输入评论内容" rows="4"></textarea>
            <span class="pull-left hidden"><i class="fa fa-smile-o" title="插入表情"></i></span>
            <span class="pull-left reply_vaild">验证码:
                <asp:TextBox ID="VCodereply" MaxLength="6" runat="server" class="form-control td_m" />
                <img id="VCodereply_img" runat="server" title="点击刷新验证码" class="code" />
                <input type="hidden" id="VCodereply_hid" name="VCodereply_hid" /></span>
            <input type="hidden" name="txtpid" id="txtpid" />
            <span class="pull-right"><span id="reinfo_reply"></span>
                <button class="btn btn-sm btn-default" type="button" id="comment_reply" onclick="replyContent('reply')">发布</button></span>
            <div class="clearfix"></div>
        </div>
    </div>
    <asp:Button ID="Reply_Btn" runat="server" Style="display: none;" OnClick="Reply_B_Click" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <link rel="stylesheet" href="/App_Themes/V3.css" />
    <style>
		body{margin:0;padding:0;}
		.container-fluid{margin-right:0;margin-left:0;padding-right:0;padding-left:0;}
		ul{display:inline-block;margin:0;padding:0;}
		ul li{float:left;}
		.replybody{margin:5px;padding:5px;border:1px #ccc solid;background-color:#FFE;}
		.replybody h5{color:#428bca;}
		.replybody .comm_btns{cursor:pointer;}
		.comm-date{float:right;display:inline-block;color:#999;}
		.comm_btns{display:inline-block;margin-right:10px;}
		.replycomm{max-width:100%;}
		.ContentRight .form-control{max-width:100%;}
		#toComment{position:relative;border:1px solid #ddd;border-radius:4px;background:#f5f5f5;}
		.form-control{max-width:100%;border-bottom:1px solid #ddd;border-radius:0;}
		#toComment .fa-smile-o{margin-top:4px;margin-left:10px;color:#0C3;font-size:1.5em;}
		#toComment .btn{padding-right:2em;padding-left:2em;}
		.comment_func .comm_btns{cursor:pointer;}
		.reply_vaild{margin-left:5px;}
		.reply_vaild input{border:1px solid #ccc!important;}
		#VCode2{height:30px;}
		.count{color:red;}
		.comm_audited{color:#080;}
		.fa-spin{-webkit-animation:fa-spin .5s infinite linear;animation:fa-spin .5s infinite linear;}
		.Assis_Div{position:fixed;top:45%;left:50%;display:none;margin-left:-650px;}
		.Assis_Div .info{display:block;padding:10px;width:80px;border:1px solid #ccc;color:#428bca;text-align:center;text-decoration:none;font-size:20px;}
    </style>
    <script type="text/javascript" src="/JS/Common.js"></script>
    <script type="text/javascript" src="/JS/ICMS/alt.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script src="/JS/ZL_ValidateCode.js"></script>
    <script type="text/javascript">
        var ismove = false;
        $(function () {
            $("#VCodesender").ValidateCode();
            $("#VCodesender").keydown(function(){
                if(event.keyCode==13)
                {
                    $("#comment_sender").click();
                    return false;
                }
            });
            parent.initCommInfo($(".Assis_Div").html());
        })
        function LoginUser(){
            var url=parent.location.href.replace(location.protocol+"//","").replace(location.host,"");
            parent.location.href="/user/login.aspx?ReturnUrl="+url;
        }
        function commentSubmit() {
            $("#Reply_Btn").click();
        }
        //支持反对操作
        function Support(obj) {
            $.ajax({
                type: "POST",
                data: { action: 'support', id: $(obj).data('id'), flag: $(obj).data('flag') },
                success: function (data) {
                    if(data=="-1"){alert("不能重复支持或反对!");return;}
					$(obj).parent().find('.support').addClass('gray_9');
                    var val=parseInt($(obj).find(".count").text()) + 1;
                    if(isNaN(val)){val=1;}
                    $(obj).find(".count").text(val);
                    $(obj).parent().find('.support').removeAttr("onclick");
                }
            });
        }
        //回复操作
        function replyContent(action){
            $("#comment_"+action).attr("disabled","disabled");
            $("#reinfo_"+action).html("<span class='fa fa-refresh fa-spin'></span>");
            //根据action设置相应的值
            $.ajax({
                type:"POST",
                data:{action:action,id:$("#txtpid").val(),content:$("#content_"+action).val(),VCode_hid:$("#VCode"+action+"_hid").val(),VCode:$("#VCode"+action).val(),Score:$("#Score_Hd").val()},
                success:function(data){
                    switch (data) {
                        case "2":
                            window.location=location;
                            break;
                        case "1":
                            $("#reinfo_"+action).html("<span class='comm_audited'><span class='glyphicon glyphicon-ok-sign'></span> 感谢回复,编辑正在审核中</span>");
                            $("#VCode"+action).ValidateCode();
                            $("#VCode"+action).removeClass('codeok');
                            $("#VCode"+action).val('');
                            $("#content_"+action).val('');
                            break;
                        case "-1":
                            $("#reinfo_"+action).html("<span style='color:red;'><span class='glyphicon glyphicon-exclamation-sign'></span> 验证码不正确!</span>");
                            $("#comment_"+action).removeAttr('disabled');
                            break;
                        case "-2":
                            $("#reinfo_"+action).html("未登录!点击[<a href='javascript:;' onclick='parent.checkLogin()'>登录</a>]!");
                            break;
                        case "-3":
                            $("#reinfo_"+action).html("内容不能为空!");
                            $("#comment_"+action).removeAttr('disabled');
                            break;
                        case "-5":
                            $("#reinfo_"+action).html("您已经评论过了!");
                            break;
                        default:
                            $("#reinfo_"+action).html("<span style='color:red;'>该内容不允许发表评论!</span>");
                            $("#comment_"+action).removeAttr('disabled');
                            break;
                    }
                }
            });
        }
        //举报操作
        function Report(obj) {
            $.ajax({
                type: "POST",
                data: { action: 'report', cid: $(obj).data('cid') },
                success: function (data) {
                    if (data == "1") {
                        $(obj).removeAttr('onclick');
                        $(obj).addClass('gray_9');
                        $(obj).text('已举报');
                    }
                }
            });
        }
        
        //顶与踩
        function ContentAssist(flag) {
            var idflag=flag==1?"setup":"setdown";
            $.ajax({
                type:"POST",
                data: { action: 'assist', gid: <%=ItemID %>,value:flag },
                success: function (data) {
                    $("#"+idflag).removeAttr("onclick");
                    $("#"+idflag).find(".hand").addClass("gray_c");
                    if(data=="1"){
                        $(".info").css({ color:'#666',});
                        var val=parseInt($("#"+idflag).find(".info_count").text())+1;
                        if(isNaN(val)){val=1;}
                        $("#"+idflag).find(".info_count").text(val);
                    }
                    
                    parent.initCommInfo($(".Assis_Div").html());
                }
            });
        }
        //回复框
        function showHuiFu(obj, pid) {
            $("#comment_reply").removeAttr("disabled");
            $("#reinfo_reply").html("");
            $("#VCodereply").ValidateCode();
            $("#txtpid").val(pid);
            $("#toComment").appendTo($(obj).parent());
			
        }   
        function LoginSuccess() {
            history.go(0);
        }
        //统计评论数量
        function upMaxLength(){
            $("#maxcount_span").text(320-$("#content_sender").val().length);
        }
        function DealwithUploadPic(path, id) {
            if (document.getElementById(id).value.indexOf("|") > -1) {
                var filepath = document.getElementById("txtFiles").value;
                var cs = filepath.split('|');
                if (path.indexOf('|') > -1) {
                    var temppath = path.split('|');
                    document.getElementById("txtFiles").value = cs[0] + "|" + temppath[1];
                }
                else {
                    document.getElementById("txtFiles").value = cs[0] + "|" + path;
                }
            } else {
                document.getElementById("txtFiles").value = path;
            }
            alert(path);
        }
		function SetScore(n,obj)
		{
			$(".ping_score_c span").removeClass("active");
			for(i=1;i<=n;i++)
			{
				$(".ping_score_c span:nth-child("+i+")").addClass("active");
			}
			$("#Score_Hd").val(n);
			$(".ping_score_r span").html($(obj).attr("data-original-title"))
		}
		$().ready(function(e) {
            $(".comment_list_s1").html("<span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span>");
            $(".comment_list_s2").html("<span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span>");
            $(".comment_list_s3").html("<span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span>");
            $(".comment_list_s4").html("<span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span>");
            $(".comment_list_s5").html("<span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span><span class=\"fa-stack fa-lg active\"><i class=\"fa fa-square fa-stack-2x\"></i><i class=\"fa fa-star fa-stack-1x fa-inverse\"></i></span>");
        });
	$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})
    </script>
</asp:Content>