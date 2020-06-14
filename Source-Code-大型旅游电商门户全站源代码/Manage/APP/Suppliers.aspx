<%@ page language="C#" autoeventwireup="true" inherits="manage_APP_Suppliers, App_Web_el4xf40j" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title><%=Resources.L.APP配置 %></title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#app" aria-controls="app" role="tab" data-toggle="tab"><%=Resources.L.社会化登录 %></a></li>
        <li role="presentation"><a href="#other" aria-controls="other" role="tab" data-toggle="tab"><%=Resources.L.其它配置 %></a></li>
    </ul>
    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="app">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td colspan="2"><%=Resources.L.默认回调地址 %>：
                <asp:Label ID="callback" ForeColor="Green" Text="text" runat="server" /></td>
                </tr>
                <tr>
                    <td class="td_l">
                        <input type="checkbox" id="CkSina"  runat="server" />
                        <label for="CkSina">
                            <img style="cursor: pointer;" src="/App_Themes/Admin/Sina_2.png" /></label></td>
                    <td>
                        <asp:Button ID="Button5" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>" OnClick="Button5_Click" />
                        <span id="Span1" style="display: none">
                            <span>App Key：</span>
                            <input id="ASina" type="text" class="form-control text_300"  runat="server" style="width: 240px" />
                            <span>App Secret：</span>
                            <input id="SSina" type="text" class="form-control text_300"  runat="server" style="width: 240px" />
                            <span><%=Resources.L.回调 %>：</span>
                            <input id="SSinaURL" type="text" class="form-control text_300"  runat="server" style="width: 350px;" />
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="CkQQ" runat="server" />
                        <label for="CkQQ">
                            <img style="cursor: pointer;" src="/App_Themes/Admin/QQ_2.png" /></label></td>
                    <td>
                        <asp:Button ID="Button6" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>" OnClick="Button6_Click" />
                        <span id="Span2" style="display: none">
                            <span>App Key：</span>
                            <input id="AQQ" type="text" class="form-control text_300"  runat="server" style="width: 240px" />
                            <span>App ID：</span>
                            <input id="AQQID" type="text" class="form-control text_300"  runat="server" style="margin-left: 20px; width: 240px" />
                            <span><%=Resources.L.回调 %>：</span>
                            <input id="AQQURL" type="text" class="form-control text_300"  runat="server" style="width: 350px;" />
                        </span></td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="CkBaidu" runat="server" />
                        <label for="CkBaidu">
                            <img style="cursor: pointer;" src="/App_Themes/Admin/Baidu_2.png" /></label></td>
                    <td>
                        <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>" OnClick="Button1_Click" />
                        <span id="CkBaidu_1" style="display: none"><span>App Key：</span>
                            <input id="ABaidu" type="text" class="form-control text_300" runat="server" style="width: 240px" />
                            <span>App Secret：</span>
                            <input id="SBaidu" type="text" class="form-control text_300" runat="server" style="width: 240px" />
                            <span><%=Resources.L.回调 %>：</span>
                            <input id="UBaidu" type="text" class="form-control text_300" runat="server" style="width: 350px;" />
                        </span></td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="CkKaixin"  runat="server" />
                        <label for="CkKaixin">
                            <img style="cursor: pointer;" src="/App_Themes/Admin/Kaixin_2.png" /></label>
                    </td>
                    <td>
                        <asp:Button ID="Button2" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>"
                            OnClick="Button2_Click" />
                        <div id="CkKaixin_1" style="display: none">
                            <span>App Key：</span>
                            <input id="AKaixin" type="text" class="form-control text_300"  runat="server" />
                            <span>App Secret：</span>
                            <input id="SKaixin" type="text" class="form-control text_300"  runat="server" />
                            <div class="margin_t5">
                                <span><%=Resources.L.回调 %>：</span>
                                <input id="SKaixiuUrl" type="text" class="form-control m715-50" runat="server" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            <input type="checkbox" id="WeChat_Chk" runat="server" />
                            <i class="fa fa-wechat" style="font-size:2em;color:green;"></i>
                            <span><%=Resources.L.微信登录 %></span>
                        </label>
                    </td>
                    <td>
                        <asp:Button ID="WeChat_Btn" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>" OnClick="WeChat_Btn_Click" />
                        <span style="display:none;">
                            <span>APPID：</span> <asp:TextBox runat="server" ID="WeChat_APPID_T" CssClass="form-control text_300"></asp:TextBox>
                            <span>Secret：</span> <asp:TextBox runat="server" ID="WeChat_Secret_T" CssClass="form-control text_300"></asp:TextBox>
                            <span><%=Resources.L.回调 %>：</span> <asp:TextBox runat="server" ID="WeChat_URL_T" CssClass="form-control text_300"></asp:TextBox>
                        </span>
                    </td>
                </tr>
                <tr style="display: none;">
                    <td>
                        <input type="checkbox" id="CkSohuChat" runat="server" checked="checked" />
                        <label for="CkChat">
                            <img style="cursor: pointer;" src="/App_Themes/Admin/Netease_2.png" /></label></td>
                    <td>
                        <asp:Button ID="sohuChatBtn" class="btn btn-primary" runat="server" Text="<%$Resources:L,配置 %>" OnClick="sohuChatBtn_Click" />
                        <span id="Span3" style="display: none">
                            <span>App_ID：</span><input id="chat_AppIDT" type="text" class="form-control text_300"  runat="server" style="width: 240px" />
                            <span>App_Key：</span><input id="chat_AppKeyT" type="text" class="form-control text_300"  runat="server" style="width: 240px" /></span></td>
                </tr>
            </table>
        </div>
        <div role="tabpanel" class="tab-pane" id="other">
            <table class="table table-striped table-bordered table-hover">
                <tr>
                    <td class="td_m" style="line-height: 30px;"><%=Resources.L.百度翻译 %></td>
                    <td>
                        <asp:Button ID="BaiduKey_Btn" Text="<%$Resources:L,配置 %>" runat="server" CssClass="btn btn-primary" OnClick="BaiduKey_Btn_Click" />
                        <span style="display: none;">
                            <span>AppID:</span>
                            <asp:TextBox ID="BaiduAppID_T" runat="server" CssClass="form-control text_300"></asp:TextBox>
                            <span>Key:</span>
                            <asp:TextBox ID="BaiduKey_T" runat="server" CssClass="form-control text_300"></asp:TextBox>
                            <a href="http://developer.baidu.com/console#app/project" target="_blank"><%=Resources.L.申请百度key %></a>
                        </span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
