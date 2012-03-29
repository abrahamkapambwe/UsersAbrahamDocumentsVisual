using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RealEstateWebRole.Admin
{
    public enum SearchTypeEnum
    {
        Buy=1,
        Rent=1,
        Agent
    }
    public class MapEventArgs
    {
        public MapEventArgs() { }
        public int PropertyID
        {
            get;
            set;
        }
        public string Lat
        {
            get;
            set;
        }
        public string Lng
        {
            get;
            set;
        }
        public string Multiview
        {
            get;
            set;
        }
       
    }
   public  delegate void MapListEventHandler(object sender,MapEventArgs e);
}