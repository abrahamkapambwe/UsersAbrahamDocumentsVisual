<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Forsale.aspx.cs" Inherits="RealEstateWebRole.Public.Forsale" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <span style="font-size: 1.9em; font-weight: bold">List your property for sale on epropertysearch</span><br />
    <div style="height: 20px">
    </div>
    <table>
        <tr>
            <td>
            </td>
            <td style="background: url(../images/button.png) center top repeat-x; width: 100px;
                padding: 10px;">
                <center>
                    <asp:LinkButton ID="linkBasic" runat="server" Font-Bold="true" Font-Size="Large"
                        ForeColor="White" OnClick="Basic_Click" CommandName="Basic">Silver</asp:LinkButton></center>
            </td>
            <td style="background: url(../images/button.png) center top repeat-x; width: 100px;
                padding: 10px;">
                <center>
                    <asp:LinkButton ID="linkBasicMonths" runat="server" Font-Bold="true" Font-Size="Large"
                        ForeColor="White" OnClick="Basic_Click" CommandName="BasicMonths">Gold</asp:LinkButton></center>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; margin-left: 10px">
                <b>Featured Listing</b><br />
                Feature your listing for particular months
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <b style="font-size:large">1</b></center>
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <b style="font-size:large">3</b></center>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; margin-left: 10px">
                <b>Enhanced Property Page</b><br />
                <br />
                20 photos, property description,<br />
                attributes and a map with points of interest.<br />
                And the contact us form
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; margin-left: 10px">
                <b>E-marketing</b><br />
                <br />
                Potential Buyers will receive<br />
                the email in your area
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
        </tr>
        <tr>
            <td style="padding: 10px; margin-left: 10px">
                <b>Advertise on the partners site</b><br />
                <br />
                Your properties will appear
                <br />
                on newsSouthAfrica.com
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
            <td style="padding: 10px; margin-left: 10px">
                <center>
                    <img src="../images/tick_grid.png" /></center>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td style="background: url(../images/button.png) center top repeat-x; width: 100px;
                padding: 10px;">
                <center>
                    <asp:HyperLink runat="server" ID="hypePriceMonth" Font-Bold="true" Font-Size="Large"
                        ForeColor="White" Text="R 200" NavigateUrl="~/Public/Login.aspx?Status=OneMonth"></asp:HyperLink></center>
            </td>
            <td style="background: url(../images/button.png) center top repeat-x; width: 100px;
                padding: 10px;">
                <center>
                    <asp:HyperLink runat="server" ID="hyperPrice3Month" Font-Bold="true" Font-Size="Large"
                        ForeColor="White" Text="R 350" NavigateUrl="~/Public/Login.aspx?Status=ThreeMonth"></asp:HyperLink></center>
            </td>
        </tr>
    </table>
</asp:Content>
