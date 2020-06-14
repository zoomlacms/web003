//初始化数据data的格式:[{UserID:0,UserName:''}]
var UserSelector = function (option) {
    this.btnid = option.btnid;//按钮id
    this.data = option.data ? option.data : [];
    this.isshow = option.isshow == undefined ? true : option.isshow;//是否显示用户列表
    this.container = option.container;//容器id
    this.onselected = option.onselected;//选择用户后触发
    this.DataSource = [];
}
UserSelector.prototype.userdiag = null;
UserSelector.prototype.PageHelper = null;
UserSelector.prototype.curScope = null;//angular对象
//窗口回调
UserSelector.prototype.UserCallBack = function (json) {
    var ref = this;
    for (var i = 0; i < json.length; i++) {
        if (ref.isshow) { ref.PageHelper.DataSource.pushNoDup({ UserID: json[i].UserID, UserName: json[i].UserName }, 'UserID'); }
        ref.DataSource.pushNoDup({ UserID: json[i].UserID, UserName: json[i].UserName }, "UserID");
    }
    if (ref.isshow) {
        ref.curScope.$apply(function ($compile) {
            //自动跳至最后一页
            ref.PageHelper.pagenum = ref.PageHelper.GetPageNum(ref.PageHelper.DataSource.length, ref.PageHelper.psize);
            ref.PageHelper.cpage = ref.PageHelper.pagenum;
            ref.curScope.list = ref.PageHelper.GetPageDT();
            ref.PageHelper.Render();
        })
    }
    ref.userdiag.CloseModal();
    if (ref.onselected) { ref.onselected(ref.DataSource); }
}
//加载用户列表
UserSelector.prototype.LoadUserList = function () {
    var ref = this;
    var tlphtml = '<div class="text_500">'
                + '<table ng-controller="Controller_' + ref.container + '" class="table table-bordered">'
                + '<tr><td>ID</td><td>用户名</td><td>操作</td></tr>'
                + '<tbody ng-repeat="item in list"><tr><td>{{item.UserID}}</td><td>{{item.UserName}}</td><td><a href="javascript:;" ng-click="remove(item.UserID);" title="移除"><span class="glyphicon glyphicon-remove"></span></a></td></tr></tbody>'
                + '<tr><td colspan="3"><div id="page_' + ref.container + '_div"></div></td></tr>'
                + '</table>';
    $("#" + ref.container).html(tlphtml);
    //ref.InitAngular();
}
UserSelector.prototype.InitAngular = function (app) {
    var ref = this;
    app.controller("Controller_" + ref.container, function ($scope, $compile) {
        ref.curScope = $scope;
        $scope.list = [];
        for (var i = 0; i < ref.DataSource.length; i++) {
            ref.PageHelper.DataSource.push({ UserID: ref.DataSource[i].UserID, UserName: ref.DataSource[i].UserName });
        }
        ref.PageHelper.pagenum = ref.PageHelper.GetPageNum(ref.PageHelper.DataSource.length, ref.PageHelper.psize);
        $scope.list = ref.PageHelper.GetPageDT();
        ref.PageHelper.Render();
        //删除操作
        $scope.remove = function (id) {
            ref.DataSource.RemoveByID(id, "UserID");
            ref.PageHelper.DataSource.RemoveByID(id,"UserID");
            ref.PageHelper.pagenum = ref.PageHelper.GetPageNum(ref.PageHelper.DataSource.length, ref.PageHelper.psize);
            $scope.list = ref.PageHelper.GetPageDT();
            if ($scope.list <= 0) {//如果这页没数据，就定位到上一页
                ref.PageHelper.cpage = ref.PageHelper.pagenum;
                $scope.list = ref.PageHelper.GetPageDT();
            }
            ref.PageHelper.Render();
            if (ref.onselected) { ref.onselected(ref.DataSource); }
        }
    });
}
UserSelector.prototype.GetData = function () { return this.DataSource; }
//初始加载
UserSelector.prototype.Init = function () {
    var ref = this;
    for (var i = 0; i < ref.data.length; i++) {//初始化用户数据
        ref.DataSource.push({ UserID: ref.data[i].UserID, UserName: ref.data[i].UserName });
    }
    ref.userdiag = new ZL_Dialog();
    $("#" + ref.btnid).click(function () {
        ref.userdiag.title = "请选择用户!";
        ref.userdiag.maxbtn = false;
        ref.userdiag.url = "/Mis/OA/Mail/SelGroup.aspx?Type=AllInfo&controlid=" + ref.btnid;
        ref.userdiag.ShowModal();
    });
    if (ref.isshow) {
        ref.PageHelper = new PageHelper();
        ref.PageHelper.Init({
            id: "page_" + ref.container + "_div", cpage: 1, psize: 5,
            pagenum: ref.PageHelper.GetPageNum(ref.PageHelper.DataSource.length, 5),
            click: function (param) {
                ref.curScope.$apply(function ($compile) {
                    ref.curScope.list = ref.PageHelper.GetPageDT();
                });
                ref.PageHelper.Render();
            }
        });
        ref.LoadUserList();
    }
}
var ZL_UserList = {
    _selects: [],//用户选择组件
    GetSelector: function (id, option) {
        var selects = this._selects;
        if (option) {//创建新的用户选择器
            for (var i = 0; i < selects.length; i++) {//重复检测
                if (id == selects[i].btnid) { return selects[i]; }
            }
            option.btnid = id;
            var usersel = new UserSelector(option);
            usersel.Init();
            selects.push(usersel);
            return usersel;
        } else {//获取用户选择器
            return selects.GetByID(id, "btnid");
        }
    },
    InitAngular: function () {
        var ref = this;
        var selects = ref._selects;
        var app = angular.module("app", []);
        for (var i = 0; i < selects.length; i++) {
            var selector = selects[i];
            if (selector.isshow) {
                selector.InitAngular(app);
            }
        }
        angular.bootstrap(document, ['app']);//手动加载angular
    }
}