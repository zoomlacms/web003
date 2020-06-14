<%@ page language="C#" autoeventwireup="true" inherits="Manage_I_Content_ShowContent, App_Web_fzreldec" masterpagefile="~/Manage/I/Default.master" clientidmode="Static" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
<title>预览内容</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <asp:HiddenField ID="ModelID_Hid" runat="server" />
    <div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="#base" data-toggle="tab">基本信息</a></li>
            <li><a href="#info" data-toggle="tab">信息属性</a></li>
            <li><a href="#process" data-toggle="tab">流程控制</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade in active" id="base">
                <table class="table table-bordered">
                    <tr>
                        <td style="width:10%;" class="fd_td_l">所属节点</td>
                        <td>
                            <asp:Label runat="server" ID="NodeName_L"></asp:Label>
						</td>
                    </tr>
                    <tr>
                        <td class="fd_td_l">ID</td>
						<td>
							<asp:Label ID="Gid_L" runat="server"></asp:Label>
						</td>
                    </tr>
                    <tr>
						<td class="fd_td_l"><asp:Label runat="server" ID="C_Title_L"></asp:Label></td>
						<td>
							<asp:Label ID="Title_L" runat="server"></asp:Label>
						</td>
					</tr>
                    <asp:Label ID="Base_L" runat="server"></asp:Label>
                </table>
            </div>
            <div class="tab-pane fade" id="info">
                <table class="table table-bordered">
                    <tr>
						<td style="width:10%;">录入者</td>
						<td >
							<asp:Label ID="Inputer_L" runat="server"></asp:Label>
						</td>
					</tr>
					<tr>
						<td >点击数</td>
						<td >
							<asp:Label ID="Hits_L" runat="server"></asp:Label>
						</td>
					</tr>
					<tr>
						<td >录入时间</td>
						<td >
							<asp:Label ID="CreateTime_L" runat="server"></asp:Label>
						</td>
					</tr>
                    <tr>
						<td >更新时间</td>
						<td >
							<asp:Label ID="UpdateTime_L" runat="server"></asp:Label>
						</td>
					</tr>
                </table>
            </div>
            <div class="tab-pane fade" id="process">
                <table class="table table-bordered">
                    <tr>
						<td style="width:10%;">审核状态<br />
						</td>
						<td class="tdrighttxt">
							<asp:Label ID="ConStatus_L" runat="server"></asp:Label>
						</td>
					</tr>
					<tr>
						<td>推荐</td>
						<td>
							<asp:Label ID="Elite_L" runat="server"></asp:Label>
						</td>
					</tr>
                </table>
            </div>
        </div>
        <div class="text-center">
            <asp:Button ID="Button5" CssClass="btn btn-primary" runat="server" Text="修改/审核" OnClick="Button5_Click" />
				&nbsp;<asp:Button ID="Del_Btn" CssClass="btn btn-primary" runat="server" Text="删除" OnClientClick="return confirm('你确定将该数据删除到回收站吗？')"
					OnClick="delete_Click" />
				&nbsp;<asp:Button ID="Reject_Btn" CssClass="btn btn-primary" runat="server" Text="直接退稿" OnClick="Reject_Btn_Click" />
				&nbsp;<asp:Button ID="UnAudit_Btn" CssClass="btn btn-primary" runat="server" Text="取消审核" OnClick="UnAudit_Btn_Click" />
				&nbsp;<asp:Button ID="Elite_Btn" CssClass="btn btn-primary" runat="server" Text="设为推荐" OnClick="Elite_Btn_Click" />
                &nbsp;<asp:Button ID="Button6" CssClass="btn btn-primary" runat="server" Text="取消推荐" OnClick="Button6_Click" />
                <a href="/Item/<%:Request.QueryString["GID"] %>.aspx" target="_blank" class="btn btn-primary">浏览文章</a>
        </div>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
        <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        $().ready(function () {
            if (getParam("type")) {
                $("li a[href='#tab" + getParam("type") + "']").parent().addClass("active").siblings("li").removeClass("active");;
            }
        })
        function ShowTabs(n) {
            location.href = 'ShowContent.aspx?GID=<%=Request.QueryString["GID"] %>&type=' + n + '&modeid=<%=Request.QueryString["modeid"] %>';
        }
        var diag = new ZL_Dialog();
        function opentitle(url, title) {
            diag.title = title;
            diag.url = url;
            diag.ShowModal();
        }
        function editnode(NodeID) {
            var answer = confirm("该栏目未绑定模板，是否立即绑定");
            if (answer == false) {
                return false;
            }
            else {
                open_page(NodeID, "EditNode.aspx?NodeID=");
            }
        }
        function closdlg() {
            Dialog.close();
        }
        function open_page(NodeID, strURL) {
            var diag = new Dialog();
            diag.Width = 1000;
            diag.Height = 750;
            diag.Title = "配置节点<span style='font-weight:normal'>[ESC键退出当前操作]</span>";
            diag.URL = strURL + NodeID;
            diag.show();
        }
        $().ready(function () {
            if ($("#Egv tr").length > 1) { $("#commentDiv").show(); }
        });
    </script>
</asp:Content>