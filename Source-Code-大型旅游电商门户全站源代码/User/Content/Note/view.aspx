﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view.aspx.cs" Inherits="test_view" MasterPageFile="~/Common/Master/Empty.master" ValidateRequest="false"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>我的游记</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div ng-app="app">
<div ng-controller="NoteCtrl">
<div class="note">
<div class="note-topimg" id="note-topimg" style="background:url({{comMod.topimg==''?'res/page_bg.jpg':comMod.topimg}}) center no-repeat;background-size:cover;">
</div>
<div class="note-content container" id="note-content">
<div class="row">
<div class="col-lg-8 col-8 col-sm-8 col-xs-12" style="width:75%">
<div class="set_title"><h1>{{comMod.title}}</h1></div>
    <div id="Raiders_con_lc">
        <%=contStr %>
    </div>
</div>
<div class="cl-lg-4 col-md-4 col-sm-4 col-xs-12" style="width:25%">
<div class="Raiders_dir" id="Raiders_dir">
<div class="Raiders_dirt">游记目录</div>
<div class="relative">
<div id="Raiders_dnav">
<div class="Raiders_dir_t"></div>
<ul class="nav">
<div ng-repeat="item in comMod.comlist track by $index" ng-switch="item.type">
<li ng-switch-when="para"><a ng-href="#{{item.id}}" ng-bind="($index+1)+' '+item.title"></a></li>
</div>
</ul>
<div class="Raiders_dir_t"></div>
</div>
</div>
</div>
</div>
</div>

