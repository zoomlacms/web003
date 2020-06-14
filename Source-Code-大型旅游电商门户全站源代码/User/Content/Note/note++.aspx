<%@ Page Language="C#" AutoEventWireup="true" CodeFile="note.aspx.cs" Inherits="test_note" MasterPageFile="~/Common/Master/Empty1.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>添加游记</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div ng-app="app">
<div ng-controller="NoteCtrl">
<div class="note">
<div class="note-head">
<div class="container">
<div class="col-lg-8 col-md-8" style="padding-top:15px;">
<span style="font-size:18px;float:left;margin-right:10px;">游记完成度</span>
<div class="progress progress-striped" style="width:260px;float:left;">
<div class="progress-bar progress-bar-success" role="progressbar"
aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"  ng-style="progcss">
</div>
</div>
<strong class="margin-l" ng-bind="getcomplete()+'%'"></strong>
<a href="javascript:;" title="查看详情" style="font-size:12px;text-decoration:none;color:#ff8a00;margin-left:10px;">完成详情 <i class="fa fa-arrow-down"></i></a>
</div>
<div class="col-lg-4 col-md-4 text-right">
</div>
<div class="clearfix"></div>
</div>
</div>
<div class="note-topimg" id="note-topimg" style="background:url({{comMod.topimg==''?'res/page_bg.jpg':comMod.topimg}}) center no-repeat;background-size:cover;">
<img ng-src="" class="note-topimg_img" />
<div class="container">
<div  style="position:relative; height:500px;">
<div class="note_topimg_btns">
<div class="pull-left"><a href="javascript:;" onclick="selTopimg();"></a></div>
<div class="pull-left">
<div class="h3">设置游记头图</div>
<div class="h5">图片建议选择尺寸大于1680px的高清大图，如相机原图</div>
</div>
<div class="clearfix"></div>
</div>
</div>
</div>

</div>
<div class="note-content container" id="note-content">

<div class="row">
<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
<div class="set_title">
<input type="text" class="form-control" ng-model="comMod.title" placeholder="填写游记标题" maxlength="48" />
</div>
<div class="con-item" ng-repeat="item in comMod.comlist track by $index|orderBy: '-orderID'" ng-switch="item.type">
<div class="toolbar">
<a href="javascript:;" ><i class="fa fa-plus bar-btn" style="padding-bottom:4px;"></i></a>
<a href="javascript:;" ng-click="note.showText(item);"><i class="fa fa-text-width bar-btn"></i>添加文字</a>
<a href="javascript:;" onclick="note.preAddcom('image');"><i class="fa fa-image bar-btn" style="padding-left:5px;padding-right:5px;"></i>添加图片</a>
<a href="javascript:;" onclick="showUPVideo(this);"><i class="fa fa-video-camera bar-btn" style="padding-left:6px;padding-right:5px;"></i>添加视频</a>
<a href="javascript:;" onclick="note.preAddcom('para');"><i class="fa fa-navicon bar-btn"></i>添加段落</a>
</div>
<div class="com-text" ng-show="item.openText">
<textarea id="{{item.id}}_text" maxlength="5000" ng-model="item.text" placeholder="在这儿添加游记文字......"></textarea>
<div class="margin-top">
<i class="fa fa-smile-o fabtn" title="选择表情" onclick="selemotion(this);" ng-click="setcur(item);"></i>
<input type="button" value="取消" class="btn btn-info" ng-click="note.hideText(item);" />
</div>
</div>
<div ng-switch-when="image" class="com com-image">
<div class="com-img_item"><img ng-src="{{item.content}}" class="com-img_img"></div>
</div>
<div ng-switch-when="video" ng-switch="item.videoType" class="con-item com com-video">
<div ng-switch-when="video" ng-bind-html="note.Video.getvideo(item)|html"></div>
<div ng-switch-when="online" ng-bind-html="note.Video.getonline(item)|html"></div>
</div>
<div ng-switch-when="para" class="con-item com com-para">
<h2 class="{{'para '+item.content}}">
<span ng-bind="item.title" class="pull-left para_title"></span>
<span class="pull-left com_para_btns">
<i class="fa fa-pencil" title="修改段落" ng-click="note.Para.edit(item);"></i>
<i class="fa fa-trash" title="删除段落" ng-click="note.delcom(item);"></i>
</span>
</h2>
</div>
</div>
<div class="note-music" hidden>
<h4 style="margin-bottom:10px;">游记音乐</h4>
<div class="addmusic">
<span ng-show="comMod.mp3==''">背景音乐请选择后缀为.mp3的音乐文件</span>
<span ng-show="comMod.mp3!=''"><span>已上传 - {{getfname(comMod.mp3)}}</span><a href="javascript:;" ng-click="delmp3();">删除音乐</a></span>
<input type="button" class="btn btn-info" value="浏览" ng-click="selmp3();" />
</div>
</div>
<div class="note_bottom">
<asp:LinkButton runat="server" OnClick="SaveToDraft_Btn_Click" ID="SaveToDraft_Btn" OnClientClick="return note.preSave();" CssClass="btn btn-warning">保存草稿</asp:LinkButton>
<button type="button" class="btn btn-default" onclick="note.save();">预览</button>
<button type="button" class="btn btn-default" onclick="note.save();">发表游记</button>
</div>
</div>

