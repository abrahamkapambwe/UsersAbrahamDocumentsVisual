using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Web.UI.HtmlControls;
using System.Net;
using System.IO;
using System.Text;
using System.Runtime.Serialization;
using System.Xml.Serialization;
using System.Runtime.Serialization.Json;
using PlacesResults;


namespace RealEstateWebRole.Public
{
    public partial class PropertyDetails : System.Web.UI.Page
    {
        int numberOfImages = 0;
        string sellmetaTag = "";
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
        private PropertyTableAzure property;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
              
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);

                HtmlMeta htmlmeta2 = new HtmlMeta();
                htmlmeta2.Name = "keywords2";

                if (Request.QueryString["PropertyID"] != null)
                {

                    string propertyid = Convert.ToString(Request.QueryString["PropertyID"]);

                    property = Search.GetPropertyTableFromCache(Guid.Parse(propertyid));

                    int? views = Search.UpdateViewNum(Guid.Parse(propertyid));
                    lblNumberOfTimes.Text = Convert.ToString(views);
                    lblWebReference.Text = property.WebReference;
                    if (property.ImageUrlAzures.Count > 0)
                    {
                        RadRotator1.DataSource = property.ImageUrlAzures;
                        RadRotator1.DataBind();
                        listviewDetails.DataSource = property.ImageUrlAzures;
                        listviewDetails.DataBind();
                        //ImageUrlAzure imgthumb = list[0];
                        imgPropThumb.ImageUrl = property.ImageUrlAzures[0].thumbnailblob;
                        imgPropThumb.Visible = true;
                    }
                    else
                    {
                        RadRotator1.Visible = false;
                        imgNoImage.Visible = true;
                        imgNoImage.ImageUrl = "~/Images/images_propertysearch.jpg";
                        imgPropThumb.ImageUrl = "~/Images/images_propertysearch.jpg";
                    }

                    //estate details
                    if (property.EstateAgentAzure != null)
                    {
                        EstateAg.Visible = true;



                        if (!string.IsNullOrWhiteSpace(property.EstateAgentAzure.ProfilePhotoUrl))
                        {
                            hypImage.ImageUrl = property.EstateAgentAzure.ProfilePhotoUrl;
                            imgAgentThumb.ImageUrl = property.EstateAgentAzure.ProfilePhotoUrl;
                        }
                        else
                        {
                            hypImage.ImageUrl = "~/Images/images_propertysearch.jpg";
                            imgAgentThumb.ImageUrl = "~/Images/images_propertysearch.jpg";
                        }
                        lblBusinessName.Text = property.EstateAgentAzure.BusinessName;
                        lblAddress.Text = property.EstateAgentAzure.AgentAddress;
                        lblCityEstate.Text = property.EstateAgentAzure.City;
                        lblestatePhone.Text = property.UsersTableAzure.WorkPhone;

                        lblAgentCity.Text = property.EstateAgentAzure.City;
                        lblAgentPhoneNumber.Text = property.UsersTableAzure.WorkPhone;
                        lblAgentPostalCode.Text = property.EstateAgentAzure.PostalCode;
                        lblAgentBusiness.Text = property.EstateAgentAzure.BusinessName;
                        lblAgentRoad.Text = property.EstateAgentAzure.Road;
                        lblAgentState.Text = property.EstateAgentAzure.State_Prov;
                    }
                    else
                    {
                        EstateAg.Visible = false;
                        imgAgentThumb.Visible = false;
                    }


                    //Property details
                    if (property.AttributeTableAzure != null)
                    {
                        GetFeatures(property.AttributeTableAzure);
                    }
                    if (property.PriceTableAzure != null)
                    {
                        lblPrice.Text = "Kshs" + Convert.ToString(property.PriceTableAzure.MonthlyRental);
                        lblPrice2.Text = "Kshs " + Convert.ToString(property.PriceTableAzure.MonthlyRental);
                        lblDescription.Text = Convert.ToString(property.PriceTableAzure.Description);
                        lblPriceDialog.Text = Convert.ToString(property.PriceTableAzure.MonthlyRental);
                    }
                    //lblCity.Text = property.City;
                    // lblUnitNumber.Text = property.UnitNumber;
                    //lblRoad.Text = property.StreetName;
                    lblSuburb.Text = CheckContainHomeType(property.PriceTableAzure.Attributes) + " " + property.PropertyType + "<br/>" + property.UnitNumber + " " + property.Municipality + " <br/>" + property.StreetNumber + " " + property.StreetName + ",<b/>" + property.Suburb + " " + property.City;
                    sellmetaTag = lblSuburb.Text;
                    lblDetails.Text = CheckContainHomeType(property.PriceTableAzure.Attributes) + " " + property.PropertyType + "<br/>" + property.UnitNumber + " " + property.Municipality + " " + property.StreetNumber + " " + property.StreetName + ",<b/>" + property.Suburb + " " + property.City + " " + property.Province;
                    lblPropertyType1.Text = CheckContainHomeType(property.PriceTableAzure.Attributes) + " " + property.PropertyType;
                    lblAddress2.Text = property.StreetName + " " + property.Suburb + " " + property.City;
                    lblCityDialog.Text = property.City;

                    lblRoadDialog.Text = property.StreetName;
                    lblSurburbDialog.Text = property.Suburb;
                    // lblPropertyType.Text = property.PropertyType;
                    UnitNumberDialog.Text = property.UnitNumber;
                    lblStateDialog.Text = property.Province;

                    hyperFriend.Attributes.Add("OnClick", "SubmitClientDetails('" + divFriend.ClientID + "')");
                    hyperView.Attributes.Add("OnClick", "SubmitClientDetails('" + divContact.ClientID + "')");
                    HyperArrangeView2.Attributes.Add("OnClick", "SubmitClientDetails('" + divContact.ClientID + "')");
                    btnContactAgent.Attributes.Add("OnClick", "SubmitClientDetails('" + divContact.ClientID + "')");
                    Hidecontent.Attributes.Add("onClick", "Hide('" + divContact.ClientID + "')");
                    //set up the client ids for the friends form
                    string clientfriendids = txtYourName.ClientID + ";" + txtyouremailaddress.ClientID + ";" + txtfirstfriendsname.ClientID + ";" + txtfirstfriendsemail.ClientID + ";" + txtsecondfriendname.ClientID + ";" + txtsecondfriendemail.ClientID + ";" + txtComment.ClientID + ";" + propertyid;
                    hypSendMailFriend.Attributes.Add("OnClick", "SubmitEmailsFriends('" + clientfriendids + "')");
                    hidedivFriend.Attributes.Add("OnClick", "Hide('" + divFriend.ClientID + "')");
                    //set up the ids for the contact us form
                    string clientid = divContact.ClientID + ";" + txtName.ClientID + ";" + txtPhone.ClientID + ";" + txtEmail.ClientID + ";" + txtMessage.ClientID + ";" + propertyid + ";" + property.UserID;

                    hyperSendEmail.Attributes.Add("OnClick", "SubmitClientPersonalDetails('" + clientid + "')");

                    //imap.Attributes.Add("src", "/Public/maps/uploadMap.aspx?lat=" + property.Latitude + "&lng=" + property.Longtitude);
                    imap.Attributes.Add("src", "/Public/Map/Map.aspx?lat=" + property.Latitude + "&lng=" + property.Longitude);
                    LoadNearPlace();
                    Page.Title = lblPropertyBed.Text + "  in  " + lblSuburb.Text + " ," + property.City;
                    htmlmeta2.Content = sellmetaTag;
                    Page.Header.Controls.Add(htmlmeta2);
                }
            }

        }


        private void GetFeatures(AttributeTableAzure propertyattributestate)
        {

            if (!string.IsNullOrEmpty(propertyattributestate.AccessGate))
            {
                string value = propertyattributestate.AccessGate;
                Features.Add(value);


            }
            if (!string.IsNullOrEmpty(propertyattributestate.AirCon))
            {

                string value = propertyattributestate.AirCon;
                Features.Add(value);


            }
            if (!string.IsNullOrEmpty(propertyattributestate.Alarm))
            {

                string value = propertyattributestate.Alarm;
                Features.Add(value);


            }
            if (!string.IsNullOrEmpty(propertyattributestate.Balcony))
            {

                string value = propertyattributestate.Balcony;
                Features.Add(value);


            }
            if (!string.IsNullOrEmpty(Convert.ToString(propertyattributestate.Bathrooms)))
            {
                string value = Convert.ToString(propertyattributestate.Bathrooms);
                Features.Add(value + " Bathrooms");
            }



            if (!string.IsNullOrEmpty(Convert.ToString(propertyattributestate.BedRooms)))
            {
                string value = Convert.ToString(propertyattributestate.BedRooms);
                Features.Add(value + " Bedroom");
                lblPropertyBed.Text = value + " Bedroom House";
            }



            if (!string.IsNullOrEmpty(propertyattributestate.Borehole))
            {
                string value = propertyattributestate.Borehole;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.BuiltInBraai))
            {
                string value = propertyattributestate.BuiltInBraai;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.BuiltInCupBoard))
            {
                string value = propertyattributestate.BuiltInCupBoard;
                Features.Add(value);
            }




            if (!string.IsNullOrEmpty(propertyattributestate.BusinessType))
            {
                string value = propertyattributestate.BusinessType;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(Convert.ToString(CheckForNullableInt(propertyattributestate.Carports))))
            {
                string value = Convert.ToString(CheckForNullableInt(propertyattributestate.Carports));
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.ClubHouse))
            {
                string value = propertyattributestate.ClubHouse;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.Deck))
            {
                string value = Convert.ToString(propertyattributestate.Deck);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.DiningArea))
            {
                string value = propertyattributestate.DiningArea;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.DisabilityAccess))
            {
                string value = Convert.ToString(propertyattributestate.DisabilityAccess);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.ElectricFencing))
            {
                string value = propertyattributestate.ElectricFencing;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.ElectricityIncluded))
            {
                string value = Convert.ToString(propertyattributestate.ElectricityIncluded);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.EnSuite))
            {
                string value = propertyattributestate.EnSuite;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.EntranceHall))
            {
                string value = Convert.ToString(propertyattributestate.EntranceHall);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Family_TV))
            {
                string value = propertyattributestate.Family_TV;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.FarmBuilding))
            {
                string value = Convert.ToString(propertyattributestate.FarmBuilding);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.FarmName))
            {
                string value = Convert.ToString(propertyattributestate.FarmName);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.FarmType))
            {
                string value = propertyattributestate.FarmType;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.Fence))
            {
                string value = Convert.ToString(propertyattributestate.Fence);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Finishes))
            {
                string value = Convert.ToString(propertyattributestate.Finishes);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Fireplace))
            {
                string value = Convert.ToString(propertyattributestate.Fireplace);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.FloorArea))
            {
                string value = propertyattributestate.FloorArea;
                Features.Add(value);
            }



            if (!string.IsNullOrEmpty(propertyattributestate.Flatlet))
            {
                string value = Convert.ToString(propertyattributestate.Flatlet);
                Features.Add(value);
            }

            if (!string.IsNullOrEmpty(propertyattributestate.Furnished))
            {
                string value = Convert.ToString(propertyattributestate.Furnished);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Garages))
            {
                string value = Convert.ToString(propertyattributestate.Garages);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Garden))
            {
                string value = Convert.ToString(propertyattributestate.Garden);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.GardenCottage))
            {
                string value = propertyattributestate.GardenCottage;
                Features.Add(value);
            }

            if (!string.IsNullOrEmpty(propertyattributestate.Golf))
            {
                string value = Convert.ToString(propertyattributestate.Golf);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.GuestToilet))
            {
                string value = propertyattributestate.GuestToilet;
                Features.Add(value);
            }

            if (!string.IsNullOrEmpty(propertyattributestate.Gym))
            {
                string value = Convert.ToString(propertyattributestate.Gym);
                Features.Add(value);
            }
            if (!string.IsNullOrEmpty(propertyattributestate.Storage))
            {
                string value = Convert.ToString(propertyattributestate.Storage);
                Features.Add(value);
            }
            bool right = true;
            foreach (var item in Features)
            {
                if (right)
                {
                    HtmlGenericControl html = new HtmlGenericControl("li");
                    html.InnerText = item;
                    html.Attributes.Add("styel", "margin-bottom:5px");
                    right = false;
                    RightlistItem.Controls.Add(html);
                }
                else
                {
                    HtmlGenericControl html = new HtmlGenericControl("li");
                    html.Attributes.Add("styel", "margin-bottom:5px");
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
        protected void listview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                ListViewDataItem item = (ListViewDataItem)e.Item;
                ImageUrlAzure imageurl = (ImageUrlAzure)e.Item.DataItem;

                Image ImageLink = (Image)item.FindControl("ImageLink");
                HtmlGenericControl liImage = (HtmlGenericControl)item.FindControl("liImage");
                ImageLink.ImageUrl = imageurl.imageblob;
                if (numberOfImages != 0)
                {
                    liImage.Attributes.Add("class", "ImageHidden");
                }


                numberOfImages = numberOfImages + 1;
            }
        }
        public void LoadNearPlace()
        {
            //WebRequest request = WebRequest.Create("http://www.streetmaps.co.za/ajax_points.asp?key=UJMCCKRSPXFYKWHBQJUCGQUOJSNURVGR&x=" + property.Latitude + "&y=" + property.Longitude + "&r=2&max=100");
            //WebResponse response = request.GetResponse();
            //Stream stream = response.GetResponseStream();
            //StreamReader readStream = new StreamReader(stream, Encoding.UTF8);
            //XmlSerializer serializer = new XmlSerializer(typeof(Result));
            //string results = readStream.ReadToEnd();
            ////DataContractSerializer seriler = new DataContractSerializer(typeof(Result));
            //Result resp = (Result)serializer.Deserialize(stream);
            //IEnumerable<Places> places = null;
            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://maps.googleapis.com/maps/api/place/search/json?location=" + property.Latitude + "," + property.Longitude + "&radius=500&types=school&sensor=false&key=AIzaSyB-M_t041Za_HC-urrhAYxWl4URq75rYFk");
            //HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            //Stream stream = response.GetResponseStream();
            //StreamReader strReader = new StreamReader(stream);

            //string strResponse = strReader.ReadToEnd();
            //DataContractJsonSerializer seriler = new DataContractJsonSerializer(typeof(Places[]));
            //places = seriler.ReadObject(stream) as IEnumerable<Places>;

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