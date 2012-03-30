using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using RealEstateLibraries;
using System.Web.Security;

using System.Threading;

namespace RealEstateWebRole.Controls
{
    public partial class Payments : System.Web.UI.UserControl
    {
        private string FederationForms = "";
        string propertyID;
        string sale = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Edit_OnClick(object sender, EventArgs e)
        {
            if (lkBEdit.Text == "Edit")
            {
                lblAmount.Visible = false;
                lkBEdit.Text = "Save";
                ddlAmountEdit.Visible = true;
            }
            else if (lkBEdit.Text == "Save")
            {
                lblAmount.Visible = true;
                lblAmount.Text = ddlAmountEdit.SelectedItem.Text;
                if (ddlAmountEdit.SelectedValue == "200")
                {
                    lblMerchandise.Text = "The amount of listing the property for a month` on epropertysearch";
                }
                else if (ddlAmountEdit.SelectedValue == "300")
                {
                    lblMerchandise.Text = "The amount of listing the property for three months on epropertysearch";
                }
                lkBEdit.Text = "Edit";
                ddlAmountEdit.Visible = false;

            }


        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            
          if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }

            if (Session["propID"] != null)
            {
                UsersTableAzure user = Search.GetUserProfile(FederationForms);


                propertyID = Convert.ToString(Session["propID"]);
                sale = (string)Session["status"];
                lblPropertyID.Text = Convert.ToString(propertyID);
                if (sale.Contains("OneMonth"))
                {
                    if (string.IsNullOrWhiteSpace(lblAmount.Text))
                    {
                        lblAmount.Text = "R 200";
                        lblMerchandise.Text = "The amount of listing the property for a month on epropertysearch";
                        Search.UpdateViewDuration(Guid.Parse(propertyID), 1);
                    }
                }
                else if (sale.Contains("ThreeMonth"))
                {
                    if (string.IsNullOrWhiteSpace(lblAmount.Text))
                    {
                        lblAmount.Text = "R 300";
                        lblMerchandise.Text = "The amount of listing the property for three months on epropertysearch";
                        Search.UpdateViewDuration(Guid.Parse(propertyID), 3);
                    }
                }

                PropertyTableAzure property = Search.GetPropertyTable(Convert.ToString(user.UserID), Guid.Parse(propertyID));
                if (property != null)
                {

                    StringBuilder builder = new StringBuilder();
                    builder.Append(user.FirstName);
                    builder.Append(";");
                    builder.Append(user.Surname);
                    builder.Append(";");
                    builder.Append(user.HomeAddress);
                    builder.Append(";");
                    builder.Append(user.WorkPhone);
                    builder.Append(";");
                    builder.Append(user.PostalCode);
                    builder.Append(";");
                    builder.Append(user.City);
                    builder.Append(";");

                    builder.Append(user.Province);
                    builder.Append(";");
                    builder.Append("Kenya");
                    builder.Append(";");
                    builder.Append(lblAmount.Text.Replace("R", ""));

                    builder.Append(";");
                    builder.Append(lblAmount.Text.Replace("R", ""));
                    builder.Append(";");
                    builder.Append(lblMerchandise.Text);
                    builder.Append(";");

                    builder.Append("http://localhost:49178/Members/UploadPictures.aspx?moneybookerstatus=success&propId=" + propertyID);
                    builder.Append(";");
                    builder.Append("http://localhost:49178/Members/UploadPictures.aspx?moneybookerstatus=cancel&propId=" + propertyID);
                    builder.Append(";");

                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "PaymentValues", "<script type='text/javascript'>" + "LoadingThePaymentvalues('" + builder.ToString() + "')" + "</script>", false);
                }
            }


        }
    }
}