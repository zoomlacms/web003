<%@ page language="C#" masterpagefile="~/Manage/I/Default.master" autoeventwireup="true" inherits="Manage_I_Guest_InfoList, App_Web_plnqpc1u" validaterequest="false" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" Runat="Server">
    <title>词条列表</title>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.js"></script>
</asp:Content>
<asp:Content  ContentPlaceHolderID="Content" Runat="Server">
    <ul class="nav nav-tabs">
        <li class="active"><a href="#tab-10" onclick="ShowTabss(-10)" data-toggle="tab">所有词条</a></li>
        <li><a href="#tab0" data-toggle="tab" onclick="ShowTabss(0)"><%=lang.LF("待审核")%></a></li>
        <li><a href="#tab1" data-toggle="tab" onclick="ShowTabss(1)"><%=lang.LF("已审核")%></a></li>
        <li><a href="#tab-1" data-toggle="tab" onclick="ShowTabss(-1)">不予通过</a></li>
    </ul>
    <div class="panel panel-default" style="padding: 0px;">
        <div class="panel panel-body" style="padding: 0px; margin: 0px;">
            <ZL:ExGridView ID="Egv" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" PageSize="10" OnRowDataBound="Egv_RowDataBound" OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Lnk_Click" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="无相关数据">
                <Columns>
                    <asp:TemplateField HeaderText="选择">
                        <HeaderStyle Width="5%" />
                        <ItemTemplate>
                            <input type="checkbox" name="idchk" title="" value='<%#Eval("ID") %>' />
                        </ItemTemplate>
                        <ItemStyle CssClass="tdbg" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="" HeaderStyle-Width="0%" Visible="false">
                        <ItemTemplate>
                        </ItemTemplate>
                        <HeaderStyle Width="0%"></HeaderStyle>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID" HeaderStyle-Width="5%">
                        <ItemTemplate>
                            <%#Eval("ID")%>
                        </ItemTemplate>
                        <HeaderStyle Width="5%"></HeaderStyle>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="词条" HeaderStyle-Width="12%">
                        <ItemTemplate>
                            <%#Eval("Tittle")%>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" class="l_input" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Tittle")%>'>'></asp:TextBox>
                        </EditItemTemplate>
                        <HeaderStyle Width="12%"></HeaderStyle>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="编辑人" HeaderStyle-Width="12%">
                        <ItemTemplate>
                            <%#Eval("UserName")%>
                        </ItemTemplate>
                        <HeaderStyle Width="12%"></HeaderStyle>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="修改时间" HeaderStyle-Width="10%">
                        <ItemTemplate>
                            <%#Eval("EditTime")%>
                        </ItemTemplate>
                        <HeaderStyle Width="10%"></HeaderStyle>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="修改原因">
                        <ItemTemplate>
                            <%#Eval("Why") %>
                        </ItemTemplate>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="审核">
                        <ItemTemplate>
                            <%#GetStatuStr()%>
                        </ItemTemplate>
                        <ItemStyle CssClass="tdbg"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" OnClientClick="return confirm('确实要删除吗？');" CommandArgument='<%#Eval("ID") %>' CommandName="Del" CausesValidation="false" CssClass="option_style"><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                            <a href="/guest/baike/Details.aspx?id=<%:BaikeID %>&editid=<%#Eval("ID") %>" target="_blank" title="浏览"><span class="fa fa-globe"></span>浏览</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" />
                <RowStyle HorizontalAlign="Center" />
            </ZL:ExGridView>
        </div>
        <div class="panel panel-footer" style="padding: 3px; margin: 0px;">
            <asp:Button ID="Button1" runat="server" Text="批量删除" UseSubmitBehavior="False" OnClientClick="if(!confirm('确定要批量删除词条吗？')){return false;}" CssClass="btn btn-primary" OnClick="Button1_Click" />
            <asp:Button ID="Button2" runat="server" Text="审核通过" UseSubmitBehavior="False" CssClass="btn btn-primary" OnClick="Button2_Click" />
            <button type="button" class="btn btn-primary" onclick="ShowReturn();">不予通过</button>
        </div>
    </div>
    <div id="return_div" style="display:none;">
        <div>
            <textarea id="detail_text" style="width:100%; height:200px;"></textarea>
            <%=Call.GetUEditor("detail_text",2) %>
        </div>
        <div class="text-center margin_t5">
            <asp:Button ID="Return_Btn" runat="server" OnClientClick="return SaveDeatail();" OnClick="Return_Btn_Click" CssClass="btn btn-primary" Text="确定" />
            <button type="button" onclick="returndiag.CloseModal();" class="btn btn-primary">取消</button>
        </div>
    </div>
    <asp:HiddenField ID="Return_Hid" runat="server" />
<script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
<script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
<script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
<script type="text/javascript">
    var tID = 0;
    var arrTabTitle = new Array("TabTitle0", "TabTitle1", "TabTitle2", "TabTitle3");
    window.onload = function ()
    {
        pload();
    }
    function ShowTabss(ID)
    {
        location.href = 'InfoList.aspx?status='+ID+'&id=<%:BaikeID %>';
    }
    function pload()
    {
        var ID = '<%=Request.QueryString["id"]%>';
        if (ID != tID)
        {
            document.getElementById(arrTabTitle[tID].toString()).className = "tabtitle";
            document.getElementById(arrTabTitle[ID].toString()).className = "titlemouseover";
            tID = ID;
        }
    }
    $().ready(function () {
        $("li a[href='#tab<%:EditStatus %>']").parent().addClass("active").siblings("li").removeClass("active");;
    });
    var returndiag = new ZL_Dialog();
    function ShowReturn() {
        returndiag.title = "请填写不予通过的理由";
        returndiag.content = "return_div";
        returndiag.ShowModal();
    }
    function SaveDeatail() {
        $("#Return_Hid").val(UE.getEditor("detail_text").getContent());
        return true;
    }
</script>
</asp:Content>