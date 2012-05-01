using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;

namespace RealEstateWebRole.Controls
{
    public partial class SearchMap : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ltvThumbnail.DataSource = Search.GetAgentsFromCache();
            ltvThumbnail.DataBind();

        }
        protected void ltvThumbnail_itemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                EstateAgentAzure estate = (EstateAgentAzure)e.Item.DataItem;
                ListViewDataItem item = (ListViewDataItem)e.Item;
                HyperLink imagelogo = (HyperLink)item.FindControl("imgLogoEstate");
                if (!string.IsNullOrWhiteSpace(estate.ProfilePhotoUrl) && !estate.ProfilePhotoUrl.Contains("empty_thumbnail.gif"))
                {
                    imagelogo.ImageUrl = estate.ProfilePhotoUrl;
                    imagelogo.NavigateUrl = "~/Public/AgentDetails.aspx?agentID=" + estate.EstateAgentID + "&UserType=" + estate.UserID;
                }
            }
        }
    }
}