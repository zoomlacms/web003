<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.Manage.User.GroupManage, App_Web_cvu4dt3w" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>会员组管理</title>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="foo" style="position:fixed;top:50%;left:30%;display:block;"></div>
<table class="table table-striped table-bordered table-hover">
    <tr>
		<td style="width:3%;text-align:center;"><strong>ID</strong></td>
		<td style="width:30%;text-align:center;"><strong><%=Resources.L.会员组名 %> </strong></td>
        <td style="width:10%;text-align:center;"><strong><%=Resources.L.会员组说明 %></strong></td>
		<td style="width:6%;text-align:center;"><strong><%=Resources.L.注册可选 %></strong></td>
        <td style="width:3%;text-align:center;"><strong><%=Resources.L.默认 %></strong></td>
        <td style="width:6%;text-align:center;"><strong><%=Resources.L.会员数 %></strong></td>
		<td style="width:45%;text-align:center;"><strong><%=Resources.L.操作 %></strong></td>
	</tr>
    <tbody id="EGV"></tbody>
</table>
</asp:Content>

<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript" src="/Plugins/JqueryUI/spin/spin.js"></script>
    <script src="/JS/Controls/ZL_Array.js"></script>
    <script src="/JS/ZL_Regex.js"></script>
    <script type="text/javascript">
        var table = $("#EGV");
        //子父级之间依靠 data-pid来确认,如何比较好的定位层级
        var trTlp = '<tr data-id="@GroupID" data-pid="@ParentGroupID" data-layer="@layer" title="<%=Resources.L.双击打开 %>" class="datarow"><td>@GroupID</td><td><fun>getLayer("@layer","@Child")</fun>@GroupName</td>'
                    + '<td>@Description</td><td><fun>GetReg("@RegSelect")</fun></td><td><fun>GetDefault("@IsDefault")</fun></td>'
                    + '<td><a href="UserManage.aspx?GroupId=@GroupID" title="<%=Resources.L.会员列表 %>">@UserNum</a></td><td><fun>GetOper("@GroupID","@UserModel")</fun></td>'
                    + '</tr>';
        //获取数据
        var getlist = function (obj, pid, isappend) {//需要添加的行
            $(obj).unbind("dblclick");
            $.post("GroupManage.aspx", { "pid": pid }, function (data) {
                setLayer(data, $(obj).data("layer"));
                var items = JsonHelper.FillItem(trTlp, data, function ($item, mod) {
                    $item.bind("dblclick", function () { getlist(this, mod.GroupID); })
                });
                if (isappend) { $(obj).append(items); }
                else { $(obj).after(items); $(obj).bind("dblclick", function () { ToggleChild(obj) }) }
                
            }, "JSON");
        }
        //为数据获取加上层级
        var setLayer = function (data, layer) {
            var newLayer = Convert.ToInt(layer, 0) + 1;
            for (var i = 0; i < data.length; i++) {
                data[i].layer = newLayer;
            }
        }
        //根据层级,显示对应的空格和图形
        var getLayer = function (layer, child) {
            var layerTlp = '<img src="/Images/TreeLineImages/tree_line4.gif" />';
            var lineTlp = '<img src="/Images/TreeLineImages/t.gif" />';
            layer = Convert.ToInt(layer, 0);
            child = Convert.ToInt(child, 0);
            lineTlp += child > 0 ? '<img src="/Images/TreeLineImages/groups.gif" border="0">' : '<img src="/Images/TreeLineImages/group.gif" border="0">';
            var html = "";
            for (var i = 1; i < layer; i++) {
                html += layerTlp;
            }
            return (html + lineTlp);
        }
        //显示或隐藏子级
        function ToggleChild(obj) {
            var id = $(obj).data("id");
            var $tr = table.find("tr[data-pid=" + id + "]");
            if ($tr.is(":hidden")) { $tr.show(); }
            else { HideByPid(id); }
        }
        function HideByPid(pid) {
            $trs = table.find("tr[data-pid=" + pid + "]");
            if (!$trs || $trs.length < 1) return;//不存在,或下再无子级时跳出递归
            for (var i = 0; i < $trs.length; i++) {
                HideByPid($($trs[i]).data("id"));
            }
            table.find("tr[data-pid=" + pid + "]").hide();
        }

        function GetReg(isselect) {
            if (isselect == "true")
            {
                return "<font color='green'>√</font>";
            }
            else
            {
                return "<font color='red'>×</font>";
            }
        }
        function GetDefault(def) {
            if (def == "true") { return "<font color='green'>√</font>"; }
            else { return "<font color='red'>×</font>"; }
        }
        function GetOper(groupid, usermodel) {
            var str = "";
            if (usermodel > 0) {
                str = "<a href='<%=customPath2 %>/Content/ModelField.aspx?ModelType=3&ModelID=" + usermodel + "'><%=Resources.L.个性字段 %></a> ";
            }
            return "<a href='Group.aspx?id=" + groupid + "' class='option_style'><i class='fa fa-pencil' title='<%=Resources.L.修改 %>'></i></a> <a href='GroupManage.aspx?action=del&id=" + groupid + "' class='fa fa-trash-o' title='<%=Resources.L.删除 %>'></a> <a href='GroupManage.aspx?action=default&id=" + groupid + "' class='option_style'><i class='fa fa-flag' title='<%=Resources.L.默认 %>'></i><%=Resources.L.默认 %></a> <a href='GroupPermissions.aspx?GroupId=" + groupid + "' class='option_style'><i class='fa fa-key' title='<%=Resources.L.权限 %>'></i><%=Resources.L.权限 %></a> <a href='GroupConfig.aspx?GroupId=" + groupid + "' class='option_style'><i class='fa fa-th-large' title='<%=Resources.L.模型 %>'></i><%=Resources.L.模型 %></a> " + str + "<a href='Group.aspx?ParentID=" + groupid + "' class='option_style'><i class='fa fa-plus' title='<%=Resources.L.添加 %>'></i><%=Resources.L.子会员组 %></a>"
        }
        $(function () {
            getlist(table, "0", true);
        })
    </script>
</asp:Content>

