<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="previewMap.aspx.cs" Inherits="RealEstateWebRole.Members.maps.previewMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
        function initialize() {
            var latlng = new google.maps.LatLng(document.getElementById("hdflat").value, document.getElementById("hdflng").value);
            var myOptions = { zoom: 18, center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP };
            var map = new google.maps.Map(document.getElementById("map_canvas"),
          myOptions);
            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: "Hello World!"
            });
        }  
    </script>
</head>
<body onload="initialize()">
    <div id="map_canvas" style="width: 100%; height: 100%">
    </div>
    <form id="form1" runat="server">
    <asp:HiddenField runat="server" ID="hdflat" Value="" />
    <asp:HiddenField runat="server" ID="hdflng" Value="" />
    <div>
    </div>
    </form>
</body>
</html>
