<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchResult.aspx.cs" Async="true"
    Inherits="RealEstateWebRole.SearchResult" MasterPageFile="~/Real.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ MasterType VirtualPath="~/Real.Master" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"> </script>
    <script type="text/javascript">
        function SubmitClientDetails(value) {
            var clientids = value.split(';');

            document.getElementById('lblPriceDialog').innerText = "R " + clientids[0];
            document.getElementById('UnitNumberDialog').innerText = clientids[1];
            document.getElementById('lblRoadDialog').innerText = clientids[2];
            document.getElementById('lblSurburbDialog').innerText = clientids[3];
            document.getElementById('lblCityDialog').innerText = clientids[4];
            document.getElementById('lblState').innerText = clientids[5];
            document.getElementById('lblPropertyType').innerText = clientids[7];
            document.getElementById('lblAgentBusiness').innerText = clientids[11];
            document.getElementById('lblAgentPhoneNumber').innerText = clientids[12];
            document.getElementById('lblAgentRoad').innerText = clientids[13];
            document.getElementById('lblAgentSurburb').innerText = clientids[14];
            document.getElementById('lblAgentCity').innerText = clientids[15];
            document.getElementById('lblAgentPostalCode').innerText = clientids[16];
            document.getElementById('lblAgentState').innerText = clientids[17];
            
            document.getElementById('hdnPropertyId').value = clientids[8];
            document.getElementById('hdnUserId').value = clientids[9];
            var imgProperty = document.getElementById('imgPropertyThumb');
            imgProperty.src = clientids[6];

            var agentimageurl = clientids[10];
            var imgAgentThumb = document.getElementById('imgAgentThumb');
            if (agentimageurl != "") {
                imgAgentThumb.src = agentimageurl;
            } else {
                imgAgentThumb.style.display = 'none';
            }
            document.getElementById('divContact').style.display = 'block';
            document.getElementById('fade').style.display = 'block';

        }

        function SubmitClientPersonalDetails() {
            var valid = false;



            var name = document.getElementById("txtFirstName").value;
            var phone = document.getElementById("txtPhone").value;
            var email = document.getElementById("txtEmail").value;
            var comment = document.getElementById("txtMessage").value;
            var propertyid = document.getElementById("hdnPropertyId").value;
            var userid = document.getElementById("hdnUserId").value;
            var atpos = email.indexOf("@");
            var dotpos = email.lastIndexOf(".");

            if ((name != "") && (phone != "") && (email != "") && (comment != "")) {

                valid = true;
            }
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                document.getElementById('divEmailRequired').style.display = 'block';
                valid = false;
            } else {

                document.getElementById('divEmailRequired').style.display = 'none';
            }



            if (valid) {
                var Data = { "propertyid": propertyid, "Userid": userid, "Name": name, "Phone": phone, "Email": email, "Message": comment }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: '<%=ResolveUrl("~/WebServices/EmailAgent.svc/Result") %>',
                    processData: false,
                    dataType: "json",
                    data: '{"propertyid":"' + propertyid + '","userid": "' + userid + '","name": "' + name + '","phone": "' + phone + '","email": "' + email + '","comment": "' + comment + '" }',
                    error: function (err) {
                        alert("Error:" + err.toString());
                    },
                    success: function (data) {
                        document.getElementById('divcontent').innerText = data.d;
                        //$(clientids[11]).innerText(data.d);
                    }
                });
            } else {
                if (name == "") {
                    document.getElementById('divName').style.display = 'block';
                } else {
                    document.getElementById('divName').style.display = 'none';
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
        function SubmitFavourite(ids) {
            var clientids = ids.split(';');
            var propid = clientids[0];
            var userid = clientids[1];
          
        document.getElementById("fouriteNumber").i
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '<%=ResolveUrl("~/WebServices/EmailAgent.svc/Favourite") %>',
                processData: false,
                dataType: "json",
                data: '{"propertyid":"' + propid + '","userid": "' + userid +'" }',
                error: function (err) {
                    alert("Error:" + err.toString());
                },
                success: function (data) {
                    document.getElementById('divcontent').innerText = data.d;
                    //$(clientids[11]).innerText(data.d);
                }
            });

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
            document.getElementById('divPhone').style.display = 'none';
            document.getElementById('divEmail').style.display = 'none';
            document.getElementById('divMessage').style.display = 'none';
            document.getElementById('divEmailRequired').style.display = 'none';
            document.getElementById('fade').style.display = 'none';
        }


    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="white_content" id="divContact">
        <div>
            <div class="dialogTitle">
                <div class="sendContact">
                    <div style="float: left">
                        Contact Us</div>
                    <div style="float: left">
                        <img alt="savingicon" src="../images/ajax.gif" class="stylenone" /></div>
                    <div style="float: left" id="content">
                    </div>
                    <div style="float: right">
                        <asp:HyperLink runat="server" Text="Hide" NavigateUrl="#" ID="Hidecontent"></asp:HyperLink></div>
                </div>
            </div>
            <div style="clear: both; padding: 10px">
                <div style="float: left">
                    <table>
                        <tr>
                            <td>
                                I saw your listing on your site
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="labeltext">Name*</span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="FirstName" class="textbox" id="txtFirstName" />
                                <div id="divName" class="stylenone">
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
                                <input type="text" name="Phone" class="textbox" id="txtPhone" />
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
                                <input type="text" class="textbox" name="Email" id="txtEmail" />
                                <div id="divEmail" class="stylenone">
                                    Email address is required
                                </div>
                                <div id="divEmailRequired" class="stylenone">
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
                                <input type="text" name="Message" class="textbox" id="txtMessage" style="height: 100px"
                                    maxlength="250"   />
                                <div id="divMessage" class="stylenone">
                                    Message is required</div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="float: left; margin-left: 15px; margin-top: 28px">
                    <div>
                        <div style="margin-bottom: 20px; padding-top:10px; height: 100px">
                            <div style="float: left;border:2px solid #bbb">
                                <img id="imgPropertyThumb" width="80px" height="50px" alt="property-image" src="" /></div>
                            <div style="float: left; margin-left: 15px">
                                <span style="color:#39ACE6" id="lblPriceDialog"></span>&nbsp;<span style="color:#39ACE6" id="lblPropertyType"></span>
                                <br />
                                <span id="UnitNumberDialog"></span>&nbsp;<span id="lblRoadDialog"></span>&nbsp;&nbsp;
                                <span id="lblSurburbDialog"></span>,<br />
                                <span id="lblCityDialog"></span>,<br />
                                <span id="lblState"></span>&nbsp;<span id="lblZipCodeDialog"></span>
                                <input type="hidden" name="propertyid" id="hdnPropertyId" />
                                <input type="hidden" name="userid" id="hdnUserId" /></div>
                        </div>
                        <div style="clear: both;height: 100px">
                            <div style="float: left;border:2px solid #bbb">
                                <img id="imgAgentThumb" src="" width="80px" height="50px" alt="Agent-logo" /></div>
                            <div style="float: left;; margin-left: 15px">
                                <span id="lblAgentBusiness"></span>
                                <br />
                                <span id="lblAgentPhoneNumber"></span>
                                <br />
                                <span id="lblAgentRoad">
                                    <br />
                                </span><span id="lblAgentSurburb"></span>,<span id="lblAgentCity"></span>
                                <br />
                                <span id="lblAgentState"></span>,<span id="lblAgentPostalCode"></span></div>
                        </div>
                        <div style="clear:both;margin-top: 20px">
                            <asp:HyperLink ID="hyperSendEmail" NavigateUrl="#5" runat="server" Text="Submit" class="button" ></asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="searchcontainer">
        <table>
            <tr valign="top">
                <td>
                    <div id="searchcriteria">
                        <div class="filtercontainer">
                            <div class="filtertitle">
                                Price Range</div>
                            <div class="dropdown">
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlMinimum" CssClass="dropdowns">
                                    </asp:DropDownList>
                                </div>
                                <div class="dropstext">
                                    <span>to</span>
                                </div>
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlMaximum" CssClass="dropdowns">
                                    </asp:DropDownList>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                            <div class="space">
                            </div>
                            <div class="space">
                            </div>
                            <div class="filtertitle">
                                Bedrooms</div>
                            <div class="dropdown">
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlBedroomsMinimum" CssClass="dropdowns">
                                        <asp:ListItem Text="No Minimum" Value="0" />
                                        <asp:ListItem Text="1 Bedroom" Value="1" />
                                        <asp:ListItem Text="2 Bedrooms" Value="2" />
                                        <asp:ListItem Text="3 Bedrooms" Value="3" />
                                        <asp:ListItem Text="4 Bedrooms" Value="4" />
                                        <asp:ListItem Text="5 Bedrooms" Value="5" />
                                        <asp:ListItem Text="6 Bedrooms" Value="6" />
                                    </asp:DropDownList>
                                </div>
                                <div class="dropstext">
                                    <span>to</span>
                                </div>
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlBedroomsMaximum" CssClass="dropdowns">
                                        <asp:ListItem Text="No Maximum" Value="0" />
                                        <asp:ListItem Text="1 Bedroom" Value="1" />
                                        <asp:ListItem Text="2 Bedrooms" Value="2" />
                                        <asp:ListItem Text="3 Bedrooms" Value="3" />
                                        <asp:ListItem Text="4 Bedrooms" Value="4" />
                                        <asp:ListItem Text="5 Bedrooms" Value="5" />
                                        <asp:ListItem Text="6 Bedrooms" Value="6" />
                                    </asp:DropDownList>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                            <div class="space">
                            </div>
                            <div class="space">
                            </div>
                            <div class="filtertitle">
                                Bathrooms</div>
                            <div class="dropdown">
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlBathroomsMinimum" CssClass="dropdowns">
                                        <asp:ListItem Text="0" Value="0" />
                                        <asp:ListItem Text="1 " Value="1" />
                                        <asp:ListItem Text="2 " Value="2" />
                                        <asp:ListItem Text="3 " Value="3" />
                                        <asp:ListItem Text="4 " Value="4" />
                                        <asp:ListItem Text="5 " Value="5" />
                                        <asp:ListItem Text="6 " Value="6" />
                                    </asp:DropDownList>
                                </div>
                                <div class="dropstext">
                                    <span>to</span>
                                </div>
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlBathroomsMaximum" CssClass="dropdowns">
                                        <asp:ListItem Text="No Maximum" Value="0" />
                                        <asp:ListItem Text="1 " Value="1" />
                                        <asp:ListItem Text="2 " Value="2" />
                                        <asp:ListItem Text="3 " Value="3" />
                                        <asp:ListItem Text="4 " Value="4" />
                                        <asp:ListItem Text="5 " Value="5" />
                                        <asp:ListItem Text="6 " Value="6" />
                                    </asp:DropDownList>
                                </div>
                                <div class="clear">
                                </div>
                            </div>
                            <div class="space">
                            </div>
                            <div class="space">
                            </div>
                            <div class="filtertitle">
                                Property Type</div>
                            <div class="dropdownx">
                                <div class="drops">
                                    <asp:DropDownList runat="server" ID="ddlPropertyType" CssClass="dropdownslong">
                                        <asp:ListItem Text="Apartment" Value="Apartment"></asp:ListItem>
                                        <asp:ListItem Text="Duplex" Value="Duplex"></asp:ListItem>
                                        <asp:ListItem Text="House" Value="House"></asp:ListItem>
                                        <asp:ListItem Text="Cluster" Value="Cluster"></asp:ListItem>
                                        <asp:ListItem Text="Simplex" Value="Simplex"></asp:ListItem>
                                        <asp:ListItem Text="Garden Cottage" Value="Garden Cottage"></asp:ListItem>
                                        <asp:ListItem Text="Farm" Value="Farm"></asp:ListItem>
                                        <asp:ListItem Text="Business Houses" Value="Business Houses"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="clear">
                                </div>
                                <div class="space">
                                </div>
                                <div class="space">
                                </div>
                                <div style="height: 20px">
                                </div>
                                <asp:Button runat="server" ID="btnSubmit" Text="Filter" OnClick="Filter_Click" Width="195px"
                                    Height="25px" BackColor="#FF0000" ForeColor="#ffffff" BorderWidth="0px" CssClass="filterbutton" />
                                <div class="space">
                                </div>
                                <div class="space">
                                </div>
                                <div class="space">
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="searchResult">
                        <div class="search-within">
                            <div style="margin-left: 20px; margin-bottom: 10px; margin-top: 10px;">
                                <asp:Label runat="server" ID="lblNumberwithinCity" Font-Size="13px" ForeColor="#666"></asp:Label><br />
                            </div>
                        </div>
                        <div class="searchresultright">
                            <div style="float: right; color: #666; margin-right: 20px; margin-bottom: 10px; margin-top: 10px;">
                                <span style="margin-right: 6px">Sort by:</span><asp:DropDownList runat="server" ID="ddlSort"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged">
                                    <asp:ListItem Text="Price-High to Low" Value="High to Low"></asp:ListItem>
                                    <asp:ListItem Text="Price-Low to High" Value="Low to High"></asp:ListItem>
                                    <asp:ListItem Text="Newest First" Value="Newest First"></asp:ListItem>
                                    <asp:ListItem Text="Oldest First" Value="Oldest First"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div style="clear: both; width: 651px; margin-left: 9px; border-bottom: 1px solid #D9D9D9">
                            </div>
                        </div>
                        <asp:UpdatePanel runat="server" ID="updatepanel1">
                            <ContentTemplate>
                                <div class="searchresultright">
                                    <div style="font-size: 11px; margin-left: 20px; margin-right: 20px; margin-bottom: 10px;
                                        margin-top: 10px">
                                        <asp:DataPager runat="server" ID="BeforeListDataPager" PagedControlID="ltvResult"
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
                                    <div style="clear: both; float: left; width: 651px; height: 1px; margin-left: 9px;
                                        border-bottom: 1px solid #D9D9D9">
                                    </div>
                                </div>
                                <div class="detailsrighttop">
                                    <asp:ListView ID="ltvResult" runat="server" OnPagePropertiesChanged="ltvResult_PagePropertiesChanged"
                                        OnItemDataBound="ltvResult_itemDataBound">
                                        <LayoutTemplate>
                                            <div runat="server" id="ItemPlaceHolder" />
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <div class="resultItem">
                                                <table>
                                                    <tr>
                                                        <td valign="top">
                                                            <div>
                                                                <asp:HyperLink runat="server" ID="HypPropetyImages"></asp:HyperLink>
                                                            </div>
                                                            <div style="padding-top: 20px; padding-left: 20px; background-image: url('http://127.0.0.1:81/Public/images/results-epropertysearch-bg.png')">
                                                                <asp:Label runat="server" ID="lblNumberOfImages" ForeColor="#333"></asp:Label></div>
                                                        </td>
                                                        <td>
                                                            <div style="margin-left: 40px;">
                                                                <span>
                                                                    <asp:Label runat="server" ID="lblPrice" Font-Size="Large" Font-Bold="true" ForeColor="#39ACE6"></asp:Label></span>
                                                                ,<br>
                                                                <div>
                                                                    <div>
                                                                        <asp:Label runat="server" ID="lblStreet" Font-Size="Large" ForeColor="#333"></asp:Label>,<br />
                                                                        <asp:Label runat="server" ID="lblSuburb" Font-Size="Large" ForeColor="#5d5d5d"></asp:Label>,<br />
                                                                        <div style="color: #666; font-size: 12px; font-family: Verdana">
                                                                            Kew Bridge Court comprises ninety four self contained residential units within five
                                                                            low built blocks set over ground to second or third floors; there are twelve one
                                                                            bedroom flats, seventy four two bedroom flats and eight three bedroom flats. All
                                                                            of the apartments have...
                                                                            <asp:Label runat="server" ID="lblDescription"></asp:Label></div>
                                                                    </div>
                                                                    <div style="float: left; margin-left: 50px; display: block; height: 20px; width: auto;">
                                                                        <asp:HyperLink runat="server" ID="btnReadmore" Text="Read More" ForeColor="#333" />
                                                                    </div>
                                                                    <div style="float: left; margin-left: 50px; margin-right: 50px">
                                                                        <asp:HyperLink runat="server" ID="btnfavorite" NavigateUrl="#" Text="Favourite" ForeColor="#333" />
                                                                    </div>
                                                                    <div style="float: left;">
                                                                        <asp:HyperLink runat="server" ID="btnContactAgent"  NavigateUrl="#" Text="Contact Agent"
                                                                            ForeColor="#333" /></div>
                                                                </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <table class="emptyTable" cellpadding="5" cellspacing="5">
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="NoDataImage" ImageUrl="~/Images/NoDataImage.jpg" runat="server" />
                                                    </td>
                                                    <td>
                                                        No records available.
                                                    </td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </div>
                                <div class="searchresultright">
                                    <div style="font-size: 11px; margin: 20px;">
                                        <asp:DataPager runat="server" ID="DataPager1" PagedControlID="ltvResult" PageSize="2">
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
                                <div class="searchbottom">
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="fade" class="black_overlay">
    </div>
</asp:Content>
