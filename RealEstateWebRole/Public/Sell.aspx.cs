using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using RealEstateLibraries;

namespace RealEstateWebRole.Public
{
    public partial class Sell : System.Web.UI.Page
    {
        string sellmetaTag = "";
        protected void Page_PreInit(object sender, EventArgs e)
        {
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Page.Title = "Sale Properties on ePropertySearch";
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);
                PopulateFeaturedProperty();
                HtmlMeta htmlmeta2 = new HtmlMeta();
                htmlmeta2.Name = "keywords2";
                htmlmeta2.Content = sellmetaTag;
                Page.Header.Controls.Add(htmlmeta2);
            }

        }

        private void PopulateFeaturedProperty()
        {
            
            lstFeaturedProperty.DataSource = Search.GetFeaturedSaleProperty();
            lstFeaturedProperty.DataBind();

        }
        
        protected void lstFeaturedProperty_itemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                PropertyTableAzure table = (PropertyTableAzure)e.Item.DataItem;
                ListViewDataItem item = (ListViewDataItem)e.Item;
                HyperLink imageProperty = (HyperLink)item.FindControl("imgFeaturedProperty");
                Label lblPropertyTypeArea = (Label)item.FindControl("lblPropertyTypeArea");
                Label lblPrice = (Label)item.FindControl("lblPropertyPrice");
                Label lblTimeAdded = (Label)item.FindControl("lblTimeAdded");
                if (table.ImageUrlAzures != null && table.ImageUrlAzures.Count > 0)
                {
                    var imgUrl = (from url in table.ImageUrlAzures
                                  select url).First();
                    imageProperty.ImageUrl = imgUrl.thumbnailblob;
                    imageProperty.NavigateUrl = "~/Public/PropertyDetails.aspx?PropertyID=" + table.PropertyID;
                    //imageProperty.NavigateUrl = "../Public/SearchResult.aspx?SearchTerm=" + table.Province + "&SearchType=1&City=" + table.City;
                }

                lblPropertyTypeArea.Text = CheckContainHomeType(table.PriceTableAzure.Attributes) + " " + table.PropertyType + " in " + table.City;
                sellmetaTag = lblPropertyTypeArea.Text + " at " + "Kshs" + table.PriceTableAzure.MonthlyRental + ",";
                lblPrice.Text = "Kshs " + table.PriceTableAzure.MonthlyRental;
                int hour = (DateTime.Now - table.Added).Hours;
                //lblTimeAdded.Text = "Added " + hour + "hours ago";
            }
        }

        private string CheckContainHomeType(string p)
        {
            if (!string.IsNullOrWhiteSpace(p))
            {
                if (p.Contains("Apartment"))
                {
                    return "Apartment";
                }
                else if (p.Contains("Duplex"))
                {
                    return "Duplex";
                }
                else if (p.Contains("House"))
                {
                    return "House";
                }
                else if (p.Contains("Cluster"))
                {
                    return "Cluster";
                }
                else if (p.Contains("Simplex"))
                {
                    return "Simplex";
                }
                else if (p.Contains("Garden Cottage"))
                {
                    return "Garden Cottage";
                }
            }

            return "House";
        }
    }
}