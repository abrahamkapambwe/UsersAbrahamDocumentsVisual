using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using RealEstateLibraries;
using Amazon.SimpleDB;

namespace RealEstateWebRole.EmailTemplates
{
    public partial class SendAgentEmails : System.Web.UI.Page
    {
        private static AmazonSimpleDBClient _amazonSimpleDBClient;
        public static AmazonSimpleDBClient amazonSimpleDBClient
        {
            get
            {
                if (_amazonSimpleDBClient == null)
                    _amazonSimpleDBClient = new AmazonSimpleDBClient();
                return _amazonSimpleDBClient;
            }
        }
        private static AmazonS3Service _amazonS3Service;
        public static AmazonS3Service amazonS3Service
        {
            get
            {
                if (_amazonS3Service == null)
                    _amazonS3Service = new AmazonS3Service();
                return _amazonS3Service;
            }
        }
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["UniqueID="]!=null)
            {
                string uniqueID = (string)Request.QueryString["UniqueID"].ToString();

                var client = (from c in AmazonSimpleDBCustom.GetAgentEmails("",amazonSimpleDBClient)
                              where c.UniqueID == uniqueID
                              select c).FirstOrDefault();
                lblName.Text = client.Name;
                lblPhone.Text = client.Phone;
                lblMessage.Text = client.Message;
                lblEmail.Text = client.UserEmail;

                hyperProperty.NavigateUrl = "~/PropertyDetails.aspx?PropertryID=" + client.PropertyID; 

                //var property = (from p in Entity.PropertyTables
                //                where p.PropertyID == client.ProductID
                //                select p).FirstOrDefault();
            }
        }
    }
}