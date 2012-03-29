using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ServiceModel;
using System.Net;
using System.Net.Http;
using System.Json;
using System.ServiceModel.Web;
using Microsoft.ApplicationServer.Http.Dispatcher;
using System.ComponentModel.Composition;
using RealEstateLibraries;
using System.Runtime.Serialization.Json;

namespace RealEstateWebRole.WebServices
{

    [ServiceContract]
    public class RealEstateApi
    {
        private static CacheApprovedItems _cacheApprovedItems;
        public static CacheApprovedItems cacheApprovedItems
        {
            get
            {
                if (_cacheApprovedItems == null)
                    _cacheApprovedItems = (CacheApprovedItems)HttpRuntime.Cache["SouthAfrica"];
                if (_cacheApprovedItems == null)
                    _cacheApprovedItems = new CacheApprovedItems();
                return _cacheApprovedItems;
            }
            set
            {
                _cacheApprovedItems = value;
            }
        }
        //[WebGet(UriTemplate = "api/properties")]
        //public IEnumerable<PropertyTableAzure> GetProperties()
        //{
        //    DataContractJsonSerializer dataContractJsonSerializer=new DataContractJsonSerializer()
        //    JsonValue value = JsonValue.Parse(cacheApprovedItems.propertyTablecache.ToArray());
        //    JsonArray array=new JsonArray();
        //       array.
          
        //    PopulateFromCache();
        //    return cacheApprovedItems.propertyTablecache;
        //}
        [WebGet]
        public IQueryable<PropertyTableAzure> GetProperties()
        {
            //DataContractJsonSerializer dataContractJsonSerializer=new DataContractJsonSerializer()
            //JsonArray array=DataContractJsonSerializer(cacheApprovedItems.propertyTablecache
            //   array.
            PopulateFromCache();
            return cacheApprovedItems.propertyTablecache.AsQueryable();
        }
        private static void PopulateFromCache()
        {

            if (HttpRuntime.Cache["SouthAfrica"] != null)
            {
                cacheApprovedItems = (CacheApprovedItems)HttpRuntime.Cache["SouthAfrica"];
            }
            else
            {
                Search.PopulatetheCache();
            }



        }
    }
}