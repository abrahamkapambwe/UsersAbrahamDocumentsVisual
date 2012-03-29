<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="uploadMap.aspx.cs" Inherits="RealEstateWebRole.Members.maps.uploadMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        html
        {
            height: 100%;
        }
        body
        {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map_canvas
        {
            height: 100%;
        }
    </style>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"> </script>
    <script type="text/javascript">
        var map;
        var markersArray = [];
        function initialize() {

        
            var myLatlng = new google.maps.LatLng(document.getElementById("hdflat").value, document.getElementById("hdflng").value);
            var myOptions = { zoom: 17,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            //var image = 'images/apartment-3.png';
            var marker = new google.maps.Marker({ position: myLatlng, map: map });
            //markersArray.push(marker);
            google.maps.event.addListener(map,
    'click', function (event) {

        var myLatLng = event.latLng;
        var lat = myLatLng.lat();
        var lng = myLatLng.lng();
        document.getElementById("hdfclientlat").value = lat;
        document.getElementById("hdfclientlng").value = lng;
        placeMarker(event.latLng);

    });
        }
        function placeMarker(location) {
            // clearOverlays();
            var marker = new google.maps.Marker({ position: location, map: map }); map.setCenter(location);

        }
        function clearOverlays() { if (markersArray) { for (i in markersArray) { markersArray[i].setMap(null); } } }
        //        function RedirecttoMaps() {
        //            var lat;
        //            var lng;
        //            if (document.getElementById("hdfclientlat").value == "") {
        //                lat = document.getElementById("hdflat").value
        //            }
        //            else {
        //                lat = document.getElementById("hdfclientlat").value
        //            }

        //        
        //        }
    </script>
</head>
<body onload="initialize()">
    <div id="map_canvas" style="width: 90%; height: 90%">
    </div>
    <form id="form1" runat="server">
    <asp:HiddenField runat="server" ID="hdflat" Value="" />
    <asp:HiddenField runat="server" ID="hdflng" Value="" />
    <asp:HiddenField runat="server" ID="hdfclientlat" />
    <asp:HiddenField runat="server" ID="hdfclientlng" />
    <asp:HiddenField runat="server" ID="hdfProperty" />
    <asp:HyperLink runat="server"  ID="hypRedirect"
        Text="Click"></asp:HyperLink>
    <asp:Button runat="server" ID="btnMap" Text="Save & Next" OnClick="SaveMap_Click" />
    </form>
</body>
</html>
