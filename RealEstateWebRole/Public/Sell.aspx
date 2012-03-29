<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Sell.aspx.cs" Inherits="RealEstateWebRole.Public.Sell" %>

<%@ Register Src="../Controls/SearchMapke.ascx" TagName="SearchMap" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="sellrenttitle">
        <div style="margin-bottom: 5px">
            <div style="font-size: 0.8em">
                Estate agent or selling your property privately?ePropertySearch offer
                you more choice when searching for properties plus an amazing pool of potential
                buyers to advertise to. It’s your key to a great property renting experience.Submit
                as many listings as you like. <b style="color: Red">List your properties for free with
                    no setup cost</b></div>
        </div>
        <div class="leadTitle">
            <span class="leadText">
                <asp:HyperLink runat="server" ID="hypSubmit" Text="Submit your listings
 for sale on ePropertySearch for free!" NavigateUrl="~/Members/UploadPictures.aspx"></asp:HyperLink></span>
        </div>
    </div>
    <uc1:SearchMap ID="SearchMap1" runat="server" />
    <div id="latestproperty">
        <div style="font-size: 16px; color: #000000; font-weight: bolder; margin-bottom: 10px;
            margin-left: 10px">
            Featured Property</div>
        <div>
            <asp:ListView runat="server" ID="lstFeaturedProperty" OnItemDataBound="lstFeaturedProperty_itemDataBound"
                Style="padding: 0; float: left; margin-left: 10px;">
                <LayoutTemplate>
                    <ul runat="server" id="itemPlaceHolder">
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li style="padding: 0px; list-style-type: none; float: left; margin-left: 20px">
                        <div class="sellfeatureitem">
                            <div>
                                <div>
                                    <asp:HyperLink runat="server" ID="imgFeaturedProperty" />
                                </div>
                                <div style="font-weight: bolder; font-size: 13px; height: 30px; line-height: normal;
                                    margin-top: 3px">
                                    <asp:Label ForeColor="#005A94" runat="server" ID="lblPropertyTypeArea"></asp:Label>
                                </div>
                                <div>
                                    <asp:Label runat="server" ID="lblPropertyPrice"></asp:Label>
                                </div>
                                <div>
                                    <asp:Label ID="lblTimeAdded" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
</asp:Content>
