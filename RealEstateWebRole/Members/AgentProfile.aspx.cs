using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Text;
using System.Data;
using System.Web.Security;

using System.Threading;
namespace RealEstateWebRole.Account
{
    public partial class AgentProfile : System.Web.UI.Page
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
                    SavePropDetailsToDB();
                    LoadData();


                }



            }
        }
        protected void Upload_Click(object sender, EventArgs e)
        {
            if (fileupload1.HasFile)
            {
                string userid = Convert.ToString(hdfUserID.Value);



                Search.AddLogo(FederationForms, fileupload1, userid);
                imgProfile.ImageUrl = Search.GetImageUrlLogo(userid);

            }
        }
        private void SavePropDetailsToDB()
        {
            UsersTableAzure user = Search.GetUserProfile(FederationForms);
            if (user == null)
            {

                user = Search.SavePropDetailsFirstTime(FederationForms, FederationForms);

                EstateAgentAzure estate = Search.GetAgentDetailsByID(user.UserName);
                if (estate == null)
                {
                    SaveEstate(user);
                }
            }
            else
            {
                EstateAgentAzure estate = Search.GetAgentDetailsByID(user.UserName);
                if (estate == null)
                {
                    SaveEstate(user);
                }
            }
        }

        private static void SaveEstate(UsersTableAzure user)
        {
            EstateAgentAzure estate;
            estate = new EstateAgentAzure();
            estate.Username = user.UserName;
            estate.UserID = Convert.ToString(user.UserID);
            Search.AddEstateAgent(estate, Guid.NewGuid());
        }

        private void LoadData()
        {
            UsersTableAzure user = Search.GetUserProfile(FederationForms);
            if (user != null)
            {
                txtCellphone.Text = user.Cellphone;
                txtLastname.Text = user.Surname;
                txtEmail.Text = user.EmailAddress;
                txtBusinessPhone.Text = user.WorkPhone;
                txtFirstName.Text = user.FirstName;
                txtZip.Text = user.PostalCode;


                hdfUserID.Value = Convert.ToString(user.UserID);
                EstateAgentAzure estate = Search.GetAgentDetailsByID(user.UserName);
                if (estate != null)
                {
                    //txtScreenname.Text = estate.;
                    txtCity.Text = estate.City;
                    txtServiceDescription.Text = estate.Description;
                    hdfEstateID.Value = Convert.ToString(estate.EstateAgentID);
                    if (!string.IsNullOrWhiteSpace(estate.State_Prov))
                        ddlProvince.Items.FindByValue(estate.State_Prov).Selected = true;

                    if (estate.ProfilePhotoUrl != null)
                    {
                        string urllogo = estate.ProfilePhotoUrl;
                        if (!string.IsNullOrWhiteSpace(urllogo))
                        {
                            imgProfile.ImageUrl = urllogo;
                        }
                        else
                        {
                            imgProfile.ImageUrl = "~/images/empty_thumbnail.gif";
                        }
                    }
                    else
                    {
                        imgProfile.ImageUrl = "~/images/empty_thumbnail.gif";
                    }
                    txtTwitter.Text = estate.TwitterUrl;
                    txtWebsite.Text = estate.WebsiteUrl;
                    txtProfessionaltitle.Text = estate.ProfessionalTitle;
                    txtfaceBook.Text = estate.FaceBookUrl;
                    txtFaxNumber.Text = estate.FaxNumber;
                    txtBusinessaddress.Text = estate.AgentAddress;
                    txtBusinessname.Text = estate.BusinessName;
                    if (!string.IsNullOrWhiteSpace(estate.ServiceArea))
                    {
                        string[] serviceArea = estate.ServiceArea.Split(new char[] { '|' });
                        for (int i = 0; i < serviceArea.Count(); i++)
                        {
                            switch (i)
                            {
                                case 0:
                                    txtServiceArea.Text = serviceArea[i];
                                    break;
                                case 1:
                                    txtServiceArea1.Text = serviceArea[i];
                                    break;
                                case 2:
                                    txtServiceArea2.Text = serviceArea[i];
                                    break;
                                case 3:
                                    txtServiceArea3.Text = serviceArea[i];
                                    break;
                                case 4:
                                    //txtServiceArea4.Text = serviceArea[i];
                                    break;

                            }
                        }
                    }
                    if (!string.IsNullOrEmpty(estate.ProfessionalCategory))
                        ddlProfessionCategory.Items.FindByText(estate.ProfessionalCategory).Selected = true;
                    //ddlProfessionCategory.Items.FindByText(estate.ProfessionalCategory.Trim()).Selected = true;
                    txtLinkedin.Text = estate.LinkedIn;
                    if (!string.IsNullOrWhiteSpace(estate.AgentType))
                    {
                        string[] Speciaties = estate.AgentType.Split(new char[] { ';' });
                        foreach (string special in Speciaties)
                        {
                            if (!string.IsNullOrEmpty(special))
                            {
                                cblAgentsSpecialties.Items.FindByText(special).Selected = true;
                            }
                        }
                    }


                }
            }
        }
        protected void SavePersonalProfile_Click(Object sender, EventArgs e)
        {
            string serviceArea = "";
            EstateAgentAzure estate = new EstateAgentAzure();

            //estate.SreenName = txtScreenname.Text;
            estate.ProfilePhotoUrl = imgProfile.ImageUrl;
            estate.ProfileVideoUrl = txtProfileVideo.Text;




            UsersTableAzure user = new UsersTableAzure();
            user.Cellphone = txtCellphone.Text;
            user.WorkPhone = txtBusinessPhone.Text;
            user.PostalCode = txtZip.Text;
            user.EmailAddress = txtEmail.Text;
            user.FirstName = txtFirstName.Text;
            user.Surname = txtLastname.Text;
            user.UserName = FederationForms;

            estate.City = txtCity.Text;
            estate.Username = FederationForms;
            //estate.ServiceArea = txtServiceArea.Text;
            estate.State_Prov = ddlProvince.SelectedValue;
            estate.BusinessName = txtBusinessname.Text;
            estate.AgentAddress = txtBusinessaddress.Text;
            estate.TwitterUrl = txtTwitter.Text;
            estate.WebsiteUrl = txtWebsite.Text;
            estate.FaceBookUrl = txtfaceBook.Text;
            estate.FaxNumber = txtFaxNumber.Text;
            estate.Description = txtServiceDescription.Text;
            if (!string.IsNullOrWhiteSpace(txtServiceArea.Text))
            {
                serviceArea = txtServiceArea.Text + "|";
            }
            if (!string.IsNullOrWhiteSpace(txtServiceArea1.Text))
            {
                serviceArea = serviceArea + txtServiceArea1.Text + "|";
            }
            if (!string.IsNullOrWhiteSpace(txtServiceArea2.Text))
            {
                serviceArea = serviceArea + txtServiceArea2.Text + "|";
            }
            if (!string.IsNullOrWhiteSpace(txtServiceArea3.Text))
            {
                serviceArea = serviceArea + txtServiceArea3.Text + "|";
            }
            estate.ServiceArea = serviceArea;
            estate.ProfessionalTitle = txtProfessionaltitle.Text;
            estate.ProfessionalCategory = ddlProfessionCategory.SelectedValue;
            estate.UserID = Convert.ToString(hdfUserID.Value);
            estate.LinkedIn = txtLinkedin.Text;
            StringBuilder agentType = new StringBuilder();
            int j = 0;
            for (int i = 0; i < cblAgentsSpecialties.Items.Count; i++)
            {
                if (cblAgentsSpecialties.Items[i].Selected)
                {
                    if (j <= 4)
                    {
                        if (cblAgentsSpecialties.Items[i].Text.Contains("Other"))
                        {
                            agentType.Append(txtOtherAgentsSpecialties.Text);
                            agentType.Append(";");
                        }
                        else
                        {
                            agentType.Append(cblAgentsSpecialties.Items[i].Value.ToString());
                            agentType.Append(";");
                        }
                    }
                    j++;
                }
            }
            estate.AgentType = agentType.ToString();


            estate.IPAddress = Request.UserHostAddress;

            Search.UpdateContact(user, hdfUserID.Value);
            Search.AddEstateAgent(estate, Guid.Parse(hdfEstateID.Value));
            lblResult.Text = "Successfully saved";
            // Response.Redirect("~/Members/UploadPictures.aspx?FromAgent=1");
        }

    }
}