<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AgentResults.aspx.cs" Inherits="RealEstateWebRole.Public.Agents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"> </script>
    <script src="../Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script type="text/javascript">
        function SubmitClientDetails(value) {

            var clientids = value.split(';');

            document.getElementById('lblPhoneNumber').innerText = clientids[0];
            document.getElementById('lblBusinessName').innerText = clientids[1];
            document.getElementById('lblAddress').innerText = clientids[2];
            document.getElementById('lblRoad').innerText = clientids[3];
            document.getElementById('lblSurburb').innerText = clientids[4];
            document.getElementById('lblCity').innerText = clientids[5];
            document.getElementById('lblProvince').innerText = clientids[6];
            document.getElementById('hdUserId').innerText = clientids[7];
            document.getElementById('hdAgentID').innerText = clientids[8];
            var imgLogo = document.getElementById('imgThumb');
            imgLogo.src = clientids[9];
            document.getElementById('divContact').style.display = 'block';
            document.getElementById('fade').style.display = 'block';

        }
        function SubmitClientPersonalDetails() {
            var valid = false;


            var email = document.getElementById('txtEmail').value;
            var name = document.getElementById('txtName').value;
            var comment = document.getElementById('txtMessage').value;
            var phone = document.getElementById('txtPhone').value;
            var estateAgntid = document.getElementById('hdAgentID').value;
            var userid = document.getElementById('hdUserId').value;
            var atpos = email.indexOf("@");
            var dotpos = email.lastIndexOf(".");
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {

            }
            if ((name != "") && (phone != "") && (email != "") && (comment != "")) {
                if (name != "")
                    document.getElementById('divyourname').style.display = 'none';
                if (phone != "")
                    document.getElementById('divPhone').style.display = 'none';
                if (email != "")
                    document.getElementById('divEmail').style.display = 'none';
                if (comment != "")
                    document.getElementById('divMessage').style.display = 'none';
                valid = true;
            }

            if (valid) {
                var Data = { "AgentID": estateAgntid, "UserId": userid, "Name": name, "Phone": phone, "Email": email, "Message": comment }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: '<%=ResolveUrl("~/WebServices/EmailAgent.svc/Result") %>',
                    processData: false,
                    dataType: "json",
                    data: '{"agentid":"' + estateAgntid + '","userid": "' + userid + '","name": "' + name + '","phone": "' + phone + '","email": "' + email + '","comment": "' + comment + '" }',
                    error: function (err) {
                        alert("Error:" + err.toString());
                    },
                    success: function (data) {
                        document.getElementById('content').innerText = data.d;
                    }
                });

            } else {

                if (name == "") {
                    document.getElementById('divyourname').style.display = 'block';
                } else {
                    document.getElementById('divyourname').style.display = 'none';
                }

                if (phone == "") {
                    document.getElementById('divPhone').style.display = 'block';
                } else {
                    document.getElementById('divPhone').style.display = 'none';
                }
                if (email == "") {
                    document.getElementById('divEmail').style.display = 'block';
                } else {
                    document.getElementById('divEmail').style.display = 'none';
                }
                if (comment == "") {
                    document.getElementById('divMessage').style.display = 'block';
                } else {
                    document.getElementById('divMessage').style.display = 'none';
                }
            }
        }
        function ShowMap(lat, long, Mapid) {

            document.getElementById(Mapid).style.display = 'block';
            document.getElementById('fade').style.display = 'block';
            var myLatLng = new google.maps.LatLng(lat, long);
            var myOptions = { zoom: 8, center: myLatLng, mapTypeId: google.maps.MapTypeId.ROADMAP };
            var map = new google.maps.Map(document.getElementById(Mapid), myOptions);


        }
        function Hide() {


            document.getElementById('divContact').style.display = 'none';
            document.getElementById('fade').style.display = 'none';
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="white_content" id="divContact">
        <div class="dialogTitle">
            <div class="sendContact">
                <div style="float: left;margin-right:10px">
                    Contact</div>
                <div style="float: left">
                    <img alt="savingicon" src="../images/ajax.gif" class="stylenone" /></div>
                <div style="float: left;color:Red" id="content">
                </div>
                <div style="float: right">
                    <asp:HyperLink runat="server" Text="Close" NavigateUrl="#" ID="hypHide"></asp:HyperLink></div>
            </div>
        </div>
        <div style="clear: both; padding: 10px">
            <div style="float: left">
                <table>
                    <tr>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="labeltext">Name*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="Name" class="textbox" id="txtName" type="text" />
                            <div id="divyourname" class="stylenone">
                                Name is required</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="labeltext">Phone*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="Phone" class="textbox" id="txtPhone" type="text" />
                            <div id="divPhone" class="stylenone">
                                Phone number is required</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="labeltext">Email*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="Email" class="textbox" id="txtEmail" type="text" />
                            <div id="divEmail" class="stylenone">
                                Email address is invalid</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span class="labeltext">Message*</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input name="Message" class="textbox" style="height: 100px" id="txtMessage" type="text" />
                            <div id="divMessage" class="stylenone">
                                Message is required</div>
                            <input name="UserID" id="hdUserId" type="hidden" />
                            <input name="AgentID" id="hdAgentID" type="hidden" />
                        </td>
                    </tr>
                </table>
            </div>
            <div style="float: left; margin-left: 15px">
                <div style="clear: both; margin-bottom: 20px; padding-top: 50px; height: 100px">
                    <div style="float: left; border: 2px solid #bbb">
                        <img alt="agent-logo" id="imgThumb" width="80px" height="50px" src="" /></div>
                    <div style="float: left; margin-left: 10px">
                        <div>
                            <span id="lblPhoneNumber"></span>
                            <br />
                            <span id="lblBusinessName"></span>&nbsp;&nbsp;<span id="lblAddress"><br />
                            </span>&nbsp;<span id="lblRoad"></span>&nbsp;&nbsp; <span id="lblSurburb"></span>
                            ,<br />
                            <span id="lblCity"></span>,&nbsp;&nbsp;<span id="lblProvince"></span>
                        </div>
                    </div>
                </div>
                <div style="clear: both; margin-top: 20px">
                    <asp:HyperLink runat="server" Text="Submit" ID="imgSendEmail" class="button" NavigateUrl="#08" /></div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel runat="server" ID="updatepanel1">
        <ContentTemplate>
            <div class="searchcontainer">
                <table>
                    <tr valign="top">
                        <td>
                            <div class="searchcriteria">
                                <div class="filtercontainer">
                                    <div class="filtertitle">
                                        Filter Results</div>
                                    <div class="agent_estate_title">
                                    </div>
                                    <div style="border-bottom: 1px solid #bbb;">
                                    </div>
                                    <div class="agent_selection">
                                        <asp:LinkButton runat="server" Font-Underline="false" ID="lnkAdvocates" CommandArgument="Advocates  Lawyers"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" Font-Underline="false" ID="lnkAlarmSystem" CommandArgument="Alarm System"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" Font-Underline="false" ID="lnkArchictecture" CommandArgument="Archictecture"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkBanks" Font-Underline="false" CommandArgument="Banks  Lenders"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkCarpentry" Font-Underline="false" CommandArgument="Carpentry"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkConsulting" Font-Underline="false" CommandArgument="Consulting"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkElectrical" Font-Underline="false" CommandArgument="Electrical"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkEngineering" Font-Underline="false" CommandArgument="Engineering"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkEstateSales" Font-Underline="false" CommandArgument="Buyers Agent;Sellers Agent"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkGarden" Font-Underline="false" CommandArgument="Garden  Lawn"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkGeneralContracting" Font-Underline="false"
                                            CommandArgument="General Contracting" OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkHomeBuilding" Font-Underline="false" CommandArgument="Home Building"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkInsurance" Font-Underline="false" CommandArgument="Insurance"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkInteriorDesign" Font-Underline="false" CommandArgument="Interior Design"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkLandscaping" Font-Underline="false" CommandArgument="Land scaping"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkLettingAgents" Font-Underline="false" CommandArgument="Letting Agent"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkMoving" Font-Underline="false" CommandArgument="Moving"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkPainting" Font-Underline="false" CommandArgument="Painting"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkPestControl" Font-Underline="false" CommandArgument="Pest Control"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkPlumbing" Font-Underline="false" CommandArgument="Plumbing"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkPropertyManagement" Font-Underline="false"
                                            CommandArgument="Property Management" OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkRelocation" Font-Underline="false" CommandArgument="Relocation"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                        <asp:LinkButton runat="server" ID="lnkStaging" Font-Underline="false" CommandArgument="Staging"
                                            OnClick="lnkAgent_Search"></asp:LinkButton><br />
                                    </div>
                                </div>
                                <div class="searchcriteria">
                                    <div class="filtercontainer">
                                        <div class="filtertitle">
                                            Featured Listing</div>
                                        <div style="height: 200px">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="searchResult">
                                <div class="search-within">
                                    <div style="padding: 10px">
                                        Results
                                        <asp:Label ID="Label1" runat="server" Visible="false" Text="Number of letting Agent"></asp:Label></div>
                                </div>
                                <div class="searchresultright">
                                    <div style="font-size: 11px; margin-left: 20px; margin-right: 20px; margin-bottom: 10px;
                                        margin-top: 10px">
                                        <asp:DataPager runat="server" ID="BeforeListDataPager" PagedControlID="ltVEstateAgents"
                                            PageSize="10">
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
                                    <div style="clear: both; float: left; width: 651px; height: 1px; margin-left: 9px;
                                        border-bottom: 1px solid #D9D9D9">
                                    </div>
                                </div>
                                <div class="detailsrighttop">
                                    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="updatepanel1" runat="server">
                                        <ProgressTemplate>
                                            <div class="updatepanel">
                                                <img src="../images/ajax-loader.gif" alt="" /><b style="color:Red">An update is in progress...</b></div>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div style="margin-left: 20px">
                                        <asp:ListView runat="server" ID="ltVEstateAgents" OnPagePropertiesChanged="ltVEstateAgents_PagePropertiesChanged"
                                            OnItemDataBound="EstateAgents_OnItemDataBound">
                                            <LayoutTemplate>
                                                <div runat="server" id="ItemPlaceHolder">
                                                </div>
                                            </LayoutTemplate>
                                            <EmptyDataTemplate>
                                                <table class="emptyTable" cellpadding="5" cellspacing="5">
                                                    <tr>
                                                        <td>
                                                            No records available.
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyDataTemplate>
                                            <EmptyItemTemplate>
                                                <table class="emptyTable" cellpadding="5" cellspacing="5">
                                                    <tr>
                                                        <td>
                                                            No records available.
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EmptyItemTemplate>
                                            <ItemTemplate>
                                                <div class="resultAgentItem">
                                                    <div>
                                                        <div style="margin-right: 20px; margin-left: 15px; float: left">
                                                            <asp:HyperLink runat="server" ID="EstateLogo" />
                                                        </div>
                                                        <div style="float: left">
                                                            <div style="height: 100px">
                                                                <div style="clear: both">
                                                                    <asp:Label runat="server" ForeColor="#39ACE6" Font-Bold="true" Font-Size="1.5em"
                                                                        ID="lblAgentName"></asp:Label></div>
                                                                <div>
                                                                    <asp:Label ForeColor="#39ACE6" Font-Size="1.5em" Font-Bold="true" runat="server"
                                                                        ID="lblAgentCity"></asp:Label>&nbsp;,<asp:Label runat="server" ID="lblAgentProvince"></asp:Label>
                                                                </div>
                                                                <div>
                                                                    <asp:Label runat="server" ID="lblAgentBusinessPhone"></asp:Label></div>
                                                                <div style="color: #666666; font-size: 0.9em;">
                                                                    <asp:Label runat="server" ID="lblAgentAddress"></asp:Label>&nbsp;,<asp:Label runat="server"
                                                                        ID="lblAgentSuburb"></asp:Label>&nbsp;,<asp:Label runat="server" ID="lblAgentPostalCode"></asp:Label></div>
                                                                <br />
                                                            </div>
                                                            <div style="clear: both">
                                                                <div style="float: left; width: 150px">
                                                                    <%-- <asp:HyperLink runat="server" ID="showMiniMap" Text="Map" NavigateUrl="#"></asp:HyperLink>--%>
                                                                </div>
                                                                <div style="float: left; width: 150px">
                                                                    <asp:HyperLink runat="server" ID="ShowContact" Text="Contact Agent" NavigateUrl="#"></asp:HyperLink>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div style="color: #39ACE6; clear: both">
                                                        Specialties
                                                    </div>
                                                    <div runat="server" id="ulSpeciaties">
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </div>
                                </div>
                                <div class="searchresultright">
                                    <div style="font-size: 11px; margin: 20px;">
                                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ltVEstateAgents" PageSize="10">
                                            <Fields>
                                                <asp:TemplatePagerField>
                                                    <PagerTemplate>
                                                        <div style="width: 555px; float: left; margin-left: 0px">
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
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="BeforeListDataPager" />
            <asp:AsyncPostBackTrigger ControlID="DataPager1" />
        </Triggers>
    </asp:UpdatePanel>
    <div id="fade" class="black_overlay">
    </div>
</asp:Content>
