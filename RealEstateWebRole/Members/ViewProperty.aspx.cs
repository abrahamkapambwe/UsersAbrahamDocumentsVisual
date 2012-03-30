using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;

using System.Threading;
using System.Web.Security;
using System.Web.UI.HtmlControls;

namespace RealEstateWebRole.Account
{
    public partial class ViewProperty : System.Web.UI.Page
    {
        Boolean alternatebg = false;
        private string address;
        //string[] items={"Active","Approved","Expired","Reported"
        private string FederationForms = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            GetAuthenticationType();
            if (!string.IsNullOrWhiteSpace(FederationForms))
            {
                ListDataBind();
            }



        }

        private void GetAuthenticationType()
        {
           
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
        }

        private void ListDataBind()
        {
            int approved = 0;
            int active = 0;
            //int followed = 0;
            int expired = 0;
            int incomplete = 0;
            int reported = 0;
            var previewProperties = Search.GetPreviews();
            foreach (var status in previewProperties)
            {
                if (status.Active)
                {
                   
                        active = active + 1;
                }
                else if (status.Approved)
                {
                    if (status.Approved)
                        approved = approved + 1;
                }
                else if (status.InComplete)
                {
                    if (status.InComplete)
                        incomplete = incomplete + 1;
                }
                else if (status.Reported)
                {
                    if (status.Reported)
                        reported = reported + 1;
                }
                else if (status.Expired)
                {
                    if (status.Expired)
                        expired = expired + 1;
                }

            }
            for (int i = 0; i < filterlist.Items.Count; i++)
            {
                switch (filterlist.Items[i].Text)
                {
                    case "Active":
                        filterlist.Items[i].Text = filterlist.Items[i].Text + "("  + active + ")";
                        if (active != 0)
                        {
                            filterlist.Items[i].Selected = true;
                        }
                        break;

                    case "Approved":
                        filterlist.Items[i].Text = filterlist.Items[i].Text + "(" + approved + ")";
                        if (approved != 0)
                        {
                            filterlist.Items[i].Selected = true;
                        }
                        break;
                    case "Expired":
                        filterlist.Items[i].Text = filterlist.Items[i].Text + "(" + expired + ")";
                        if (expired != 0)
                        {
                            filterlist.Items[i].Selected = true;
                        }
                        break;
                    case "Incomplete":
                        filterlist.Items[i].Text = filterlist.Items[i].Text + "(" + incomplete + ")";
                        if (incomplete != 0)
                        {
                            filterlist.Items[i].Selected = true;
                        }
                        break;
                    case "Reported":
                        filterlist.Items[i].Text = filterlist.Items[i].Text + "(" + reported + ")";
                        if (reported != 0)
                        {
                            filterlist.Items[i].Selected = true;
                        }
                        break;
                }

            }


            lstPropertyView.DataSource = Search.GetPropertyTable(FederationForms).ToList();
            lstPropertyView.DataBind();
        }
        protected void Filterlist_SelectedIndexChanged(object sender, EventArgs e)
        {
            Dictionary<string, bool> paramPreview = new Dictionary<string, bool>();

            for (int i = 0; i < filterlist.Items.Count; i++)
            {
                if (filterlist.Items[i].Selected == true)
                {
                    paramPreview.Add(filterlist.Items[i].Value, true);
                }
            }
            //Keys key = Search.GetID(FederationForms);
            Session["ParamPreview"] = paramPreview;
            if (paramPreview.ContainsValue(true))
            {
                List<Guid> list = Search.GetPropertyIDsSearch(paramPreview, FederationForms);
                lstPropertyView.DataSource = Search.GetPropertyTable(FederationForms, list);
                lstPropertyView.DataBind();

            }
            else
            {
                ListDataBind();

            }


        }
        protected void lstPropertyView_PagePropertiesChanged(object sender, EventArgs e)
        {
            GetAuthenticationType();

            if (FederationForms != null)
            {
                if (Session["ParamPreview"] != null)
                {
                    var paramPreview = (Dictionary<String, bool>)Session["ParamPreview"];
                    if (paramPreview.ContainsValue(true))
                    {
                        //Keys key = Search.GetID(FederationForms);
                        List<Guid> list = Search.GetPropertyIDsSearch(paramPreview, FederationForms);
                        lstPropertyView.DataSource = Search.GetPropertyTable(FederationForms, list);
                        lstPropertyView.DataBind();

                    }
                    else
                    {
                        ListDataBind();
                    }
                }
                else
                {
                    ListDataBind();
                }


            }
        }
        public void Delete_Click(object sender, EventArgs e)
        {
            LinkButton bnt = (LinkButton)sender;

           string propertyID = Convert.ToString(bnt.CommandArgument);
            Search.DeleteProperty(propertyID);
            ListDataBind();

        }
        protected void lstPropertyView_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                PropertyTableAzure propertytable = (PropertyTableAzure)item.DataItem;
                ImageUrlAzure imageurl = Search.GetImageUrl(propertytable.PropertyID);
                HyperLink hyperImage = (HyperLink)item.FindControl("hyperImage");
                HyperLink hyperPreview = (HyperLink)item.FindControl("hyperPreview");
                HtmlGenericControl divStyle = (HtmlGenericControl)item.FindControl("alternateCss");

                if (alternatebg)
                {
                    divStyle.Attributes.Add("style", "background-color:aqua;border-bottom:1px solid #bbb;padding:10px");
                    alternatebg = false;
                }
                else
                {
                    divStyle.Attributes.Add("style", " background-color:white;border-bottom:1px solid #bbb;padding:10px");
                    alternatebg = true;
                }
                hyperPreview.NavigateUrl = "~/Members/Preview.aspx?propertyId=" + propertytable.PropertyID + "&UserId=" + propertytable.UserID;
                if (imageurl != null)
                {

                    hyperImage.ImageUrl = imageurl.thumbnailblob;
                    hyperImage.NavigateUrl = "~/Members/UploadPictures.aspx?propertyId=" + imageurl.PropertyID;
                }
                else
                {
                    hyperImage.ImageUrl = "~/Images/empty_thumbnail.gif";
                    hyperImage.NavigateUrl = "~/Members/UploadPictures.aspx?propertyId=" + propertytable.PropertyID;
                }

                Label lblStatus = (Label)item.FindControl("lblStatus");
                Label lblActivated = (Label)item.FindControl("lblActivated");
                Label lblExpiredDate = (Label)item.FindControl("lblExpiredDate");
                Label lblNumberofDaysView = (Label)item.FindControl("lblNumberofDaysView");
                Label lblNumberOfViews = (Label)item.FindControl("lblNumberOfViews");
                ImageButton imagePreview = (ImageButton)item.FindControl("imagePreview");
                LinkButton linkPreview = (LinkButton)item.FindControl("linkPreview");
                linkPreview.CommandArgument = Convert.ToString(propertytable.PropertyID);

                PreviewPropertyTableAzure prevProprtyTable = Search.GetPreviewValues(propertytable.PropertyID);
                if (prevProprtyTable != null)
                {
                    lblStatus.Text = prevProprtyTable.ListingStatus;
                    lblActivated.Text = Convert.ToString(prevProprtyTable.ActivedDate);
                    lblExpiredDate.Text = Convert.ToString(prevProprtyTable.ExpiryDate);
                    lblNumberOfViews.Text = Convert.ToString(prevProprtyTable.NumberOfView);
                   // lblNumberofDaysView.Text = Convert.ToString(prevProprtyTable.NumberOfView);
                }


            }
        }
    }
}