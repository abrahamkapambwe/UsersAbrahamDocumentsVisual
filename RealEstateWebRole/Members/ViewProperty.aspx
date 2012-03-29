<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="ViewProperty.aspx.cs" Inherits="RealEstateWebRole.Account.ViewProperty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="updatePanel2">
        <ContentTemplate>
            <table>
                <tr valign="top">
                    <td>
                        <div id="FilterAvailableListing" style="width: 280px; height: 400px; border: 1px solid #bbb;
                            margin-right: 10px">
                            <div style="padding: 15px">
                                <div style="font-size: 15px">
                                    Property filter options</div>
                                <br />
                                <asp:CheckBoxList runat="server" ID="filterlist" CellPadding="10" AutoPostBack="true"
                                    RepeatLayout="Flow" RepeatColumns="1" TextAlign="Right" OnSelectedIndexChanged="Filterlist_SelectedIndexChanged">
                                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                    <asp:ListItem Text="Expired" Value="Expired"></asp:ListItem>
                                    <asp:ListItem Text="Incomplete" Value="Incomplete"></asp:ListItem>
                                    <asp:ListItem Text="Reported" Value="Reported"></asp:ListItem>
                                    <asp:ListItem Text="Followed" Value="Followed"></asp:ListItem>
                                    <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                    </td>
                    <td width="100%">
                        <div class="paging_top">
                            <div style="border-top: 1px solid #bbb" class="inner_paging_top">
                                <asp:DataPager runat="server" ID="BeforeListDataPager" PagedControlID="lstPropertyView"
                                    PageSize="2">
                                    <Fields>
                                        <asp:TemplatePagerField>
                                            <PagerTemplate>
                                                <div style="width: 550px; float: left;">
                                                    Page
                                                    <asp:Label ID="CurrentPageLabel" runat="server" Text="<%# Container.TotalRowCount>0 ? (Container.StartRowIndex / Container.PageSize) + 1 : 0 %>" />
                                                    of
                                                    <asp:Label ID="TotalPagesLabel" runat="server" Text="<%# Math.Ceiling ((double)Container.TotalRowCount / Container.PageSize) %>" />
                                                    (
                                                    <asp:Label ID="TotalItemsLabel" runat="server" Text="<%# Container.TotalRowCount%>" />
                                                    records)</div>
                                            </PagerTemplate>
                                        </asp:TemplatePagerField>
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="true" ShowNextPageButton="false"
                                            ShowPreviousPageButton="false" />
                                        <asp:NumericPagerField ButtonCount="10" />
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="true" ShowNextPageButton="false"
                                            ShowPreviousPageButton="false" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </div>
                        <div style="border-left: 1px solid #bbb; border-right: 1px solid #bbb; height: 300px;
                            width: 100%">
                            <asp:ListView runat="server" ID="lstPropertyView" OnPagePropertiesChanged="lstPropertyView_PagePropertiesChanged"
                                OnItemDataBound="lstPropertyView_OnItemDataBound">
                                <LayoutTemplate>
                                    <div runat="server" id="itemPlaceHolder">
                                    </div>
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div id="alternateCss" runat="server">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:HyperLink runat="server" ID="hyperImage"></asp:HyperLink>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                Status
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblStatus"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Activated
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblActivated"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                Expired date
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblExpiredDate"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                View in the last
                                                                <asp:Label runat="server" ID="lblNumberofDaysView"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label runat="server" ID="lblNumberOfViews"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:HyperLink runat="server" ID="hyperPreview" Text="Preview"></asp:HyperLink>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton runat="server" ID="imagePreview" ImageUrl="~/Images/DeleteIcon.gif">
                                                                </asp:ImageButton><asp:LinkButton runat="server" OnClick="Delete_Click" ID="linkPreview"
                                                                    Text="Delete Listing"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    Your dont have any listing.To add the listing please click <a href="UploadPictures.aspx?listStatus=new">
                                        here</a>
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </div>
                        <div class="paging_bottom">
                            <div class="inner_paging_bottom">
                                <asp:DataPager runat="server" ID="DataPager1" PagedControlID="lstPropertyView" PageSize="2">
                                    <Fields>
                                        <asp:TemplatePagerField>
                                            <PagerTemplate>
                                                <div style="width: 550px; float: left; margin-left: 0px">
                                                    Page
                                                    <asp:Label ID="CurrentPageLabel" runat="server" Text="<%# Container.TotalRowCount>0 ? (Container.StartRowIndex / Container.PageSize) + 1 : 0 %>" />
                                                    of
                                                    <asp:Label ID="TotalPagesLabel" runat="server" Text="<%# Math.Ceiling ((double)Container.TotalRowCount / Container.PageSize) %>" />
                                                    (
                                                    <asp:Label ID="TotalItemsLabel" runat="server" Text="<%# Container.TotalRowCount%>" />
                                                    records)
                                                </div>
                                            </PagerTemplate>
                                        </asp:TemplatePagerField>
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowFirstPageButton="true" ShowNextPageButton="false"
                                            ShowPreviousPageButton="false" />
                                        <asp:NumericPagerField ButtonCount="10" />
                                        <asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="true" ShowNextPageButton="false"
                                            ShowPreviousPageButton="false" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
