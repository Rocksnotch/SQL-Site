using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace siteSQL
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            productTable1.SelectedIndex = -1;
            var siteMaster = (SiteMaster)this.Master;
            if (siteMaster != null)
            {
                siteMaster.ProductNavClass = "nav-link active current";
                siteMaster.ProductNavCurrent = "page";
                siteMaster.ProductNavColor = "color:lightgreen";
            }
        }

        protected void productTable1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void dropdownlist_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}