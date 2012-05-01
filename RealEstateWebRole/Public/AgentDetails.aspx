<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    CodeBehind="AgentDetails.aspx.cs" Inherits="RealEstateWebRole.Public.AgentDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function ShowMap(lat, long, Mapid) {
            document.getElementById(Mapid).style.display = 'block'; document.getElementById('fade').style.display = 'block';
            var myLatLng = new google.maps.LatLng(lat, long); var myOptions = { zoom: 8, center: myLatLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById(Mapid),
    myOptions);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        <tr valign="top">
            <td>
                <div class="agentcontainer">
                    <div class="agentContact">
                        <div style="padding-left: 10px">
                            Contact Agent</div>
                    </div>
                    <div>
                        <asp:UpdatePanel runat="server" ID="updatePanel1">
                            <ContentTemplate>
                                <div style="padding-left: 10px">
                                    <asp:HiddenField ID="hdfAgentID" runat="server" />
                                    <asp:HiddenField ID="hdfUserID" runat="server" />
                                    <table>
                                        <tr>
                                            <td>
                                                Name*
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" Width="250px" class="textbox" ID="txtName"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Phone*
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" Width="250px" class="textbox" ID="txtPhone"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Email*
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" Width="250px" class="textbox" ID="txtEmail"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Message*
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" Width="250px" class="textbox" ID="txtMessage" Height="142px"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Button runat="server" ID="btnSubmit" Text="Send" />
                                            </td>
                                        </tr>
                                    </table>
                                    <div>
                                        <asp:Label runat="server" ID="lblResult"></asp:Label></div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </td>
            <td>
                <div class="searchResult">
                    <div class="search-within">
                    </div>
                    <div class="detailsrighttop">
                        <div style="padding-left: 30px; padding-top: 30px">
                            <div style="float: left; width: 100%">
                                <div style="float: left">
                                    <asp:Image runat="server" ID="Agentlogo" /></div>
                                <div style="float: left">
                                    <div style="float: left;">
                                        <div style="clear: both; margin-left: 20px; width: 250px">
                                            <div style="float: left; width: 150px">
                                                <asp:Label runat="server" ForeColor="Red" ID="lblAddressTitle"></asp:Label>
                                            </div>
                                            <div style="float: left">
                                                <asp:Label runat="server" ID="lblAddressAgent"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblStateProv"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblCity"></asp:Label>
                                            </div>
                                        </div>
                                        <div style="clear: both; margin-left: 20px; width: 250px">
                                            <div style="float: left; width: 150px">
                                                <asp:Label runat="server" ID="lblWorkPhoneTitle"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblCellPhoneTitle"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblFaxNumberTitle"></asp:Label>
                                            </div>
                                            <div style="float: left">
                                                <asp:Label runat="server" ID="lblWorkPhone"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblCellphone"></asp:Label><br />
                                                <asp:Label runat="server" ID="lblFaxNumber"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="clear: both">
                                    </div>
                                </div>
                            </div>
                            <div style="clear: both">
                                <span>Specialties:</span><br />
                                <ul runat="server" id="speciaties" style="list-style-type: none">
                                </ul>
                            </div>
                            <div style="clear: both">
                                <div id="listurls" runat="server">
                                </div>
                                <div class="description">
                                    <asp:Label runat="server" ID="lblBussinesss" ForeColor="Red" Text="Business Name"></asp:Label>
                                    <asp:Literal runat="server" ID="ltlTitle"></asp:Literal>
                                    <br />
                                    <asp:Label runat="server" ID="lblDescription"></asp:Label>
                                </div>
                                <ul style="list-style-type: none">
                                    <li>
                                        <asp:HyperLink runat="server" ID="hyperView"></asp:HyperLink>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <div style="padding-left: 20px">
                                    <h4>
                                        <asp:Literal runat="server" ID="ltlListing"></asp:Literal>
                                    </h4>
                                    <asp:ListView runat="server" ID="lstAgentListing" OnItemDataBound="lstAgentListing_OnDataBound">
                                        <LayoutTemplate>
                                            <ul runat="server" id="itemPlaceHolder" />
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <li style="list-style-type: none">
                                                <asp:HyperLink runat="server" ID="AgentListing"></asp:HyperLink>
                                            </li>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                                <div class="map">
                                    <iframe id="imap" runat="server" width="500px" height="450px" frameborder="0" scrolling="no">
                                    </iframe>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
