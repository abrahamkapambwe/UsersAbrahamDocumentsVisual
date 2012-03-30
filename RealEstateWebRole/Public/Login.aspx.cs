using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Threading;

using System.Configuration;
using System.Web.UI.HtmlControls;

namespace RealEstateWebRole.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Title = "Login Page ";
                HtmlMeta htmlmeta = new HtmlMeta();
                htmlmeta.Name = "Keywords";
                htmlmeta.Content = "Property in Kenya,property kenya,real estate in kanya,kenyan real estate,real estate agent in kenya,proprty listing site in kenya,plots for sale,most popular property site in kenya";
                Page.Header.Controls.Add(htmlmeta);

                HtmlMeta htmlmeta2 = new HtmlMeta();
                htmlmeta2.Name = "keywords2";
                htmlmeta2.Content = "Nation daily,nation news paper kenya";
                Page.Header.Controls.Add(htmlmeta2);
            }
            RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            IEnumerable<IdentityProvider> providers = null;
            if (Page.User.Identity.IsAuthenticated)
            {
                AnonymousUser.Visible = false;
                //IClaimsIdentity claimsIdentity = Thread.CurrentPrincipal.Identity as IClaimsIdentity;
                //ClaimsAuthenticationManager manager = new ClaimsAuthenticationManager();


            }
            else
            {
                //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://epropertysearchnet.accesscontrol.windows.net:443/v2/metadata/IdentityProviders.js?protocol=wsfederation&realm=http%3a%2f%2f127.0.0.1%3a81%2f&reply_to=http%3a%2f%2f127.0.0.1%3a81%2fPublic%2fLogin.aspx&context=&request_id=&version=1.0&callback=");
                //HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                //Stream stream = response.GetResponseStream();

                //StreamReader strReader = new StreamReader(stream);

                //// string strResponse = strReader.ReadToEnd();
                //DataContractJsonSerializer seriler = new DataContractJsonSerializer(typeof(IdentityProvider[]));
                //providers = seriler.ReadObject(stream) as IEnumerable<IdentityProvider>;
            }

            if (providers != null)
            {
                if (providers.Count() > 0)
                {
                    foreach (var access in providers)
                    {
                        if (access.Name.Contains("Facebook"))
                        {
                            hypfacebook.NavigateUrl = access.LoginUrl;
                            hypfacebook.Text = "Facebook";
                         
                        }
                        else if (access.Name.Contains("Google"))
                        {
                            hypGoogle.NavigateUrl = access.LoginUrl;
                            hypGoogle.Text = "Google";
                        }
                    }
                }
            }
            if (Request.QueryString["Status"] != null)
            {
                Session["Status"] = (string)Request.QueryString["Status"];
                LoginUser.DestinationPageUrl = "~/Members/UploadPictures.aspx";
            }
            else{
                LoginUser.DestinationPageUrl = "~/Public/Login.aspx";
            }
        }


    }
}
