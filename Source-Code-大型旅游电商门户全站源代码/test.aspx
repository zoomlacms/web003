<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test_test" MasterPageFile="~/Common/Master/Empty.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>附近景点</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table class="table table-bordered table-striped">
        <tr><td><input type="checkbox" id="chkAll" onclick="selectAllByName(this,'idchk')" /></td><td>ID</td><td>景点名称</td><td>价格</td><td>距离</td></tr>
        <asp:Repeater runat="server" ID="RPT" EnableViewState="false">
            <ItemTemplate>
                <tr>
                    <td><input type="checkbox" name="idchk" value="<%#Eval("GeneralID") %>" /></td>
                    <td><%#Eval("GeneralID") %></td>
                    <td><a href="/Item/<%#Eval("GeneralID") %>.aspx" target="_blank" title="点击浏览"><%#Eval("Title") %></a></td>
                    <td><%#Eval("price") %></td>
                    <td><%#Eval("distance","{0:f0}")+"米" %></td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script src="/JS/SelectCheckBox.js"></script>
</asp:Content>