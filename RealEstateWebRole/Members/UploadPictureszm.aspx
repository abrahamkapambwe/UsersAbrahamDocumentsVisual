<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadPictureszm.aspx.cs"
    Inherits="RealEstateWebRole.Account.UploadPictureszm" MasterPageFile="~/Site.Master"
    Async="true" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../Controls/Payments.ascx" TagName="Payments" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="http://ecn.dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=7.0"></script>
    <script type="text/javascript">
        function LoadingThePaymentvalues(value) {
            var paymentsValues = value.split(';');

            document.getElementById("hdffirstname").value = paymentsValues[0];
            document.getElementById("hdflastname").value = paymentsValues[1];
            document.getElementById("hdfaddress").value = paymentsValues[2];
            document.getElementById("hdfphone_number").value = paymentsValues[3];
            document.getElementById("hdfpostal_code").value = paymentsValues[4];
            document.getElementById("hdfcity").value = paymentsValues[5];
            document.getElementById("hdfstate").value = paymentsValues[6];
            document.getElementById("hdfcountry").value = paymentsValues[7];
            document.getElementById("hdfamount").value = paymentsValues[8];

            document.getElementById("hdfcurrency").value = paymentsValues[9];
            document.getElementById("hdfamount2_description").value = paymentsValues[9];


        }
        function Post() {
            document.forms[0].action = "https://www.moneybookers.com/app/payment.pl";
            document.forms[0].target = "_blank";
        }
        var map = null;
        var credentials = null;

        function getMap() {
            var lat = document.getElementById('<%=hdfLatitude.ClientID%>').value;
            var lng = document.getElementById('<%=hdfLongitude.ClientID%>').value;


            map = new Microsoft.Maps.Map(document.getElementById('myMap'), { credentials: 'AulBVPBIF6tuge2iCxtecpoZHYPv1R6cStgh6VV9_v0brVDsagIKqDttEuOmX_Q0', center: new Microsoft.Maps.Location(lat, lng), zoom: 12 });

            addDefaultPushpin(lat, lng);
            var click = Microsoft.Maps.Events.addHandler(map, 'click', displayInfo);

        }
        function addDefaultPushpin(lat, lng) {
            latitude = lat;
            longitude = lng;
            var pushpin = new Microsoft.Maps.Pushpin(new Microsoft.Maps.Location(latitude, longitude), null);
            map.entities.push(pushpin);
        }
        function displayInfo(e) {

            if (e.targetType == "map") {
                var point = new Microsoft.Maps.Point(e.getX(), e.getY());
                var loc = e.target.tryPixelToLocation(point);
                map.entities.clear();
                addDefaultPushpin(loc.latitude, loc.longitude);
                document.getElementById('<%=hdfLatitude.ClientID%>').value = loc.latitude;
                document.getElementById('<%=hdfLongitude.ClientID%>').value = loc.longitude;

            }




        }
            

    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="updatepanel1">
        <ContentTemplate>
            <table>
                <tr valign="top">
                    <td>
                        <div style="width: 300px; height: 350px; border: 1px solid #bbb; margin-right: 15px">
                            <div style="padding: 20px">
                                <table>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divContactInfo" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkbContactInformation" Text="Contact Information"
                                                    CommandArgument="Contact" OnClick="Status_Click"></asp:LinkButton></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divPropertyLoc" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkblocation" Text="Property Location" CommandArgument="location"
                                                    OnClick="Status_Click"></asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divPropertyDetails" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkbdetails" Text="Property Details" CommandArgument="details"
                                                    OnClick="Status_Click"></asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divUploadImages" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkbimages" Text="Uploaded Property Images" CommandArgument="images"
                                                    OnClick="Status_Click"></asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divPreview" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkbpreview" Text="Completed" CommandArgument="preview"
                                                    OnClick="Status_Click"></asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div runat="server" id="divCompleted" visible="false" style="height: 15px; margin-bottom: 10px">
                                                <span style="width: 60px; margin-right: 10px; text-decoration: none"></span>
                                                <asp:LinkButton runat="server" ID="lkbcompleted" Text="Completed" CommandArgument="completed"
                                                    OnClick="Status_Click"></asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <div style="font-size: 0.7em; color: HighlightText">
                                    To edit the information you have already completed, follow the links above. Please
                                    note: you are only able to complete your listing after you have previewed & confirmed
                                    the information is correct.
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <div>
                                <div style="padding-left: 20px">
                                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                        <ProgressTemplate>
                                            <img src="../images/ajax-loader.gif" alt="" />An update is in progress...
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </div>
                                <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="VwContactInformation" runat="server">
                                        <div class="viewItem">
                                            <div>
                                                Contact Information</div>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">First name</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtFirstname"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Last name</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtLastname"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Cell Phone</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtCellPhone" MaxLength="11"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" Text="*"
                                                            ValidationGroup="form" ControlToValidate="txtCellPhone" ValidationExpression="\d{11}"
                                                            ToolTip="Code Requires 11 Numeric Values" ErrorMessage="<br/>Code Requires 11 Numeric Values"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Home Phone</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtHomePhone" MaxLength="11"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Text="*"
                                                            ValidationGroup="form" ControlToValidate="txtHomePhone" ValidationExpression="\d{11}"
                                                            ToolTip="Code Requires 11 Numeric Values" ErrorMessage="<br/>Code Requires 11 Numeric Values"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Work Phone</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtWorkPhone" MaxLength="11"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" Text="*"
                                                            ValidationGroup="form" ControlToValidate="txtWorkPhone" ValidationExpression="\d{11}"
                                                            ToolTip="Code Requires 11 Numeric Values" ErrorMessage="<br/>Code Requires 11 Numeric Values"></asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Email</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtEmailAddress"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Visible="false" class="textbox" ID="txtAddress"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Visible="false" class="textbox" ID="txtUserPostalCode"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Visible="false" class="textbox" ID="txtUserCity"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="200px">
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" class="dropbox" ID="DropDownList1">
                                                            <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                                            <asp:ListItem Text="Central" Value="Central"></asp:ListItem>
                                                            <asp:ListItem Text="Copperbelt" Value="Eastern"></asp:ListItem>
                                                            <asp:ListItem Text="Lusaka" Value="Copperbelt"></asp:ListItem>
                                                            <asp:ListItem Text="Eastern" Value="Eastern"></asp:ListItem>
                                                            <asp:ListItem Text="Luapula" Value="Luapula"></asp:ListItem>
                                                            <asp:ListItem Text="Northern" Value="Northern"></asp:ListItem>
                                                            <asp:ListItem Text="Southern" Value="Southern"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:HiddenField runat="server" ID="hdfUserID" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <asp:Button runat="server" CssClass="formbutton" ID="btnContact" Text="Save & Next"
                                                                OnClick="Contact_Click" />
                                                            <asp:Button runat="server" ID="btncontactReset" CssClass="formbutton" Text="Reset"
                                                                OnClick="ContactReset_Click" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="VwPropertyDetails" runat="server">
                                        <div class="viewItem" runat="server" id="divPropertyDetailsFields">
                                            <div>
                                                Listing Details</div>
                                            <br />
                                            <asp:HiddenField runat="server" ID="hdfWebrefence" />
                                            <table>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Listing Type</span>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList class="dropbox" runat="server" ID="ddlPropertyType">
                                                            <asp:ListItem Text="Select"></asp:ListItem>
                                                            <asp:ListItem Text="For Rent" Value="For Rent"></asp:ListItem>
                                                            <asp:ListItem Text="For Sale" Value="For Sale"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Unit number</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtUnitNumber"></asp:TextBox>
                                                    </td>
                                                    <tr>
                                                        <td>
                                                            <span class="labeltext">Unit name</span>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox runat="server" class="textbox" ID="txtUnitName"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <td>
                                                        <span class="labeltext">Street number</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtStreetnumber"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Street name</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtStreetname"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">Suburb</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtSuburb"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">City</span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtCity"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="200px">
                                                        <span class="labeltext">Province</span>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList runat="server" class="dropbox" ID="ddlProvince">
                                                            <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                                            <asp:ListItem Text="Central" Value="Central"></asp:ListItem>
                                                            <asp:ListItem Text="Copperbelt" Value="Eastern"></asp:ListItem>
                                                            <asp:ListItem Text="Lusaka" Value="Copperbelt"></asp:ListItem>
                                                            <asp:ListItem Text="Eastern" Value="Eastern"></asp:ListItem>
                                                            <asp:ListItem Text="Luapula" Value="Luapula"></asp:ListItem>
                                                            <asp:ListItem Text="Northern" Value="Northern"></asp:ListItem>
                                                            <asp:ListItem Text="Southern" Value="Southern"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="Please enter the province where your company is located."
                                                            ControlToValidate="ddlProvince" InitialValue="--Select--" ValidationGroup="Agentform"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext"></span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" Visible="false" Text="za" class="textbox" ID="txtCountry"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button runat="server" CssClass="formbutton" ID="btnSave" Text="Save & Next"
                                                            OnClick="Property_Click" />
                                                        <asp:Button runat="server" CssClass="formbutton" ID="btnResetProperty" Text="Reset"
                                                            OnClick="PropertyReset_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:HiddenField runat="server" ID="hdfPropertyID" />
                                        <%--  The propertyid when saved to the database--%>
                                        <asp:HiddenField runat="server" ID="PropertyIDFromDataBase" />
                                        <asp:HiddenField runat="server" ID="hdfLatitude" />
                                        <asp:HiddenField runat="server" ID="hdfLongitude" />
                                        <div runat="server" id="map" class="mapItem" visible="false">
                                            <table>
                                                <tr>
                                                    <td height="300px">
                                                        <div id="myMap" style="position: relative; width: 680px; height: 300px;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <asp:Button runat="server" CssClass="formbutton" ID="btnSaveMap" Text="Save & Next"
                                                            OnClick="SaveMap_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="VwPriceDetails" runat="server">
                                        <div class="viewItem">
                                            <div>
                                                Price Details</div>
                                            <br />
                                            <table>
                                                <tr>
                                                    <td>
                                                        <span class="labeltext">
                                                            <asp:Label runat="server" ID="lblPriceProperty" Text="Monthly rental"></asp:Label></span>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox runat="server" class="textbox" ID="txtMonthlyrental"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <span class="labeltext">Please write a description of your listing that describes your
                                                            property very well.Maximum number of characters should be 2000</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:TextBox runat="server" class="textbox" ID="txtDescription" MaxLength="700" Width="500px"
                                                            Height="200px" TextMode="MultiLine"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:HiddenField runat="server" ID="hdfPriceID" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top">
                                                        <span class="labeltext">Property Type</span>
                                                    </td>
                                                    <td>
                                                        <asp:RadioButtonList runat="server" ID="chbHomeType" RepeatColumns="2" RepeatLayout="Table">
                                                            <asp:ListItem Text="Duplex" Value="Duplex"></asp:ListItem>
                                                            <asp:ListItem Text="Apartment" Value="Apartment"></asp:ListItem>
                                                            <asp:ListItem Text="House" Value="House"></asp:ListItem>
                                                            <asp:ListItem Text="Cluster" Value="Cluster"></asp:ListItem>
                                                            <asp:ListItem Text="Simplex" Value="Simplex"></asp:ListItem>
                                                            <asp:ListItem Text="Garden Cottage" Value="Garden Cottage"></asp:ListItem>
                                                            <asp:ListItem Text="Townhome" Value="Townhome"></asp:ListItem>
                                                            <asp:ListItem Text="Land" Value="Land"></asp:ListItem>
                                                            <asp:ListItem Text="Farm" Value="Farm"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td valign="top" width="200px">
                                                        <span class="labeltext">Property Features</span>
                                                    </td>
                                                    <td>
                                                        <div id="div" runat="server">
                                                            <table runat="server" id="tblAccessGate" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Access Gate</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="AccessGate">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                        <asp:RequiredFieldValidator runat="server" ID="rfV1" InitialValue="Choose one" Enabled="false"
                                                                            ControlToValidate="AccessGate"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="ImgAccessGate"
                                                                            CommandArgument="AccessGate" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblAirCon" runat="server" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Air Con</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="AirCon" Visible="false">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="ImageAirCon"
                                                                            CommandArgument="AirCon" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table id="tblAlarm" runat="server" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Alarm</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="Alarm">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgAlarm"
                                                                            CommandArgument="Alarm" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBalcony" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Balcony</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="Balcony">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBalcony"
                                                                            CommandArgument="Balcony" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBathrooms" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Bathrooms</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtBathrooms" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBathrooms"
                                                                            CommandArgument="Bathrooms" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBedrooms" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Bedrooms</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtBedrooms"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBedrooms"
                                                                            CommandArgument="Bedrooms" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBorehole" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Borehole</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="Borehole">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBorehole"
                                                                            CommandArgument="Borehole" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBuiltinCupboards" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Built-in Cupboards</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="BuiltinCupboards">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBuitinCupboards"
                                                                            CommandArgument="BuiltinCupboards" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBuiltinBraai" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Built-in Braai</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="BuiltinBraai">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBuiltinBraai"
                                                                            CommandArgument="BuiltinBraai" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblBusinessType" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Business Type</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="BusinessType">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Offices" Value="Offices"></asp:ListItem>
                                                                            <asp:ListItem Text="Commercials" Value="Commercials"></asp:ListItem>
                                                                            <asp:ListItem Text="Industrial" Value="Industrial"></asp:ListItem>
                                                                            <asp:ListItem Text="Retails" Value="Retails"></asp:ListItem>
                                                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                                                            <asp:ListItem Text="Hotel" Value="Hotel"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgBusinessType"
                                                                            CommandArgument="BusinessType" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblCarports" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Carports</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtCarports" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgCarports"
                                                                            CommandArgument="Carports" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblClubHouse" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Club House</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="clubHouse">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgClubHouse"
                                                                            CommandArgument="ClubHouse" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblDeck" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Deck</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlDeck">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgDeck" CommandArgument="Deck"
                                                                            OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblDiningArea" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Dining Area</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtDiningArea" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgDiningArea"
                                                                            CommandArgument="DiningArea" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblElectricfencing" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Electric Fencing</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlElectricFencing">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgElectricFencing"
                                                                            CommandArgument="ElectricFencing" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblElectricityIncluded" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Electricity Included</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlElectricityIncluded">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgElectricityIncluded"
                                                                            CommandArgument="ElectricFencing" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblEnSuite" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">En Suite</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtEnSuite" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgEnSuite"
                                                                            CommandArgument="En-Suite" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblEntranceHall" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Entrance Hall</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlEntranceHall">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgEntranceHall"
                                                                            CommandArgument="EntranceHall" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFamilyTV" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Family/TV</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFamilyTV">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFamilyTV"
                                                                            CommandArgument="FamilyTV" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFarmType" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Farm Type</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFarmType">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Crop farm" Value="Crop farm"></asp:ListItem>
                                                                            <asp:ListItem Text="Beef farm" Value="Beef farm"></asp:ListItem>
                                                                            <asp:ListItem Text="Dairy farm" Value="Dairy farm"></asp:ListItem>
                                                                            <asp:ListItem Text="Orchard farm" Value="Orchard farm"></asp:ListItem>
                                                                            <asp:ListItem Text="Poutry farm" Value="Poutry farm"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFarmType"
                                                                            CommandArgument="FarmType" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFarmBuilding" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Farm Building</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFarmBuilding">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Barn" Value="Barn"></asp:ListItem>
                                                                            <asp:ListItem Text="Birthing Pens" Value="Birthing Pens"></asp:ListItem>
                                                                            <asp:ListItem Text="Silo" Value="Silo"></asp:ListItem>
                                                                            <asp:ListItem Text="Milking Shed" Value="Milking Shed"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFarmBuilding"
                                                                            CommandArgument="FarmBuilding" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFarmName" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Farm Name</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtfarmName"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgfarmName"
                                                                            CommandArgument="FarmName" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFence" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Fence</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFence">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFence"
                                                                            CommandArgument="Fence" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFinishes" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Finishes</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFinishes">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Very High" Value="Very High"></asp:ListItem>
                                                                            <asp:ListItem Text="High" Value="High"></asp:ListItem>
                                                                            <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                                                                            <asp:ListItem Text="Budget" Value="Budget"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFinishes"
                                                                            CommandArgument="Finishes" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblfirePlace" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Fireplace</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFirePlace">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFirePlace"
                                                                            CommandArgument="Fence" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFlatlet" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Flatlet</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFlatlet">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFlatlet"
                                                                            CommandArgument="Flatlet" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFloorArea" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Floor Area</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtFloorArea" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFloorArea"
                                                                            CommandArgument="FloorArea" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblFurnished" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Furnished</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlFurnished">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgFurnished"
                                                                            CommandArgument="Furnished" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGarage" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Garages</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtGarage" Text="0"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGarage"
                                                                            CommandArgument="Garage" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGarden" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Garden</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlGarden">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGarden"
                                                                            CommandArgument="Garden" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGardenCottage" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Garden Cottage</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlGardenCottage">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGardenCottage"
                                                                            CommandArgument="GardenCottage" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGolf" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Golf</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlGolf">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGolf" CommandArgument="Golf"
                                                                            OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGuestToilet" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Guest Toilet</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlGuestToilet">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGuestToilet"
                                                                            CommandArgument="GuestToilet" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblGym" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Gym</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlGym">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgGym" CommandArgument="Gym"
                                                                            OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblDisabilityAccess" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <span class="labeltext">Disability Access</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="ddlDisabilityAccess">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                                            <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgDisabilityAccess"
                                                                            CommandArgument="Disability Access" OnClick="Img_Delete" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table runat="server" id="tblHomeType" visible="false">
                                                                <tr>
                                                                    <td>
                                                                        <asp:ImageButton runat="server" ImageUrl="~/Images/DeleteIcon.gif" ID="imgHomeType"
                                                                            CommandArgument="HomeType" OnClick="Img_Delete" />
                                                                    </td>
                                                                    <td>
                                                                        <span class="labeltext">Home Type</span>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList runat="server" ID="HomeType">
                                                                            <asp:ListItem Text="Choose one" Value="Choose one"></asp:ListItem>
                                                                            <asp:ListItem Text="Duplex" Value="Duplex"></asp:ListItem>
                                                                            <asp:ListItem Text="Apartment" Value="Apartment"></asp:ListItem>
                                                                            <asp:ListItem Text="House" Value="House"></asp:ListItem>
                                                                            <asp:ListItem Text="Cluster" Value="Cluster"></asp:ListItem>
                                                                            <asp:ListItem Text="Simplex" Value="Simplex"></asp:ListItem>
                                                                            <asp:ListItem Text="Garden Cottage" Value="Garden Cottage"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <asp:HiddenField runat="server" ID="hdfAttributeID" />
                                                            <asp:HiddenField runat="server" ID="hdfAttributeStateID" />
                                                        </div>
                                                        <asp:DropDownList runat="server" ID="ddlFeatures" DataTextField="AttributeNameType"
                                                            DataValueField="AttributeNameType">
                                                        </asp:DropDownList>
                                                        <asp:Button Text="Add attribute" ID="btnattribute" OnClick="btnattribute_Onclick"
                                                            runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Button runat="server" CssClass="formbutton" ID="btnPrice" Text="Save & Next"
                                                            OnClick="PriceDetails_Click" />
                                                        <asp:Button runat="server" CssClass="formbutton" ID="btnReset" Text="Reset" OnClick="PriceReset_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="VwUploadpropertyImages" runat="server">
                                        <div class="viewItem" style="display: block">
                                            <div>
                                                Property Pictures</div>
                                            <br />
                                            <div>
                                                <iframe id="propertypictures" runat="server" width="600px" height="400px" frameborder="0"
                                                    scrolling="no"></iframe>
                                            </div>
                                            <div style="margin-top: 10px">
                                                <asp:Button runat="server" Text="Next" CssClass="formbutton" ID="btnNextUpload" OnClick="NextUpload_Click" /></div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="VwCompleted" runat="server">
                                        <div class="viewItem">
                                            <p>
                                                Thank you very much for publishing your listing on our site.Your listing will be
                                                live in 24hrs.</p>
                                            <p>
                                                If you want the listing to appear on Newkenya and Safarike.apphb
                                                <asp:LinkButton runat="server" ID="lkbPartner" OnClick="lkb_Partner">here</asp:LinkButton>
                                            </p>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="VwPreviewPay" runat="server">
                                        <iframe id="paymentGateway" runat="server" width="600px" height="700px" frameborder="0"
                                            scrolling="no"></iframe>
                                        <%-- <uc1:Payments ID="Payments1" runat="server" />--%>
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnattribute" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnResetProperty" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:AsyncPostBackTrigger ControlID="btnContact" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btncontactReset" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
