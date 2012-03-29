<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="RealEstateWebRole.Public.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="space">
    </div>
    <div class="space">
    </div>
    <div class="space">
    </div>
    <div class="main_a">
        <div class="mapSearch">
            <table>
                <tr>
                    <td>
                        map
                    </td>
                    <td>
                        cities
                    </td>
                </tr>
            </table>
        </div>
        <div class="latestProperty">
            <div>
                <asp:Label runat="server" Text="Latest Property for Sale"></asp:Label>
            </div>
            <div>
            </div>
        </div>
        <%--<div class="default_content">
                    <div class="default_content_a">
                        <img src="../images/bg_atext.png" alt="" title="" />
                    </div>
                    <div class="default_content_b">
                        <img src="../images/bg_btext.png" alt="" title="" />
                    </div>
                    <div class="default_content_c">
                        <img src="../images/bg_ctext.png" alt="" title="" />
                    </div>
                    <div class="clear"></div>
                    <div class="space"></div>
                    <div class="space"></div>
                    <div class="default_content_d">
                        <img src="../images/bg_dtext.png" alt="" title="" />
                    </div>
                    <div class="default_content_e">
                        <img src="../images/bg_etext.png" alt="" title="" />
                    </div>
                    <div class="default_content_f">
                        <img src="../images/bg_ftext.png" alt="" title="" />
                    </div>--%>
        <div class="clear">
        </div>
    </div>
    <div class="space">
    </div>
    <div class="space">
    </div>
</asp:Content>
