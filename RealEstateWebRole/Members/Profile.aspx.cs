using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Web.Security;

using System.Threading;

namespace RealEstateWebRole.Members
{
    public partial class Profile : System.Web.UI.Page
    {
        private string FederationForms = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
            if (!IsPostBack)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    UsersTableAzure user = Search.GetUserProfile(FederationForms);
                    if (user != null)
                    {
                        txtFirstname.Text = user.FirstName;
                        txtLastname.Text = user.Surname;
                        txtCellPhone.Text = user.Cellphone;
                        txtHomePhone.Text = user.HomePhone;
                        txtWorkPhone.Text = user.WorkPhone;
                        txtEmailAddress.Text = user.EmailAddress;
                        txtAddress.Text = user.HomeAddress;
                        txtCity.Text = user.City;
                        if (!string.IsNullOrEmpty(user.Province))
                            ddlUserProvince.Items.FindByValue(user.Province.Trim()).Selected = true;
                        if (!string.IsNullOrEmpty(user.Title))
                            ddlTitle.Items.FindByValue(user.Title.Trim()).Selected = true;
                        hdfUser.Value = Convert.ToString(user.UserID);

                    }
                    else
                    {

                        txtEmailAddress.Text = FederationForms;

                    }
                }
            }
        }
        protected void Update_Click(object sender, EventArgs e)
        {

            UsersTableAzure user = new UsersTableAzure();
            user.Surname = txtLastname.Text;
            user.FirstName = txtFirstname.Text;
            user.EmailAddress = txtEmailAddress.Text;
            user.Cellphone = txtCellPhone.Text;
            user.HomeAddress = txtAddress.Text;
            user.HomePhone = txtHomePhone.Text;
            user.WorkPhone = txtWorkPhone.Text;
            user.Title = ddlTitle.SelectedValue.Trim();
            user.City = txtCity.Text.Trim();
            user.Province = ddlUserProvince.SelectedValue.Trim();
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {

                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name.Trim());
                user.UserName = membershipuser.UserName;
                membershipuser.Email = user.EmailAddress;
                Membership.UpdateUser(membershipuser);
            }


            Guid value = Search.UpdateContact(user, hdfUser.Value);
            hdfUser.Value = Convert.ToString(value);
            tblProfile.Visible = true;
        }
    }
}