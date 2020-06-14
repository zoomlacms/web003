define(function (require, exports, module) {
    var _self = function () { }, _base = require("base"), $ = require('jquery');
    _base.utils.inherits(_self, _base.Control);
   
    _self.prototype.Init_Pre = function (model, extend) {
        this.htmlTlp = '<div style="margin:20px;">';
        this.htmlTlp += model.dataMod.html;
        this.htmlTlp += '</div>';
    }
    module.exports = function () { return _self; }
});