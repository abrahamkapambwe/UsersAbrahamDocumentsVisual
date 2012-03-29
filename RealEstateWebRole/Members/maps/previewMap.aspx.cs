using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RealEstateWebRole.Members.maps
{
    public partial class previewMap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["lat"] != null && Request.QueryString["lng"] != null)
            {

                string lat = (string)Request.QueryString["lat"];
                string lng = (string)Request.QueryString["lng"];
                hdflat.Value = lat;
                hdflng.Value = lng;
            }
        }
    }
}