<%@ page language="C#" autoeventwireup="true" inherits="Manage_I_Content_CssManage, App_Web_m22flkqc" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/SFileUp.ascx" TagPrefix="ZL" TagName="SFileUp" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>风格管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <table width="100%" class="table table-bordered">
        <tr>
            <td align="left">当前目录：<asp:Label ID="lblDir" runat="server" Text="Label"></asp:Label>
            </td>
            <td align="right">
                <asp:Literal ID="LitParentDirLink" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
    <div class="panel panel-default" style="padding:0px;">
        <div>
            <table class="table table-striped table-bordered table-hover" style="border-top:none;">
                <tr class="gridtitle" align="center">
                    <td width="45%">名称</td>
                    <td width="10%">大小</td>
                    <td width="10%">类型</td>
                    <td>修改时间</td>
                    <td>操作</td>
                </tr>
                <asp:Repeater ID="repFile" runat="server" OnItemCommand="repFileReName_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td align="left">
                                <i class=' <%# System.Convert.ToInt32(Eval("type")) == 1 ? "fa fa-folder" :"fa  fa-file" %>' />
                                <%# System.Convert.ToInt32(Eval("type")) != 1&&(Eval("content_type").ToString()=="jpg"||Eval("content_type").ToString()=="gif"||Eval("content_type").ToString()=="jpge"||Eval("content_type").ToString()=="png")?"<span onmouseover=\"ShowADPreview('" + GetFileContent(Eval("Name").ToString(), Eval("content_type").ToString()) + "')\" onmouseout=\"hideTooltip('dHTMLADPreview')\">":"<span>"%>
                                <a href="<%#isvideo(Eval("content_type").ToString())?""+TemplateDir+"/"+Eval("Name")+"\" rel=\"vidbox":(isimg(Eval("content_type").ToString())?"javascript:void(0);": (System.Convert.ToInt32(Eval("type")) == 1 ?  "CssManage.aspx?Dir=" + Server.UrlEncode(Request.QueryString["Dir"] +"/"+ Eval("Name").ToString()):"CssEdit.aspx?filepath="+ Server.UrlEncode(Request.QueryString["Dir"] +"/"+ Eval("Name").ToString()))) %>">
                                    <%# Eval("Name") %></a></span>
                            </td>
                            <td align="center">
                                <%# GetSize(Eval("size").ToString()) %>
                            </td>
                            <td align="center">
                                <asp:HiddenField ID="HdnFileType" Value='<%#Eval("type") %>' runat="server" />
                                <%# System.Convert.ToInt32(Eval("type")) == 1 ? "文件夹" : Eval("content_type").ToString() + "文件" %>
                            </td>
                            <td align="center">
                                <%#Eval("lastWriteTime")%>
                            </td>
                            <td align="center">&nbsp;
                                <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("Name").ToString()%>'
                                    CommandName='<%# System.Convert.ToInt32(Eval("type")) == 1 ? "":"DownFiles" %>'
                                    Enabled='<%# System.Convert.ToInt32(Eval("type")) == 1 ? false:true %>' Visible='<%# System.Convert.ToInt32(Eval("type")) == 1 ? false : true %>' CssClass="option_style"><i class="fa fa-download" title="下载"></i>下载</asp:LinkButton>
                        
                                <asp:LinkButton ID="LinkButton2" runat="server" CommandName='<%# System.Convert.ToInt32(Eval("type")) == 1 ? "CopyDir":"CopyFiles" %>'
                                    CommandArgument='<%# Eval("Name").ToString()%>' CssClass="option_style"><i class="fa fa-copy" title="复制"></i>复制</asp:LinkButton>
                                
                                <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Name").ToString()%>'
                                    CommandName='<%# System.Convert.ToInt32(Eval("type")) == 1 ? "DelDir":"DelFiles" %>'
                                    OnClientClick="return confirm('你确认要删除该文件夹或文件吗？')" CssClass="option_style"><i class="fa fa-trash-o" title="删除"></i>删除</asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
        <div class="panel panel-footer" style="padding:5px; margin:0px;">
            <div>
                <asp:Button ID="btnCSSBackup" class="btn btn-primary" runat="server" Style="width: 110px;" Text="备份当前风格" OnClientClick="return confirm('是否创建备份？(提示：备份同名文件会覆盖！）');" OnClick="btnCSSBackup_Click" />
            目录名称：
                <asp:TextBox ID="txtForderName" class="form-control text_300" runat="server" Width="350px"></asp:TextBox>
                <asp:Button ID="btnCreateFolder" class="btn btn-primary" runat="server" Text="创建目录" OnClick="btnCreateFolder_Click" />
                 <ZL:SFileUp ID="SFile_Up" runat="server" IsRelName="true" FType="All" />
                <asp:Button ID="btnTemplateUpLoad" class="btn btn-primary" runat="server" Text="上传风格" OnClientClick="return confirm('即将覆盖同名风格，是否继续？');" OnClick="btnTemplateUpLoad_Click" />
            </div>
        </div>
    </div>
    <div id="dHTMLADPreview" style="z-index: 1000; left: 0px; visibility: hidden; width: 10px; position: absolute; top: 0px; height: 10px"></div>
    <div class="clearbox"></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script type="text/javascript" src="/JS/Popup.js"></script>
</asp:Content>