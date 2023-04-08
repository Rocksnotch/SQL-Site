using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace siteSQL
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var siteMaster = (SiteMaster)this.Master;
            if (siteMaster != null)
            {
                siteMaster.QuoteNavClass = "nav-link active current";
                siteMaster.QuoteNavCurrent = "page";
                siteMaster.QuoteNavColor = "color:lightgreen";
            }
        }
    }
}