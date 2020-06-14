define(function (require, exports, module) {
    var _self = function () { }, _base = require("base"), $ = require('jquery');
    _base.utils.inherits(_self, _base.Control);
  
    _self.prototype.Init_Pre = function (model, extend) {
        //this.menu_wrap = '<nav class="navbar navbar-default"><div class="container-fluid">'
        // + '<div class="navbar-header"><a class="navbar-brand" href="javascript;:"><i class="glyphicon glyphicon-th"></i></a></div>'
        // + '<ul class="nav navbar-nav" ng-model="list.@id.dataMod">{html}</ul></div></nav>';
        //this.menu_item = '<li ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="{{item.css}}"><a href="{{item.href}}">{{item.name}}</a></li>';
        //this.htmlTlp = this.menu_wrap.replace("{html}", this.menu_item)
        var menu_wrap = "", menu_item = "";
        switch (model.config.compid) {
            case "h1":
                menu_wrap = '<nav class="navbar navbar-default"><div class="container-fluid">'
                       + '<div class="navbar-header"><a class="navbar-brand" href="javascript;:"><i class="glyphicon glyphicon-th"></i></a></div>'
                       + '<ul class="nav navbar-nav" ng-model="list.@id.dataMod">{html}</ul></div></nav>';
                menu_item = '<li ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="{{item.css}}"><a href="{{item.href}}">{{item.name}}</a></li>';
                break;
            case "h2":
                menu_wrap = '<ul class="nav nav-pills" ng-model="list.@id.dataMod">{html}</ul>';
                menu_item = '<li ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="{{item.css}}"><a href="{{item.href}}">{{item.name}}</a></li>';
                break;
            case "h3":
                menu_wrap = '<div class="btn-group" role="group" aria-label="..." ng-model="list.@id.dataMod">{html}</div>';
                menu_item = '<a href="{{item.href}}" ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="btn btn-primary {{item.css}}" >{{item.name}}</a>';
                break;
            case "v1":
                menu_wrap = '<div class="list-group" ng-model="list.@id.dataMod">{html}</div>';
                menu_item = '<a href="{{item.href}}" ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="list-group-item list-group-item-success {{item.css}}">{{item.name}}</a>';
                break;
            case "v2":
                menu_wrap = '<div class="list-group" ng-model="list.@id.dataMod">{html}</div>';
                menu_item = '<a href="{{item.href}}" ng-repeat="item in list.@id.dataMod.items|orderBy:\'orderid\'" class="list-group-item list-group-item-info {{item.css}}">{{item.name}}</a>';
                break;
        }
        this.htmlTlp = menu_wrap.replace("{html}", menu_item);
    }
    module.exports = function () { return _self; }
});