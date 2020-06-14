<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Details.aspx.cs" MasterPageFile="~/Guest/Baike/Baike.master" ClientIDMode="Static" Inherits="Guestbook_BkDetails" EnableViewStateMac="false" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title><%=tittle_sp.InnerText %>_<%=Call.SiteName %></title> 
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container viewcon_bg" data-offset="280">
<div class="viewcon_main" style="background:#fff">

<ol class="breadcrumb margin_top10" style="margin-bottom:0px;">
<li><a href="/Baike">百科中心</a></li>
<li class="active">词条详情</li>
</ol>
<div class="mybaike_main" style="padding-left:15px; padding-right:15px;">
<div class="row">
<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
<div class="tittle_div">
<h1 id="tittle_sp" runat="server" class="bktitle"></h1>
<!--<span id="cate_sp" runat="server" class="bktype"></span>-->
<asp:LinkButton runat="server" ID="Edit_Btn" OnClick="Edit_Click" CssClass="btn btn-default margin_l5"><i class="fa fa-pencil"></i> 编辑</asp:LinkButton>
</div>
<div class="brief_div">
<div runat="server" id="pic_div" style="float:left;padding-right:10px;padding-bottom:10px;">
</div>
<asp:Label runat="server" ID="Brief_L"></asp:Label>
<div class="clearfix"></div>
</div>
<div class="info_div">
<ul class="list-unstyled" id="info_tb"></ul>
</div>
<div style="position: relative;">
<div id="loading"></div>
<div class="index_div">
<div class="block-title col-lg-2 col-md-2 col-xs-2">目录</div>
<div class="catalog-list col-lg-10 col-md-10 col-xs-10" id="baike_list"></div>
<div class="clearfix"></div>
</div>
<div >
<div runat="server" id="Contents_div"></div>
</div>
</div>
<div class="yl_items its" runat="server" visible="false">
<div id="editSpan" class="item" runat="server">
<div class="itme_tit"><strong>合作编辑</strong></div>
<div runat="server" id="editman" class="x_input"></div>
</div>
<span style="float: right; padding-right: 50px"><asp:LinkButton ID="lbtFavorite" runat="server" OnClick="lbtFavorite_Click">收藏</asp:LinkButton></span>
<div style="display: none;" id="divSupplyment">
<asp:TextBox runat="server" ID="txtSupplyment" CssClass="form-control" TextMode="MultiLine" Width="500" Height="120"></asp:TextBox>
</div>
</div>
</div>
<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
<div class="mybaike_pics">
<a href="/Class_1/NodeHot.aspx?GID=<%Call.Label("{$GetRequest(gid)$}"); %>"><img runat="server" id="pic_img" /></a>
<div class="mybaike_pics_t"><i class="fa fa-picture-o"></i> <%=tittle_sp.InnerText %>图册</div>
</div>

<div class="mybaike_view">
<div class="mybaike_view_t">青岩古镇周边景点</div>
<div class="mybaike_view_c">
<div class="row padding10">
<ul>
<%Call.Label("{ZL.Label id=\"获取指定景点周边景点\" GeneralID=\"{$GetRequest(gid)$}\" ShowNum=\"9\" /}"); %>
</ul>
</div>
</div>
</div>
<div class="mybaike_ask">
<div class="mybaike_ask_t">青岩古镇问答<span class="pull-right"><a href="#"><i class="fa fa-plus-circle"></i>更多</a></span></div>
<div class="mybaike_ask_c">
<ul>
<%Call.Label("{ZL.Label id=\"输出景点问答标题列表\" ShowNum=\"10\" GeneralID=\"{$GetRequest(gid)$}\" /}"); %>
</ul>
</div>
</div>
<div class="mybaike_ad"><a href="#"><img src="/Template/Travel/style/images/theme_img4.jpg" alt="" /></a></div>
<div class="mybaike_gong">
<div class="mybaike_gong_t">青岩古镇攻略<span class="pull-right"><i class="fa fa-plus-circle"></i>更多</span></div>
<div class="mybaike_gong_c">
<ul class="media-list">
<%Call.Label("{ZL.Label id=\"输出指定景点游记列表百科专用\" NodeID=\"2\" ShowNum=\"10\" TitleNum=\"30\" SysNum=\"30\" GeneralID=\"{$GetRequest(gid)$}\" /}"); %>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
<!--content end;-->
<div class="bk_bottom">
<div class="bkheader"><span>参考资料</span></div>
<div id="ref_body" style="margin-bottom:20px;"></div>
<div class="bkheader"></div>
<div style="padding:10px 0px;"><strong>词条标签：</strong><asp:Label runat="server" ID="BType_L"></asp:Label></div>
</div>
</div>
<nav id="baike_div" class="bs-docs-sidebar affix-top">
<div class="baike_div_t"></div>
<ul class="nav" id="baike_nav"></ul>
<div class="baike_div_t" style="margin-bottom:5px;"></div>
<div><button type="button" style="width: 50px;height: 50px;font-size:20px; border-radius:0;" onclick="toggleNav()" class="btn btn-default"><span class="glyphicon glyphicon-th-list"></span></button></div>
<div id="topcontrol" title="点击回到顶部！" style="cursor: pointer; opacity: 1;"></div>
</nav>

