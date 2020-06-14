<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Manage/I/Default.master" enableviewstatemac="false" inherits="ZoomLa.WebSite.Manage.Template.SelectTemplate, App_Web_m22flkqc" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>选择模板</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div>
<div class="bg-success padding5" style="min-height:3em; line-height:3em;">
<span>当前目录:</span><asp:Label ID="lblDir" runat="server"></asp:Label>  
<span><asp:Literal ID="LitParentDirLink" runat="server"></asp:Literal></span>
</div>
<div style="width: 100%; height: 200px;">
        <asp:Repeater ID="RepFiles" runat="server" OnItemDataBound="RepFiles_ItemDataBound">
            <ItemTemplate>
                <%#  System.Convert.ToInt32(Eval("type")) == 1 ? "<i class='fa fa-folder' style='color:#4586BD;'></i>" : "<i class='fa fa-file-text' style='color:#4586BD;'></i>"%>
                <a href="javascript:;" onclick="<%#  System.Convert.ToInt32(Eval("type")) == 1 ?"openfilesdir('" + Eval("Name") + "')":"add('" + Eval("Name") + "')"%>"> <%# Eval("Name")%></a>
                <br />
            </ItemTemplate>
        </asp:Repeater>
        <asp:HiddenField ID="HdnFileText" runat="server" />
    </div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script type="text/javascript">
function add(obj)
{
    if(obj==""){return false;}
    var s = document.getElementById('HdnFileText').value + "\/" + obj;
    parent.document.getElementById('FileName').value = s.substring(1);
}
function openfilesdir(obj)
{
  if(obj==""){return false;}
    var pathtext="<%=Server.UrlEncode(Request.QueryString["FilesDir"]) %>";
    parent.document.getElementById('ParentDirText').value = pathtext;
    var path = "SelectTemplate.aspx?FilesDir=" + pathtext + "/" + obj;
    parent.document.getElementById('main_right').src=path;
}
</script>
</asp:Content>
