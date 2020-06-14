<%@ page language="C#" autoeventwireup="true" inherits="manage_Zone_Schoollist, App_Web_kuj0seqg" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE HTML>
<html>
<head id="Head1" runat="server">
<title>选择学校</title>
<base target="_self" />
<script>
    function putname(name,id)
    {
    opener.document.getElementById('txtSchoolName').value=name;
    opener.document.getElementById('txtSchoolID').value=id;
    window.close();
    }
</script>
</head>
<body>
<form id="form1" runat="server">        
            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="border" id="TABLE1">
                <tr class="title">
                    <td align="left">
                        <b>学校列表：</b></td>
                    <td align="right">
                        <asp:TextBox ID="TxtKeyWord" class="l_input" runat="server"></asp:TextBox>&nbsp;&nbsp;<asp:Button
                            ID="BtnSearch" class="C_input" runat="server" Text="查找"  OnClick="BtnSearch_Click" /></td>
                </tr>
                <tr>
                    <td valign="top" colspan="2">
              <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                     <tr class="tdbgleft">
             <td width="5%" height="24" align="center"><strong>ID</strong></td>
              <td width="30%" height="24" align="center"><strong>学校名称</strong></td>
              <td width="10%" height="24" align="center"><strong>类型</strong></td>
              <td width="15%" height="24" align="center"><strong>国家</strong></td>
              <td width="15%" height="24" align="center"><strong>省份</strong></td>
            </tr>
                        <ZL:ExRepeater ID="Pagetable" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>">
                            <ItemTemplate>
              <tr class="tdbg">
              <td height="24" align="center"><%#Eval("ID") %></td>
              <td height="24" align="center"><a href="###" onclick="putname('<%#Eval("SchoolName") %>','<%#Eval("ID") %>');"><%#Eval("SchoolName") %></a></td>
              <td height="24" align="center"><%#Eval("SchoolType") %></td>
              <td height="24" align="center"><%#Eval("Country") %></td>
              <td height="24" align="center"><%#Eval("Province") %></td>
              </tr>
                            </ItemTemplate>
                            <FooterTemplate></FooterTemplate>
                        </ZL:ExRepeater>
             </table> 
             </td>
             </tr>
             </table>
</form>    
</body>
</html>
