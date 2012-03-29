using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateWebRole.Admin;

namespace RealEstateWebRole
{
    public partial class Buy : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public event MapListEventHandler SearchClickedEvent;
        public void Search_Click(object sender, ImageClickEventArgs e)
        {
           
                Response.Redirect("~/Public/SearchResult.aspx?SearchTerm=" + txtSearchBuy.Text + "&SearchType=" + 1);
            
           
        }
    }
}