</div>
<div class="note-music container" style="display:none;">
<asp:HiddenField runat="server" ID="Save_Hid" />
<audio id="mp3_audio" ng-src="{{comMod.mp3}}" autoplay></audio>
</div>
</div>
</div>
</div>
<div class="view_bottom">
    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-danger" OnClick="LinkButton1_Click">发表游记</asp:LinkButton>
    <a href="note.aspx?id=<%= Request.QueryString["id"] %>&nodeid=2" class="btn btn-warning">返回编辑</a>
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
<script>
//添加一个节点,如果节点为空节点,则填充其自身,否则添加
//不需要最后一个,所有添加都从顶端开始
var scope = null, $upvideo = null;
var note = {
	getModel: function () {
		return { type: "", id: note.createID(), orderID: note.maxOrderID(), text: "", content: "", openText: false };
	},
	Video: {
		add: function (id, videoType, content) {
			var com = note.getModel();
			com.id = id;
			com.type = "video";
			com.videoType = videoType;
			note.addToList(com);
		},
		getvideo: function (model) {
			console.log(model);
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
		add: function () {
			var com = note.getModel();
			com.type = "para";
			com.title = "这是标题";
			note.addToList(com);
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
	}
};
angular.module("app", [])
.controller("NoteCtrl", function ($scope, $compile) {
	scope = $scope;
	scope.note = note;
	$scope.comMod = { topimg: "", title: "", mp3: "", comlist: [] };
	$scope.comMod = JSON.parse($("#Save_Hid").val());
	var emotion = {
		SmilmgName: { tab0: ['j_00', 84], tab1: ['t_00', 40], tab2: ['w_00', 52], tab3: ['B_00', 63], tab4: ['C_00', 20], tab5: ['i_f', 50], tab6: ['y_00', 40] }, //图片前缀名
		imageFolders: { tab0: 'jx2/', tab1: 'tsj/', tab2: 'ldw/', tab3: 'bobo/', tab4: 'babycat/', tab5: 'face/', tab6: 'youa/' }, //图片对应文件夹路径
		SmileyInfor: {
			tab0: ['Kiss', 'Love', 'Yeah', '啊！', '背扭', '顶', '抖胸', '88', '汗', '瞌睡', '鲁拉', '拍砖', '揉脸', '生日快乐', '大笑', '瀑布汗~', '惊讶', '臭美', '傻笑', '抛媚眼', '发怒', '打酱油', '俯卧撑', '气愤', '?', '吻', '怒', '胜利', 'HI', 'KISS', '不说', '不要', '扯花', '大心', '顶', '大惊', '飞吻', '鬼脸', '害羞', '口水', '狂哭', '来', '发财了', '吃西瓜', '套牢', '害羞', '庆祝', '我来了', '敲打', '晕了', '胜利', '臭美', '被打了', '贪吃', '迎接', '酷', '微笑', '亲吻', '调皮', '惊恐', '耍酷', '发火', '害羞', '汗水', '大哭', '', '加油', '困', '你NB', '晕倒', '开心', '偷笑', '大哭', '滴汗', '叹气', '超赞', '??', '飞吻', '天使', '撒花', '生气', '被砸', '吓傻', '随意吐'],
			tab1: ['Kiss', 'Love', 'Yeah', '啊！', '背扭', '顶', '抖胸', '88', '汗', '瞌睡', '鲁拉', '拍砖', '揉脸', '生日快乐', '摊手', '睡觉', '瘫坐', '无聊', '星星闪', '旋转', '也不行', '郁闷', '正Music', '抓墙', '撞墙至死', '歪头', '戳眼', '飘过', '互相拍砖', '砍死你', '扔桌子', '少林寺', '什么？', '转头', '我爱牛奶', '我踢', '摇晃', '晕厥', '在笼子里', '震荡'],
			tab2: ['大笑', '瀑布汗~', '惊讶', '臭美', '傻笑', '抛媚眼', '发怒', '我错了', 'money', '气愤', '挑逗', '吻', '怒', '胜利', '委屈', '受伤', '说啥呢？', '闭嘴', '不', '逗你玩儿', '飞吻', '眩晕', '魔法', '我来了', '睡了', '我打', '闭嘴', '打', '打晕了', '刷牙', '爆揍', '炸弹', '倒立', '刮胡子', '邪恶的笑', '不要不要', '爱恋中', '放大仔细看', '偷窥', '超高兴', '晕', '松口气', '我跑', '享受', '修养', '哭', '汗', '啊~', '热烈欢迎', '打酱油', '俯卧撑', '?'],
			tab3: ['HI', 'KISS', '不说', '不要', '扯花', '大心', '顶', '大惊', '飞吻', '鬼脸', '害羞', '口水', '狂哭', '来', '泪眼', '流泪', '生气', '吐舌', '喜欢', '旋转', '再见', '抓狂', '汗', '鄙视', '拜', '吐血', '嘘', '打人', '蹦跳', '变脸', '扯肉', '吃To', '吃花', '吹泡泡糖', '大变身', '飞天舞', '回眸', '可怜', '猛抽', '泡泡', '苹果', '亲', '', '骚舞', '烧香', '睡', '套娃娃', '捅捅', '舞倒', '西红柿', '爱慕', '摇', '摇摆', '杂耍', '招财', '被殴', '被球闷', '大惊', '理想', '欧打', '呕吐', '碎', '吐痰'],
			tab4: ['发财了', '吃西瓜', '套牢', '害羞', '庆祝', '我来了', '敲打', '晕了', '胜利', '臭美', '被打了', '贪吃', '迎接', '酷', '顶', '幸运', '爱心', '躲', '送花', '选择'],
			tab5: ['微笑', '亲吻', '调皮', '惊讶', '耍酷', '发火', '害羞', '汗水', '大哭', '得意', '鄙视', '困', '夸奖', '晕倒', '疑问', '媒婆', '狂吐', '青蛙', '发愁', '亲吻', '', '爱心', '心碎', '玫瑰', '礼物', '哭', '奸笑', '可爱', '得意', '呲牙', '暴汗', '楚楚可怜', '困', '哭', '生气', '惊讶', '口水', '彩虹', '夜空', '太阳', '钱钱', '灯泡', '咖啡', '蛋糕', '音乐', '爱', '胜利', '赞', '鄙视', 'OK'],
			tab6: ['男兜', '女兜', '开心', '乖乖', '偷笑', '大笑', '抽泣', '大哭', '无奈', '滴汗', '叹气', '狂晕', '委屈', '超赞', '??', '疑问', '飞吻', '天使', '撒花', '生气', '被砸', '口水', '泪奔', '吓傻', '吐舌头', '点头', '随意吐', '旋转', '困困', '鄙视', '狂顶', '篮球', '再见', '欢迎光临', '恭喜发财', '稍等', '我在线', '恕不议价', '库房有货', '货在路上']
		}
	};
	var strToEmotion = function (str) {
		if (!str || str == "" || str.indexOf("]") < 0) { return str; }
		var baseurl = "/Plugins/Ueditor/dialogs/emotion/images/";//jx2/j_0001.gif";
		for (var i = 0; i < 7; i++) {
			if (str.indexOf("]") < 0) { return str; }
			var tab = emotion.SmileyInfor["tab" + i];
			var url = emotion.imageFolders["tab" + i] + emotion.SmilmgName["tab" + i][0];
			for (var j = 0; j < tab.length; j++) {
				var index = j + 1;
				var imgurl = url + (index < 10 ? ("0" + index) : index);
				if (str.indexOf("[" + tab[j] + "]") < 0) continue;
				else {
					str = str.replace(new RegExp("\\[" + tab[j] + "\\]", "g"), '<img src="' + baseurl + imgurl + '.gif" />');
				}
			}
		}
		return str;
	}
	for (var i = 0; i < $scope.comMod.comlist.length; i++) {
		var com = $scope.comMod.comlist[i];
		com.text = strToEmotion(com.text);
		
	}
	//----------------
	$scope.getfname = function (name) { var start = name.lastIndexOf("/") + 1; return name.substring(start, name.length - 1); }
	//----------------
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
})
.filter("html", ["$sce", function ($sce) {
	return function (text) { return $sce.trustAsHtml(text); }
}])
var h1Arr = $("#Raiders_con_lc h1");
var str = "";
for (i = 0; i < h1Arr.length; i++) {
    $(h1Arr[i]).attr("id", "RT" + i);
    str += "<li><a href=\"#RT" + i + "\">" + $(h1Arr[i]).html() + "</a></li>";
}
$("#Raiders_dnav .nav").html(str);
</script>
</asp:Content>