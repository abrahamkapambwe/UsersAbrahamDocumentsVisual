using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Web.UI.HtmlControls;
using System.Text;

namespace RealEstateWebRole.Public
{
    public partial class Agents : System.Web.UI.Page
    {
        private SearchParam param;
        public SearchParam Param
        {
            get
            {
                if (param == null)
                    param = new SearchParam();
                return param;
            }
            set
            {
                value = param;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["SearchTerm"] != null)
            {
                String SearchTerm = (string)Request.QueryString["SearchTerm"];
                String SearchTypevalue = (string)Request.QueryString["SearchType"];

                if (SearchTerm.Equals("Estate Agent"))
                    SearchTerm = "Buyers Agent;Sellers Agent";
                Param.SearchTerm = SearchTerm;
                if (SearchTypevalue == "5")
                {
                    Param.SearchTypeValue = SearchType.Filter;
                }
                else if(SearchTypevalue=="3")
                {
                    Param.SearchTypeValue = SearchType.FreeText;
                }
                Session["SearchTermEstate"] = Param;
                ltVEstateAgents.DataSource = Search.SearchAgents(Param);
                ltVEstateAgents.DataBind();
                hypHide.Attributes.Add("onClick", "Hide()");
                imgSendEmail.Attributes.Add("onClick", "SubmitClientPersonalDetails()");
            }
            if (!IsPostBack)
            {
                hypHide.Attributes.Add("onClick", "Hide()");
                imgSendEmail.Attributes.Add("onClick", "SubmitClientPersonalDetails()");
                lnkAdvocates.Text = "Advocates & Lawyers";
                lnkAlarmSystem.Text = "Alarm System";
                lnkBanks.Text = "Banks & Lenders";
                lnkGarden.Text = "Garden & Lawn";
                lnkInsurance.Text = "Insurance";
                lnkPestControl.Text = "Pest Control";
                lnkEstateSales.Text = "Estate Agent";
                lnkLettingAgents.Text = "Letting Agent";
                lnkRelocation.Text = "Relocation";
                lnkConsulting.Text = "Consulting";
                lnkMoving.Text = "Moving";
                lnkPropertyManagement.Text = "Property Management";
                lnkStaging.Text = "Staging";
                lnkArchictecture.Text = "Archictecture";
                lnkCarpentry.Text = "Carpentry";
                lnkEngineering.Text = "Engineering";
                lnkInteriorDesign.Text = "Interior Design";
                lnkPainting.Text = "Painting";
                lnkHomeBuilding.Text = "Home Building";
                lnkElectrical.Text = "Electrical";
                lnkGeneralContracting.Text = "General Contracting";
                lnkLandscaping.Text = "Land scaping";
                lnkPlumbing.Text = "Plumbing";
                Page.Title = "Agents Results Page";
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);

                HtmlMeta htmlmeta2 = new HtmlMeta();
                htmlmeta2.Name = "keywords2";
                htmlmeta2.Content = "Nation daily,nation news paper kenya";
                Page.Header.Controls.Add(htmlmeta2);
            }
        }
        public void lnkAgent_Search(object sender, EventArgs e)
        {
            LinkButton but = (LinkButton)sender;
            String value = but.CommandArgument;
            LoadSelectedItems(value);
        }
        public void EstateAgents_CheckedChanged(object sender, EventArgs e)
        {

            LoadSelectedItems("Buyers Agent;Sellers Agent");
        }

        private void LoadSelectedItems(string text)
        {
            Param.SearchTerm = text;
            Param.SearchTypeValue = SearchType.Filter;
            Session["SearchTermEstate"] = Param;
            ltVEstateAgents.DataSource = Search.SearchAgents(Param);
            ltVEstateAgents.DataBind();
        }
        public void LettingAgents_CheckedChanged(object sender, EventArgs e)
        {
            LoadSelectedItems("Letting Agent");
        }
        protected void imgSendEmail_OnClick(object sender, ImageClickEventArgs e)
        {

        }
        protected void ltVEstateAgents_PagePropertiesChanged(object sender, EventArgs e)
        {

            if (Session["SearchTermEstate"] != null)
            {
                Param = (SearchParam)Session["SearchTermEstate"];

                if (Param.SearchTypeValue == SearchType.FreeText)
                {
                    if (!string.IsNullOrWhiteSpace(Param.SearchTerm))
                    {
                        ltVEstateAgents.DataSource = Search.SearchAgents(param);
                        ltVEstateAgents.DataBind();
                    }
                    else
                    {
                        //IEnumerable<PropertyTableAzure> propertyTable = Search.GetPropertyTablesFromCache(Param.UserID);
                        //ltVEstateAgents.DataSource = propertyTable;
                        //ltVEstateAgents.DataBind();

                    }
                }
                else if (Param.SearchTypeValue == SearchType.Filter)
                {
                    ltVEstateAgents.DataSource = Search.SearchAgents(Param);
                    ltVEstateAgents.DataBind();
                }

            }
        }
        protected void EstateAgents_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                String PhoneNumber = "";
                String BusinessName = "";
                String UnitNumber = "";
                String Road = "";
                String Surburb = "";
                String City = "";
                String Province = "";
                String UserID = "";
                String AgentID = "";
                String Imagelogo = "";

