<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" ValidateRequest="false" Inherits="RealEstateWebRole.Account.Login" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="clear">
    </div>
    <div runat="server" id="AnonymousUser">
        <div style="border-top-left-radius: 4px; border-top-right-radius: 4px; width: 200px;
            height: 50px; border-left: 1px solid #bbb; border-top: 1px solid #bbb; border-right: 1px solid #bbb;">
            <div style="text-align: center; padding-top: 10px;">
                Log In</div>
        </div>
        <div style="width: 1000px;">
            <div style="float: left; width: 198px; height: 50px; border-left: 1px solid #bbb;">
            </div>
            <div style="float: left; height: 50px; width: 800px; border-top: 1px solid #bbb;
                border-right: 1px solid #bbb;">
            </div>
        </div>
        <div style="clear: both; width: 1000px; height: 350px; border-right: 1px solid #bbb;
            border-bottom: 1px solid #bbb; border-left: 1px solid #bbb;">
            <div style="padding: 20px">
                <div>
                    Please enter your username and password.<br />
                    <asp:HyperLink runat="server" ID="hypForgetPassword" Text="Forgotten your password?"
                        NavigateUrl="~/Public/ForgotPassword.aspx"></asp:HyperLink>
                    <asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false">Register</asp:HyperLink>
                    if you don't have an account.</div>
                <br />
                <asp:Login ID="LoginUser" runat="server" EnableViewState="false" RenderOuterTable="false">
                    <LayoutTemplate>
                        <span class="failureNotification">
                            <asp:Literal ID="FailureText" runat="server"></asp:Literal>
                        </span>
                        <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification"
                            ValidationGroup="LoginUserValidationGroup" />
                        <div class="accountInfo">
                            <div>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Email:</asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    CssClass="failureNotification" ErrorMessage="Email is required." ToolTip="Email is required."
                                    ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                            </div>
                            <div>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required."
                                    ValidationGroup="LoginUserValidationGroup">*</asp:RequiredFieldValidator>
                            </div>
                            <div style="float: left">
                                <asp:CheckBox ID="RememberMe" runat="server" />
                                <asp:Label ID="RememberMeLabel" runat="server" AssociatedControlID="RememberMe" CssClass="inline">Keep me logged in</asp:Label>
                            </div>
                            <div class="submitButton">
                                <asp:Button ID="LoginButton" runat="server" TabIndex="0" CssClass="button" CommandName="Login"
                                    Text="Log In" ValidationGroup="LoginUserValidationGroup" />
                            </div>
                        </div>
                    </LayoutTemplate>
                </asp:Login>
            </div>
            <div class="clear">
            </div>
            <div style="padding: 20px">
                or login with the following</div>
            <div style="float: left; padding-left: 20px; margin-right: 20px;">
                <asp:HyperLink runat="server" class="facabook_icon" ID="hypfacebook"></asp:HyperLink></div>
            <div style="float: left">
                <asp:HyperLink runat="server" ID="hypGoogle"></asp:HyperLink></div>
        </div>
    </div>
    <asp:LoginView ID="HeadLoginView" runat="server" EnableViewState="false">
        <LoggedInTemplate>
            <div style="width: 100%; float: left; background-color: #EBF4EB; border-radius: 10px 10px 10px 10px;">
                <div style="width: 50%; float: left">
                    <div style="width: 200px; height: 150px; padding: 20px">
                        <div style="float: left">
                            <img src="../images/eproperty-estate-agency.png" alt="Agent" />
                        </div>
                        <div style="float: left; width: 100px; margin-left: 10px; text-align: center; margin-top: 10px">
                            <asp:HyperLink ID="HyperViewProperty" runat="server" Text="Manage Listing" NavigateUrl="~/Members/ViewProperty.aspx"></asp:HyperLink>
                        </div>
                    </div>
                    <div style="width: 200px; height: 150px; clear: both; padding: 20px">
                        <div style="float: left">
                            <img src="../images/eproperty-estate-agency.png" alt="Agent" />
                        </div>
                        <div style="float: left; width: 100px; margin-left: 10px; text-align: center; margin-top: 10px">
                            <asp:HyperLink ID="HyperPrivate" runat="server" Text="New Listing" NavigateUrl="~/Members/UploadPictures.aspx"></asp:HyperLink>
                        </div>
                    </div>
                </div>
                <div style="width: 50%; float: left">
                    <div style="width: 200px; height: 150px; padding: 20px">
                        <div style="float: left">
                            <img src="../images/eproperty-estate-agency.png" alt="Agent" />
                        </div>
                        <div style="float: left; width: 100px; margin-left: 10px; text-align: center; margin-top: 10px">
                            <%--       Let ePropertySearch turn your property dream into reality.List your--%>
                            <asp:HyperLink ID="hyperAgent" runat="server" Text="Agent listing" NavigateUrl="~/Members/AgentProfile.aspx"></asp:HyperLink>&nbsp;
                        </div>
                    </div>
                    <div style="width: 200px; height: 150px; clear: both; padding: 20px">
                        <div style="float: left">
                            <img src="../images/eproperty-estate-agency.png" alt="Agent" />
                        </div>
                        <div style="float: left; width: 100px; margin-left: 10px; text-align: center; margin-top: 10px">
                            <asp:HyperLink runat="server" ID="hypProfile" Text="Edit Profile" NavigateUrl="~/Members/Profile.aspx"></asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </LoggedInTemplate>
        <RoleGroups>
            <asp:RoleGroup Roles="Administrator">
                <ContentTemplate>
                    <asp:HyperLink runat="server" Text="Approve" ID="hyperApprove" NavigateUrl="~/Admin/Admin.aspx" />
                </ContentTemplate>
            </asp:RoleGroup>
        </RoleGroups>
    </asp:LoginView>
</asp:Content>
