using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Collections.Specialized;
using System.Data;

namespace RealEstateWebRole.Account
{
    public partial class Admin : System.Web.UI.Page
    {
        List<string> clientappid = new List<string>();
        List<string> clientrepid = new List<string>();
        List<string> clientexpid = new List<string>();

        private List<PropertyTableAzure> _propertyTables;
        private List<PropertyTableAzure> PropertyTables
        {
            get
            {
                if (_propertyTables == null)
                    _propertyTables = new List<PropertyTableAzure>();
                return _propertyTables;
            }

            set
            {

                _propertyTables = value;
            }

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.Name == "epropertysearch@epropertysearch.co.za")
            {

                if (!IsPostBack)
                {
                    PropertyTables = Search.GetProperties();
                    BindGridView();
                }
            }
        }
        private void BindGridView()
        {
            grdProperties.DataSource = PropertyTables;
            grdProperties.DataBind();
            Session["PropertyTables"] = PropertyTables;
        }
        protected void ApproveAll_Click(object sender, EventArgs e)
        {

        }
        protected void Search_Click(object sender, EventArgs e)
        {
        }
        protected void SaleBuy_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSaleBuy.SelectedValue != null)
            {
                PropertyTables = Search.GetPropertiesByPropertyType(ddlSaleBuy.SelectedValue);
                BindGridView();

            }
        }
        protected void grdProperties_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            List<PreviewPropertyTableAzure> previewlist = new List<PreviewPropertyTableAzure>();
            if (e.CommandName.Equals("Sort"))
            {
                if (this.ViewState["SortExp"] == null)
                {
                    this.ViewState["SortExp"] = e.CommandArgument.ToString();
                    this.ViewState["SortOrder"] = "ASC";
                }
                else
                {
                    if (this.ViewState["SortExp"].ToString() == e.CommandArgument.ToString())
                    {
                        if (this.ViewState["SortOrder"].ToString() == "ASC")
                            this.ViewState["SortOrder"] = "DESC";
                        else
                            this.ViewState["SortOrder"] = "ASC";
                    }
                    else
                    {
                        this.ViewState["SortOrder"] = "ASC";
                        this.ViewState["SortExp"] = e.CommandArgument.ToString();
                    }
                }


                if (Session["PropertyTables"] != null)
                {
                    string sortExp = this.ViewState["SortExp"].ToString();
                    string sortOrder = this.ViewState["SortOrder"].ToString();
                    PropertyTables = Session["PropertyTables"] as List<PropertyTableAzure>;

                    switch (sortExp)
                    {
                        case "City":
                            PropertyTables = PropertyTables.OrderBy(p => p.City.Equals(sortExp)).ToList();
                            BindGridView();
                            break;

                        default:
                            break;
                    }





                }
            }


            if (e.CommandName == "ApplyAll")
            {

                for (int i = 0; i < grdProperties.Rows.Count; i++)
                {
                    CheckBox chkApprove = (CheckBox)grdProperties.Rows[i].FindControl("chkApproved");
                    CheckBox chkReported = (CheckBox)grdProperties.Rows[i].FindControl("chkReported");
                    CheckBox chkExpired = (CheckBox)grdProperties.Rows[i].FindControl("chkExpired");
                    string propid = Convert.ToString(grdProperties.DataKeys[grdProperties.Rows[i].RowIndex].Value);
                    PreviewPropertyTableAzure preview = new PreviewPropertyTableAzure();
                    preview.PropertyID = Guid.Parse(propid);
                    preview.Approved = chkApprove.Checked;
                    preview.Reported = chkReported.Checked;
                    preview.Expired = chkExpired.Checked;
                    previewlist.Add(preview);

                }
            }
            else if (e.CommandName == "Apply")
            {
                GridViewRow row = (GridViewRow)((Button)e.CommandSource).NamingContainer;
                CheckBox chkApprove = (CheckBox)row.FindControl("chkApproved");
                CheckBox chkReported = (CheckBox)row.FindControl("chkReported");
                CheckBox chkExpired = (CheckBox)row.FindControl("chkExpired");
                string propid = Convert.ToString(grdProperties.DataKeys[row.RowIndex].Value);
                PreviewPropertyTableAzure preview = new PreviewPropertyTableAzure();
                preview.PropertyID = Guid.Parse(propid);
                preview.Approved = chkApprove.Checked;
                preview.Reported = chkReported.Checked;
                preview.Expired = chkExpired.Checked;
                previewlist.Add(preview);
            }
            Search.UpdatePreviewPropertyTable(previewlist);
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (Session["Approve"] != null)
            {
                CheckBox chkSelectApproveAllHeader = (CheckBox)Session["Approve"];
                string value = chkSelectApproveAllHeader.ClientID;
                foreach (var v in clientappid)
                {
                    value += ";" + v;
                }
                chkSelectApproveAllHeader.Attributes.Add("Onclick", "SelectApproveCheck('" + value + "')");
            }

            if (Session["Report"] != null)
            {
                CheckBox chkSelectReportedAllHeader = (CheckBox)Session["Report"];
                string value = chkSelectReportedAllHeader.ClientID;
                foreach (var v in clientrepid)
                {
                    value += ";" + v;
                }
                chkSelectReportedAllHeader.Attributes.Add("Onclick", "SelectReportedCheck('" + value + "')");
            }
            if (Session["Expired"] != null)
            {
                CheckBox chkSelectExpiredAllHeader = (CheckBox)Session["Expired"];
                string value = chkSelectExpiredAllHeader.ClientID;
                foreach (var v in clientexpid)
                {
                    value += ";" + v;
                }
                chkSelectExpiredAllHeader.Attributes.Add("Onclick", "SelectExpiredCheck('" + value + "')");
            }
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


            if (paramPreview.ContainsValue(true))
            {
                List<Guid> list = Search.GetPropertyAdminIDsSearch(paramPreview);
                grdProperties.DataSource = Search.GetPropertiesById(list);
                grdProperties.DataBind();

            }
            else
            {

            }


        }
        private string ConvertSortDirectionToSql(SortDirection sortDirection)
        {
            string newSortDirection = String.Empty;

            switch (sortDirection)
            {
                case SortDirection.Ascending:
                    newSortDirection = "ASC";
                    break;

                case SortDirection.Descending:
                    newSortDirection = "DESC";
                    break;
            }

            return newSortDirection;
        }
        protected void linkSort(object sender, EventArgs e)
        {

        }

        protected void grdProperties_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = grdProperties.DataSource as DataTable;

            if (dataTable != null)
            {
                DataView dataView = new DataView(dataTable);
                dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

                grdProperties.DataSource = dataView;
                grdProperties.DataBind();
            }
        }

        protected void grdProperties_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdProperties.PageIndex = e.NewPageIndex;
            grdProperties.DataSource = Search.GetProperties();
            grdProperties.DataBind();
        }
        protected void grdProperties_DataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                CheckBox chkSelectApproveAllHeader = (CheckBox)e.Row.FindControl("chkSelectApproveAllHeader");
                Session["Approve"] = chkSelectApproveAllHeader;
                CheckBox chkSelectReportedAllHeader = (CheckBox)e.Row.FindControl("chkSelectReportedAllHeader");
                Session["Report"] = chkSelectReportedAllHeader;
                CheckBox chkSelectExpiredAllHeader = (CheckBox)e.Row.FindControl("chkSelectExpiredAllHeader");
                Session["Expired"] = chkSelectExpiredAllHeader;
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //Adding the javascripts to the footer for approve checkbox
                CheckBox chkSelectApproveAll = (CheckBox)e.Row.FindControl("chkSelectApproveAll");
                string value = chkSelectApproveAll.ClientID;
                foreach (var v in clientappid)
                {
                    value += ";" + v;
                }
                chkSelectApproveAll.Attributes.Add("Onclick", "SelectApproveCheck('" + value + "')");

                //Adding the javascripts to the footer for reported checkbox
                CheckBox chkSelectReportedAll = (CheckBox)e.Row.FindControl("chkSelectReportedAll");
                string valuerep = chkSelectReportedAll.ClientID;
                foreach (var v in clientrepid)
                {
                    valuerep += ";" + v;
                }
                chkSelectReportedAll.Attributes.Add("Onclick", "SelectReportedCheck('" + valuerep + "')");
                //Adding the javascripts to the footer for reported checkbox
                CheckBox chkSelectExpiredAll = (CheckBox)e.Row.FindControl("chkSelectExpiredAll");
                string valueexp = chkSelectExpiredAll.ClientID;
                foreach (var v in clientexpid)
                {
                    valueexp += ";" + v;
                }
                chkSelectExpiredAll.Attributes.Add("Onclick", "SelectExpiredCheck('" + valueexp + "')");
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PropertyTableAzure table = (PropertyTableAzure)e.Row.DataItem;

                PreviewPropertyTableAzure previewtable = Search.GetPreviewValues(table.PropertyID);

                UsersTableAzure user = Search.GetUserTable(table.UserName);

                HyperLink HyperSelect = (HyperLink)e.Row.FindControl("HyperSelect");
                Label lblName = (Label)e.Row.FindControl("lblName");
                Label lblEmail = (Label)e.Row.FindControl("lblEmail");
                Label lblCity = (Label)e.Row.FindControl("lblCity");
                Label lblIncomplete = (Label)e.Row.FindControl("lblIncomplete");
                CheckBox chkApproved = (CheckBox)e.Row.FindControl("chkApproved");
                CheckBox chkReported = (CheckBox)e.Row.FindControl("chkReported");
                CheckBox chkExpired = (CheckBox)e.Row.FindControl("chkExpired");


                clientappid.Add(chkApproved.ClientID);
                clientrepid.Add(chkReported.ClientID);
                clientexpid.Add(chkExpired.ClientID);
                Button Apply = (Button)e.Row.FindControl("btnApply");

                Apply.CommandArgument = Convert.ToString(table.PropertyID);
                //
                HyperSelect.NavigateUrl = "~/Admin/Details.aspx?UserId=" + user.UserID + "&propertyId=" + table.PropertyID;
                lblName.Text = user.FirstName + " " + user.Surname;

                lblEmail.Text = user.EmailAddress;
                lblCity.Text = table.City;
                if (previewtable != null)
                {
                    if (previewtable.InComplete == false || previewtable.InComplete == null)
                    {
                        lblIncomplete.Text = "Complete";
                    }
                    else
                    {
                        lblIncomplete.Text = "InComplete";
                    }
                    //Check the status
                    if (previewtable.Approved == null)
                    {
                        chkApproved.Checked = false;
                    }
                    else
                    {
                        chkApproved.Checked = Convert.ToBoolean(previewtable.Approved);
                    }
                    if (previewtable.Reported == null)
                    {
                        chkReported.Checked = false;

                    }
                    else
                    {
                        chkReported.Checked = Convert.ToBoolean(previewtable.Reported);
                    }
                    if (previewtable.Expired == null)
                    {
                        chkExpired.Checked = false;
                    }
                    else
                    {
                        chkExpired.Checked = Convert.ToBoolean(previewtable.Expired);
                    }
                }
            }
        }
    }
}