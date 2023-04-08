using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace siteSQL
{
    public partial class Employees : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var siteMaster = (SiteMaster)this.Master;
            if (siteMaster != null)
            {
                siteMaster.DepartmentsNavClass = "nav-link active current";
                siteMaster.DepartmentsNavCurrent = "page";
                siteMaster.DepartmentsNavColor = "color:lightgreen";
            }
        }
    }
}