using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateWebRole.Admin;

using System.Web.Security;

namespace RealEstateWebRole
{
    public partial class Rent : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void Search_Click(object sender, ImageClickEventArgs e)
        {


            Response.Redirect("~/Public/SearchResult.aspx?SearchTerm=" + txtSearchBuy.Text + "&SearchType=" + 2);


        }
        public void Login_out(object sender, EventArgs e)
        {
            

            try
            {
                FormsAuthentication.SignOut();
            }
            finally
            {
               
            }

        }
    }
}