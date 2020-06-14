<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Guest/Baike/Baike.master" inherits="Guest_Baike_MyBaike, App_Web_ay0tfihc" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>我的词条</title>
<style>
    .mybaike .gray6{color:#666;}
    .mybaike .baike_content{border:1px solid #d5d5d5;}
    .mybaike .table{margin-bottom:0px;}
    .mybaike .table th,td{padding:8px 40px!important; color:#666; font-weight:normal; border-bottom:none;}
    .mybaike .table td{color:#888;}
    .baie_footer .col-md-2{height:80px;line-height:65px;}
    #draft_option{visibility:hidden;}
    #draft_option .btn{line-height:23px;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container mybaike" ng-app="app">
<div class="text-center gray6"><h2>我的版本</h2></div>
<div class="text-center">
<div id="seldatas_div" class="btn-group btn-group-lg gray666" role="group" aria-label="Large button group">
<button type="button" onclick="ShowTable(this,'check_table')" class="btn btn-default active gray6">已通过版本</button>
<button type="button" onclick="ShowTable(this,'uncheck_table')" class="btn btn-default gray6">待通过版本</button>
<button type="button" onclick="ShowTable(this,'return_table')" class="btn btn-default gray6">未通过版本</button>
<button type="button" onclick="ShowTable(this,'draft_table')" class="btn btn-default gray6">草稿箱</button>
</div>
</div>
<div class="baike_content margin_t10">
<table ng-controller="Check_Controller" id="check_table" class="table table-condensed table-hover">
<thead>
<tr>
<th>词条名称</th>
<th>版本对比</th>
<th>通过时间</th>
<th>被他人修改版本</th>
</tr>
</thead>
<tbody ng-repeat="item in list">
<tr>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank" ng-bind="item.Tittle"></a></td>
<td><a href="CompBaike.aspx?id={{item.ID}}" target="_blank">查看</a></td>
<td ng-bind="item.EditTime"></td>
<td ng-bind-html="getNextTime(item) | trustHtml"></td>
</tr>
</tbody>
</table>
<table ng-controller="UnCheck_Controller" id="uncheck_table" style="display:none;" class="table table-condensed table-hover">
<thead>
<tr>
<th>词条名称</th>
<th>版本</th>
<th>提交时间</th>
</tr>
</thead>
<tbody ng-repeat="item in list">
<tr>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank" ng-bind="item.Tittle"></a></td>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank">查看</a></td>
<td ng-bind="item.EditTime"></td>
</tr>
</tbody>
</table>
<table ng-controller="Return_Controller" id="return_table" style="display:none;" class="table table-condensed table-hover">
<thead>
<tr>
<th>词条名称</th>
<th>未通过原因</th>
<th>版本</th>
<th>提交时间</th>
<th>未通过时间</th>
</tr>
</thead>
<tbody ng-repeat="item in list">
<tr>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank" ng-bind="item.Tittle"></a></td>
<td><a href="javascript:;" onclick="ShowDetail(this)">展开</a><span class="caret"></span></td>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank">查看</a></td>
<td ng-bind="item.EditTime"></td>
<td ng-bind="item.ReturnTime"></td>
</tr>
<tr style="display:none;">
<td colspan="5" ng-bind="item.ReturnDetail"></td>
</tr>
</tbody>
</table>
<table ng-controller="Draft_Controller" id="draft_table" style="display:none;" class="table table-condensed table-hover">
<thead>
<tr>
<th><input type="checkbox" class="checkall" /> 全选</th>
<th>词条名称</th>
<th>保存时间</th>
<th>操作</th>
</tr>
</thead>
<tbody ng-repeat="item in list">
<tr>
<td><input type="checkbox" name="idchk" value="{{item.ID}}" /></td>
<td><a href="/Guest/Baike/Details.aspx?id={{item.BaikeID}}&editid={{item.ID}}" target="_blank" ng-bind="item.Tittle"></a></td>
<td ng-bind="item.EditTime"></td>
<td><a href="/Guest/Baike/Alter.aspx?id={{item.ID}}">继续编辑</a> <a href="javascript:;" ng-click="RemoveData(item.ID)">删除</a></td>
</tr>
</tbody>
</table>
</div>
<div class="baie_footer margin_t10">
<div class="col-lg-2 col-md-2" id="draft_option"><label class="checkall_div btn btn-default"><input type="checkbox" class="checkall" /> 全选</label> <button type="button" onclick="DelDatas()" class="btn btn-default">删除</button></div>
<div class="col-lg-8 col-md-8 text-center" id="page_div">
</div>
<div class="col-lg-2 col-md-2"></div>
</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<script type="text/javascript" src="/JS/Plugs/angular.min.js"></script>
<script type="text/javascript" src="/JS/Controls/ZL_Array.js"></script>
<script type="text/javascript" src="/JS/Plugs/PageHelper.js"></script>
<script>
    var app = angular.module("app", []);
    var checkScope = {};//已通过版本数据标识
    var uncheckScope = {};//未通过版本数据标识
    var returnScope = {};//带通过版本数据标识
    var draftScope = {};//草稿版本数据标识
    var checkdatas = new PageHelper();
    app.filter('trustHtml', function ($sce) {
        return function (input) {
            return $sce.trustAsHtml(input);
        }

    });
    Angular_InitCheckData();
    Angular_InitUnCheckData();
    Angular_InitReturnData();
    Angular_InitDraftData();

    //初始化已通过版本Angular
    function Angular_InitCheckData() {
        app.controller("Check_Controller", function ($scope, $compile) {
            checkScope = $scope;
            checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
            $scope.list = checkdatas.GetPageDT();
            $scope.getNextTime = function (item) {
                if (!item.NextTime) { return "无" }
                return "<a href='CompBaike.aspx?id=" + item.NextID + "&oldid="+item.ID+"' target='_blank'>查看</a> "+item.EditTime;
            }
            checkdatas.Render();
        });
    }
    //初始化待通过版本Angular
    function Angular_InitUnCheckData() {
        app.controller("UnCheck_Controller", function ($scope, $compile) {
            uncheckScope = $scope;
            checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
            $scope.list = checkdatas.GetPageDT();
            checkdatas.Render();
        });
    }
    //初始化未通过版本Angular
    function Angular_InitReturnData() {
        app.controller("Return_Controller", function ($scope, $compile) {
            returnScope = $scope;
            checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
            $scope.list = checkdatas.GetPageDT();
            checkdatas.Render();
        });
    }
    //初始化草稿Angular
    function Angular_InitDraftData() {
        app.controller("Draft_Controller", function ($scope, $compile) {
            draftScope = $scope;
            checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
            $scope.list = checkdatas.GetPageDT();
            checkdatas.Render();
            $scope.RemoveData = function (id) {
                if (!confirm("是否确定删除!")) { return; }
                AjaxData({ action: "deldata", ID: id }, function (data) {
                    if (data == "1") {
                        checkdatas.DataSource.RemoveByID(id, "ID");
                        checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
                        $scope.$apply(function ($compile) {
                            $scope.list = checkdatas.GetPageDT();
                        });
                        checkdatas.Render();
                    }
                })
            }
        });
    }

    //显示未通过信息
    function ShowDetail(obj) {
        var $detailTr = $(obj).closest('tr').next();
        $detailTr.toggle();
        $detailTr.find('td').html($detailTr.find('td').text());//解析html
    }
    //加载已通过版本数据
    function InitCheckData(action, status) {
        var scope = GetScope(action);
        AjaxData({ action: 'getdatas', status: status }, function (data) {
            checkdatas.DataSource = JSON.parse(data);
            checkdatas.Init({
                id: "page_div", cpage: 1, psize: 10,
                pagenum: checkdatas.GetPageNum(checkdatas.DataSource.length, 10),
                click: function (param) {
                    scope.$apply(function ($compile) {
                        scope.list = checkdatas.GetPageDT();
                    });
                    checkdatas.Render();
                }
            });
            scope.$apply(function ($compile) {
                scope.list = checkdatas.GetPageDT();
            });
            checkdatas.Render();
        });
    }
    //根据不同数据获取的$scope
    function GetScope(action) {
        switch (action) {
            case "checkdatas":
                return checkScope;
            case "uncheckdatas":
                return uncheckScope;
            case "returndatas":
                return returnScope;
            case "draftdatas":
                return draftScope;
        }
        return checkScope;
    }

    function AjaxData(formdata,callback) {
        $.post('',formdata, callback);
    }

    $(function () {
        InitCheckData("checkdatas", 1);//默认加载已通过版本
        $(".checkall").click(function () {
            var refobj = $(this);
            $("[name='idchk']").each(function () {
                $(this)[0].checked = refobj[0].checked;
            });
        });
    })
    //显示对应信息
    function ShowTable(obj,tableid) {
        $('.table').hide();
        $("#seldatas_div button").removeClass('active');
        $("#draft_option").css('visibility', 'hidden');
        switch (tableid) {
            case "check_table":
                InitCheckData("checkdatas", 1);
                break;
            case "uncheck_table":
                InitCheckData("uncheckdatas", 0);
                break;
            case "return_table":
                InitCheckData("returndatas", -1);
                break;
            case "draft_table":
                InitCheckData("draftdatas", 2);
                $("#draft_option").css('visibility', 'visible');
                break;
        }
        $('#' + tableid).show();
        $(obj).addClass('active');
    }
    //删除数据(用于草稿数据)
    function DelDatas() {
        if (!confirm("是否确认删除?")) { return; }
        var ids = "";
        var listdata = checkdatas.DataSource;
        $("input[name='idchk']:checked").each(function () {
            ids += $(this).val() + " ";
            listdata.RemoveByID($(this).val(), "ID"); 
        });
        AjaxData({ action: "deldata", ID: ids.trim().replace(/ /g, ',') }, function (data) {
            if (data == "1") {
                draftScope.$apply(function ($compile) {
                    checkdatas.DataSource = listdata;
                    checkdatas.pagenum = checkdatas.GetPageNum(checkdatas.DataSource.length, checkdatas.psize);
                    draftScope.list = checkdatas.GetPageDT();
                    checkdatas.Render();
                });
            }
        })
    }
</script>
</asp:Content>