<div><asp:Button ID="KeyTj" runat="server" class="btn btn-primary" Text="<%$Resources:L,提交 %>" OnClick="KeyTj_Click" /></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript">
        $(function () {
            $(".Cksele").focus(function () {
                $(this).select();
            })
            $(".btn-primary").click(function () {
                if ($(this).val() == "<%=Resources.L.提交 %>") {
                    return true;
                }
                if ($(this).val() == "<%=Resources.L.确定 %>") {
                    $(this).next().hide();
                    $(this).val("<%=Resources.L.配置 %>");
                    return true;
                } else {
                    $(this).next().show();
                    $(this).val("<%=Resources.L.确定 %>");
                    return false;
                }
            })
        })
        var Num = 0;
        var nn = 0;
        function help_show(helpid) {
            Num++;
            var newDiv = document.createElement('div');
            var str = "<div id='help_content'></div><div id='help_hide'><a onclick='help_hide(Num)' style='width:20px;color:#666' title='<%=Resources.L.关闭 %>'></a></div> ";
            newDiv.innerHTML = str;
            newDiv.setAttribute("Id", "help_div" + Num);
            nn = Num - 1
            jQuery("#help").append(newDiv);
            if ($("#help_div" + nn))
            { $("#help_div" + nn).remove(); }
            jQuery("#help_content").load("/manage/help/" + helpid + ".html", function () { jQuery("#help").show(); });
        }
    </script>
</asp:Content>
