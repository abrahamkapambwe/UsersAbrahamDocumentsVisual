<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="RealEstateWebRole.Admin.Details" %>
<%@ Register src="../Controls/PreviewControl.ascx" tagname="PreviewControl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <uc1:PreviewControl ID="PreviewControl1" runat="server" />

</asp:Content>
