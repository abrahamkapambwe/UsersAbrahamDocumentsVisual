using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateWebRole.Admin;

namespace RealEstateWebRole.Members.maps
{
    public partial class uploadMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["propertyid"] != null && Request.QueryString["lat"] != null && Request.QueryString["lng"] != null)
            {
                hdfProperty.Value = (string)Request.QueryString["propertyid"];
                string lat = (string)Request.QueryString["lat"];
                string lng = (string)Request.QueryString["lng"];
                hdflat.Value = lat;
                hdflng.Value = lng;
               hypRedirect.NavigateUrl="~/Members/UploadPictures.aspx?propertyid=" + hdfProperty.Value + "&lat=" + hdflat.Value + "&lng=" + hdflng.Value + "&Multiview=2";
            }
        }
        protected void SaveMap_Click(object sender, EventArgs e)
        {
            string lat = hdfclientlat.Value;
            string lng = hdfclientlng.Value;
            hdflat.Value = lat;
            hdflng.Value = lng;
            Session["LngLat"] = lat + ";" + lng;
            //Server.Transfer("~/Members/uploadPictures.aspx?propertyid=" + hdfProperty.Value + "&lat=" + hdflat.Value + "&lng=" + hdflng.Value + "&Multiview=2");
            Response.Redirect("~/Members/uploadPictures.aspx?propertyid=" + hdfProperty.Value + "&lat=" + hdflat.Value + "&lng=" + hdflng.Value + "&Multiview=2",true);
            //MapEventArgs eventArgs = new MapEventArgs();
            //eventArgs.Lat = lat;
            //eventArgs.Lng = lng;
            //eventArgs.PropertyID = Convert.ToInt32(hdfProperty.Value);
            //eventArgs.Multiview = "2";

            //MapListChanged(this, eventArgs);
        }
        public event MapListEventHandler MapListChanged;
    }
}