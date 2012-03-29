<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="RealEstateWebRole.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <table>
        <tr>
            <td>
                Monthly rental
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtMonthlyrental"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Please write a description of your listing that describes your property very well.Maximum
                number of characters should be 2000
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox runat="server" ID="txtDescription"></asp:TextBox>
            </td>
        </tr>
        <tr runat="server" id="trStorage" visible="false">
            <td>
                Storage
            </td>
            <td>
                <asp:ImageButton runat="server" ID="imgbtnStorage" AlternateText="Delete" CommandArgument="Storage" OnCommand ="but_Click"  />
                <asp:DropDownList runat="server" ID="ddlStorage">
                    <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr runat="server" id="trSwimmingPool" visible="false">
            <td>
                Swimming Pool
            </td>
            <td>
                <asp:ImageButton runat="server" ID="ImgbtnSwimmingPool" AlternateText="Delete" CommandArgument="SwimmingPool" OnCommand ="but_Click" />
                <asp:DropDownList runat="server" ID="ddlSwimmingPool">
                    <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Property Features
            </td>
            <td>
                <div id="div" runat="server">
                </div>
                <asp:DropDownList runat="server" ID="ddlFeatures">
                    <asp:ListItem Value="Select" Text="Select"></asp:ListItem>
                    <asp:ListItem Value="Storage" Text="Storage"></asp:ListItem>
                    <asp:ListItem Value="Swimming Pool" Text="Swimming Pool"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button Text="Add attribute" ID="btnattribute" OnClick="btnattribute_Onclick"
                    runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button runat="server" ID="btnPrice" Text="Save"  />
            </td>
        </tr>
    </table>
</asp:Content>
