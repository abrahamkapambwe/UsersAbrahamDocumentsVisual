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
    public partial class AgentDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Title = "Agent Details Page";
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);

               
                if (Request.QueryString["agentID"] != null && Request.QueryString["UserType"] != null)
                {
                    string AgentID = Convert.ToString(Request.QueryString["agentID"]);
                    string UserID = Convert.ToString(Request.QueryString["UserType"]);
                    PopulateAgentDetails(AgentID, UserID);
                }
            }
        }
        #region Private
        private void PopulateAgentDetails(string AgentID, string UserID)
        {

            string agentmeta="";
            EstateAgentAzure estate = Search.GetAgentFromCache(Guid.Parse(AgentID));
            if (estate != null)
            {
                UsersTableAzure usertable = Search.GetUserTableFromCache(Guid.Parse(estate.UserID));
                if (usertable != null)
                {
                    hdfAgentID.Value = Convert.ToString(AgentID);
                    hdfUserID.Value = Convert.ToString(UserID);
                    HtmlMeta htmlmeta2 = new HtmlMeta();
                    htmlmeta2.Name = "keywords2";
                    agentmeta = estate.AgentAddress + ", " + estate.BusinessName + ", " + estate.City;

                    IEnumerable<PropertyTableAzure> propertyTable = Search.GetPropertyTablesFromCache(usertable.UserName);
                    imap.Attributes.Add("src", "/Public/Map/Map.aspx?lat=" + estate.Latitude + "&lng=" + estate.Longitude);
                    if (propertyTable != null)
                    {
                        int NumberOfProperty = propertyTable.Count();
                        hyperView.Text = "Number of listing " + NumberOfProperty;
                    }
                    else
                    {
                        hyperView.Text = "Number of listing  " + 0;
                    }
                    hyperView.NavigateUrl = "~/Public/SearchResult.aspx?Agent=" + AgentID + "&User=" + UserID;
                    Agentlogo.ImageUrl = estate.ProfilePhotoUrl;
                    if (propertyTable != null)
                    {
                        ltlListing.Text = "Agent Property Listing";
                        lstAgentListing.DataSource = propertyTable;
                        lstAgentListing.DataBind();
                    }
                    //populate the list element of speciaties with home improvemet and agent type properties of estate agent class
                    if (!string.IsNullOrEmpty(estate.HomeImprovement))
                    {
                        string[] special = estate.HomeImprovement.Split(new char[] { ';' });
                        foreach (var value in special)
                        {
                            if (!string.IsNullOrEmpty(value))
                            {
                                HtmlGenericControl html = new HtmlGenericControl("li");
                                html.InnerText = value;
                                speciaties.Controls.Add(html);
                            }
                        }
                    }
                    if (!string.IsNullOrEmpty(estate.AgentType))
                    {
                        string[] agentType = estate.AgentType.Split(new char[] { ';' });
                        foreach (var type in agentType)
                        {
                            if (!string.IsNullOrEmpty(type))
                            {
                                agentmeta = agentmeta + ", " + type;
                                HtmlGenericControl html = new HtmlGenericControl("li");
                                html.Attributes.Add("style", "float:left");
                                html.InnerHtml = "<div style='margin-left:10px'>" + type + "</div>";
                                speciaties.Controls.Add(html);
                            }
                        }
                    }
                    //Add the addresses to the list element
                    if (!string.IsNullOrEmpty(estate.AgentAddress))
                    {
                        lblAddressTitle.Text = "Address";
                        lblAddressAgent.Text = estate.AgentAddress;


                    }
                    if (!string.IsNullOrEmpty(estate.State_Prov))
                    {
                        lblStateProv.Text = estate.State_Prov;

                    }
                    if (!string.IsNullOrEmpty(estate.City))
                    {
                        lblCity.Text = estate.City;

                    }
                    if (!string.IsNullOrEmpty(estate.Country))
                    {
                        //HtmlGenericControl html = new HtmlGenericControl("li");
                        //html.InnerText = estate.Country;
                        //addressAgent.Controls.Add(html);

                    }
                    //Add the cellphone,fax and business phone to the list element
                    if (!string.IsNullOrEmpty(usertable.WorkPhone))
                    {
                        lblWorkPhoneTitle.Text = "Business phone:";


                        lblWorkPhone.Text = usertable.WorkPhone;

                    }
                    if (!string.IsNullOrEmpty(usertable.Cellphone))
                    {
                        lblCellPhoneTitle.Text = "Cell phone:";
                        lblCellphone.Text = usertable.Cellphone;

                    }
                    if (!string.IsNullOrEmpty(estate.FaxNumber))
                    {
                        lblFaxNumberTitle.Text = "Fax number:";

                        lblFaxNumber.Text = estate.FaxNumber;


                    }
                    if (!string.IsNullOrEmpty(estate.FaceBookUrl))
                    {
                        agentmeta = agentmeta + "," + estate.FaceBookUrl;
                        HtmlGenericControl html = new HtmlGenericControl("div");
                        HyperLink link = new HyperLink();
                        link.NavigateUrl = estate.FaceBookUrl;
                        html.Controls.Add(link);
                        html.Attributes.Add("style", "margin-bottom:5px");
                        listurls.Controls.Add(html);

                    }
                    if (!string.IsNullOrEmpty(estate.TwitterUrl))
                    {
                        agentmeta = agentmeta + "," + estate.TwitterUrl;
                        HtmlGenericControl html = new HtmlGenericControl("div");
                        HyperLink link = new HyperLink();
                        link.NavigateUrl = estate.TwitterUrl;
                        html.Controls.Add(link);
                        listurls.Controls.Add(html);

                    }
                    if (!string.IsNullOrEmpty(estate.LinkedIn))
                    {
                        agentmeta = agentmeta + "," + estate.LinkedIn;
                        HtmlGenericControl html = new HtmlGenericControl("div");
                        HyperLink link = new HyperLink();
                        link.NavigateUrl = estate.LinkedIn;
                        html.Controls.Add(link);
                        listurls.Controls.Add(html);

                    }
                    if (!string.IsNullOrEmpty(estate.WebsiteUrl))
                    {
                        agentmeta = agentmeta + "," + estate.WebsiteUrl;
                        HtmlGenericControl html = new HtmlGenericControl("div");
                        HyperLink link = new HyperLink();
                        link.NavigateUrl = estate.WebsiteUrl;
                        html.Controls.Add(link);
                        listurls.Controls.Add(html);

                    }
                    if (!string.IsNullOrEmpty(estate.Description))
                    {
                        lblDescription.Text = estate.Description;
                    }
                    if (!string.IsNullOrEmpty(estate.BusinessName))
                    {
                        ltlTitle.Text = estate.BusinessName;
                    }
                    htmlmeta2.Content = agentmeta;
                    Page.Header.Controls.Add(htmlmeta2);
                }
            }
        }
        #endregion
        #region Events
        protected void lstAgentListing_OnDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                PropertyTableAzure table = (PropertyTableAzure)e.Item.DataItem;
                HyperLink link = (HyperLink)e.Item.FindControl("AgentListing");
                link.Text = table.UnitNumber + " " + table.Suburb + " " + table.StreetNumber + " " + table.StreetName + " " + table.City;
                link.NavigateUrl = "~/Public/PropertyDetails.aspx?PropertyID=" + table.PropertyID;
            }
        }
        protected void btnSend_Click(object sender, EventArgs args)
        {
            StringBuilder emailstring = new StringBuilder();

            emailstring.Append("");
            emailstring.Append(";");
            emailstring.Append(hdfUserID.Value);
            emailstring.Append(";");
            emailstring.Append(txtName.Text);
            emailstring.Append(";");
            emailstring.Append(txtPhone.Text);
            emailstring.Append(";");
            emailstring.Append(txtEmail.Text);
            emailstring.Append(";");
            emailstring.Append(txtMessage.Text);
            emailstring.Append(";");
            emailstring.Append(hdfAgentID.Value);

            
            lblResult.Text= "Email sent Successfully";
        }
        #endregion
    }
}