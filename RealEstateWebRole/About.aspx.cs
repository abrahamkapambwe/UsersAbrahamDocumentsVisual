using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace RealEstateWebRole
{
    public partial class About : System.Web.UI.Page
    {
        private static Table _table;
        public static Table Table
        {
            get
            {
                if (_table == null)
                    _table = new Table();
                return _table;
            }
            set
            {
                _table = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnattribute_Onclick(object sender, EventArgs e)
        {
            switch (ddlFeatures.SelectedValue)
            {
                case "Storage":
                    trStorage.Visible = true;
                   
                    break;
                case "Swimming Pool":
                    trSwimmingPool.Visible = true;
                    break;
                default:
                    break;
            }

        }
        protected void but_Click(object sender,CommandEventArgs e)
        {
            switch (e.CommandArgument.ToString())
            {
                case "Storage":
                    trStorage.Visible = false;
                    break;
                case "SwimmingPool":
                    trSwimmingPool.Visible = false;
                    break;
            }
        }
    }
}
