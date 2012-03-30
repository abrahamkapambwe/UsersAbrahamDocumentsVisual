using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

using System.Web.Security;
using RealEstateLibraries;

namespace RealEstateWebRole.Members.maps
{
    public partial class PropertyPictures : System.Web.UI.Page
    {
        private string FederationForms = "";
        string propertyID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (HttpContext.Current.User.Identity.AuthenticationType.Contains("Forms"))
            {
                MembershipUser membershipuser = Membership.GetUser(HttpContext.Current.User.Identity.Name);
                FederationForms = membershipuser.Email;
            }
            if (!IsPostBack)
            {
                propertyID = Convert.ToString(Request.QueryString["propertyimagesID"]);
             
                Session["propPicturesID"] = propertyID;
                ltvThumbnail.DataSource = Search.GetThumbnails(FederationForms, Guid.Parse(propertyID));
                ltvThumbnail.DataBind();
            }

        }
        protected void ImgThumbDelete_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton but = sender as ImageButton;
           string imageID = Convert.ToString(but.CommandArgument);
            Search.DeleteImage(imageID);
        
            if (Session["propPicturesID"] != null)
            {
                propertyID = (string)Session["propPicturesID"];
            }
            else
            {

              //  propertyID = Convert.ToInt32(PropertyIDFromDataBase.Value);
                Session["propPicturesID"] = propertyID;
            }
            //Keys key = Search.GetID(HttpContext.Current.User.Identity.Name);
            ltvThumbnail.DataSource = Search.GetThumbnails(FederationForms, Guid.Parse(propertyID));
            ltvThumbnail.DataBind();

        }
        protected void UploadImages_Click(object sender, EventArgs e)
        {
            List<UploadFiles> listOffiles = new List<UploadFiles>();
            UploadFiles uploadFiles;
            string  propertyID="";
            if (Session["propPicturesID"] != null)
            {
                propertyID = (string)Session["propPicturesID"];
            }


            if (FileUpload1.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload1.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload1.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload1.PostedFile.FileName;
                uploadFiles.Stream = FileUpload1.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            if (FileUpload2.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload2.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload2.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload2.PostedFile.FileName;
                uploadFiles.Stream = FileUpload2.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            if (FileUpload3.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload3.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload3.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload3.PostedFile.FileName;
                uploadFiles.Stream = FileUpload3.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            if (FileUpload4.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload4.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload4.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload4.PostedFile.FileName;
                uploadFiles.Stream = FileUpload4.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            if (FileUpload5.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload5.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload5.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload5.PostedFile.FileName;
                uploadFiles.Stream = FileUpload5.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            if (FileUpload6.HasFile)
            {
                uploadFiles = new UploadFiles();
                uploadFiles.ContentLength = Convert.ToString(FileUpload6.PostedFile.ContentLength);
                uploadFiles.ContentType = FileUpload6.PostedFile.ContentType;
                uploadFiles.FileName = FileUpload6.PostedFile.FileName;
                uploadFiles.Stream = FileUpload6.PostedFile.InputStream;
                listOffiles.Add(uploadFiles);
            }
            Search.AddImage(FederationForms, listOffiles, Guid.Parse(propertyID));
            lblImages.Visible = true;
           // Keys key = Search.GetID(FederationForms);
            ltvThumbnail.DataSource = Search.GetThumbnails(FederationForms, Guid.Parse(propertyID));
            ltvThumbnail.DataBind();



        }
    }
}