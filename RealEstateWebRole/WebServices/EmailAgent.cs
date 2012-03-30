using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Activation;
using System.Web.Script.Serialization;
using RealEstateLibraries;
using System.Web;

using System.Web.Security;
using System.Threading;
using System.Net;
using System.IO;

using System.Net.Mail;



// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "EmailAgent" in code, svc and config file together.
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class EmailAgent : IEmailAgent
{
    List<Favourite> favourites;
    public string Result(string propertyid, string userid, string name, string phone, string email, string comment, string agentid)
    {

        StringBuilder emailstring = new StringBuilder();

        emailstring.Append(propertyid);
        emailstring.Append(";");
        emailstring.Append(userid);
        emailstring.Append(";");
        emailstring.Append(name);
        emailstring.Append(";");
        emailstring.Append(phone);
        emailstring.Append(";");
        emailstring.Append(email);
        emailstring.Append(";");
        emailstring.Append(comment);
        emailstring.Append(";");
        emailstring.Append(agentid);
        string[] items = emailstring.ToString().Split(new char[] { ';' });
        SaveToDataBaseAndEmail(items);

        return "Email sent Successfully";
    }
    private void SaveToDataBaseAndEmail(string[] items)
    {
        AgentEmail email = new AgentEmail();
        if (!string.IsNullOrEmpty(items[0]))
        {
            email.PropertyID = items[0].ToString();
        }
        if (!string.IsNullOrEmpty(items[1]))
        {
            email.UseID= items[1];
        }
        if (!string.IsNullOrEmpty(items[2]))
        {
            email.Name = items[2].ToString();
        }
        if (!string.IsNullOrEmpty(items[3]))
        {
            email.Phone = items[3].ToString();
        }
        if (!string.IsNullOrEmpty(items[4]))
        {
            email.UserEmail = items[4];
        }
        if (!string.IsNullOrEmpty(items[5]))
        {
            email.Message = items[5];
        }
        email.AgentID = Convert.ToString(Guid.NewGuid());

      


        SendEmail(email);

    }
    private void SendEmail(AgentEmail email)
    {
        WebRequest request = WebRequest.Create(ConfigurationManager.AppSettings["EmailTemplate"].ToString() + "UniqueID=" + email.UniqueID);
        WebResponse response = request.GetResponse();
        Stream stream = response.GetResponseStream();

        StreamReader readStream = new StreamReader(stream, Encoding.UTF8);
        string result = readStream.ReadToEnd();

        MailMessage mail = new MailMessage();

        //AlternateView alterView = AlternateView.CreateAlternateViewFromString(result, null, "text/html");

        //LinkedResource logo = new LinkedResource("");
        //logo.ContentId = "companylogo";

        //alterView.LinkedResources.Add(logo);

        //mail.AlternateViews.Add(alterView);
        mail.Body = result;

        var user = (from u in Search.GetUserTablesFromCache()
                    where u.UserID == Guid.Parse(email.UseID)
                    select u).FirstOrDefault();
        if (user != null)
        {
            mail.To.Add(new MailAddress(user.EmailAddress));
            mail.From = new MailAddress(email.UserEmail, email.Name);
            mail.IsBodyHtml = true;
            mail.Subject = "Enquiry about the property";
            try
            {
                SmtpClient client = new SmtpClient();
                //client.Credentials = new NetworkCredential(RoleEnvironment.GetConfigurationSettingValue("EWSUserName"), RoleEnvironment.GetConfigurationSettingValue("EWSPassword"));
                client.Port = 25;
                client.Timeout = 50000;
                client.Host = ConfigurationManager.AppSettings["SMTP"];
                client.UseDefaultCredentials = false;
                client.Send(mail);
            }
            catch (Exception e)
            {
               // Trace.WriteLine("Sending an email to the client", e.Message);
            }
        }

    }
    public string EmailFriend(string propertyid, string name, string email, string firstname, string firstemail, string secondname, string secondemail, string comment)
    {

        StringBuilder emailstring = new StringBuilder();

        emailstring.Append(propertyid);
        emailstring.Append(";");
        emailstring.Append(name);
        emailstring.Append(";");
        emailstring.Append(email);
        emailstring.Append(";");
        emailstring.Append(firstname);
        emailstring.Append(";");
        emailstring.Append(firstemail);
        emailstring.Append(";");
        emailstring.Append(secondname);
        emailstring.Append(";");
        emailstring.Append(secondemail);
        emailstring.Append(";");
        emailstring.Append(comment);

        return "Email sent Successfully";
    }
    public void Favourite(string propertyid, string userid)
    {
        Favourite favourite = new Favourite();
        if (HttpContext.Current.Session["Favourite"] != null)
        {
            favourites = (List<Favourite>)HttpContext.Current.Session["Favourite"];
            PopulateSession(propertyid, userid, favourite);


        }
        else
        {
            favourites = new List<Favourite>();
            PopulateSession(propertyid, userid, favourite);
        }
    }

    private void PopulateSession(string propertyid, string userid, Favourite favourite)
    {
        favourite.UserID = Convert.ToString(userid);
        favourite.PropertyID = Convert.ToString(propertyid);

        HttpContext.Current.Session["Favourite"] = favourites;
        string FederationForms = "";
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
           
             if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
            favourite.UserName = FederationForms;
            Search.AddFavourite(favourite);
        }
        favourites.Add(favourite);
    }
}
