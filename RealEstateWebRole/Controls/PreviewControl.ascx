<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PreviewControl.ascx.cs"
    Inherits="RealEstateWebRole.Controls.PreviewControl" %>
<div class="preview">
    <div>
        <div class="preview_top">
            <div class="preview_top_left">
                <div class="preview_content">
                    <h3>
                        Property Address</h3>
                    <div style="padding: 10px">
                        <asp:Label runat="server" ID="lblAddress"></asp:Label><br />
                        <asp:Label ID="lblPrice" runat="server"></asp:Label></div>
                </div>
            </div>
            <div class="preview_top_right">
                <div class="preview_content">
                    <asp:HyperLink ID="hypEdit" Text="Edit" runat="server"></asp:HyperLink></div>
            </div>
        </div>
        <div style="height: 20px; clear: both">
        </div>
        <div class="preview_bottom">
            <div class="preview_content">
                <h3>
                    Property Images</h3>
                <br />
                <asp:Image runat="server" ID="imgPicture" />
                <asp:ListView runat="server" ID="listviewDetails" OnItemDataBound="listview_ItemDataBound">
                    <LayoutTemplate>
                        <ul runat="server" id="itemPlaceHolder">
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <li style="padding: 0; margin: 10px; list-style-type: none">
                            <div id="divPreviewImages" runat="server">
                            </div>
                            <asp:Image runat="server" ID="ImageLink" CssClass="DetailsImageContainer"></asp:Image>
                        </li>
                    </ItemTemplate>
                </asp:ListView>
            </div>
            <div class="preview_content">
                <h3>
                    Property Details</h3>
                <br />
                <div>
                    <div style="float: left; margin-right: 20px">
                        <ul class="preview_features" runat="server" id="RightlistItem">
                        </ul>
                    </div>
                    <div style="float: left">
                        <ul class="preview_features" runat="server" id="LeftlistItem">
                        </ul>
                    </div>
                </div>
            </div>
            <div class="preview_content">
                <h3>
                    Property Description</h3>
                <br />
                <div style="padding: 10px">
                    <asp:Label runat="server" ID="lblPropertyDescription"></asp:Label></div>
            </div>
            <div class="preview_content">
                <iframe id="Map" runat="server" width="650px" height="450px" frameborder="0" scrolling="no">
                </iframe>
            </div>
            <div class="preview_content">
                <asp:Panel runat="server" ID="pnlPointInterest">
                </asp:Panel>
            </div>
        </div>
    </div>
</div>
