using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace siteSQL
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var siteMaster = (SiteMaster)this.Master;
            if (siteMaster != null)
            {
                siteMaster.HomeNavClass = "nav-link active current";
                siteMaster.HomeNavCurrent = "page";
                siteMaster.HomeNavColor = "color:lightgreen";
            }
        }
    }
}