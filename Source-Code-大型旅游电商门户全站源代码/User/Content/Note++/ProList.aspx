<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Plat/Main.master" inherits="User_Content_Note_ProjectPre, App_Web_yddzbnlz" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
<title>项目列表</title>
<link rel="stylesheet" type="text/css" href="/user/content/note/note.css" />
</asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="server">
    <div class="container-fluid">
        <ol class="breadcrumb">
        <li><a href="/">首页</a></li>
        <li><a href="/Plat/Blog/">能力中心</a></li>
        <li class="active">项目列表 [<a href="<%=GetNoteUrl() %>" target="_blank">添加项目</a>]</li>
        <li class="clearfix hidden"></li>
        </ol>
    </div>
    <div class="container-fluid margin-top note_pro_list">
        <ul class="list-unstyled prolist_ul">
        <ZL:ExRepeater ID="ProList_RPT" runat="server" OnItemCommand="ProList_RPT_ItemCommand" PageSize="12" PagePre="<div class='clearfix'></div><div class='text-center margin_t5'>" PageEnd="</div>">
            <ItemTemplate>
                <li class="pre_li col-md-2 col-sm-12 col-lg-2 col-xs-12">
                    <div class="pro_item" title="查看项目" data-id="<%#Eval("ID") %>">
                        <img src="<%#Eval("topimg") %>" onerror="this.src='/images/nopic.gif'" />
                        <div class="pro_tips">名称：<%#Eval("Title") %></div>
                        <div class="pro_tips">时间：<%#Eval("CDate","{0:yyyy年MM月dd日 HH:mm}") %></div>
                        <div class="pro_tips">用户：<%#Eval("CUName") %></div>
                      <%--  <div class="text-center pro_tips"><span>类型:<%# GetProType() %></span> <span>状态:<%#GetStatus() %></span> <span>等级:<%#GetLevel() %></span></div>--%>
                    </div>
                    <div class="pro_tools">
                        <a href="<%#GetViewUrl() %>" target="_blank"><i class="fa fa-eye"></i> 查看</a>
                        <a href="<%#GetNoteUrl(Convert.ToInt32(Eval("ID"))) %>" target="_blank" title="编辑项目"><i class="fa fa-magic"></i> 编辑</a>
                        <asp:LinkButton ID="Del_Link" CommandName="Del" OnClientClick="return confirm('是否确定删除!')" CommandArgument='<%#Eval("ID") %>' runat="server" ToolTip="删除"><i class="fa fa-trash"></i> 删除</asp:LinkButton>
                    </div>
                    <%--<div class="pro_detail">
                        <ul class="list-unstyled">
                            <li>网站:<%#Eval("WebSite") %></li>
                            <li>联系:<%#Eval("Contact") %></li>
                        </ul>
                    </div>--%>
                </li>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
        </ul>
    </div>
    <div class="alert alert-info" id="empty_div" runat="server" visible="false">
       无项目数据
    </div>
</asp:Content>
<asp:Content ContentPlaceHolderID="ScriptContent" runat="server">
    <script>
        $(function () {
            var listflag = 0;
            $(".note_pro_list .pro_item").click(function () {
                //window.open("view.aspx?id=" + $(this).data('id'), "_blank");
            });
            $(".note_pro_list .pre_li").hover(function () {
                var obj = this;
                $(obj).find(".pro_tools").css('top', '0');
                $(obj).popover({ content: $(obj).find('.pro_detail').html(), placement: "bottom", html: true });
                $(obj).popover('show');
            }, function () {
                $(this).popover('hide');
                $(this).find(".pro_tools").css('top', '-30px');
                clearTimeout(listflag);
            });
        });
    </script>
</asp:Content>

