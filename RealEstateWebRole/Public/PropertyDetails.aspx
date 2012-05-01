<%@ Page Title="" Language="C#" MasterPageFile="~/Real.Master" AutoEventWireup="true"
    Async="true" CodeBehind="PropertyDetails.aspx.cs" Inherits="RealEstateWebRole.Public.PropertyDetails" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="../Scripts/jqFancyTransitions.1.8.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        function ChangeVisible(index) {

            var lis = document.getElementById("fullImage").getElementsByTagName("li");

            for (var i = 0; i < lis.length; i++) {
                if (i == index) {
                    lis[i].className = "ImageVisible";
                } else {
                    lis[i].className = "ImageHidden";
                }
            }
        }
        function SubmitClientDetails(value) {



            document.getElementById(value).style.display = 'block';
            document.getElementById('fade').style.display = 'block';

        }

        function Hide(value) {

            document.getElementById(value).style.display = 'none';
            document.getElementById('fade').style.display = 'none';
        }
        function SubmitClientPersonalDetails(value) {

            var valid = false;

            var clientids = value.split(';');

            var name = document.getElementById(clientids[1]).value;
            var phone = document.getElementById(clientids[2]).value;
            var email = document.getElementById(clientids[3]).value;
            var comment = document.getElementById(clientids[4]).value;
            var atpos = email.indexOf("@");
            var dotpos = email.lastIndexOf(".");

            if ((name != "") && (phone != "") && (email != "") && (comment != "")) {
                document.getElementById('divPhone').style.display = 'none';
                document.getElementById('divName').style.display = 'none';
                document.getElementById('divEmail').style.display = 'none';
                document.getElementById('divMessage').style.display = 'none';
                valid = true;
            }
            if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                document.getElementById('divEmailRequired').style.display = 'block';
                valid = false;
            } else {
                document.getElementById('divEmailRequired').style.display = 'none';
            }


            var propertyid = clientids[5];
            var userid = clientids[6];
            if (valid) {
                document.getElementById("saving").style.display = "block";
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


                        document.getElementById("saving").style.display = "none";

                        //    value                    JSONObject objJSON = (JSONObject) JSONValue.parse(value);
                        //                        String Message = objJSON.get("d").toString();

                        document.getElementById('content').innerText = data.d;
                        //                        $("#content").;
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
                //                document.getElementById(clientids[0]).style.display = 'block';
                //                document.getElementById('divEmailRequired').style.display = 'block';
            }


        }
        function SubmitEmailsFriends(value) {

            var valid = false;

            var clientids = value.split(';');

            var name = document.getElementById(clientids[0]).value;
            var email = document.getElementById(clientids[1]).value;
            var firstname = document.getElementById(clientids[2]).value;
            var firstemail = document.getElementById(clientids[3]).value;
            var secondname = document.getElementById(clientids[4]).value;
            var secondemail = document.getElementById(clientids[5]).value;
            var comment = document.getElementById(clientids[6]).value;
            var propertyid = clientids[7];
            var atpos = email.indexOf("@");
            var dotpos = email.lastIndexOf(".");


            if ((name != "") && (firstname != "") && (email != "") && (firstemail != "")) {
                if (name != "")
                    document.getElementById('divyourname').style.display = 'none';
                if (email != "")
                    document.getElementById('divemailaddress').style.display = 'none';
                if (firstname != "")
                    document.getElementById('divfirstfriendname').style.display = 'none';
                if (firstemail != "")
                    document.getElementById('divfirstfriendemail').style.display = 'none';
                valid = true;
            } if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= email.length) {
                document.getElementById('divemailaddressinvalid').style.display = 'block';
                document.getElementById('divfirstfriendemailinvalid').style.display = 'block';
                valid = false;

            } else {
                document.getElementById('divemailaddressinvalid').style.display = 'none';
                document.getElementById('divfirstfriendemailinvalid').style.display = 'none';
            }


            if (valid) {
                document.getElementById("saving").style.display = "block";
                var Data = { "propertyid": propertyid, "Name": name, "email": email, "firstname": firstname, "firstemail": firstemail, "secondname": secondname, "secondemail": secondemail, "comment": comment }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: '<%=ResolveUrl("~/WebServices/EmailAgent.svc/EmailFriend") %>',
                    processData: false,
                    dataType: "json",
                    data: '{"propertyid":"' + propertyid + '","name": "' + name + '","email": "' + email + '","firstname": "' + firstname + '","firstemail": "' + firstemail + '","secondname": "' + secondname + '","secondemail": "' + secondemail + '","comment": "' + comment + '"}',
                    error: function (err) {
                        document.getElementById("saving").style.display = "none";
                        alert("Error:" + err.toString());
                    },
                    success: function (data) {

                        document.getElementById("saving").style.display = "none";
                        document.getElementById('content').innerText = data.d;
                        //                        $("#content").;
                    }
                });
            } else {
                if (name == "") {
                    document.getElementById('divyourname').style.display = 'block';
                } else {
                    document.getElementById('divyourname').style.display = 'none';
                }
                if (firstname == "") {
                    document.getElementById('divfirstfriendname').style.display = 'block';
                } else {
                    document.getElementById('divfirstfriendname').style.display = 'none';
                }
                if (email == "") {
                    document.getElementById('divemailaddress').style.display = 'block';
                } else {
                    document.getElementById('divemailaddress').style.display = 'none';
                }
                if (firstemail == "") {
                    document.getElementById('divfirstfriendemail').style.display = 'block';
                } else {
                    document.getElementById('divfirstfriendemail').style.display = 'none';
                }

            }


        }
        //        function ShowMap(lat, long, Mapid) {

        //            document.getElementById(Mapid).style.display = 'block';
        //            document.getElementById('fade').style.display = 'block';
        //            var myLatLng = new google.maps.LatLng(lat, long);
        //            var myOptions = { zoom: 8, center: myLatLng, mapTypeId: google.maps.MapTypeId.ROADMAP };
        //            var map = new google.maps.Map(document.getElementById(Mapid), myOptions);


        //        }
        //        function Hide(value) {

        //            document.getElementById(value).style.display = 'none';
        //            document.getElementById('fade').style.display = 'none';
        //        }
        
    </script>
    <style type="text/css">
        .ImageVisible
        {
            position: relative;
            display: block;
            float: left;
        }
        .ImageHidden
        {
            display: none;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div>
        <div>
            <table>
                <tr valign="top">
                    <td>
                        <div id="left" class="left">
                            <div class="topleft">
                                <div class="propertyDetailsHeader">
                                    Property Details</div>
                                <div class="propertyDetailsleft">
                                    <div class="topleft-content">
                                        <asp:Label runat="server" ID="lblSuburb"></asp:Label>
                                        <span style="color: #666666; font-size: 0.8em; font-weight: normal; margin: 0; padding: 0;">
                                        </span>
                                    </div>
                                    <div>
                                        <h3>
                                            <asp:Label runat="server" ID="lblPrice"></asp:Label>
                                        </h3>
                                    </div>
                                    <div style="margin-left: 13px; margin-top: 15px">
                                        <asp:HyperLink runat="server" ID="hyperView" Text="Arrange Viewing" NavigateUrl="#"></asp:HyperLink></div>
                                    <div>
                                        <asp:HyperLink CssClass="button_arrange" runat="server" Visible="false" ID="hyperFriend" Text="Email your friend"
                                            NavigateUrl="#01"></asp:HyperLink></div>
                                </div>
                            </div>
                            <div class="estateAgent" id="EstateAg" runat="server">
                                <div class="propertyDetailsHeader">
                                    Estate Agent Details</div>
                                <div class="propertyDetailsleft">
                                    <div id="leftestate">
                                        <asp:HyperLink runat="server" Width="100px" Height="100px" ID="hypImage"></asp:HyperLink>
                                    </div>
                                    <div id="rightestate">
                                        <div style="color: #666666;">
                                            <strong>
                                                <asp:Label runat="server" ID="lblBusinessName"></asp:Label></strong>
                                        </div>
                                        <div style="color: #666666;">
                                            <asp:Label runat="server" Font-Bold="false" ID="lblAddress"></asp:Label></div>
                                        <div style="color: #666666;">
                                            <asp:Label runat="server" Font-Bold="false" ID="lblCityEstate"></asp:Label></div>
                                        <h4>
                                            <asp:Label ID="lblestatePhone" runat="server"></asp:Label></h4>
                                    </div>
                                    <div id="estatecontact">
                                        <asp:HyperLink runat="server" ID="btnContactAgent" Text="Contact Agent" NavigateUrl="#"></asp:HyperLink></div>
                                </div>
                            </div>
                            <div class="estateAgent">
                                <div class="propertyDetailsHeader">
                                    Points Of Interest</div>
                                <div class="propertyDetailsleft">
                                    <div runat="server" id="PrimarySchool">
                                        <ul runat="server" class="features" id="primaSchool">
                                        </ul>
                                    </div>
                                    <div runat="server" id="secondaryColleges">
                                        <ul runat="server" class="features" id="secondSchool">
                                        </ul>
                                    </div>
                                    <div runat="server" id="medicalfacilities">
                                        <ul runat="server" class="features" id="medical">
                                        </ul>
                                    </div>
                                    <div runat="server" id="station">
                                        <ul runat="server" class="features" id="stat">
                                        </ul>
                                    </div>
                                    <div runat="server" id="mallrestuarat">
                                        <ul runat="server" class="features" id="mallrest">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div id="right">
                            <div class="detailsrighttop">
                                <div class="one">
                                    <div style="float: left; margin-top: 20px; margin-bottom: 10px; margin-right: 5px">
                                        This listing has been viewed&nbsp;&nbsp;
                                        <asp:Label runat="server" ID="lblNumberOfTimes"></asp:Label>
                                       times<br />
                                    </div>
                                    <div style="float: left; margin-top: 20px; margin-bottom: 10px">
                                        <iframe src="http://www.facebook.com/plugins/like.php?href=http://127.0.0.1:81" scrolling="no"
                                            frameborder="0" style="border: none; width: 250px; height: 80px"></iframe>
                                    </div>
                                </div>
                                <div style="margin-left:30px; margin-bottom: 5px">
                                    Web Ref:<asp:Label runat="server" ID="lblWebReference"></asp:Label></div>
                                <div>
                                    <asp:Image runat="server" CssClass="detailsImageContainer" ID="imgNoImage" Visible="false">
                                    </asp:Image>
                                    <div id="spotlight">
                                    </div>
                                    <div class="container">
                                        <div id="fullImage" style="padding-left: 10px">
                                            <asp:ListView runat="server" ID="listviewDetails" OnItemDataBound="listview_ItemDataBound">
                                                <LayoutTemplate>
                                                    <ul runat="server" id="itemPlaceHolder" style="padding: 0; float: left; list-style-type: none">
                                                    </ul>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <li runat="server" id="liImage">
                                                        <asp:Image runat="server" ID="ImageLink" /></li>
                                                </ItemTemplate>
                                            </asp:ListView>
                                        </div>
                                        <div style="padding-left: 10px">
                                            <div style="float: left">
                                                <img src="../images/right.gif" id="img_right" height="117" width="50" alt="" style="cursor: pointer" />
                                            </div>
                                            <div style="float: left; background-color: #fff">
                                                <telerik:RadRotator ID="RadRotator1" runat="server" RotatorType="ButtonsOver" Width="550"
                                                    Height="118px" ItemHeight="118" ItemWidth="145" SlideShowAnimation-Type="Fade"
                                                    FrameDuration="200" ScrollDirection="Left,Right">
                                                    <ItemTemplate>
                                                        <div class="itemTemplate">
                                                            <img src='<%#Eval("thumbnailblob") %>' alt="tst" class="RotatorImage" onclick="ChangeVisible('<%#Eval("Index") %>')" />
                                                        </div>
                                                    </ItemTemplate>
                                                    <ControlButtons LeftButtonID="img_left" RightButtonID="img_right" />
                                                </telerik:RadRotator>
                                            </div>
                                            <div style="float: left">
                                                <img src="../images/left.gif" id="img_left" height="117" width="50" alt="" style="cursor: pointer" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="detailsrighttop">
                                    <div class="propertyimages">
                                    </div>
                                </div>
                                <div class="detailsright">
                                    <div style="margin-left: 20px; width: 100%">
                                        <h4>
                                            <asp:Label runat="server" Font-Names="Verdana" ID="lblDetails"></asp:Label></h4>
                                    </div>
                                    <div style="margin-left: 20px;">
                                        <span style="font-size: 18px">Property Description</span>
                                        <div style="margin-top: 10px">
                                            <asp:Label runat="server" Font-Bold="false" ForeColor="#666666" ID="lblDescription"></asp:Label>
                                        </div>
                                    </div>
                                    <div style="margin-left: 20px; margin-top: 20px; margin-bottom: 20px; height: 40px">
                                        <div style="float: left">
                                            <h3>
                                                <asp:Label runat="server" ID="lblPrice2"></asp:Label>
                                            </h3>
                                        </div>
                                        <div style="float: left; padding-left: 20px; padding-right: 20px; margin-left: 10px;
                                            margin-right: 10px; border-right: 1px solid #bbb; border-left: 1px solid #bbb">
                                            <div style="float: none; clear: both">
                                                <asp:Label runat="server" ForeColor="#333333" Font-Bold="true" ID="lblPropertyBed"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:Label
                                                    ForeColor="#333333" Font-Bold="true" runat="server" ID="lblPropertyType1"></asp:Label>
                                            </div>
                                            <div>
                                                <asp:Label runat="server" Font-Bold="false" ForeColor="#66666" ID="lblAddress2"></asp:Label>
                                            </div>
                                        </div>
                                        <div style="float: left">
                                            <div>
                                                <asp:HyperLink runat="server" ID="HyperArrangeView2" Text="Arrange Viewing" NavigateUrl="#"></asp:HyperLink></div>
                                        </div>
                                    </div>
                                    <div style="float: none; clear: both; margin-left: 20px; margin-top: 20px">
                                        <div>
                                            <span>Property Features</span></div>
                                        <div style="float: left; width: 200px; margin-right: 50px">
                                            <ul runat="server" class="features" id="RightlistItem">
                                            </ul>
                                        </div>
                                        <div style="float: left">
                                            <ul runat="server" class="features" id="LeftlistItem">
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="detailsright">
                                <div class="map">
                                    <iframe id="imap" runat="server" width="600px" height="450px" frameborder="0" scrolling="no">
                                    </iframe>
                                </div>
                            </div>
                            <div class="detailsrightbottom">
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <div class="white_content" id="divFriend" runat="server">
                <asp:HyperLink runat="server" Text="Hide" NavigateUrl="#" ID="hidedivFriend"></asp:HyperLink>
                <div id="Div1">
                </div>
                <table>
                    <tr>
                        <td>
                            Your name*
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtYourName"></asp:TextBox><div id="divyourname"
                                class="stylenone">
                                Name is required</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your email address*
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtyouremailaddress"></asp:TextBox><div id="divemailaddress"
                                class="stylenone">
                                Email is required</div>
                            <div id="divemailaddressinvalid" class="stylenone">
                                Email is invalid(someone@gmail.com)</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your first friend's name*
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtfirstfriendsname"></asp:TextBox><div id="divfirstfriendname"
                                class="stylenone">
                                First friend's name is required</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your first friend's email address*
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtfirstfriendsemail"></asp:TextBox><div id="divfirstfriendemail"
                                class="stylenone">
                                First friend's email is required</div>
                            <div id="divfirstfriendemailinvalid" class="stylenone">
                                First friend's email is invalid</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your second friend's name
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtsecondfriendname"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Your second friend's email address
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtsecondfriendemail"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Comments
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtComment"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <asp:HyperLink runat="server" ID="hypSendMailFriend" Text="Send" NavigateUrl="#00"></asp:HyperLink>
                        </td>
                    </tr>
                </table>
            </div>
            <div runat="server" class="white_content" id="divContact">
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
                    <div style="clear: both" class="sendContactForm">
                        <div style="float: left">
                            <table>
                                <tr valign="top">
                                    <td>
                                        <span class="labeltext">Name*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox runat="server" class="textbox" ID="txtName"></asp:TextBox><div id="divName"
                                            class="stylenone">
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
                                        <asp:TextBox runat="server" class="textbox" ID="txtPhone"></asp:TextBox><div id="divPhone"
                                            class="stylenone">
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
                                        <asp:TextBox runat="server" class="textbox" ID="txtEmail"></asp:TextBox><div id="divEmail"
                                            class="stylenone">
                                            Email address is required</div>
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
                                        <asp:TextBox runat="server" ID="txtMessage" Width="280px" Height="142px" TextMode="MultiLine"></asp:TextBox><div
                                            id="divMessage" class="stylenone">
                                            Message is required</div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div style="float: left; margin-left: 20px;">
                            <div style="margin-bottom: 20px; padding-top: 10px; height: 100px">
                                <div style="float: left; border: 2px solid #bbb">
                                    <asp:Image runat="server" Width="80px" Height="50px" ID="imgPropThumb" /></div>
                                <div style="float: left; margin-left: 15px">
                                    <asp:Label runat="server" ForeColor="#39ACE6" ID="lblPriceDialog"></asp:Label>
                                    <asp:Label runat="server" ID="UnitNumberDialog"></asp:Label>&nbsp;<asp:Label runat="server"
                                        ID="lblRoadDialog"></asp:Label><br />
                                    <asp:Label runat="server" ID="lblSurburbDialog"></asp:Label>,&nbsp;<asp:Label runat="server"
                                        ID="lblCityDialog"></asp:Label><br />
                                    <asp:Label runat="server" ID="lblStateDialog">,&nbsp;</asp:Label>
                                    <asp:Label runat="server" ID="lblZipCodeDialog"></asp:Label></div>
                            </div>
                            <div style="clear: both; height: 100px">
                                <div style="float: left; border: 2px solid #bbb">
                                    <asp:Image runat="server" Width="80px" Height="60px" ID="imgAgentThumb" /></div>
                                <div style="float: left; margin-left: 15px">
                                    <asp:Label runat="server" ID="lblAgentBusiness"></asp:Label>
                                    <asp:Label runat="server" ID="lblAgentPhoneNumber"></asp:Label><br />
                                    <asp:Label runat="server" ID="lblAgentRoad"></asp:Label>,<asp:Label runat="server"
                                        ID="lblAgentSurburb"></asp:Label><br />
                                    <asp:Label runat="server" ID="lblAgentCity"></asp:Label>,<br />
                                    <asp:Label runat="server" ID="lblAgentState"></asp:Label><br />
                                    <asp:Label runat="server" ID="lblAgentPostalCode"></asp:Label>
                                </div>
                            </div>
                            <div style="clear: both; margin-top: 20px">
                                <asp:HyperLink ID="hyperSendEmail" NavigateUrl="#5" runat="server" class="button"></asp:HyperLink></div>
                        </div>
                    </div>
                    <div style="clear: both">
                    </div>
                </div>
            </div>
            <div id="fade" class="black_overlay">
            </div>
        </div>
    </div>
</asp:Content>