                ListViewDataItem item = (ListViewDataItem)e.Item;
                HyperLink EstateLogo = (HyperLink)item.FindControl("EstateLogo");
                HtmlGenericControl ulSpeciaties = (HtmlGenericControl)item.FindControl("ulSpeciaties");
                EstateAgentAzure agent = (EstateAgentAzure)e.Item.DataItem;
                UsersTableAzure user = Search.GetUserTableFromCache(Guid.Parse(agent.UserID));
                Image img = (Image)item.FindControl("imgThumb");


                Label lblAgentName = (Label)item.FindControl("lblAgentName");
                Label lblAgentBusinessPhone = (Label)item.FindControl("lblAgentBusinessPhone");
                Label lblAgentAddress = (Label)item.FindControl("lblAgentAddress");
                Label lblAgentSuburb = (Label)item.FindControl("lblAgentSuburb");
                Label lblAgentCity = (Label)item.FindControl("lblAgentCity");
                Label lblAgentPostalCode = (Label)item.FindControl("lblAgentPostalCode");
                //Popup dialog box
                UserID = Convert.ToString(agent.UserID);
                AgentID = Convert.ToString(agent.EstateAgentID);



                HyperLink ShowContact = (HyperLink)item.FindControl("ShowContact");
                HyperLink showMiniMap = (HyperLink)item.FindControl("showMiniMap");

                //html server side refereneces

                HtmlGenericControl htmlContact = (HtmlGenericControl)item.FindControl("divContact");
                ///HtmlGenericControl htmlMap = (HtmlGenericControl)item.FindControl("showMiniMap");

                //Populate ids to the javascripts methods




                //populate the Agent details on the page
                lblAgentAddress.Text = agent.AgentAddress;
                lblAgentBusinessPhone.Text = user.WorkPhone;
                lblAgentCity.Text = agent.City;
                lblAgentPostalCode.Text = agent.PostalCode;

                //populate the dialog label controls
                UnitNumber = agent.AgentAddress;
                City = agent.City;
                Province = agent.State_Prov;
                PhoneNumber = user.WorkPhone;
                //Populate the controls with items

                EstateLogo.NavigateUrl = "~/Public/AgentDetails.aspx?agentID=" + agent.EstateAgentID + "&UserType=" + agent.UserID;
                
                if (agent.ProfilePhotoUrl != null)
                {
                    if (!string.IsNullOrWhiteSpace(agent.ProfilePhotoUrl))
                    {
                        EstateLogo.ImageUrl = agent.ProfilePhotoUrl;
                        Imagelogo = agent.ProfilePhotoUrl;
                    }
                    else
                    {
                        EstateLogo.ImageUrl = "~/Images/empty_thumbnail.gif";
                        Imagelogo = "http://127.0.0.1:81/Images/empty_thumbnail.gif";
                    }
                }
                else
                {
                    EstateLogo.ImageUrl = "~/Images/empty_thumbnail.gif";
                    Imagelogo = "http://127.0.0.1:81/Images/empty_thumbnail.gif";
                }



                BusinessName = agent.BusinessName;
                string[] agentType = agent.AgentType.Split(new char[] { ';' });

                if (agentType.Count() > 0)
                {
                    foreach (var a in agentType)
                    {
                        HtmlGenericControl html = new HtmlGenericControl("span");
                        html.Attributes.Add("style", "margin-right:20px;");
                        html.InnerText = a;
                        ulSpeciaties.Controls.Add(html);
                    }
                }

                StringBuilder builder = new StringBuilder();
                builder.Append(PhoneNumber);
                builder.Append(";");
                builder.Append(BusinessName);
                builder.Append(";");
                builder.Append(UnitNumber);
                builder.Append(";");
                builder.Append(Road);
                builder.Append(";");
                builder.Append(Surburb);
                builder.Append(";");
                builder.Append(City);
                builder.Append(";");
                builder.Append(Province);
                builder.Append(";");
                builder.Append(UserID);
                builder.Append(";");
                builder.Append(AgentID);
                builder.Append(";");
                builder.Append(Imagelogo);

                ShowContact.Attributes.Add("OnClick", "SubmitClientDetails('" + builder.ToString() + "')");


            }
        }
    }
}