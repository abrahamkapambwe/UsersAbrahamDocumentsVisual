using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Routing;
using RealEstateLibraries;

using System.Data.Services.Client;
using RealEstateWebRole.WebServices;
using Microsoft.ApplicationServer.Http;


namespace RealEstateWebRole
{
    public class Global : System.Web.HttpApplication
    {
        private const string ZA = ".ke";
        private static CacheApprovedItems _cachedItems;
        public static CacheApprovedItems cachedItems
        {
            get
            {
                if (_cachedItems == null)
                    _cachedItems = new CacheApprovedItems();
                return _cachedItems;
            }
        }
        void Application_Start(object sender, EventArgs e)
        {
            var config = new WebApiConfiguration();
            config.EnableTestClient = true;
            RouteTable.Routes.SetDefaultHttpConfiguration(config);
            RouteTable.Routes.MapServiceRoute<RealEstateApi>("PropertyTableAzures");
            Search.PopulatetheCache();
            Search.PopulatetheCacheEstate();
           // PopulateTheCache();
        }

        

        private void RegisterRoute(RouteCollection routeCollection)
        {
            //Admin Client
            //routeCollection.MapPageRoute("Preview", "Preview", "~/Admin/Preview.aspx");
            //routeCollection.MapPageRoute("LoadPropertyDetails", "LoadPropertyDetails", "~/Admin/UploadPictures.aspx");
            //routeCollection.MapPageRoute("ViewProperties", "ViewProperties", "~/Admin/ViewProperty.aspx");
            //routeCollection.MapPageRoute("AgentProfile", "AgentProfile", "~/Admin/AgentProfile.aspx");
            ////Public 
            //routeCollection.MapPageRoute("PropertyDetails", "{Rentals}/{City}/{Subarb}/{StreetName}/{Price}/{PropertyID}", "~/Public/PropertyDetails.aspx");
            //routeCollection.MapPageRoute("SearchResult", "Search", "~/Public/SearchResult.aspx");
            //routeCollection.MapPageRoute("AgentDetails", "{Rentals}/{City}/{Subarb}/{StreetName}", "~/Public/Agents.aspx");


            ////Authenticating
            //routeCollection.MapPageRoute("Registeration", "Register/", "~/Account/Register.aspx");
            //routeCollection.MapPageRoute("Login", "Login/", "~/Account/Login.aspx");
            //routeCollection.MapPageRoute("ChangePassword", "ChangePassword/", "~/Account/ChangePassword.aspx");
            //routeCollection.MapPageRoute("ChangePasswordSuccess", "ChangePasswordSuccess", "~/Account/ChangePasswordSuccess.aspx");

        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new session is started

        }

        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }

    }
}
