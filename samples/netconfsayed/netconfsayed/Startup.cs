using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(netconfsayed.Startup))]
namespace netconfsayed
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
