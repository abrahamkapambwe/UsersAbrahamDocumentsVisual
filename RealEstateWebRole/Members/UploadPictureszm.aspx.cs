using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using RealEstateLibraries;
using System.Net;
using System.Runtime.Serialization.Json;
using System.IO;
using PlacesResults;
using AddressResult;

using System.Threading;
using RealEstateWebRole.Members.maps;
using RealEstateWebRole.Admin;
using System.Text;
namespace RealEstateWebRole.Account
{
    public partial class UploadPictureszm : System.Web.UI.Page
    {
        private string address;
        private string FederationForms = "";

        protected void Page_PreInit(object sender, EventArgs e)
        {
            //if (Session["ShowMap"] != null)
            //{
            //    var show = (bool)Session["ShowMap"];
            //    if (show)
            //        this.MasterPageFile = "~/UploadPictures.Master";
            //    Session["ShowMap"] = false;
            //}

        }
        protected void Page_Load(object sender, EventArgs e)
        {


           
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["moneybookerstatus"] != null)
                {
                    string status = Convert.ToString(Request.QueryString["moneybookerstatus"]);
                    string propID = Convert.ToString(Request.QueryString["propId"]);
                    //string status = Convert.ToString(Request.QueryString["moneybookerstatus"]);
                    Session["propID"] = propID;
                    string payments = "";
                    if (status.Contains("success"))
                    {
                        payments = "Paid";
                    }
                    else if (status.Contains("cancel"))
                    {
                        payments = "Cancelled";
                    }
                    string value = Request.Params[0];
                    Search.UpdatePaymentStatus(Guid.Parse(propID), payments);
                    Request.QueryString["moneybookerstatus"] = null;
                    MultiView1.ActiveViewIndex = 4;
                }
                ddlFeatures.DataSource = Search.GetAttributes();
                ddlFeatures.DataBind();
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    SavePropDetailsToDB();
                    LoadData();


                }


