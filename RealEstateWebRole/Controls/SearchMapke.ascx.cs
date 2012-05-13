using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Web.UI.HtmlControls;

namespace RealEstateWebRole.Controls
{
    public partial class SearchMapke : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ltvThumbnail.DataSource = Search.GetAgentsFromCache().Where(p => !p.ProfilePhotoUrl.Contains("empty_thumbnail.gif")).Take(9);
            ltvThumbnail.DataBind();

        }
        protected void ltvThumbnail_itemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                EstateAgentAzure estate = (EstateAgentAzure)e.Item.DataItem;
                ListViewDataItem item = (ListViewDataItem)e.Item;
                HtmlAnchor imagelogo = (HtmlAnchor)item.FindControl("link");
                if (!string.IsNullOrWhiteSpace(estate.ProfilePhotoUrl) && !estate.ProfilePhotoUrl.Contains("empty_thumbnail.gif"))
                {


                    imagelogo.HRef = "~/Public/AgentDetails.aspx?agentID=" + estate.EstateAgentID + "&UserType=" + estate.UserID;
                }
            }
        }
    }
}