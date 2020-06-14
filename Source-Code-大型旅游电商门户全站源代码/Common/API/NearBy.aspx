<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NearBy.aspx.cs" Inherits="Common_API_NearBy" MasterPageFile="~/Common/Master/Empty.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>附近景点</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div style="height:420px;overflow-y:auto;">
        <table class="table table-bordered table-striped">
        <tr><td><input type="checkbox" id="chkAll" onclick="selectAllByName(this, 'idchk')" /></td><td>ID</td><td>景点名称</td><td>价格</td><td>距离</td></tr>
        <asp:Repeater runat="server" ID="RPT" EnableViewState="false">
            <ItemTemplate>
                <tr>
                    <td><input type="checkbox" name="idchk" <%#IsChecked() %> value="<%#Eval("GeneralID") %>" data-gid="<%#Eval("GeneralID") %>" data-title="<%#Eval("Title") %>" /></td>
                    <td><%#Eval("GeneralID") %></td>
                    <td><a href="/Item/<%#Eval("GeneralID") %>.aspx" target="_blank" title="点击浏览"><%#Eval("Title") %></a></td>
                    <td><%#Eval("price") %></td>
                    <td><%#Eval("distance","{0:f0}")+"米" %></td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    </div>
<div class="bottom">
    你已选经选择了<span style="color: #ff0000; font-size: 14px; font-weight: bold;" id="num_sp">0</span>个景点
    <input type="button" value="确定" id="sure_btn" class="btn btn-info" onclick="sure();" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <style type="text/css">
        .bottom {position:relative;width:100%;bottom:0px;background-color:#fff;border:1px solid #ccc;box-shadow:0 4px 20px 1px rgba(0,0,0,0.2);
                 padding:10px;padding-left:20px;
        }
    </style>
    <script src="/JS/SelectCheckBox.js"></script>
    <script>
        $(function () {
            $("input[type=checkbox]").click(function () {
                var count = $("input[name=idchk]:checked").length;
                $("#num_sp").text(count);
            });
        })
        //保存IDS,返回IDS与名称
        function sure() {
            var list = [];
            $("input[name=idchk]:checked").each(function () {
                var model = { gid: $(this).data("gid"), title: $(this).data("title") };
                list.push(model);
            });
            parent.nearby.add(list);
            parent.CloseComDiag();
        }
    </script>
</asp:Content>