<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="note_drafts">
<div class="note_drafts_t">草稿箱（4）</div>
</div>
</div>
</div>


</div>

</div>
<div class="sortbox" hidden>
<ul class="sortul list-unstyled">
<li ng-repeat="item in comMod.comlist"><img ng-src="{{getImgByType(item)}}" /></li>
</ul>
</div>
<div class="hidden">
<div class="tool-upvideo" id="upvideo_div" style="position: absolute;">
<a href="javascript:;" onclick="hideUPVideo();" class="upvideo-close" title="关闭"><i class="fa fa-remove"></i></a>
<div class="upvideo-head">
<a href="javascript:;" data-pane="upvideo-file" class="vt_btn active"><i class="fa fa-upload"></i>本地上传</a>
<a href="javascript:;" data-pane="upvideo-online" class="vt_btn"><i class="fa fa-toggle-right"></i>在线视频</a>
<div class="clearfix"></div>
</div>
<div class="vt-pane upvideo-file">
<input type="button" value="上传视频" style="width: 160px;" class="btn btn-info btn-lg" onclick="note.preAddcom('video');" />
<div style="color: #666; margin-top: 20px;">请上传200M以内的视频</div>
</div>
<div class="vt-pane upvideo-online">
<div style="color: #666; margin-top: 20px;">请复制粘贴视频源文件地址</div>
<input type="text" id="video_online_t" class="form-control margin-top" />
<input type="button" class="margin-top btn btn-info pull-right" value="确定" onclick="note.preAddcom('online');" />
</div>
</div>
<audio id="mp3_audio" autoplay></audio>
<asp:HiddenField runat="server" ID="Sys_Hid" />
<asp:HiddenField runat="server" ID="Save_Hid" />
<asp:Button runat="server" ID="Save_Btn" OnClick="Save_Btn_Click" />
<input type="file" id="mp3_file" onchange="setmp3();" accept="audio/mp3" />
<input type="file" id="topimg_file" onchange="setTopimg();" accept="image/*" />
</div>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<link href="/Plugins/Ueditor/third-party/video-js/video-js.min.css" rel="stylesheet" />
<link href="note.css" rel="stylesheet" />
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/Controls/ZL_Webup.js"></script>
<script src="/JS/Plugs/angular.min.js"></script>
<script src="/JS/Controls/ZL_Array.js"></script>
<script src="/Plugins/Ueditor/third-party/video-js/video.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<%--<script src="Base64.js"></script>--%>
<script>
    //添加一个节点,如果节点为空节点,则填充其自身,否则添加
    //不需要最后一个,所有添加都从顶端开始
    var scope = null, $upvideo = null, $emotion = $('<iframe src="/Plugins/Ueditor/dialogs/emotion/ImgFace.html" class="emotion_ifr" id="emotion_ifr"></iframe>');
    angular.module("app", [])
    .controller("NoteCtrl", function ($scope, $compile) {
        scope = $scope;
        scope.note = note;
        $scope.comMod = { id: 0, topimg: "", pic: "", title: "", mp3: "", comlist: [] };
        if ($("#Save_Hid").val() != "") { $scope.comMod = JSON.parse($("#Save_Hid").val()); }
        else { $scope.note.Empty.add(); }
        //----------------
        $scope.getfname = function (name) {  var start = name.lastIndexOf("/")+1; return name.substring(start, name.length-1); }
        $scope.selmp3 = function () { $("#mp3_file").click(); }
        $scope.delmp3 = function () { $scope.comMod.mp3 = ""; $("#mp3_audio").attr("src", ""); }
        //----------------
        $scope.setcur = function (item) {
            $scope.curitem = item;
            console.log($scope.curitem);
        }
        //边栏图片
        $scope.getImgByType = function (item) {
            switch (item.type) {
                //case "text":
                //    return "res/word_v2.gif";
                case "image":
                    return item.content;
                case "video":
                    return "res/video_v2.gif";
                case "para":
                    return "res/para_v2.gif";
                default:
                    return item.type;
            }
        }
        $scope.getcomplete = function () {
            var index = 20;
            if ($scope.comMod.topimg != "") { index += 15; }
            if ($scope.comMod.mp3 != "") { index += 10; }
            //if($scope.comMod.)//设置封面
            if ($scope.comMod.comlist&&$scope.comMod.comlist.length > 0) {
                index += 10;
                if ($scope.comMod.comlist.GetByID("image", "type")) { index += 15; }
                if ($scope.comMod.comlist.GetByID("para", "type")) { index += 15; }
                if ($scope.comMod.comlist.GetByID("video", "type")) { index += 15; }
            }
            $scope.progcss = { width: index + "%" };
            return index;
        }
    })
    .filter("html", ["$sce", function ($sce) {
        return function (text) { return $sce.trustAsHtml(text); }
    }])
    var note = {
        getModel: function () {
            return { type: "", id: note.createID(), orderID: note.maxOrderID(), text: "", content: "", openText: false };
        },
        Video: {
            add: function (videoType, content) {
                var com = note.getModel();
                com.type = "video";
                com.videoType = videoType;
                com.content = content;
                note.addToList(com);
            },
            getvideo: function (model) {
                if (!model.content || model.content == "") { return ""; }
                return '<video width="600" height="400" src="' + model.content + '" poster="/Template/V3/style/Images/l_logo.jpg" class="edui-upload-video vjs-default-skin video-js" preload="none" controls=""><source src="' + model.content + '" type="video/mp4"></video>';
            },
            getonline: function (model) {
                //直接写html会出错
                return '<embed type="application/x-shockwave-flash" src="' + model.content + '" quality="high" align="middle" allowscriptaccess="false" allowfullscreen="true" wmode="transparent" width="600" height="400">';
            }
        },
        Img: {
            add: function (src) {
                var com = note.getModel();
                com.type = "image";
                com.content = src;
                note.addToList(com);
            },
        },
        Empty: {
            //空节点,仅包含文字
            add: function () {
                var com = note.getModel();
                note.addToList(com);
            }
        },
        Para: {
            add: function (title, content) {
                var com = note.getModel();
                com.type = "para";
                com.title = title;
                com.content = content;
                note.addToList(com);
            },
            edit: function (item) {
                showPara(item.id);
            }
        },
        addToList: function (com) {
            //将组件添加入列表,如果第一个节点为空,则修改其,否则直接插入
            var first = scope.comMod.comlist[0];
            if (first && first.type == "") {
                com.text = first.text;
                com.openText = first.openText;
                scope.comMod.comlist[0] = com;
            }
            else { scope.comMod.comlist.push(com); }
        },
    };
    note.createID = function () {
        var len = ($(".com").length + 1);
        return "com-" + len;
    }
    note.maxOrderID = function () {
        var len = ($(".com").length + 1);
        return len;
    }
    note.preAddcom = function (type) {
        var id = note.createID();
        switch (type) {
            case "text":
                note.Text.add();
                break;
            case "image":
                ZL_Webup.config.json = { accept: "img", pval: { "id": id, type: "img" } };
                ZL_Webup.ShowFileUP();
                //note.Img.add(id);
                break;
            case "video":
                ZL_Webup.config.json = { pval: { "id": id, type: "video" } };
                ZL_Webup.ShowFileUP();
                break;
            case "online":
                var url = $("#video_online_t").val();
                if (url.length < 10) { alert("请输入正确的视频地址"); return; }
                note.Video.add("online", url);
                hideUPVideo();
                break;
            case "para":
                showPara();
                break;
        }
        scope.$digest();
    };
    note.autoSave = function () {
        setInterval(function () {
            note.preSave();
            $.post("", { "action": "save", value: $("#Save_Hid").val() }, function (data) {
                scope.comMod.id = data;
                console.log("autoSave", data);
            });
        }, (60 * 1000));
    }
    note.preSave = function () {
        var uploadfiles = "<%Call.Label("{$UploadDir/}");%>"
        scope.comMod.pic = $(".com-img_item img:first").attr("src");
        if (scope.comMod.pic) { scope.comMod.pic = scope.comMod.pic.replace(uploadfiles, ''); }
        $("#Save_Hid").val(angular.toJson(scope.comMod));
		var sysstr=GetFirstText();
		$("#Sys_Hid").val(sysstr)
        return true;
    }
    note.save = function () {
        note.preSave();
        $("#Save_Btn").click();
    }
    note.showText = function (item) {
        //如果未显,则显示,否则聚焦
        if (item.openText == false||item.openText==undefined) { item.openText = true; return; }
        else {
            note.alertText(item.id+"_text");
        }
    }
    note.hideText = function (item) {
        //隐掉,是否同样把文本清除掉
        item.openText = false;
    }
    note.alertText = function (id,time) {
        if (!time || time < 1) time = 3;
        var $text= $("#" + id);
        $text.focus();
        for (var i = 0, span = 200; i < time; i++) {
            setTimeout(function () {$text.css("background-color", "#f9f2f4") }, span);
            span += 200;
            setTimeout(function () {$text.css("background-color", "#fff") }, span);
            span += 200;
        }
    }
    var selemotion = function (obj) {
        var $obj = $(obj);
        //如果在当前选定中已打开,则再点击则关闭
        var $em = $obj.parent().find(".emotion_ifr:visible");
        if ($em.length > 0) { $emotion.hide(); }
        else { $obj.after($emotion); $emotion.show(); }
    }
    //--------------------------
    //WUFile {name: "z_logo.jpg", size: 12309, type: "image/jpeg", lastModifiedDate: Fri Jan 22 2016 14:52:22 GMT+0800 (中国标准时间), id: "WU_FILE_1"…}
    //note.aspx:121 Object {_raw: "/UploadFiles/Admin/admin1/20160129/z_logo.jpg"}
    //note.aspx:121 undefined
    function showUPVideo(obj) { $(obj).after($upvideo); $upvideo.show(); }
    function hideUPVideo() { $upvideo.hide(); }
    $(function () {
        //------视频
        $upvideo = $("#upvideo_div");
        $("#upvideo_div").remove();
        $upvideo.find(".vt_btn").click(function () {
            $(".vt_btn").removeClass("active");
            $(this).addClass("active");
            $(".vt-pane").hide();
            $("." + $(this).data("pane")).show();
        });
        note.autoSave();
    })
