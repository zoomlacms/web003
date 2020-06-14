<%@ page language="C#" autoeventwireup="true" enableeventvalidation="false" inherits="Questions_Paper, App_Web_bglufef4" enableviewstatemac="false" viewStateEncryptionMode="Never" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
<title><%Call.Label("{$SiteName/}");%>-试题列表</title>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />
<style type="text/css">
    body{font-size: 9pt;}
    a{font-size: 9pt;}
</style>
</head>

<script>
    function showtab(id) {
        if (document.getElementById(id).style.display != "none") {
            document.getElementById(id).style.display = "none";
        }
        else {
            document.getElementById(id).style.display = "";
        }
        parent.SetCwinHeight();
    }

</script>

<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
        <hr style="height: 1px;" />
        难度：
        <asp:DropDownList ID="nd" runat="server">
            <asp:ListItem Text="基础" Value="1"></asp:ListItem>
            <asp:ListItem Text="容易" Value="2"></asp:ListItem>
            <asp:ListItem Text="中等" Value="3"></asp:ListItem>
            <asp:ListItem Text="偏难" Value="4"></asp:ListItem>
            <asp:ListItem Text="极难" Value="5"></asp:ListItem>
        </asp:DropDownList>
        题型：
        <asp:DropDownList ID="tx" runat="server">
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="过滤" />
        <asp:Button ID="Button2" runat="server" Text="进入试题篮 --> 生成试卷" 
            onclick="Button2_Click" />
        &nbsp;
        <hr style="height: 1px;" />
        <div style="float: left; width: 10%; height: 24px; padding-top: 5px">
            排序方法：
        </div>
        <div style="float: left; width: 40%; height: 24px;">
            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="2" Selected="True">入库时间</asp:ListItem>
                <asp:ListItem Value="1">使用次数</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div style="float: left; width: 50%; height: 24px; padding-top: 5px; text-align: right;">
            试题篮分布情况
        </div>
        <div style="float: left; width: 100%">
            <hr />
            <br />
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <ZL:ExRepeater ID="RPT" runat="server" PagePre="<div class='text-center'>" PageEnd="</div>">
                        <ItemTemplate>
                            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                                <tr>
                                    <td bgcolor="#FFFFFF" height="26px" style="line-height: 26px">
                                        <span style="width: 70%; float: left; font-weight: bold">难度：<%#Getndname(Eval("p_Difficulty","{0}"))%>
                                            使用次数：<%#Eval("p_Views")%>
                                            入库时间：<%#Eval("p_CreateTime", "{0:yyyy-MM-dd}")%><br />
                                            来源：<font color="green" style="font-weight:normal"><%#GetPaper(Eval("Paper_Id", "{0}"))%></font> </span>
                                        <span style="width: 30%; float: left; text-align: right">
                                            <asp:HiddenField ID="PageIDs" runat="server" Value='<%#Eval("p_id") %>' />
                                            <asp:Button ID="Button4" runat="server" Text='<%#GetText(Eval("p_id","{0}")) %>'
                                                OnClick="Button4_Click" CommandArgument='<%#Eval("p_id")%>' />
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#FFFFFF" height="26px" style="padding-bottom: 10px; padding-top: 10px">
                                        <%#Eval("p_Content")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#FFFFFF" height="26px" style="line-height: 26px">
                                        <span style="width: 60%; float: left">
                                            <input id="Button1" type="button" value="答案 >>" onclick="showtab('an<%#Eval("p_id") %>');return false;"
                                                style="color: Red" />
                                            纠错[永久链接] </span><span style="width: 40%; float: left; text-align: right">题型：<font
                                                color="blue"><%#Gettxname(Eval("p_Type","{0}"))%></font> 知识点：<font color="blue"><%#GetKnowledge(Eval("p_Knowledge","{0}"))%></font>
                                            </span>
                                    </td>
                                </tr>
                                <tr style="display: none" id="an<%#Eval("p_id") %>" name="an<%#Eval("p_id") %>">
                                
                                    <td bgcolor="#FFFFFF" height="26px" style="line-height: 26px;border: 1px dotted #F00;">
                                        <%#Eval("p_Answer")%>
                                    </td>
                                </tr>
                            </table>
                            <br />
                        </ItemTemplate>
                        <FooterTemplate></FooterTemplate>
                    </ZL:ExRepeater>
            <%--<asp:HiddenField ID="hiddenid" runat="server" />--%>
            <%--<asp:TextBox ID="hiddenid" runat="server"></asp:TextBox>--%>
            </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
