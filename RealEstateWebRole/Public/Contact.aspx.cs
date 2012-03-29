using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using System.Net.Mail;
using System.Text;


using System.Net;

using System.Configuration;
using System.Web.UI.HtmlControls;

namespace RealEstateWebRole.Public
{
    public partial class Contact : System.Web.UI.Page
    {
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
                htmlmeta2.Content = "Nation daily,nation news paper kenya";
                Page.Header.Controls.Add(htmlmeta2);
                Page.Title = "Contact Us";
            }


        }
        protected void Submit_Click(object sender, EventArgs e)
        {
            WebOwner owner = new WebOwner();
            owner.Comment = txtComment.Text;
            owner.Email = txtEmail.Text;
            owner.FirstName = txtName.Text;
            owner.HeardUs = ddlHear.SelectedValue;
            owner.Phone = txtPhone.Text;
            owner.Surname = txtSurname.Text;
            owner.Query = ddlInTouch.SelectedValue;
            Search.AddContactInfo(owner);
            SendEmail(owner);
        }

        private void SendEmail(WebOwner owner)
        {
            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://api.mailgun.net/v2");
            
            //request.PreAuthenticate = true;
            //request.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["SMTPUSERNAME"].ToString().Trim(), ConfigurationManager.AppSettings["SMTPPASSWORD"].ToString().Trim());
            //request.Method = WebRequestMethods.Http.Post;

            MailMessage mail = new MailMessage();

            StringBuilder build = new StringBuilder();
            build.Append("<table><tr><td>Firstname</td><td>" + owner.FirstName + "</td></tr>");
            build.Append("<table><tr><td>Surname</td><td>" + owner.Surname + "</td></tr>");
            build.Append("<table><tr><td>Phone</td><td>" + owner.Phone + "</td></tr>");
            build.Append("<table><tr><td>Email</td><td>" + owner.Email + "</td></tr>");
            build.Append("<table><tr><td>How did you hear us?</td><td>" + owner.HeardUs + "</td></tr>");
            build.Append("<table><tr><td>Question</td><td>" + owner.Query + "</td></tr>");
            build.Append("<table><tr><td>Comments</td><td>" + owner.Comment + "</td></tr>");

            mail.From = new MailAddress(owner.Email);
            mail.Body = build.ToString();
            mail.To.Add(ConfigurationManager.AppSettings["OwnerEmail"]);
            //mail.To.Add(ConfigurationManager.AppSettings["CCOwnerEmail"]);
            mail.IsBodyHtml = true;

            SmtpClient client = new SmtpClient();
            client.Host = ConfigurationManager.AppSettings["SMTP"];
      //      client.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["SMTPUSERNAME"].ToString().Trim(),
      //ConfigurationManager.AppSettings["SMTPPASSWORD"].ToString().Trim());
            client.Port = 25;
            //client.Timeout = 50000;
            //client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            Object user = mail;
            client.SendCompleted += new SendCompletedEventHandler(smtpClient_SendCompleted);
            
            //client.PickupDirectoryLocation =@"C:\Users\Abraham\Documents\pickupdirectory";

            try
            {

                client.SendAsync(mail, user);
            }
            catch (Exception e)
            {
            }

        }

        void smtpClient_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
        {

            //Get UserState as MailMessage instance from SendMail()
            MailMessage mailMessage = e.UserState as MailMessage;
            divStatus.Visible = true;
            divMessage.Visible = false;

            if (e.Cancelled)
            {
                labMessage.Text = "Sending of email message was cancelled. Address=" + mailMessage.To[0].Address;
            }

            if (e.Error != null)
            {
                labMessage.Text = "Error occured, info=" + e.Error.Message;
            }
            else
            {
                labMessage.Text = "Mail sent successfully";
            }

        }

    }
}