                if (Request.QueryString["FromAgent"] != null)
                {
                    MultiView1.ActiveViewIndex = 1;
                    LoadSelectedState(1);
                }
            }

        }

        #region PrivateMethod

        private void SavePropDetailsToDB()
        {
            UsersTableAzure user = Search.GetUserProfile(FederationForms);
            if (user == null)
            {

                Search.SavePropDetailsFirstTime(FederationForms, FederationForms);
            }
        }

        private void LoadData()
        {
            if (Session["Status"] != null)
            {
                string rentOrsale = (string)Session["Status"];
                if (rentOrsale == "OneMonth" || rentOrsale == "ThreeMonth")
                {
                    ddlPropertyType.Items.FindByText("For Sale").Selected = true;
                }
                else
                {
                    ddlPropertyType.Items.FindByText("For Rent").Selected = true;

                }
            }

            string prop = "";
            //Get the profile data
            UsersTableAzure user = Search.GetUserProfile(FederationForms);
            if (user != null)
            {

                txtFirstname.Text = user.FirstName;
                txtLastname.Text = user.Surname;
                txtCellPhone.Text = user.Cellphone;
                txtHomePhone.Text = user.HomePhone;
                txtWorkPhone.Text = user.WorkPhone;
                txtAddress.Text = user.HomeAddress;
                hdfUserID.Value = Convert.ToString(user.UserID);

                txtEmailAddress.Text = FederationForms;
                LoadSelectedState(1);

                if (Request.QueryString["propertyId"] != null)
                {

                    prop = Convert.ToString(Request.QueryString["propertyId"]);







                    //Get the property data

                    PropertyTableAzure property = Search.GetPropertyTable(user.UserName, Guid.Parse(prop));
                    if (property != null)
                    {
                        if (!string.IsNullOrEmpty(property.PropertyType))
                            ddlPropertyType.Items.FindByText(property.PropertyType).Selected = true;
                        txtStreetnumber.Text = property.StreetNumber;
                        txtStreetname.Text = property.StreetName;
                        txtUnitName.Text = property.Municipality;
                        txtSuburb.Text = property.Suburb;
                        txtCity.Text = property.City;
                        hdfWebrefence.Value = property.WebReference;
                        txtUnitNumber.Text = Convert.ToString(property.UnitNumber);
                        ddlProvince.Items.FindByText(property.Province).Selected = true;
                        txtCountry.Text = property.Country;

                        hdfPropertyID.Value = Convert.ToString(property.PropertyID);


                        hdfLatitude.Value = property.Latitude;
                        hdfLongitude.Value = property.Longitude;



                    }


                    //Get the price
                    PriceTableAzure price = Search.GetPriceTable(property.PropertyID);
                    if (price != null)
                        if (ddlPropertyType.SelectedValue.Contains("For Sale"))
                        {
                            lblPriceProperty.Text = "Sale Price Kshs";
                        }
                        else if (ddlPropertyType.SelectedValue.Contains("For Rent"))
                        {
                            lblPriceProperty.Text = "Monthly rental Kshs";
                        }
                    {
                        txtMonthlyrental.Text = Convert.ToString(price.MonthlyRental);
                        txtDescription.Text = price.Description;
                        hdfPriceID.Value = Convert.ToString(price.PriceID);

                        if (!string.IsNullOrWhiteSpace(price.Attributes))
                        {
                            string[] attributes = price.Attributes.Split(new char[] { '|' });

                            foreach (var attr in attributes)
                            {
                                if (attr.Contains("Bathroom"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Bathroom"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        txtBathrooms.Text = item;
                                        tblBathrooms.Visible = true;
                                    }

                                }
                                else if (attr.Contains("Bedroom"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Bedroom"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblBedrooms.Visible = true;
                                        txtBedrooms.Text = item;

                                    }

                                }
                                else if (attr.Contains("Carports"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Carports"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblCarports.Visible = true;
                                        txtCarports.Text = Convert.ToString(attr);

                                    }
                                }
                                else if (attr.Contains("Dining-Area"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Dining-Area"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblDiningArea.Visible = true;


                                        txtDiningArea.Text = item;

                                    }
                                }
                                else if (attr.Contains("En-Suite"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "En-Suite"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblEnSuite.Visible = true;

                                        txtEnSuite.Text = item;

                                    }
                                }
                                else if (attr.Contains("Farm-name"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Farm-name"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblFarmName.Visible = true;


                                        txtfarmName.Text = item;

                                    }
                                }
                                else if (attr.Contains("Floor-Area"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Floor-Area"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblFloorArea.Visible = true;


                                        txtFloorArea.Text = item;

                                    }
                                }
                                else if (attr.Contains("Garages"))
                                {
                                    string[] bathroom = attr.Split(new char[] { ' ' });
                                    var item = (from a in bathroom
                                                where a != "Garages"
                                                select a).FirstOrDefault();
                                    if (!string.IsNullOrWhiteSpace(item))
                                    {
                                        tblGarage.Visible = true;



                                        txtGarage.Text = item;

                                    }
                                }
                                switch (attr)
                                {
                                    case "Access Gate":
                                        tblAccessGate.Visible = true;
                                        AccessGate.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Air Con":
                                        tblAirCon.Visible = true;
                                        AirCon.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Alarm":
                                        tblAlarm.Visible = true;
                                        Alarm.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Balcony":
                                        tblBalcony.Visible = true;
                                        Balcony.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Borehole":
                                        tblBorehole.Visible = true;
                                        Borehole.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Built-in Braai":
                                        tblBuiltinBraai.Visible = true;
                                        BuiltinBraai.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Built-in Cupboards":
                                        tblBuiltinCupboards.Visible = true;
                                        BuiltinCupboards.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Offices":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Commercials":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Industrial":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Retails":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Other":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Hotel":
                                        tblBusinessType.Visible = true;
                                        BusinessType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "ClubHouse":
                                        tblClubHouse.Visible = true;
                                        clubHouse.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Deck":
                                        tblDeck.Visible = true;
                                        ddlDeck.Items.FindByText("Yes").Selected = true;
                                        break;
                                    case "Disability Access":
                                        tblDisabilityAccess.Visible = true;
                                        ddlDisabilityAccess.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Electric Fencing":
                                        tblElectricfencing.Visible = true;
                                        ddlElectricFencing.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Electricity Included":
                                        tblElectricityIncluded.Visible = true;
                                        ddlElectricityIncluded.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Entrance Hall":
                                        tblEntranceHall.Visible = true;
                                        ddlEntranceHall.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Family/TV":
                                        tblFamilyTV.Visible = true;
                                        ddlFamilyTV.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Crop farm":
                                        tblFarmType.Visible = true;
                                        ddlFarmType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Beef farm":
                                        tblFarmType.Visible = true;
                                        ddlFarmType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Dairy farm":
                                        tblFarmType.Visible = true;
                                        ddlFarmType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Orchard farm":
                                        tblFarmType.Visible = true;
                                        ddlFarmType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Poutry farm":
                                        tblFarmType.Visible = true;
                                        ddlFarmType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Barn":
                                        tblFarmBuilding.Visible = true;
                                        ddlFarmBuilding.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Birthing Pens":
                                        tblFarmBuilding.Visible = true;
                                        ddlFarmBuilding.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Silo":
                                        tblFarmBuilding.Visible = true;
                                        ddlFarmBuilding.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Milking Shed":
                                        tblFarmBuilding.Visible = true;
                                        ddlFarmBuilding.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Fence":
                                        tblFence.Visible = true;
                                        ddlFence.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Very High":
                                        tblFamilyTV.Visible = true;
                                        ddlFinishes.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "High":
                                        tblFamilyTV.Visible = true;
                                        ddlFinishes.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Medium":
                                        tblFamilyTV.Visible = true;
                                        ddlFinishes.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Budget":
                                        tblFamilyTV.Visible = true;
                                        ddlFinishes.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Fireplace":
                                        tblfirePlace.Visible = true;
                                        ddlFirePlace.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Flatlet":
                                        tblFlatlet.Visible = true;
                                        ddlFlatlet.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Furnished":
                                        tblFurnished.Visible = true;
                                        ddlFurnished.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Garden":
                                        tblGarden.Visible = true;
                                        ddlGarden.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Garden-Cottage":
                                        tblGardenCottage.Visible = true;
                                        ddlGardenCottage.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Golf":
                                        tblGolf.Visible = true;
                                        ddlGolf.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Guest Toilet":

                                        tblGuestToilet.Visible = true;
                                        ddlGuestToilet.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Gym":

                                        tblGym.Visible = true;
                                        ddlGym.Items.FindByValue("Yes").Selected = true;
                                        break;
                                    case "Duplex":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Apartment":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "House":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Cluster":

                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Simplex":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Garden Cottage":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Townhome":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Land":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    case "Farm":
                                        //tblHomeType.Visible = true;
                                        chbHomeType.Items.FindByValue(attr).Selected = true;
                                        break;
                                    default:
                                        break;
                                }
                            }


                        }


                    }
                }

            }
            else
            {
                hdfAttributeID.Value = Convert.ToString(-1);
                hdfAttributeStateID.Value = Convert.ToString(-1);
                hdfPriceID.Value = Convert.ToString(-1);
                hdfPropertyID.Value = Convert.ToString(-1);


                txtEmailAddress.Text = FederationForms;
                txtEmailAddress.ReadOnly = true;

            }
        }

        private void LoadSelectedState(int i)
        {
            switch (i)
            {
                case 1:
                    lkbContactInformation.Enabled = false;
                    lkblocation.Enabled = true;
                    lkbdetails.Enabled = true;
                    lkbimages.Enabled = true;
                    lkbpreview.Enabled = true;

                    divContactInfo.Disabled = true;
                    divPropertyLoc.Disabled = false;
                    divPropertyDetails.Disabled = false;
                    divUploadImages.Disabled = false;
                    divPreview.Disabled = false;

                    divContactInfo.Attributes.Add("class", "activeStep");
                    divPropertyLoc.Attributes.Add("class", "inactiveStep");

                    divPropertyDetails.Attributes.Add("class", "inactiveStep");
                    divUploadImages.Attributes.Add("class", "inactiveStep");
                    divPreview.Attributes.Add("class", "inactiveStep");
                    break;
                case 2:
                    lkbContactInformation.Enabled = true;
                    lkblocation.Enabled = false;
                    lkbdetails.Enabled = true;
                    lkbimages.Enabled = true;
                    lkbpreview.Enabled = true;

                    divContactInfo.Disabled = false;
                    divPropertyLoc.Disabled = true;
                    divPropertyDetails.Disabled = false;
                    divUploadImages.Disabled = false;
                    divPreview.Disabled = false;

                    divContactInfo.Attributes.Add("class", "inactiveStep");
                    divPropertyLoc.Attributes.Add("class", "activeStep");

                    divPropertyDetails.Attributes.Add("class", "inactiveStep");
                    divUploadImages.Attributes.Add("class", "inactiveStep");
                    divPreview.Attributes.Add("class", "inactiveStep");
                    break;
                case 3:
                    lkbContactInformation.Enabled = true;
                    lkblocation.Enabled = true;
                    lkbdetails.Enabled = false;
                    lkbimages.Enabled = true;
                    lkbpreview.Enabled = true;

                    divContactInfo.Disabled = false;
                    divPropertyLoc.Disabled = false;
                    divPropertyDetails.Disabled = true;
                    divUploadImages.Disabled = false;
                    divPreview.Disabled = false;

                    divContactInfo.Attributes.Add("class", "inactiveStep");
                    divPropertyLoc.Attributes.Add("class", "inactiveStep");

                    divPropertyDetails.Attributes.Add("class", "activeStep");
                    divUploadImages.Attributes.Add("class", "inactiveStep");
                    divPreview.Attributes.Add("class", "inactiveStep");
                    break;
                case 4:
                    lkbContactInformation.Enabled = true;
                    lkblocation.Enabled = true;
                    lkbdetails.Enabled = true;
                    lkbimages.Enabled = false;
                    lkbpreview.Enabled = true;

                    divContactInfo.Disabled = false;
                    divPropertyLoc.Disabled = false;
                    divPropertyDetails.Disabled = false;
                    divUploadImages.Disabled = true;
                    divPreview.Disabled = false;

                    divContactInfo.Attributes.Add("class", "inactiveStep");
                    divPropertyLoc.Attributes.Add("class", "inactiveStep");

                    divPropertyDetails.Attributes.Add("class", "inactiveStep");
                    divUploadImages.Attributes.Add("class", "activeStep");
                    divPreview.Attributes.Add("class", "inactiveStep");
                    break;
                case 5:

                    lkbContactInformation.Enabled = true;
                    lkblocation.Enabled = true;
                    lkbdetails.Enabled = true;
                    lkbimages.Enabled = true;
                    lkbpreview.Enabled = false;

                    divContactInfo.Disabled = false;
                    divPropertyLoc.Disabled = false;
                    divPropertyDetails.Disabled = false;
                    divUploadImages.Disabled = false;
                    divPreview.Disabled = true;

                    divContactInfo.Attributes.Add("class", "inactiveStep");
                    divPropertyLoc.Attributes.Add("class", "inactiveStep");

                    divPropertyDetails.Attributes.Add("class", "inactiveStep");
                    divUploadImages.Attributes.Add("class", "inactiveStep");
                    divPreview.Attributes.Add("class", "activeStep");
                    break;
                default:
                    break;
            }
        }
        #endregion
        #region Events
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //PropertyTable propertytable = new PropertyTable();



        }
        protected void btnattribute_Onclick(object sender, EventArgs e)
        {
            switch (ddlFeatures.SelectedValue)
            {
                case "Access Gate":
                    tblAccessGate.Visible = true;

                    break;
                case "Air Con":

                    tblAirCon.Visible = true;
                    break;
                case "Alarm":

                    tblAlarm.Visible = true;
                    break;
                case "Balcony":

                    tblBalcony.Visible = true;
                    break;
                case "Bathrooms":
                    tblBathrooms.Visible = true;

                    break;
                case "Bedrooms":
                    tblBedrooms.Visible = true;
                    break;
                case "Borehole":
                    tblBorehole.Visible = true;
                    break;
                case "Built-in Cupboards":
                    tblBuiltinCupboards.Visible = true;
                    break;
                case "Built-in Braai":
                    tblBuiltinBraai.Visible = true;
                    break;
                case "Business Type":
                    tblBusinessType.Visible = true;
                    break;
                case "Carports":
                    tblCarports.Visible = true;
                    break;
                case "Clubhouse":
                    tblClubHouse.Visible = true;
                    break;
                case "Deck":
                    tblHomeType.Visible = true;
                    break;
                case "Dinning Areas":
                    tblDiningArea.Visible = true;
                    break;
                case "Electric Fencing":
                    tblElectricfencing.Visible = true;
                    break;
                case "Electricity Included":
                    tblElectricityIncluded.Visible = true;
                    break;
                case "En Suite":
                    tblEnSuite.Visible = true;
                    break;
                case "Entrance Hall":
                    tblEntranceHall.Visible = true;
                    break;
                case "Land Area":
                    tblAccessGate.Visible = true;
                    break;
                case "Family/TV":
                    tblFamilyTV.Visible = true;
                    break;
                case "Farm Type":
                    tblFarmType.Visible = true;
                    break;
                case "Farm Building":
                    tblFarmBuilding.Visible = true;
                    break;
                case "Home Type":
                    tblHomeType.Visible = true;
                    break;
                case "Farm Name":
                    tblFarmName.Visible = true;
                    break;
                case "Fence":
                    tblFence.Visible = true;
                    break;
                case "Finishes":
                    tblFinishes.Visible = true;
                    break;
                case "Fireplace":
                    tblfirePlace.Visible = true;
                    break;
                case "Flatlet":
                    tblFlatlet.Visible = true;
                    break;
                case "  Floor Area":
                    tblFloorArea.Visible = true;
                    break;
                case "Furnished":
                    tblFurnished.Visible = true;
                    break;
                case "Garages":
                    tblGarage.Visible = true;
                    break;
                case "Garden":
                    tblGarden.Visible = true;
                    break;
                case "Garden Cottage":
                    tblGardenCottage.Visible = true;
                    break;
                case "Golf":
                    tblGolf.Visible = true;
                    break;
                case "Guest Toilet":
                    tblGuestToilet.Visible = true;
                    break;
                case "Gym":
                    tblGym.Visible = true;
                    break;
                case " Disability Access":
                    tblDisabilityAccess.Visible = true;
                    break;
                default:
                    break;
            }


        }



        protected void Property_Click(object sender, EventArgs e)
        {
            PropertyTableAzure prop = new PropertyTableAzure();
            prop.StreetNumber = txtStreetnumber.Text;
            prop.StreetName = txtStreetname.Text;
            prop.Municipality = txtUnitName.Text;
            prop.Suburb = txtSuburb.Text;
            prop.City = txtCity.Text;
            prop.Province = ddlProvince.SelectedValue;
            prop.Country = txtCountry.Text;
            prop.Added = DateTime.Now;
            prop.UserName = FederationForms;
            prop.WebReference = hdfWebrefence.Value;
            prop.Longitude = "";
            prop.Latitude = "";
            prop.PropertyType = "";

            prop.UnitNumber = txtUnitNumber.Text;


            //prop.UniqueNumberUser = Guid.NewGuid();
            if (ddlPropertyType.SelectedValue != "Select")
            {
                prop.PropertyType = ddlPropertyType.SelectedValue;
            }
            string UserId;
            if (!string.IsNullOrEmpty(hdfUserID.Value))
            {
                Session["UserID"] = hdfUserID.Value;
                prop.UserID = Convert.ToString(hdfUserID.Value);
            }
            else if (Session["UserID"] != null)
            {
                UserId = (string)Session["UserID"];
                prop.UserID = UserId;
            }

            else
            {
                //Keys keys = Search.GetID(FederationForms);
                //prop.UserID = keys.UserID;
                //Session["UserID"] = keys.UserID;
            }
            Guid propID = Search.AddProperty(prop, hdfPropertyID.Value);
            Session["propID"] = Convert.ToString(propID);
            //Check if the currently login guy is an agent

            PropertyIDFromDataBase.Value = Convert.ToString(propID);
            try
            {
                if (string.IsNullOrEmpty(hdfLatitude.Value) && string.IsNullOrEmpty(hdfLongitude.Value))
                {
                    address = txtStreetnumber.Text + "+" + txtStreetname.Text + "+" + txtSuburb.Text + "+" + ddlProvince.SelectedValue + "+" + txtCity.Text + "+" + "ke";
                    WebRequest request = WebRequest.Create("http://maps.googleapis.com/maps/api/geocode/json?address=" + address + " &sensor=false");
                    WebResponse response = request.GetResponse();
                    Stream stream = response.GetResponseStream();
                    DataContractJsonSerializer seriler = new DataContractJsonSerializer(typeof(AddressResponse));
                    AddressResponse resp = (AddressResponse)seriler.ReadObject(stream);

                    if (resp.Results.Count() > 0)
                    {
                        prop.Latitude = resp.Results[0].Geometry.Location.Lat;
                        prop.Longitude = resp.Results[0].Geometry.Location.Lng;

                        hdfLatitude.Value = prop.Latitude;
                        hdfLongitude.Value = prop.Longitude;
                        map.Visible = true;
                        divPropertyDetailsFields.Visible = false;
                    }
                }
                else
                {
                    divPropertyDetailsFields.Visible = false;
                    map.Visible = true;
                    //imap.Attributes.Add("src", "/Members/maps/uploadMap.aspx?propertyid=" + propID + "&lat=" + hdfLatitude.Value + "&lng=" + hdfLongitude.Value);
                }
            }
            catch
            {

            }


            //this.Page.RegisterStartupScript("OnMap", "<script>getMap()</script>");
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "Map", "<script type='text/javascript'>getMap()</script>", false);

            LoadSelectedState(3);



        }


        protected void SaveMap_Click(object sender, EventArgs e)
        {

            if (Session["propID"] != null)
            {
                string prop = (string)Session["propID"];
                string lat = hdfLatitude.Value;
                string lng = hdfLongitude.Value;
                Search.UpdateLatLng(Guid.Parse(prop), lat, lng);
            }
            LoadSelectedState(4);
            MultiView1.ActiveViewIndex = 2;
        }
        protected void PriceDetails_Click(object sender, EventArgs e)
        {
            string attributes = "|";
            PriceTableAzure price = new PriceTableAzure();

            price.MonthlyRental = txtMonthlyrental.Text;
            price.Description = txtDescription.Text;

            string propID;
            if (Session["propID"] != null)
            {//Populate the propertyid and the attributeid
                propID = (string)Session["propID"];
                price.PropertyID = Guid.Parse(propID);

            }
            else
            {//If the propertyid in not available from the session get from the hidden control
                propID = Convert.ToString(PropertyIDFromDataBase.Value);

                price.PropertyID = Guid.Parse(propID);


                Session["propID"] = propID;
            }

            if (tblAccessGate.Visible == true)
            {
                if (AccessGate.SelectedValue == "Yes")
                {
                    attributes = attributes + "Access Gate" + "|";
                }
                else if (AccessGate.SelectedValue == "No")
                {

                }

            }

            if (tblAirCon.Visible == true)
            {
                if (AirCon.SelectedValue == "Yes")
                {
                    attributes = attributes + "Air Conditioning |";
                }



            }

            if (tblAlarm.Visible == true)
            {

                if (Alarm.SelectedValue == "Yes")
                {
                    attributes = attributes + "Alarm System |";
                }

            }

            if (tblBalcony.Visible == true)
            {

                if (Balcony.SelectedValue == "Yes")
                {
                    attributes = attributes + "Balcony |";
                }

            }

            if (tblBathrooms.Visible == true)
            {
                attributes = attributes + txtBathrooms.Text + " Bathroom |";

            }

            if (tblBedrooms.Visible == true)
            {
                attributes = attributes + txtBedrooms.Text + " Bedroom|";

            }

            if (tblBorehole.Visible == true)
            {
                if (Borehole.SelectedValue == "Yes")
                {
                    attributes = attributes + "Borehole |";
                }



            }
            if (tblBuiltinBraai.Visible == true)
            {

                if (BuiltinBraai.SelectedValue == "Yes")
                {
                    attributes = attributes + "Built-in Braai |";
                }


            }
            if (tblBuiltinCupboards.Visible == true)
            {

                if (BuiltinCupboards.SelectedValue == "Yes")
                {
                    attributes = attributes + "Built-in Cupboard |";
                }


            }
            if (tblBusinessType.Visible == true)
            {
                if (!BusinessType.SelectedValue.Contains("Choose one"))
                {
                    attributes = attributes + BusinessType.SelectedValue + "|";

                }
            }

            if (tblCarports.Visible == true)
            {
                attributes = attributes + txtCarports.Text + " Carports |";

            }

            if (tblClubHouse.Visible == true)
            {

                if (clubHouse.SelectedValue == "Yes")
                {
                    attributes = attributes + "Club House |";
                }

            }
            for (int i = 0; i < chbHomeType.Items.Count; i++)
            {
                if (chbHomeType.Items[i].Selected)
                {
                    attributes = attributes + chbHomeType.Items[i].Value + " |";
                }
            }
            if (tblHomeType.Visible == true)
            {
                if (!HomeType.SelectedValue.Contains("Choose one"))
                {
                    // attributes = attributes + HomeType.SelectedValue +" |";

                }
            }

            if (tblDeck.Visible == true)
            {

                if (ddlDeck.SelectedValue == "Yes")
                {
                    attributes = attributes + " Deck |";
                }

            }

            if (tblDiningArea.Visible == true)
            {
                attributes = attributes + txtDiningArea.Text + " Dining Area |";

            }

            if (tblElectricfencing.Visible == true)
            {

                if (ddlElectricFencing.SelectedValue == "Yes")
                {
                    attributes = attributes + "Electric Fencing |";
                }


            }

            if (tblElectricityIncluded.Visible == true)
            {

                if (ddlElectricityIncluded.SelectedValue == "Yes")
                {
                    attributes = attributes + "Electricity Included |";
                }

            }

            if (tblEnSuite.Visible == true)
            {
                attributes = attributes + txtEnSuite.Text + " En-Suite |";

            }

            if (tblEntranceHall.Visible == true)
            {

                if (ddlEntranceHall.SelectedValue == "Yes")
                {
                    attributes = attributes + "Entrance Hall |";
                }

            }

            if (tblFamilyTV.Visible == true)
            {

                if (ddlFamilyTV.SelectedValue == "Yes")
                {
                    attributes = attributes + "Family TV |";
                }

            }

            if (tblFarmType.Visible == true)
            {

                if (!ddlFarmType.SelectedValue.Contains("Choose one"))
                {
                    attributes = attributes + ddlFarmType.SelectedValue + "|";

                }
            }

            if (tblFarmBuilding.Visible == true)
            {
                if (!ddlFarmBuilding.SelectedValue.Contains("Choose one"))
                {
                    attributes = attributes + ddlFarmBuilding.SelectedValue + "|";

                }
            }

            if (tblFarmName.Visible == true)
            {
                attributes = attributes + txtfarmName.Text + "|";

            }

            if (tblFence.Visible == true)
            {

                if (ddlFence.SelectedValue == "Yes")
                {
                    attributes = attributes + "Fence|";
                }

            }

            if (tblFinishes.Visible == true)
            {

                if (ddlFinishes.SelectedValue == "Yes")
                {
                    attributes = attributes + "Finishes|";
                }

            }

            if (tblfirePlace.Visible == true)
            {

                if (ddlFirePlace.SelectedValue == "Yes")
                {
                    attributes = attributes + "Fire|";
                }

            }

            if (tblFlatlet.Visible == true)
            {

                if (ddlFlatlet.SelectedValue == "Yes")
                {
                    attributes = attributes + "Flatlet|";
                }

            }

            if (tblFloorArea.Visible == true)
            {
                attributes = attributes + txtFloorArea.Text + " Floors|";

            }

            if (tblFurnished.Visible == true)
            {

                if (ddlFurnished.SelectedValue == "Yes")
                {
                    attributes = attributes + "Furnished|";
                }

            }

            if (tblGarage.Visible == true)
            {
                attributes = attributes + txtGarage.Text + " Garage|";

            }

            if (tblGarden.Visible == true)
            {

                if (ddlGarden.SelectedValue == "Yes")
                {
                    attributes = attributes + "Garden |";
                }

            }


            if (tblGardenCottage.Visible == true)
            {

                if (ddlGardenCottage.SelectedValue == "Yes")
                {
                    attributes = attributes + "Garden Cottage |";
                }

            }


            if (tblGolf.Visible == true)
            {

                if (ddlGolf.SelectedValue == "Yes")
                {
                    attributes = attributes + "Golf |";
                }

            }

            if (tblGuestToilet.Visible == true)
            {

                if (ddlGuestToilet.SelectedValue == "Yes")
                {
                    attributes = attributes + "Guest Toilet |";
                }

            }

            if (tblGym.Visible == true)
            {

                if (ddlGym.SelectedValue == "Yes")
                {
                    attributes = attributes + "Gym |";
                }

            }

            if (tblDisabilityAccess.Visible == true)
            {

                if (ddlDisabilityAccess.SelectedValue == "Yes")
                {
                    attributes = attributes + "Disability Access |";
                }


            }
            price.Attributes = attributes;
            Search.AddPrice(price, hdfPriceID.Value);

            //Search.UpdateLatLng(Convert.ToInt16(propID), hdfLatitude.Value.ToString(), hdfLongitude.Value.ToString());

            Session["propID"] = propID;
            //ltvThumbnail.DataSource = Search.GetThumbnails(key.UserID, Convert.ToInt32(propID));
            //ltvThumbnail.DataBind();
            propertypictures.Attributes.Add("src", "/Members/maps/PropertyPictures.aspx?propertyimagesID=" + propID);
            MultiView1.ActiveViewIndex = 3;

            LoadSelectedState(4);




        }
        protected void lkb_Partner(object sender, EventArgs e)
        {
            string sale = "";

            if (ddlPropertyType.SelectedValue.Contains("For Sale"))
            {


                string propID;
                if (Session["propID"] != null)
                {//Populate the propertyid and the attributeid
                    propID = (string)Session["propID"];

                }
                else
                {//If the propertyid in not available from the session get from the hidden control
                    propID = Convert.ToString(PropertyIDFromDataBase.Value);



                    Session["propID"] = propID;
                }

                paymentGateway.Attributes.Add("src", "/Members/maps/PayGateway.aspx?propertyId=" + propID + "&status=" + sale);
                LoadSelectedState(5);
                MultiView1.ActiveViewIndex = 5;
            }
        }
        protected void NextUpload_Click(object sender, EventArgs e)
        {





            LoadSelectedState(5);
            MultiView1.ActiveViewIndex = 4;




        }

        private void LoadingThePaymentvalues()
        {
            ///hdfaddress/Customer details
            //.Value = txtAddress.Text;
            //hdfcity.Value = txtCity.Text;
            //hdfcountry.Value = "South Africa";
            //hdfcurrency.Value = "Rand";
            //hdffirstname.Value = txtFirstname.Text;
            //hdflastname.Value = txtLastname.Text;
            //Mechats details
        }

        protected void Contact_Click(object sender, EventArgs e)
        {
            UsersTableAzure tableUser = new UsersTableAzure();
            tableUser.FirstName = txtFirstname.Text;
            tableUser.Surname = txtLastname.Text;
            tableUser.Cellphone = txtCellPhone.Text;
            tableUser.HomePhone = txtHomePhone.Text;
            tableUser.WorkPhone = txtWorkPhone.Text;
            tableUser.EmailAddress = txtEmailAddress.Text;
            tableUser.HomeAddress = txtAddress.Text;
            tableUser.UserName = FederationForms;
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(tableUser.UserName);
                membershipuser.Email = tableUser.EmailAddress;
                Membership.UpdateUser(membershipuser);
            }
            Guid UserID = Search.UpdateContact(tableUser, hdfUserID.Value);
            Session["UserID"] = Convert.ToString(UserID);
            LoadSelectedState(2);


            MultiView1.ActiveViewIndex = 1;



        }
        protected void ContactReset_Click(object sender, EventArgs e)
        {
            txtFirstname.Text = "";
            txtLastname.Text = "";
            txtCellPhone.Text = "";
            txtHomePhone.Text = "";
            txtWorkPhone.Text = "";
            txtEmailAddress.Text = "";
            txtAddress.Text = "";
        }
        protected void PropertyReset_Click(object sender, EventArgs e)
        {
            txtStreetnumber.Text = "";
            txtStreetname.Text = "";
            txtUnitName.Text = "";
            txtSuburb.Text = "";
            txtUnitNumber.Text = "";
            txtCity.Text = "";
            ddlProvince.Items.FindByText("--Select--").Selected = true;
            txtCountry.Text = "";
        }
        protected void PriceReset_Click(object sender, EventArgs e)
        {
            txtMonthlyrental.Text = "";
            txtDescription.Text = "";
            //txtUnitName.Text = "";
            //txtSuburb.Text = "";
            //txtCity.Text = "";
            //ddlProvince.Text = "";
            //txtCountry.Text = "";

        }

        public void Img_Delete(object sender, ImageClickEventArgs e)
        {
            string selected = "";
            ImageButton but = sender as ImageButton;
            switch (but.CommandArgument.ToString())
            {
                case "AccessGate":
                    tblAccessGate.Visible = false;
                    selected = "AccessGate";
                    DeleteAttributeInDatabase(selected);

                    break;
                case "AirCon":

                    selected = "AirCon";
                    DeleteAttributeInDatabase(selected);
                    tblAirCon.Visible = false;
                    break;
                case "Alarm":
                    selected = "Alarm";
                    DeleteAttributeInDatabase(selected);
                    tblAlarm.Visible = false;
                    break;
                case "Balcony":
                    selected = "Balcony";
                    DeleteAttributeInDatabase(selected);
                    tblBalcony.Visible = false;
                    break;
                case "Bathrooms":
                    selected = txtBathrooms.Text + "Bathrooms";
                    DeleteAttributeInDatabase(selected);
                    tblBathrooms.Visible = false;

                    break;
                case "Bedrooms":
                    selected = txtBedrooms.Text + "Bedrooms";
                    DeleteAttributeInDatabase(selected);

                    tblBedrooms.Visible = false;
                    break;
                case "Borehole":
                    selected = "Borehole";
                    DeleteAttributeInDatabase(selected);

                    tblBorehole.Visible = false;
                    break;
                case "Built-in Cupboards":
                    selected = "Built-in Cupboards";
                    DeleteAttributeInDatabase(selected);
                    tblBuiltinCupboards.Visible = false;
                    break;
                case "Built-in Braai":
                    selected = "Built-in Braai";
                    DeleteAttributeInDatabase(selected);
                    tblBuiltinBraai.Visible = false;
                    break;
                case "BusinessType":
                    selected = BusinessType.SelectedValue;
                    DeleteAttributeInDatabase(selected);

                    tblBusinessType.Visible = false;
                    break;
                case "Carports":
                    selected = txtCarports.Text + "Carports";
                    DeleteAttributeInDatabase(selected);
                    tblCarports.Visible = false;
                    break;
                case "Clubhouse":
                    selected = "Clubhouse";
                    DeleteAttributeInDatabase(selected);
                    tblClubHouse.Visible = false;
                    break;
                case "Deck":
                    selected = "Deck";
                    DeleteAttributeInDatabase(selected);
                    tblDeck.Visible = false;

                    break;
                case "Dinning-Areas":
                    selected = txtDiningArea.Text + " Dinning-Areas";
                    DeleteAttributeInDatabase(selected);
                    tblDiningArea.Visible = false;

                    break;
                case "Electric Fencing":
                    selected = "Electric Fencing";
                    DeleteAttributeInDatabase(selected);
                    tblElectricfencing.Visible = false;

                    break;
                case "Electricity Included":
                    selected = "Electricity Included";
                    DeleteAttributeInDatabase(selected);
                    tblElectricityIncluded.Visible = false;

                    break;
                case "En-Suite":
                    selected = txtEnSuite.Text + "En-Suite";
                    DeleteAttributeInDatabase(selected);
                    tblEnSuite.Visible = false;

                    break;
                case "Entrance Hall":
                    selected = "Entrance Hall";
                    DeleteAttributeInDatabase(selected);
                    tblEntranceHall.Visible = false;

                    break;
                case "LandArea":
                    //attributeFeatures.AttributeTableState. = false;
                    //attributeFeatures.AttributeTable.ClubHouse = null;
                    //Search.DeleteAttribute(attributeFeatures, hdfAttributeID.Value, hdfAttributeStateID.Value, but.CommandArgument.ToString());
                    tblAccessGate.Visible = false;
                    break;
                case "HomeType":
                    selected = HomeType.SelectedValue;
                    DeleteAttributeInDatabase(selected);
                    tblHomeType.Visible = false;
                    break;
                default:
                    break;

            }
        }

        private void DeleteAttributeInDatabase(string selected)
        {
            PriceTableAzure price = new PriceTableAzure();
            string results = Search.GetAttributes(hdfPriceID.Value);
            var attributes = results.Split(new char[] { '|' }).ToList();
            if (attributes.Contains(selected))
            {
                attributes.Remove(selected);
            }
            string newItems = "|";
            foreach (var item in attributes)
            {
                newItems = item + newItems;
            }
            Search.DeleteAttribute(price);
        }

        public void Status_Click(object sender, EventArgs e)
        {
            LinkButton bnt = (LinkButton)sender;

            switch (bnt.CommandArgument)
            {
                case "Contact":
                    LoadSelectedState(1);

                    MultiView1.ActiveViewIndex = 0;
                    break;
                case "location":
                    LoadSelectedState(2);
                    MultiView1.ActiveViewIndex = 1;
                    break;
                case "details":
                    LoadSelectedState(3);
                    MultiView1.ActiveViewIndex = 2;
                    break;
                case "images":
                    LoadSelectedState(4);
                    Guid propID=new Guid();
                    if (Session["propID"] != null)
                    {//Populate the propertyid
                        propID = (Guid)Session["propID"];


                    }
                    else
                    {//If the propertyid in not available from the session get from the hidden control
                        if (!string.IsNullOrEmpty(hdfPropertyID.Value))
                        {
                            propID = Guid.Parse(hdfPropertyID.Value);
                        }


                    }
                    propertypictures.Attributes.Add("src", "/Members/maps/PropertyPictures.aspx?propertyimagesID=" + propID);
                    MultiView1.ActiveViewIndex = 3;
                    break;
                case "preview":
                    LoadSelectedState(5);
                    MultiView1.ActiveViewIndex = 4;
                    break;
            }
        }
        #endregion
    }
}