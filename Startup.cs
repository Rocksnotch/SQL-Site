using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(siteSQL.Startup))]
namespace siteSQL
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
