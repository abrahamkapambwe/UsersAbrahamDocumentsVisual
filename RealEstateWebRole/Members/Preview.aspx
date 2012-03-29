<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Preview.aspx.cs" Inherits="RealEstateWebRole.Account.Preview" %>

<%@ Register Src="../Controls/PreviewControl.ascx" TagName="PreviewControl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <uc1:PreviewControl ID="PreviewControl1" runat="server" />
    </div>
</asp:Content>