</script>
<script>
    function AddAttach(file, ret, pval) {
        switch (pval.type) {
            case "img":
                note.Img.add(ret._raw);
                break;
            case "video":
                note.Video.add("video", ret._raw);
                hideUPVideo();
                break;
        }
        scope.$digest();
    }
    /*-------TopImg-------*/
    function selTopimg() { $("#topimg_file").click(); }
    function setTopimg() {
        var fname = $("#topimg_file").val();
        if (!SFileUP.isWebImg(fname)) { alert("请选择图片文件"); return false; }
        SFileUP.AjaxUpFile("topimg_file", function (data) {
            showCut(data);
            //scope.comMod.topimg = data;
            //scope.$digest();
        });
    }
    function cutTopimg() {
        $(".modal_ifr")[0].contentWindow.cutpic();
    }
    function cutok(url) {
        scope.comMod.topimg = url;
        scope.$digest();
        closeDiag();
    }
    function setmp3() {
        var fname = $("#mp3_file").val();
        if (!fname || fname == "") { return false; }
        fname = fname.toLowerCase();
        if (fname.indexOf(".mp3") < 0) { alert("只能上传mp3文件"); return false; }
        SFileUP.AjaxUpFile("mp3_file", function (data) {
            scope.comMod.mp3 = data;
            $("#mp3_audio").attr("src", data); scope.$digest();
        });
    }
    function InsertSmiley(data) {
        scope.curitem.text += data.title;
        scope.$digest();
    }
    /*-------对话框-------*/
    var diag = new ZL_Dialog();
    diag.maxbtn = false;
    diag.backdrop = true;
    diag.reload = true;
    function showPara(id) {
        diag.title = "选择段落";
        diag.reload = true;
        diag.width = "paragraph_diag";
        diag.url = "/user/content/note/diag/addparagraph.aspx";
        if (id) { diag.url += "?id=" + id; }
        diag.ShowModal();
    }
    function showCut(url) {
        diag.url = "diag/cutpic.aspx?ipath=" + url;
        diag.title = '图片裁剪 <input type="button" class="btn btn-info margin-r" value="确定" onclick="cutTopimg();" />';
        diag.width = "widlg";
        diag.ShowModal();
    }
    function closeDiag() {
        diag.CloseModal();
    }
    function GetFirstText() {
        for (var i = 0; i < scope.comMod.comlist.length; i++) {
            var com = scope.comMod.comlist[i];
            if (!ZL_Regex.isEmpty(com.text)) { return com.text; }
        }
        return "";
    }
</script>
</asp:Content>