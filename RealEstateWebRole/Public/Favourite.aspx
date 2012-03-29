<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="FavouritePage.aspx.cs" Inherits="RealEstateWebRole.Public.FavouritePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 100%">
        <div style="width: 60%; float: left">
            <div>
            </div>
            <div>
                <asp:ListView ID="lstFavourite" runat="server" OnItemDataBound="ltvFavourite_itemDataBound">
                    <LayoutTemplate>
                        <ul id="itemPlaceHolder" runat="server" style="padding: 0px">
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li style="list-style-type: none">
                            <div style="width: 100%">
                                <div style="float: left; width: 30%">
                                    <asp:HyperLink runat="server" ID="hypImage"></asp:HyperLink>
                                </div>
                                <div style="float: left; width: 30%">
                                    <div style="clear: both">
                                        <div id="price">
                                            <asp:Label runat="server" ID="lblPrice"></asp:Label>
                                        </div>
                                        <div id="address">
                                            <asp:Label runat="server" ID="lblAddress">></asp:Label>
                                        </div>
                                        <div id="feature">
                                            <asp:Label runat="server" ID="lblFeature"></asp:Label></div>
                                        <div id="contact">
                                            <asp:HyperLink runat="server" ID="hypContact"></asp:HyperLink>
                                        </div>
                                    </div>
                                </div>
                                <div style="float: left; width: 40%">
                                    <asp:LinkButton runat="server" ID="lkbRemove" Text="Remove Property from Favourite"
                                        OnClick="Remove_OnClick"></asp:LinkButton>
                                </div>
                            </div>
                        </li>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <div>
                            You currently have no properties in your favourites!</div>
                    </EmptyDataTemplate>
                </asp:ListView>
            </div>
        </div>
        <div style="width: 40%; float: left">
            <asp:LoginView runat="server" ID="loginView1">
                <AnonymousTemplate>
                    <asp:Login ID="LoginUser" runat="server" OnLoggedIn="Favourite_LoggedIn" EnableViewState="false"
                        RenderOuterTable="false">
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
                </AnonymousTemplate>
                <LoggedInTemplate>
                    You have
                    <asp:Label runat="server" ID="lblNumberFavourite"></asp:Label>
                    favourite properties.
                </LoggedInTemplate>
            </asp:LoginView>
        </div>
    </div>
</asp:Content>
