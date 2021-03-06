﻿<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeFile="AddScenicContent.aspx.cs" Inherits="ZoomLa.WebSite.User.Content.AddScenicContentpage" ClientIDMode="Static" ValidateRequest="false" %>
<html>
    <head>
<title id="content_tite" runat="server">添加内容</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.free.css" />
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" href="/dist/css/font-awesome.min.css"/>
<link type="text/css" rel="stylesheet" href="/App_Themes/User.css" />
<link href="/Template/Travel/style/global.css?id=20150909" rel="stylesheet"/>
<script src="/JS/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/dist/js/bootstrap.min.js"></script> 

<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
<style>
.speDiag{width:500px;}
.fd_td_l{ width:150px;}
.specDiv{width:110px;padding-left:5px;}
.specDiv .spec{border:solid 1px #ccc;margin:5px;}
.specDiv .specname{text-align:left;padding-left:5px;display:inline-block}
.specDiv span{display:inline-block;float:right;line-height:20px;}
.tabinput{ border:none; padding-left:5px; height:30px; line-height:30px;}
.radius{margin:2px;height:24px; line-height:24px; background:#eee; border:1px solid #ddd;border-radius:3px;padding:3px;}
#OAkeyword{ max-width:460px; height:36px; border:1px solid #ccc; display:inline-block;min-width:300px;padding-top:3px;}
#Keywords {display: none;}
</style>
<script>
var modelid="<%Call.Label("{ZL.Label id=\"获取指定内容模型ID\" /}");%>";
if(modelid=="46")
{
	window.location.href="/User/Content/Note/Note.aspx?id=<%Call.Label("{$GetRequest(generalid)$}");%>"
}
</script>
</head>
<body>
<form runat="server">
<%Call.Label("{ZL.Label id=\"全站共用头部\" /}");%>
<div id="pageflag" data-nav="content" data-ban="cnt"></div>
<div class="myuser_youji" style="padding:10px;">
<div class="tab-pane active" id="ConInfo">
<table id="mainTable" class="table table-bordered table_padding0 addcontent_modeltale" >
<tr style="display:none;">
<td colspan="2" class="text-center">
<asp:Label ID="Tips_L" runat="server"></asp:Label>
</td>
</tr>
<tr style="display:none;">
<td>
<asp:Label ID="Node_L" runat="server" Text=""></asp:Label>
</td>
</tr>
<tr>
<td><asp:Label ID="bt_txt" runat="server" Text="标题"></asp:Label>&nbsp;&nbsp;</td>
<td>
<asp:TextBox ID="txtTitle" style="background:url(/Images/bg1.gif) repeat-x;" CssClass="form-control m715-50" onkeyup="isgoEmpty('txtTitle','span_txtTitle');Getpy('txtTitle','PYtitle')"  runat="server"></asp:TextBox>
<span class="vaild_tip">*</span>
<div hidden>
<a href="javascript:;" id="Button11" class="btn btn-info btn-sm" onclick="ShowTitle()" ><i class="fa fa-info"></i> 标题属性</a>
<button type="button" class="btn btn-info btn-sm" onclick="ShowSys();"><i class="fa fa-list"></i></button>
<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle" ErrorMessage="标题不能为空" ForeColor="Red" Display="Dynamic" />
<span id="span_txtTitle" name="span_txtTitle"></span>
<asp:HiddenField ID="ThreadStyle" runat="server" />
<div id="duptitle_div" class="alert alert-warning" style="position: absolute;margin-left:315px;display:none;">
<ul id='duptitle_ul'></ul>
</div>
</div>
</td>
</tr>
<tbody id="Sys_Fied" runat="server" style="display:none;">
<tr hidden style="display:none;">
<td class="text-right"><asp:Label ID="py" runat="server" Text="拼音缩写"></asp:Label>&nbsp;&nbsp;</td>
<td>
<asp:TextBox ID="PYtitle" CssClass="form-control m715-50" runat="server" />
</td>
</tr>
<tr id="spec_tr" hidden style="display:none;">
<td class="text-right">所属专题&nbsp;&nbsp;</td>
<td>
<div class="specDiv"></div>
<span id="specbtn_span"><asp:Literal ID="SpecInfo_Li" runat="server"></asp:Literal></span>
<asp:HiddenField ID="Spec_Hid" runat="server" />
</td>
</tr>
<tr runat="server" hidden>
<td class="tdbgleft" align="right"> 
<asp:Label ID="gjz_txt" runat="server" Text="关键字"></asp:Label>
&nbsp;
</td>
<td>                             
<div id="OAkeyword"></div>
<asp:TextBox ID="Keywords" runat="server" CssClass="form-control" /><span>(空格或回车键分隔，长度不超过10字符或5汉字)</span>  
</td>                        
</tr>
<tr runat="server" hidden style="display:none;">
<td class="text-right"><asp:Label ID="Label4" runat="server" Text="副标题"></asp:Label>&nbsp;&nbsp;</td>
<td>
<asp:TextBox ID="Subtitle" CssClass="form-control m715-50" runat="server"></asp:TextBox>
</td>
</tr>
</tbody>
<asp:Literal ID="ModelHtml" runat="server"></asp:Literal>
<%--<tr id="attPic" runat="server">
<td class="text-right">主编辑器扩展图</td>
<td style="height:80px;">
<ul id="ThumImg_ul" class="preview_img_ul">
</ul>
<div class="clearfix"></div>
<select name="selectpic" id="selectpic" onchange="ShowPic(this.value)" class="form-control text_300">
<option value="" selected="selected">不指定附属图片</option>
</select>
</td>
</tr>--%>
<tr id="CreateHTML" runat="server">
<td class="text-right">
<asp:Label ID="Label1" runat="server" Text="生成"></asp:Label>&nbsp;
</td>
<td>
<asp:CheckBox ID="quickmake" runat="server" Checked="false" Text="是否立即生成" />&nbsp;
</td>
</tr>
<tr><td></td><td>
<asp:HiddenField runat="server" ID="RelatedIDS_Hid" />
<asp:HiddenField runat="server" ID="nodename" />
<asp:Button runat="server" CssClass="btn btn-primary" ID="EBtnSubmit" Text="添加项目" OnClick="EBtnSubmit_Click" />
<a href="MyContent.aspx?NodeID=<%=NodeID %>" class="btn btn-primary">返回列表</a>
<%--  <a href="javascript:;" id="toTop" onclick="pageScroll();"><i class="glyphicon glyphicon-upload"></i>Top</a>--%>
</td></tr>
</table>
</div>

</div>
<%Call.Label("{ZL.Label id=\"全站底部\" /}");%>
</form></body></html>
<script>
var zlconfig = {
  updir: "<%=ZoomLa.Components.SiteConfig.SiteOption.UploadDir.ToLower()%>",
duptitlenum: "<%=ZoomLa.Components.SiteConfig.SiteOption.DupTitleNum%>",
modelid: "<%=ModelID%>"
};
</script>
<script type="text/javascript" src="/JS/OAKeyWord.js"></script>
<script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/JS/chinese.js"></script>
<script type="text/javascript" src="/JS/Common.js"></script>
<script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
<script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
<script type="text/javascript" src="/JS/ICMS/tags.json"></script>
<script type="text/javascript" src="/JS/ZL_Content.js"></script>
<script type="text/javascript" src="/JS/jquery.zclip.min.js"></script>
<script type="text/javascript" src="/JS/Plugs/transtool.js"></script>
<script>
$().ready(function () {
Tlp_initTemp();
$("#BaiduTrans_a").TransTools({top:120});
});
//智能模板选择事件
function OnTemplateViewCheck(value) {
$("#TxtTemplate_hid").val(value);
}
</script>
