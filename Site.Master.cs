using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using WebGrease.Css.Ast.Selectors;

namespace siteSQL
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }

        public String HomeNavClass
        {
            get { return homeNav.Attributes["class"]; }
            set { homeNav.Attributes["class"] = value; }
        }
        public String HomeNavCurrent
        {
            get { return homeNav.Attributes["aria-current"]; }
            set { homeNav.Attributes["aria-current"] = value; }
        }
        public String HomeNavColor
        {
            get { return homeNav.Attributes["style"]; }
            set { homeNav.Attributes["style"] = value; }
        }
        public String DepartmentsNavClass
        {
            get { return departmentsNav.Attributes["class"]; }
            set { departmentsNav.Attributes["class"] = value; }
        }
        public String DepartmentsNavCurrent
        {
            get { return departmentsNav.Attributes["aria-current"]; }
            set { departmentsNav.Attributes["aria-current"] = value; }
        }
        public String DepartmentsNavColor
        {
            get { return departmentsNav.Attributes["style"]; }
            set { departmentsNav.Attributes["style"] = value; }
        }
        public String QuoteNavClass
        {
            get { return quoteNav.Attributes["class"]; }
            set { quoteNav.Attributes["class"] = value; }
        }
        public String QuoteNavCurrent
        {
            get { return quoteNav.Attributes["aria-current"]; }
            set { quoteNav.Attributes["aria-current"] = value; }
        }
        public String QuoteNavColor
        {
            get { return quoteNav.Attributes["style"]; }
            set { quoteNav.Attributes["style"] = value; }
        }
        public String ProductNavClass
        {
            get { return productsNav.Attributes["class"]; }
            set { productsNav.Attributes["class"] = value; }
        }
        public String ProductNavCurrent
        {
            get { return productsNav.Attributes["aria-current"]; }
            set { productsNav.Attributes["aria-current"] = value; }
        }
        public String ProductNavColor
        {
            get { return productsNav.Attributes["style"]; }
            set { productsNav.Attributes["style"] = value; }
        }
    }

}