using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using RealEstateLibraries;

namespace RealEstateWebRole.Controls
{
    public partial class PreviewControl : System.Web.UI.UserControl
    {
        int numberOfImages = 0;
        private List<string> _features;
        public List<string> Features
        {
            get
            {
                if (_features == null)
                    _features = new List<string>();
                return _features;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["propertyId"] != null && Request.QueryString["UserId"] != null)
            {
                string propertyid = Convert.ToString(Request.QueryString["propertyId"]);
                string userid = Convert.ToString(Request.QueryString["UserId"]);
                PropertyTableAzure table = Search.GetPropertyTable(Guid.Parse(propertyid));
                PriceTableAzure price = Search.GetPriceTable(Guid.Parse(propertyid));
               


                lblAddress.Text = table.UnitNumber + "&nbsp;&nbsp;&nbsp;&nbsp;" + table.Municipality + "<br/>" + table.StreetNumber + " &nbsp;&nbsp;&nbsp;&nbsp;" + table.StreetName + ",<br/>" + table.Suburb + "&nbsp;&nbsp;&nbsp;&nbsp;" + table.City + " &nbsp;&nbsp;&nbsp;&nbsp;" + table.Province;
                if (price != null)
                {
                    GetFeatures(price.Attributes);
                }
                if (price != null)
                {
                    lblPrice.Text ="R " +  Convert.ToString(price.MonthlyRental);
                    lblPropertyDescription.Text = price.Description;
                }
                var image = Search.GetThumbnails(HttpContext.Current.User.Identity.Name,Guid.Parse(propertyid));
                if (image.Count() > 0)
                {
                    listviewDetails.DataSource = image;
                    listviewDetails.DataBind();
                    //ImageUrlAzure imgthumb = list[0];
                    //imgPropThumb.ImageUrl = imgthumb.thumbnailblob;
                    imgPicture.Visible = false;
                }
                else
                {
                    listviewDetails.Visible = false;
                    imgPicture.Visible = true;
                    imgPicture.ImageUrl = "~/Images/images_propertysearch.jpg";
                    
                }
             
               
                Map.Attributes.Add("src", "/Members/maps/previewMap.aspx?lat=" + table.Latitude + "&lng=" + table.Longitude);
                hypEdit.NavigateUrl = "~/Members/UploadPictures.aspx?propertyId=" + table.PropertyID;

            }
        }
        protected void listview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                ImageUrlAzure imageurl = (ImageUrlAzure)e.Item.DataItem;
              
               
                HtmlGenericControl divImages = (HtmlGenericControl)item.FindControl("divPreviewImages");

                Image ImageLink = (Image)item.FindControl("ImageLink");
                ImageLink.ImageUrl = imageurl.imageblob;
                if (numberOfImages == 0)
                {
                    divImages.Attributes.Add("style", "display:none");
                }
                numberOfImages = numberOfImages + 1;

            }
        }
        private void GetFeatures(string propertyattributestate)
        {
            string[] attributes = propertyattributestate.Split(new char[]{'|'});
            foreach (var att in attributes)
            {
                if (!string.IsNullOrEmpty(att))
                {
                    string value = att;
                    Features.Add(value);


                }
            }
            
           
            bool right = true;
            foreach (var item in Features)
            {
                if (right)
                {
                    HtmlGenericControl html = new HtmlGenericControl("li");
                    html.InnerText = item;
                    right = false;
                    RightlistItem.Controls.Add(html);
                }
                else
                {
                    HtmlGenericControl html = new HtmlGenericControl("li");
                    html.InnerText = item;
                    right = true;
                    LeftlistItem.Controls.Add(html);
                }
            }
        }
        private static Boolean CheckForBool(bool? value)
        {
            bool Value = false;
            if (value == null)
            {
                Value = false;
            }
            else
            {
                Value = true;
            }
            return Value;
        }
        private static int? CheckForNullableInt(int? value)
        {
            int? Value = 0;
            if (value == null)
            {
                Value = 0;
            }
            else
            {
                Value = value;
            }
            return Value;
        }

    }
    
}