<div class="hidden">
<asp:HiddenField runat="server" ID="info_hid" />
<asp:HiddenField runat="server" ID="refence_hid" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style type="text/css">
.floatul li {float:left;margin-left:10px;}
.foot_sub {font-size:16px;font-weight:bold;}
/*资料,信息,参考*/
.tittle_div {margin-top:15px;margin-bottom:5px;}
.tittle_div .bktitle {font-size:34px;line-height:34px;margin-bottom:14px;color:#000;font-weight:400;margin:0 10px 0 0;}
.tittle_div h1{ font-size:28px;}
.tittle_div .bktype {font-size:20px;font-weight:400;color:#333;}
#info_tb li {border-bottom:1px dashed #ddd;line-height:26px; padding-left:10px;padding-right:10px;}
.info_li_div {width:48%;float:left;}
.info_l {width:107px;color:#999;font-weight:700; display:inline-block;}
.info_r {color:#333;display:inline-block;}
.ref_item  {color:#666;line-height:30px;font-size:12px;}
.ref_item .item_url {color:#666;}
.brief_div p{ font-family:微软雅黑; font-size:14px; line-height:26px;}
.Edit_Btn{ float:left}
/*目录索引*/
.block-title { border:1px solid #ddd;background:#fbfbfb;height: 210px; line-height: 210px; font-size: 1.5em; text-align: center;}
.catalog-list { display:block;position:relative;overflow:hidden;height:210px; padding-top:15px;padding-bottom:10px;background:#fff; border:1px solid #ddd;}
.dirul {float:left;width:150px;border-right:1px solid #ddd;padding-left:20px;list-style-type:none;list-style:none;}
.dirul>li{padding-bottom:3px;list-style-type:none;list-style:none;}
.drul li ul {padding:0px;margin:0px;list-style-type:none;}
.dirul .level1 {color:#136ec2;font-size:16px;font-weight:500;text-decoration:none;}
.dirul .level2 {color:#333;line-height:16px;font-size:12px;text-decoration:none;color:#136ec2;padding-left:12px;}
.dirul .level3 {color:#333;line-height:16px;font-size:12px;text-decoration:none;padding-left:24px;}
#baike_div { position:fixed; bottom:600px; background:#fff; width:181px; z-index:1300;}
.baike_div_t { height:10px; background:url(/Template/Travel/style/Images/baike_bg2.png) left no-repeat;}
#baike_nav { background:url(/Template/Travel/style/Images/baike_bg4.jpg) left repeat-y; background-position-x:4px;}

#baike_nav li { line-height:30px;}
#baike_nav li a { display:block;}
#baike_nav li.active a { background:url(/Template/Travel/style/Images/baike_bg.png) left no-repeat;}
#baike_nav li>a{ padding:0px; padding-left:20px; background:url(/Template/Travel/style/Images/baike_bg3.png) left no-repeat; background-position-x:2px;}
#baike_nav .level1 { color:#333; font-weight:bold;}
#baike_nav .level2 { color:#666; padding-left:30px; background:none;}
#baike_nav .level3 { color:#666; padding-left:40px; background:none;}
.wordcount{ padding:15px; border:1px solid #ddd;} 

#topcontrol{display: block;width: 50px;height: 50px;background: url(/App_Themes/User/top.jpg);margin-right: 14px;margin-bottom: 44px;}
#topcontrol:hover{background: url(/App_Themes/User/top.jpg) 0px 50px;background-image: url(https://www.zoomla.cn/App_Themes/User/top.jpg);background-position-x: 0px;background-position-y: 50px;background-size: initial; background-repeat-x: initial;background-repeat-y: initial;background-attachment: initial;background-origin: initial;background-clip: initial;background-color: initial;}

.bkheader{padding-bottom:10px;border-bottom:2px solid #ccc;padding:0 !important;margin:0 !important;font-size:19px;line-height:45px;font-weight:200;}
.btype_a {margin-left:5px;margin-right:5px;color:#136ec2;}
.flag_h {border-bottom:1px solid #ddd;padding-bottom:5px;}
.flag_h .flag_num {font-size:14px; display:inline-block;width:25px;height:25px;line-height:25px;border-radius:4px; color:#fff;background-color:#136ec2;text-align:center;}
.flag_h .flag_name {font-size:18px;color:#2488e4;padding-left:5px;}
</style>
<script src="/JS/ICMS/ZL_Common.js"></script>
<script src="/JS/Plugs/Baike.js"></script>
<script src="/JS/ZL_Regex.js"></script>
<script src="/JS/Controls/ZL_Array.js"></script>
<script>
BaiKe.config.id = "Contents_div";
BaiKe.config.dirid = "baike_list";
BaiKe.config.navid = "baike_nav";
BaiKe.Init();

    $(function () {
        $("#baike_div").hide();
        $('body').scrollspy({ target: '#baike_div', offset: 100 });
        $('body').on('activate.bs.scrollspy', function (e) {
            $("#baike_nav .navTitle").each(function (i) {
                if ($(this).parent()[0] == e.target) {
                    if (i >= 1) { $("#baike_div").show(); return; } else { $("#baike_div").hide(); }
                }
            })
        })
        //----------------------
        var intertag = 0;
        $("#topcontrol").click(function () {
            intertag = setInterval(function () {
                if ($(window).scrollTop() <= 0) { clearInterval(intertag); }
                $(window).scrollTop($(window).scrollTop() - 50);
            }, 10);
        });
        //---------------------------------------
        {
            var val = $("#info_hid").val();
            if (!ZL_Regex.isEmpty(val)) { info.data = JSON.parse(val); info.dataToHtml(); }
        }
        //---------------------------------------
        {
            var val = $("#refence_hid").val();
            if (!ZL_Regex.isEmpty(val)) { refence.data = JSON.parse(val); refence.dataToHtml(); }
        }
    });
    function toggleNav() {
        if ($('#baike_nav').css("visibility") == "visible")
        { $('#baike_nav').css('visibility', 'hidden'); }
        else
        { $('#baike_nav').css('visibility', 'visible'); }
    }
    //---------修改h1标识的样式,根据选择开启
    var $items = $("#Contents_div").find("h1");
    //var flagTlp = '<h1 class="flag_h"><span class="flag_num">1</span><span class="flag_name">级别信息</span></h1>';
    for (var i = 0; i < $items.length; i++) {
        //替换标识
        var $item = $($items[i]);
        var name = $item.text(); $item.text("");
        $item.addClass("flag_h");
        $item.append('<span class="flag_num">' + (i + 1) + '</span><span class="flag_name">' + name + '</span>');
    }
    $().ready(function (e) {
        var bw = $(window).width();//页面总宽
        var right_width = (bw / 2 + 570); //490为页面宽度/2
        var right_point = right_width - 240;//110为对联宽度 5为间隔5px
        $('#baike_div').css({ "left": right_point });
    });
</script>
</asp:Content>