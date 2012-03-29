<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AgentProfile.aspx.cs" Inherits="RealEstateWebRole.Account.AgentProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="agentProfile">
                <asp:MultiView runat="server" ID="multiview1" ActiveViewIndex="0">
                    <asp:View runat="server" ID="view1">
                        <asp:HiddenField runat="server" ID="hdfUserID" />
                        <asp:HiddenField runat="server" ID="hdfEstateID" />
                        <table>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtScreenname" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">First Name<sub>*</sub></span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtFirstName"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RqfvFirstname" runat="server" Text="Please enter your first name." ControlToValidate="txtFirstName"
                                        ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Last Name</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtLastname"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RqfvLastname" runat="server" Text="Please enter your last name. "
                                        ControlToValidate="txtFirstName" ErrorMessage="Lastname is required" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Logo</span>
                                </td>
                                <td>
                                    <asp:FileUpload runat="server" ID="fileupload1" /><asp:Button runat="server" ID="btnUpload"
                                        Text="Upload" CausesValidation="false" OnClick="Upload_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Image Width="60px" Height="60px" runat="server" ID="imgProfile" />
                                </td>
                            </tr>
                            <tr runat="server" id="trProfileVideo" visible="false">
                                <td>
                                    <span class="labeltext">Profile Video</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtProfileVideo"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Professionanl Category</span>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" class="dropbox" ID="ddlProfessionCategory">
                                        <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                        <asp:ListItem Text="Estate Agent" Value="Estate Agent"></asp:ListItem>
                                        <asp:ListItem Text="Home Improvement Services" Value="Home Improvement Services"></asp:ListItem>
                                        <asp:ListItem Text="Property Manager" Value="Property Manager"></asp:ListItem>
                                        <asp:ListItem Text="Builders/Developers" Value="Builders/Developers"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RfvProfessionalCategory" runat="server" Text="Please select a professional category."
                                        ControlToValidate="ddlProfessionCategory" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Professional title</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtProfessionaltitle"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Business name</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtBusinessname"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RfvBusinessname" runat="server" Text="Please enter your company name."
                                        ControlToValidate="txtBusinessname" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Business address</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtBusinessaddress"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Text="Please enter your company address."
                                        ControlToValidate="txtBusinessaddress" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">City/County</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtCity"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator1" runat="server" Text="Please enter the city where your company is located."
                                        ControlToValidate="txtCity" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Province</span>
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" class="dropbox" ID="ddlProvince">
                                        <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                        <asp:ListItem Text="Coast" Value="Coast"></asp:ListItem>
                                        <asp:ListItem Text="Eastern" Value="Eastern"></asp:ListItem>
                                        <asp:ListItem Text="Nairobi" Value="Nairobi"></asp:ListItem>
                                        <asp:ListItem Text="North Eastern" Value="North Eastern"></asp:ListItem>
                                        <asp:ListItem Text="Nyanza" Value="Nyanza"></asp:ListItem>
                                        <asp:ListItem Text="Rift Valley" Value="Rift Valley"></asp:ListItem>
                                        <asp:ListItem Text="Western" Value="Western"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="Please enter the province where your company is located."
                                        ControlToValidate="ddlProvince" InitialValue="--Select--" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Postal Code</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtZip"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator4" runat="server" Text="Please enter your companys postal code."
                                        ControlToValidate="txtZip" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Text="Postal code requires 4 characters"
                                        ControlToValidate="txtZip" ValidationExpression="\d{4}" ValidationGroup="Agentform"
                                        ToolTip="Postal code requires 4 characters" ErrorMessage="<br/>Postal code requires 4 characters"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Business phone</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtBusinessPhone" class="textbox"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator5" runat="server" Text="Please enter a valid phone number."
                                        ControlToValidate="txtBusinessPhone" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" Text="Business phone number requires 10 numeric values"
                                        ControlToValidate="txtBusinessPhone" ValidationExpression="\d{10}" ValidationGroup="Agentform"
                                        ToolTip="Business phone number requires 10 numeric values" ErrorMessage="<br/>Business phone number requires 10 numeric values"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Cell phone</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtCellphone"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Fax number</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtFaxNumber"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Website</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtWebsite" class="textbox"></asp:TextBox><asp:RegularExpressionValidator
                                        ID="RegularExpressionValidator1" runat="server" Text="Please enter the valid website url"
                                        ControlToValidate="txtWebsite" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Facebook</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtfaceBook"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Twitter</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtTwitter"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">LinkedIn</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtLinkedin"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="labeltext">Email</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtEmail" class="textbox" Enabled="false"></asp:TextBox><br />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <span class="labeltext">Service Area</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" class="textbox" ID="txtServiceArea"></asp:TextBox>
                                    <sup>City,Suburb/County</sup><br />
                                    <asp:TextBox runat="server" class="textbox" ID="txtServiceArea1"></asp:TextBox>
                                    <sup>City,Suburb/County</sup><br />
                                    <asp:TextBox runat="server" class="textbox" ID="txtServiceArea2"></asp:TextBox>
                                    <sup>City,Suburb/County</sup><br />
                                    <asp:TextBox runat="server" class="textbox" ID="txtServiceArea3"></asp:TextBox>
                                    <sup>City,Suburb/County</sup>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <span class="labeltext">Description</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtServiceDescription" MaxLength="600" TextMode="MultiLine"
                                        Height="100px" Width="500px"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Text="*"
                                        ValidationGroup="form" ControlToValidate="txtServiceDescription" ValidationExpression="\d{500}"
                                        ToolTip="500 characters are allowed" ErrorMessage="<br/>500 characters are allowed"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <span class="labeltext">Specialties(atleast 4)</span>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                Agents Specialties
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:CheckBoxList runat="server" ID="cblAgentsSpecialties" RepeatColumns="2" RepeatLayout="Table">
                                                    <asp:ListItem Text="Buyers Agent" Value="Buyers Agent"></asp:ListItem>
                                                    <asp:ListItem Text="Sellers Agent" Value="Sellers Agent"></asp:ListItem>
                                                    <asp:ListItem Text="Relocation" Value="Relocation"></asp:ListItem>
                                                    <asp:ListItem Text="Listing Agent" Value="Listing Agent"></asp:ListItem>
                                                    <asp:ListItem Text="Consulting" Value="Consulting"></asp:ListItem>
                                                    <asp:ListItem Text="Moving" Value="Moving"></asp:ListItem>
                                                    <asp:ListItem Text="Property Management" Value="Property Management"></asp:ListItem>
                                                    <asp:ListItem Text="Staging" Value="Staging"></asp:ListItem>
                                                    <asp:ListItem Text="Archictecture" Value="Archictecture"></asp:ListItem>
                                                    <asp:ListItem Text="Carpentry" Value="Carpentry"></asp:ListItem>
                                                    <asp:ListItem Text="Engineering" Value="Engineering"></asp:ListItem>
                                                    <asp:ListItem Text="Interior Design" Value="Interior Design"></asp:ListItem>
                                                    <asp:ListItem Text="Painting" Value="Painting"></asp:ListItem>
                                                    <asp:ListItem Text="Home Building" Value="Home Building"></asp:ListItem>
                                                    <asp:ListItem Text="Electrical" Value="Electrical"></asp:ListItem>
                                                    <asp:ListItem Text="General Contracting" Value="General Contracting"></asp:ListItem>
                                                    <asp:ListItem Text="Land scaping" Value="Land scaping"></asp:ListItem>
                                                    <asp:ListItem Text="Plumbing" Value="Plumbing"></asp:ListItem>
                                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                                </asp:CheckBoxList>
                                                <asp:TextBox runat="server" ID="txtOtherAgentsSpecialties"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:Button runat="server" ID="btnLastNext" OnClick="SavePersonalProfile_Click" Text="Save" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label runat="server" Font-Bold="true" ForeColor="Red" ID="lblResult"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnLastNext" EventName="Click" />
            <asp:PostBackTrigger ControlID="btnUpload" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <img src="../images/ajax-loader.gif" alt="" />
            An update is in progress...
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
