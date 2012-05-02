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
    public partial class Real : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {



        }
      
        public void Search_Click(object sender, ImageClickEventArgs e)
        {
            if (rdnSearchBuy.Checked)
            {

                Response.Redirect("~/Public/SearchResult.aspx?SearchTerm=" + txtSearchBuy.Text + "&SearchType=" + 1);
            }
            else if (rbnSearchRent.Checked)
            {
                Response.Redirect("~/Public/SearchResult.aspx?SearchTerm=" + txtSearchBuy.Text + "&SearchType=" + 2);
            }
            else if (rbnSearchAgent.Checked)
            {
                Response.Redirect("~/Public/AgentResults.aspx?SearchTerm=" + txtSearchBuy.Text + "&SearchType=" + 3);
            }

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