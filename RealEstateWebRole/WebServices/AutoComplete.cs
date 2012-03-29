
using System;
using System.Collections.Generic;
using System.Web.Services;
using System.Web;
using RealEstateLibraries;
using System.Linq;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
public class AutoComplete : WebService
{
    public AutoComplete()
    {
    }

    [WebMethod]
    public string[] GetCompletionList(string prefixText, int count)
    {
        if (count == 0)
        {
            count = 10;
        }
        List<string> items = new List<string>();
        if (HttpRuntime.Cache["SouthAfrica"] != null)
        {
            CacheApprovedItems cacheapproveditems = (CacheApprovedItems)HttpRuntime.Cache["SouthAfrica"];
            var property = from p in cacheapproveditems.propertyTablecache
                           select p;
            foreach (var c in property)
            {
                if (!string.IsNullOrWhiteSpace(c.City))
                {
                    if (c.City.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
                    {
                        if (!items.Contains(c.City.ToString() + " " + c.Province.ToString()))
                            items.Add(c.City.ToString() + " " + c.Province.ToString());
                    }
                }
                if (!string.IsNullOrWhiteSpace(c.Suburb))
                {
                    if (c.Suburb.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
                    {
                        if (!items.Contains(c.Suburb))
                            items.Add(c.Suburb.ToString() + " " + c.City.ToString() + " " + c.Province);
                    }
                }
                if (!string.IsNullOrWhiteSpace(c.Province))
                {

                    if (c.Province.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
                    {
                        if (!items.Contains(c.Province))
                            items.Add(c.Province.ToString());
                    }
                }
            }
            //var attribute = from a in cacheapproveditems.attributelistcache
            //                select a;
            //foreach (var a in attribute)
            //{
            //    string hometype = "House";
            //    if (!string.IsNullOrWhiteSpace(a.HomeType))
            //        hometype = a.HomeType;

            //    var prop = (from p in property
            //                where p.PropertyID == a.PropertyID
            //                select p).FirstOrDefault();
            //    if (!string.IsNullOrWhiteSpace(a.AccessGate))
            //    {
            //        if (a.AccessGate.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
            //        {

            //            if (!string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.BedRooms.ToString() + " " + "with " + a.AccessGate.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.BedRooms.ToString()+ " " + hometype + "with" + a.AccessGate.ToString() + "in" + prop.Suburb + " " + prop.City);
            //            if (string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.AccessGate.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.AccessGate.ToString() + "in" + prop.Suburb + " " + prop.City);
            //        }
            //    }
            //    if (!string.IsNullOrWhiteSpace(a.AirCon))
            //    {
            //        if (a.AirCon.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
            //        {
            //            if (!string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.BedRooms.ToString() + " " + "with " + a.AirCon.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.BedRooms.ToString() + " " + hometype +  "with" + a.AirCon.ToString() + "in" + prop.Suburb + " " + prop.City);
            //            if (string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.AccessGate.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.AirCon.ToString() + " " + hometype + "in" + prop.Suburb + " " + prop.City);
            //        }
            //    }
            //    if (!string.IsNullOrWhiteSpace(a.Alarm))
            //    {
            //        if (a.Alarm.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
            //        {
            //            if (!string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.BedRooms.ToString() + " " + "with " + a.Alarm.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.BedRooms.ToString()+ " " + hometype + "with" + a.Alarm.ToString() + "in" + prop.Suburb + " " + prop.City);
            //            if (string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.Alarm.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.Alarm.ToString() + "in" + prop.Suburb + " " + prop.City);
            //        }
            //    }
            //    if (!string.IsNullOrWhiteSpace(a.Balcony))
            //    {
            //        if (a.Balcony.StartsWith(prefixText, StringComparison.CurrentCultureIgnoreCase))
            //        {
            //            if (!string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.BedRooms.ToString() + " " + "with " + a.Balcony.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.BedRooms.ToString() + " " + hometype + "with" + a.Balcony.ToString() + "in" + prop.Suburb + " " + prop.City);
            //            if (string.IsNullOrWhiteSpace(a.BedRooms.ToString()) && !items.Contains(a.Balcony.ToString() + "in" + prop.Suburb + " " + prop.City))
            //                items.Add(a.Balcony.ToString() + " " + hometype + "in" + prop.Suburb + " " + prop.City);
            //        }

            //    }
            //    if (!string.IsNullOrWhiteSpace(a.Bathrooms.ToString()))
            //    {
            //        if (!items.Contains(a.Bathrooms.ToString() + "in" + prop.Suburb + " " + prop.City))
            //            items.Add(a.Bathrooms.ToString() + " " + hometype + "in" + prop.Suburb + " " + prop.City);
                    
            //    }
            //    if (!string.IsNullOrWhiteSpace(a.BedRooms.ToString()))
            //    {
                    
            //        if (!items.Contains(a.BedRooms.ToString() + "in" + prop.Suburb + " " + prop.City))
            //            items.Add(a.BedRooms.ToString() + " " + hometype + "in" + prop.Suburb + " " + prop.City);
            //    }
            //}




        }
        return items.ToArray();
    }
}

