<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs" Inherits="RealEstateWebRole.Members.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="viewItem" style="height: 400px">
                <asp:Panel runat="server" ID="panelProfile">
                    <table>
                        <tr>
                            <td width="200px">
                                <span class="labeltext">Title</span>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlTitle">
                                    <asp:ListItem Text="Select One" Value="Select One"></asp:ListItem>
                                    <asp:ListItem Text="Adv" Value="Adv"></asp:ListItem>
                                    <asp:ListItem Text="Dr" Value="Dr"></asp:ListItem>
                                    <asp:ListItem Text="Hon" Value="Hon"></asp:ListItem>
                                    <asp:ListItem Text="Mr" Value="Mr"></asp:ListItem>
                                    <asp:ListItem Text="Mrs" Value="Mrs"></asp:ListItem>
                                    <asp:ListItem Text="Ms" Value="Ms"></asp:ListItem>
                                    <asp:ListItem Text="Prof" Value="Prof"></asp:ListItem>
                                    <asp:ListItem Text="Rev" Value="Rev"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ID="rfvTitle" ControlToValidate="ddlTitle"
                                    InitialValue="Select One" Text="*"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">First name</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtFirstname"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Last name</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtLastname"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Cell Phone</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtCellPhone"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Home Phone</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtHomePhone"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Work Phone</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtWorkPhone"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Email</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtEmailAddress"></asp:TextBox>
                                <asp:RegularExpressionValidator runat="server" ID="revEmail" ControlToValidate="txtEmailAddress"
                                    ValidationGroup="profile" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Address</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtAddress"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">City</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" class="textbox" ID="txtCity"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Province</span>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" class="dropbox" ID="ddlUserProvince">
                                    <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                    <asp:ListItem Text="Central" Value="Central"></asp:ListItem>
                                    <asp:ListItem Text="Copperbelt" Value="Eastern"></asp:ListItem>
                                    <asp:ListItem Text="Lusaka" Value="Copperbelt"></asp:ListItem>
                                    <asp:ListItem Text="Eastern" Value="Eastern"></asp:ListItem>
                                    <asp:ListItem Text="Luapula" Value="Luapula"></asp:ListItem>
                                    <asp:ListItem Text="Northern" Value="Northern"></asp:ListItem>
                                    <asp:ListItem Text="Southern" Value="Southern"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">I am a...</span>
                            </td>
                            <td>
                                <asp:DropDownList class="dropbox" runat="server" ID="ddlIam">
                                    <asp:ListItem Text="Buyers Agent" Value="Buyers Agent" />
                                    <asp:ListItem Text="Estate Agent" Value="Estate Agent" />
                                    <asp:ListItem Text="Owner" Value="Owner" />
                                    <asp:ListItem Text="Property Manager" Value="Property Manager" />
                                    <asp:ListItem Text="Sellers Agent" Value="Sellers Agent" />
                                    <asp:ListItem Text="Other/Just Looking" Value="Other/Just Looking" />
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField runat="server" ID="hdfUser" />
                            </td>
                        </tr>
                    </table>
                    <asp:Button runat="server" ID="btnSaveContinue" CssClass="formbutton" OnClick="Update_Click"
                        Text="Update" ValidationGroup="profile" />
                </asp:Panel>
                <asp:Panel runat="server" ID="pnlSucess" visble="false">
                    <table runat="server" id="tblProfile" visible="false">
                        <tr>
                            <td>
                                <span style="color: Red"></span>Your Profile has been Updated
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
