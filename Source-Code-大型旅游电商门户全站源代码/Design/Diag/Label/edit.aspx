﻿<%@ page language="C#" autoeventwireup="true" inherits="Design_Diag_Label_edit, App_Web_5110zhfo" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head"><title>修改标签</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script>
        var editor = { id: "<%:Request.QueryString["ID"]%>", dom: null, model: null, scope: null};
        $(function () {
            //editor.model = top.page.compList.GetByID(editor.id);
            //editor.dom = editor.model.instance;
            location = "LabelCall.aspx?<%=Request.QueryString%>";
        })
    </script>
</asp:Content>