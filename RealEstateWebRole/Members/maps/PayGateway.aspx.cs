using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Threading;
using System.Web.Security;
using RealEstateLibraries;
using System.Text;

namespace RealEstateWebRole.Members.maps
{
    public partial class PayGateway : System.Web.UI.Page
    {
        private string FederationForms = "";
        String propertyID = "";
        string sale = "";
        private List<ShoppingBasket> _shoppingBaskets;
        private List<ShoppingBasket> ShoppingBaskets
        {
            get
            {
                if (_shoppingBaskets == null)
                    _shoppingBaskets = new List<ShoppingBasket>();
                return _shoppingBaskets;
            }

            set
            {

                _shoppingBaskets = value;
            }

        }
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
                if (ddlAmountEdit.SelectedValue == "1000")
                {
                    lblAmount.Text = "Kshs 1000";
                    lblMerchandise.Text = "The amount of listing the property for a month on epropertysearch";
                    Search.UpdateViewDuration(Guid.Parse(propertyID), 1);
                }
                else if (ddlAmountEdit.SelectedValue == "1500")
                {
                    lblAmount.Text = "Kshs 1500";
                    lblMerchandise.Text = "The amount of listing the property for three months on epropertysearch";
                    Search.UpdateViewDuration(Guid.Parse(lblPropertyID.Text), 3);
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

            if (Request.QueryString["propertyId"] != null)
            {
                UsersTableAzure user = Search.GetUserProfile(FederationForms);
                ShoppingBasket shoppingBasket = new ShoppingBasket();

                propertyID = Convert.ToString(Request.QueryString["propertyId"]);
                sale = Request.QueryString["status"];
                lblPropertyID.Text = Convert.ToString(propertyID);
                lblAmount.Text = "Kshs 1000";
                lblMerchandise.Text = "The amount of listing the property for a month on epropertysearch";
                Search.UpdateViewDuration(Guid.Parse(propertyID), 1);

                

                PropertyTableAzure property = Search.GetPropertyTable(user.UserName, Guid.Parse(propertyID));
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
                    builder.Append(lblAmount.Text.Replace("Kshs", ""));

                    builder.Append(";");
                    builder.Append(lblAmount.Text.Replace("Kshs", ""));
                    builder.Append(";");
                    builder.Append(lblMerchandise.Text);
                    builder.Append(";");

                    builder.Append("http://epropertysearchke.apphb.com/Members/UploadPictures.aspx?moneybookerstatus=success&propId=" + propertyID);
                    builder.Append(";");
                    builder.Append("http://epropertysearchke.apphb.com/Members/UploadPictures.aspx?moneybookerstatus=cancel&propId=" + propertyID);
                    builder.Append(";");

                    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "PaymentValues", "<script type='text/javascript'>" + "LoadingThePaymentvalues('" + builder.ToString() + "')" + "</script>", false);
                }
            }


        }


    }
    public class ShoppingBasket
    {
        public string Propertyid
        {
            get;
            set;
        }
        public string Merchandise
        {
            get;
            set;
        }
        public string Amount
        {
            get;
            set;
        }
    }
}