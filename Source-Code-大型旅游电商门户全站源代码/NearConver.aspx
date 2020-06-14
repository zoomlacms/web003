<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NearConver.aspx.cs" Inherits="Common_API_NearConver" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button runat="server" ID="Test" OnClick="Test_Click" Text="开始转换" />
        <script>
            var json = [{ "mark": { "lng": "105.614044", "lat": "27.15882" }, "content": "", "icon": "/Common/Label/Map/Img/f1.png" }];
            console.log(json[0].mark.lng);
        </script>
    </form>
</body>
</html>
