<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Admin.aspx.cs" Inherits="RealEstateWebRole.Account.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function SelectApproveCheck(value) {

            var clientids = value.split(';');
            for (var i = 1; i <= clientids.length - 1; i++) {
                if (document.getElementById(clientids[0]).checked == false) {
                    document.getElementById(clientids[i]).checked = true;
                } else if (document.getElementById(clientids[0]).checked == true) {

                    document.getElementById(clientids[i]).checked = false;
                }
            }
        }
        function SelectReportedCheck(value) {

            var clientids = value.split(';');
            for (var i = 1; i <= clientids.length - 1; i++) {
                if (document.getElementById(clientids[0]).checked == false) {
                    document.getElementById(clientids[i]).checked = true;
                } else if (document.getElementById(clientids[0]).checked == true) {

                    document.getElementById(clientids[i]).checked = false;
                }
            }
        }
        function SelectExpiredCheck(value) {

            var clientids = value.split(';');
            for (var i = 1; i <= clientids.length - 1; i++) {
                if (document.getElementById(clientids[0]).checked == false) {
                    document.getElementById(clientids[i]).checked = true;
                } else if (document.getElementById(clientids[0]).checked == true) {

                    document.getElementById(clientids[i]).checked = false;
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div>
            <asp:CheckBoxList runat="server" ID="filterlist" AutoPostBack="true" RepeatLayout="Flow"
                RepeatColumns="1" OnSelectedIndexChanged="Filterlist_SelectedIndexChanged">
                <asp:ListItem Text="Listing Status" Value="ListingStatus"></asp:ListItem>
                <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                <asp:ListItem Text="Expired" Value="Expired"></asp:ListItem>
                <asp:ListItem Text="Incomplete" Value="Incomplete"></asp:ListItem>
                <asp:ListItem Text="Reported" Value="Reported"></asp:ListItem>
                <asp:ListItem Text="Followed" Value="Followed"></asp:ListItem>
                <asp:ListItem Text="Approved" Value="Approved"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <div>
            <asp:DropDownList runat="server" ID="ddlSaleBuy" AutoPostBack="true" OnSelectedIndexChanged="SaleBuy_SelectedIndexChanged">
                <asp:ListItem Text="For Sale" Value="For Sale"></asp:ListItem>
                <asp:ListItem Text="For Rent" Value="For Rent"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div>
            <asp:Button runat="server" ID="btnSearch" Text="Search" OnClick="Search_Click" /></div>
    </div>
    <div>
    </div>
    <div>
    </div>
    <asp:GridView runat="server" ID="grdProperties" ShowFooter="true" DataKeyNames="PropertyID"
        AllowPaging="true" OnRowCommand="grdProperties_RowCommand" AutoGenerateColumns="false"
        OnRowDataBound="grdProperties_DataBound" OnSorting="grdProperties_Sorting" AllowSorting="true"
        OnPageIndexChanging="grdProperties_PageIndexChanging">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperSelect" runat="server" Text="Select"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:LinkButton runat="server" ID="linkSortName" Text="Names" CommandName="Sort" CommandArgument="Name"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblName"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField >
             <HeaderTemplate>
                    <asp:LinkButton runat="server" ID="linkSortEmail" Text="Email" CommandName="Sort" CommandArgument="Email"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblEmail"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField >
             <HeaderTemplate>
                    <asp:LinkButton runat="server" ID="linkSortCity" Text="City" CommandName="Sort" CommandArgument="City"></asp:LinkButton>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblCity"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Complete">

                <ItemTemplate>
                    <asp:Label runat="server" ID="lblIncomplete"></asp:Label></ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectApproveAllHeader" Text="Select All" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkApproved" Text="Approved" />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectApproveAll" Text="Select All" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectReportedAllHeader" Text="Select All" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkReported" Text="Reported" />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectReportedAll" Text="Select All" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectExpiredAllHeader" Text="Select All" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox runat="server" ID="chkExpired" Text="Expired" />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:CheckBox runat="server" ID="chkSelectExpiredAll" Text="Select All" />
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Button runat="server" ID="btnApplyAll" Text="Apply All" CommandName="ApplyAll" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Button runat="server" ID="btnApply" Text="Apply" CommandName="Apply" />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Button runat="server" ID="btnApplyAll" Text="Apply All" CommandName="ApplyAll" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
