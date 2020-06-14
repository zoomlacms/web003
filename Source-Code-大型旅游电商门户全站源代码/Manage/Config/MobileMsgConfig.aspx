<%@ page language="C#" autoeventwireup="true" inherits="Manage_I_Config_MobileMsgConfig, App_Web_aqfobaxz" masterpagefile="~/Manage/I/Default.master" enableviewstatemac="false" validaterequest="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>短信通配置</title>
<link type="text/css" href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
<script type="text/javascript" src="/dist/js/bootstrap-switch.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table width="100%" cellspacing="1" cellpadding="0" class="table table-striped table-bordered table-hover">
    <tr>
      <td style="width: 200px; "><strong><%:lang.LF("选择默认短信接口") %>：</strong></td>
      <td>
          <asp:DropDownList ID="ddlMessageCheck" runat="server" CssClass="form-control pull-left" Width="200" onselectedindexchanged="ddlMessageCheck_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
        <span style="line-height:32px; margin-left:5px; color:#f00;">*必选</span></td>
    </tr>
    <tr>
        <td><strong>每日手机号发送次数：</strong></td>
        <td>
            <asp:TextBox ID="MaxPhoneMsg" runat="server" Text="10" CssClass="form-control text_s num"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td><strong>每日ip发送次数：</strong></td>
        <td>
            <asp:TextBox ID="MaxIpMsg" runat="server" Text="50" CssClass="form-control text_s num"></asp:TextBox>
        </td>
    </tr>
  </table>
  <asp:Panel ID="ShenZhen_P" runat="server"  Visible="false">
    <table class="table table-striped table-bordered table-hover">
      <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("短信通用户") %>：</strong></td>
        <td><asp:TextBox ID="TxtMssUser" runat="server" Width="200" class="form-control pull-left"></asp:TextBox>
          <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
      </tr>
      <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("短信通密码") %>：</strong></td>
        <td><asp:TextBox ID="TxtMssPsw" runat="server" TextMode="Password" Width="200" class="form-control pull-left"></asp:TextBox>
          <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
      </tr>
      <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("黑名单") %>：</strong></td>
        <td><asp:TextBox ID="blackList" runat="server" Width="200" class=" form-control pull-left"></asp:TextBox>
          <span style="line-height:32px; margin-left:5px;">用户ID用“,”隔开</span></td>
      </tr>
         <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("会员变更手机号权限") %>：</strong></td>
        <td><asp:RadioButtonList runat="server" ID="userMobilAuth" RepeatDirection="Horizontal">
            <asp:ListItem Value="0">短信验证</asp:ListItem>
            <asp:ListItem Value="1" Selected="True">自由修改</asp:ListItem>
            </asp:RadioButtonList></td>
      </tr>
      <tr >
        <td><%:lang.LF("操作") %>：</td>
        <td ><asp:Button ID="Button2" class="btn btn-primary" runat="server" Text="保存设置" OnClick="Button2_Click" /></td>
      </tr>
      <tr >
        <td  colspan="2">
            <strong><a href="http://www.zoomla.cn/server" target="view_window">没有帐号?点此联系官方授权短信通>></a></strong>
        </td>
      </tr>
    </table>
    </asp:Panel>
    <asp:Panel ID="East_P" runat="server">
    <table class="table table-striped table-bordered table-hover">
        <tr >
        <td class="td_s"><strong><%:lang.LF("东时方企业号") %>：</strong></td>
        <td><asp:TextBox ID="txtg_eid" runat="server" Width="200" class="form-control pull-left"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
        </tr>
        <tr >
        <td ><strong><%:lang.LF("东时方用户") %>：</strong></td>
        <td><asp:TextBox ID="txtg_uid" runat="server" Width="200" class="form-control pull-left"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
        </tr>
        <tr >
        <td><strong><%:lang.LF("东时方密码") %>：</strong></td>
        <td><asp:TextBox ID="txtg_pwd" runat="server" Width="200" TextMode="Password" class="form-control pull-left"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
        </tr>
        <tr >
        <td><strong><%:lang.LF("东时方通道") %>：</strong></td>
        <td><asp:TextBox ID="txt_h_gate_id" runat="server" Width="200" class="form-control pull-left"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td>
        </tr>
        <tr>
        <td><strong><%:lang.LF("短信内容") %>：</strong></td>
        <td><asp:TextBox ID="txtContent" runat="server" class="form-control pull-left" Height="72px" TextMode="MultiLine" Width="475px"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 必填<br />
            {m:username}:当前用户名 {m:mobile}:手机号 {m:proname}:商品名称 {m:orderno}:订单号 {m:sitename}:网站名 </span></td>
        </tr>
        <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("短信类型") %>：</strong></td>
        <td><asp:TextBox ID="txtType" runat="server" Width="200" class="form-control pull-left"></asp:TextBox>
            <span style="line-height:32px; margin-left:5px; color:#f00;">* 选填[例如：景点，路线]</span></td>
        </tr>
        <tr >
        <td  style="width: 200px; "><%:lang.LF("操作") %>：</td>
        <td >
            <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="保存设置" OnClick="Button1_Click" />
        </td>
        </tr>
        <tr >
        <td  colspan="2"><strong><a href="http://www.xhsms.com/" target="view_window">东时方短信接口申请>></a></strong></td>
        </tr>
    </table>
    </asp:Panel>
    <div runat="server" id="YiMei_P" visible="false">
        <table style="width:100%;" cellspacing="1" cellpadding="0" class="table table-striped table-bordered table-hover">
            <tr >
                <td  style="width: 200px;"><strong><%:lang.LF("序列号") %>：</strong></td>
                <td><asp:TextBox ID="smskeyT" runat="server" Width="200" class="form-control pull-left" /><span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td></tr>
            <tr ><td  style="width: 200px;"><strong>密码：</strong></td>
                <td><asp:TextBox ID="smspwdT" runat="server" Width="200" class="form-control pull-left" TextMode="Password" /><span style="line-height:32px; margin-left:5px; color:#f00;">* 必填</span></td></tr>
            <tr >
        <td  style="width: 200px; "><strong><%:lang.LF("操作") %>会员变更手机号权限：</strong></td>
        <td><asp:RadioButtonList runat="server" ID="smsRadio3" RepeatDirection="Horizontal">
            <asp:ListItem Value="0">短信验证</asp:ListItem>
            <asp:ListItem Value="1" Selected="True">自由修改</asp:ListItem></asp:RadioButtonList></td></tr>
                <tr ><td  style="width: 200px;"><strong><%:lang.LF("操作") %>：</strong></td>
                <td><asp:Button runat="server" ID="saveBtn3" OnClick="saveBtn3_Click" Text="保存" class="btn btn-primary"/></td></tr>
        </table>
    </div>
    <div id="CCPRest_Div" runat="server" visible="false">
        <table class="table table-striped table-bordered table-hover">
            <tr>
                <td style="width: 200px; ">应用ID:</td>
                <td>
                    <asp:TextBox ID="CCAppID_T" Text="8a48b55152a56fc20152aa33f3d60673" runat="server" CssClass="form-control text_300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>ACCOUNT_SID:</td>
                <td>
                    <asp:TextBox ID="CCAccount_T" Text="aaf98f8952a572be0152aa32e1b606e4" runat="server" CssClass="form-control text_300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>AUTH_TOKEN:</td>
                <td>
                    <asp:TextBox ID="CCToken_T" Text="595fc398965a433a9a57290fa7179fc4" runat="server" CssClass="form-control text_300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>短信模板ID:</td>
                <td>
                    <asp:TextBox ID="CCTemplate_T" runat="server" CssClass="form-control text_300"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="text-center">
                    <asp:Button ID="CCP_Btn" runat="server" CssClass="btn btn-primary" OnClick="CCP_Btn_Click" Text="保存"></asp:Button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript" src="/JS/ZL_Regex.js"></script>
    <script>
        $(function () {
            ZL_Regex.B_Num('.num');
        });
    </script>
</asp:Content>