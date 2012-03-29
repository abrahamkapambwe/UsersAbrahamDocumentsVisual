<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="RealEstateWebRole.Public.Map.Map" %>

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
            margin: 0px;
            padding: 0px;
        }
        #map_canvas
        {
            height: 100%;
            position: fixed;
        }
    </style>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"> </script>
    <script type="text/javascript">
        var map;

        function initialize() {
        
            var lat = document.getElementById("hdflat").value;
            var lng = document.getElementById("hdflng").value;
            var myLatlng = new google.maps.LatLng(lat, lng);
            var myOptions = {
                zoom: 12,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

//            google.maps.event.addListener(map, 'zoom_changed', function () {
//                setTimeout(moveToDarwin, 3000);
//            });

            var marker = new google.maps.Marker({
                position: myLatlng,
                map: map,
                title: "Hello World!"
            });

        }

        function moveToDarwin() {
            var darwin = new google.maps.LatLng(-12.461334, 130.841904);
            map.setCenter(darwin);
        }
    </script>
</head>
<body onload="initialize()">
    <div id="map_canvas" style="width: 600; display: block; height: 600">
    </div>
    <form id="form1" runat="server">
    <asp:HiddenField runat="server" ID="hdflat" Value="" />
    <asp:HiddenField runat="server" ID="hdflng" Value="" />
    <div>
    </div>
    </form>
</body>
</html>
