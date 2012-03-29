<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Contact.aspx.cs" Async="true" Inherits="RealEstateWebRole.Public.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div runat="server" id="divMessage">
        <table>
            <tr>
                <td>
                    First name*
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtName"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator3" ControlToValidate="txtName" Text="Name is required"
                        runat="server" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Surname
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtSurname"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Phone*
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtPhone"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2" ControlToValidate="txtPhone" Text="Contact phone is required"
                        runat="server" ErrorMessage="Contact phone is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Email*
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtEmail"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" Text="Email is required"
                        ErrorMessage="Email is required"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator1" ControlToValidate="txtEmail" Text="Invalid email address"
                            runat="server" ErrorMessage="Invalid email address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    How did you hear about us?
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlHear">
                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                        <asp:ListItem Text="Reference from another agent/public" Value="Reference from another agent/public"></asp:ListItem>
                        <asp:ListItem Text="Search engine(Google,Bing,Yahoo)" Value="Search engine(Google,Bing,Yahoo)"></asp:ListItem>
                        <asp:ListItem Text="A Link or Banner from another website" Value="A Link or Banner from another website"></asp:ListItem>
                        <asp:ListItem Text="Newpaper/Magazine advert" Value="Newpaper/Magazine advert"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Tell us the reason of getting in touch
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlInTouch">
                        <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                        <asp:ListItem Text="Estate Agents services" Value="Estate Agents services"></asp:ListItem>
                        <asp:ListItem Text="Listing a property for sell" Value="Listing a property for sell"></asp:ListItem>
                        <asp:ListItem Text="Listing a property for rent" Value="Listing a property for rent"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    Comment*
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtComment" MaxLength="200" TextMode="MultiLine"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtComment"
                        Text="Comment is required" ErrorMessage="Comment is required"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <asp:Button runat="server" ID="bntSubmit" Text="Submit" OnClick="Submit_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divStatus" runat="server" visible="false">
        <asp:Label runat="server" ID="labMessage"></asp:Label>
    </div>
</asp:Content>
