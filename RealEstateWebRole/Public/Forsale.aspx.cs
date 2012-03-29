using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RealEstateWebRole.Public
{
    public partial class Forsale : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Basic_Click(object sender, EventArgs e)
        {
            LinkButton butt = (LinkButton)sender;
            if (butt.CommandName == "Basic")
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    Session["Status"] = "OneMonth";
                    Response.Redirect("~/Members/UploadPictures.aspx");
                }
                else
                {
                    Response.Redirect("~/Public/Login.aspx?Status=OneMonth");
                }

            }
            else if (butt.CommandName == "BasicMonths")
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    Session["Status"] = "ThreeMonth";
                    Response.Redirect("~/Members/UploadPictures.aspx");
                }
                else
                {
                    Response.Redirect("~/Public/Login.aspx?Status=ThreeMonth");
                }
            }
        }
    }
}