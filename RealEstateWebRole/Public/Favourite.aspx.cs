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

namespace RealEstateWebRole.Public
{
    public partial class FavouritePage : System.Web.UI.Page
    {
        private List<Favourite> favourites;
        private string FederationForms = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Title = "Terms and Conditions";
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);

                HtmlMeta htmlmeta2 = new HtmlMeta();
                htmlmeta2.Name = "keywords2";
                htmlmeta2.Content = "Nation daily,nation news paper kenya";
                Page.Header.Controls.Add(htmlmeta2);
            }
       
           if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
            if (Session["Favourite"] != null)
            {
                favourites = (List<Favourite>)Session["Favourite"];

                PopulateFavouriteSession();
            }
            else
            {
                favourites = Search.GetFavourite();
                updateSession();
                PopulateFavouriteSession();

            }
        }
        protected void Favourite_LoggedIn(Object sender, EventArgs e)
        {
            foreach (var f in favourites)
            {
                Search.AddFavourite(f);
            }
        }
        private void updateSession()
        {
            Session["Favourite"] = favourites;
        }
        private void PopulateFavouriteSession()
        {
            List<Guid> list = new List<Guid>();
            foreach (var f in favourites)
            {
                list.Add(Guid.Parse(f.PropertyID));
            }
            lstFavourite.DataSource = Search.GetPropertiesAzureById(list);
            lstFavourite.DataBind();
        }
        protected void Remove_OnClick(Object sender, EventArgs args)
        {
            LinkButton button = (LinkButton)sender;

            string propid = Convert.ToString(button.CommandArgument);
            if (Context.User.Identity.IsAuthenticated)
            {
                Search.DeleteFavourite(FederationForms, propid);
                favourites = Search.GetFavourite();
                updateSession();
                PopulateFavouriteSession();
            }
            else
            {
                if (Session["Favourite"] != null)
                {
                    favourites = (List<Favourite>)Session["Favourite"];
                    favourites.RemoveAll(f => f.PropertyID == propid);
                    PopulateFavouriteSession();
                }
            }
        }
        protected void ltvFavourite_itemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                PropertyTableAzure propertyTableAzure = (PropertyTableAzure)e.Item.DataItem;
                if (propertyTableAzure != null)
                {
                    string AgentThumb = "";
                    string AgentBusiness = "";
                    string AgentPhoneNumber = "";
                    string AgentRoad = "";
                    string AgentSurburb = "";
                    string AgentCity = "";
                    string AgentPostalCode = "";
                    string AgentState = "";
                    string PriceDialog = "";
                    string NumberDialog = "";
                    string RoadDialog = "";
                    string SurburbDialog = "";
                    string CityDialog = "";
                    string State = "";
                    string ZipCodeDialog = "";
                    string PropertyType = "";
                    string PropertyThumb = "";


                    ListViewDataItem item = (ListViewDataItem)e.Item;
                    HyperLink hyperImage = (HyperLink)item.FindControl("hypImage");
                    Label lblPrice = (Label)item.FindControl("lblPrice");
                    Label lblAddress = (Label)item.FindControl("lblAddress");
                    HyperLink hypContact = (HyperLink)item.FindControl("hypContact");
                    Label lblFeature = (Label)item.FindControl("lblFeature");
                    LinkButton lkbRemove = (LinkButton)item.FindControl("lkbRemove");



                    //Contact Us form

                    HyperLink hyperSendEmail = (HyperLink)item.FindControl("hyperSendEmail");

                    lkbRemove.CommandArgument = Convert.ToString(propertyTableAzure.PropertyID);


                    lblFeature.Text = propertyTableAzure.AttributeTableAzure.BedRooms + "  Bedroom House " + propertyTableAzure.PropertyType;
                    NumberDialog = propertyTableAzure.StreetNumber;

                    RoadDialog = propertyTableAzure.StreetName;

                    SurburbDialog = propertyTableAzure.Suburb;

                    CityDialog = propertyTableAzure.City;
                    Session["City"] = propertyTableAzure.City;
                    // lblState.Text = table.Province;
                    State = propertyTableAzure.Province;
                    // lblPropertyType.Text = table.PropertyType;
                    PropertyType = propertyTableAzure.PropertyType;
                    ZipCodeDialog = "abraham";

                    //hdfLat.Value = table.Latitude;
                    //hdfLong.Value = table.Longitude;





                    if (propertyTableAzure.EstateAgentAzure != null)
                    {

                        //Get the reference of the control from the UI



                        AgentBusiness = propertyTableAzure.EstateAgentAzure.BusinessName;

                        AgentPhoneNumber = propertyTableAzure.UsersTableAzure.WorkPhone;

                        AgentRoad = propertyTableAzure.EstateAgentAzure.AgentAddress;

                        AgentSurburb = "";

                        AgentCity = propertyTableAzure.EstateAgentAzure.City;

                        AgentPostalCode = propertyTableAzure.EstateAgentAzure.PostalCode;
                        AgentState = propertyTableAzure.EstateAgentAzure.State_Prov;
                        if (propertyTableAzure.EstateAgentAzure.ProfilePhotoUrl != null)
                        {
                            if (!string.IsNullOrWhiteSpace(propertyTableAzure.EstateAgentAzure.ProfilePhotoUrl))
                            {

                                AgentThumb = propertyTableAzure.EstateAgentAzure.ProfilePhotoUrl;
                            }
                            else
                            {

                                AgentThumb = "http://127.0.0.1:81/Images/empty_thumbnail.gif";
                            }
                        }
                        else
                        {

                            AgentThumb = "http://127.0.0.1:81/Images/empty_thumbnail.gif";
                        }

                    }


                    //lblZipCodeDialog.Text=table.
                    //Property Details



                    lblAddress.Text = propertyTableAzure.StreetName + " " + propertyTableAzure.Suburb + " " + propertyTableAzure.City;



                    if (propertyTableAzure.ImageUrlAzures.Count() > 0)
                    {
                        //lblNumberOfImages.Text = propertyTableAzure.ImageUrlAzures.Count() + " Photos Available";

                        if (propertyTableAzure.ImageUrlAzures[0].thumbnailblob != null)
                        {
                            hyperImage.ImageUrl = propertyTableAzure.ImageUrlAzures[0].thumbnailblob;

                            hyperImage.Width = 152;
                            hyperImage.Height = 100;
                            PropertyThumb = propertyTableAzure.ImageUrlAzures[0].thumbnailblob;
                        }
                        else
                        {
                            hyperImage.ImageUrl = "~/Images/images_propertysearch.jpg";
                            hyperImage.Width = 152;
                            hyperImage.Height = 100;
                            PropertyThumb = "http://127.0.0.1:81/Images/images_propertysearch.jpg";
                        }
                    }

                    else
                    {
                        hyperImage.ImageUrl = "~/Images/images_propertysearch.jpg";
                        hyperImage.Width = 152;
                        hyperImage.Height = 100;
                        PropertyThumb = "http://127.0.0.1:81/Images/images_propertysearch.jpg";

                    }





                    hyperImage.NavigateUrl = "~/Public/PropertyDetails.aspx?PropertyID=" + propertyTableAzure.PropertyID;
                    if (propertyTableAzure.PriceTableAzure != null)
                    {
                        lblPrice.Text = string.Format("R {0}", propertyTableAzure.PriceTableAzure.MonthlyRental);
                        PriceDialog = propertyTableAzure.PriceTableAzure.MonthlyRental;
                    }
                    String clientDetails = PriceDialog + ";" + NumberDialog + ";" + RoadDialog + " ;" + SurburbDialog + ";" + CityDialog + ";" + State + ";" + PropertyThumb + ";" + PropertyType + ";" + propertyTableAzure.PropertyID + ";" + propertyTableAzure.UserID + ";" + AgentThumb + ";" + AgentBusiness + ";" + AgentPhoneNumber + ";" + AgentRoad + ";" + AgentSurburb + ";" + AgentCity + ";" + AgentPostalCode + ";" + AgentState;
                    hypContact.Attributes.Add("onClick", "SubmitClientDetails('" + clientDetails + "')");



                }
            }
        }
    }

}