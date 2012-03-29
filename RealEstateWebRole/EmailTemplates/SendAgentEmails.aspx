<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendAgentEmails.aspx.cs"
    Inherits="RealEstateWebRole.EmailTemplates.SendAgentEmails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label runat="server" ID="lblName"></asp:Label>
        <asp:Label runat="server" ID="lblPhone"></asp:Label>
        <asp:Label runat="server" ID="lblEmail"></asp:Label>
        <asp:Label runat="server" ID="lblMessage"></asp:Label>
        <asp:HyperLink runat="server" ID="hyperProperty" Text="Click here for more details"></asp:HyperLink>
    </div>
    </form>
</body>
</html>
