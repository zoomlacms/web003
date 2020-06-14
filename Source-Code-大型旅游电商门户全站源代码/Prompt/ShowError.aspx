<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.Admin.Prompt.ShowError, App_Web_lywot1rw" enableviewstatemac="false" validaterequest="false" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style type="text/css">ul li{list-style-type:none;}</style> 
    <title>错误提示</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="container" style="margin-top: 10%">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 col-lg-offset-3 col-md-offset-3">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span class="glyphicon glyphicon-remove-circle pull-left"></span>系统提示-来自可能错误的请求，可能的原因是：</h3>
                    </div>
                    <div class="panel-body text-center">
                        <ul class="text-center list-unstyled">
                            <asp:Literal ID="LtrSuccessMessage" runat="server"></asp:Literal>
                        </ul>
                    </div>
                    <div class="panel-footer" style="text-align: center;">
                        <a href="/" title="返回网站首页" style="margin-right: 10px;" class="btn btn-primary"><span class="glyphicon glyphicon-home"></span>网站首页</a>
                        <asp:HyperLink ID="LnkReturnUrl" runat="server" class="btn btn-primary" ToolTip="返回上一页"><span class="glyphicon glyphicon-repeat"></span>返回上一页</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>