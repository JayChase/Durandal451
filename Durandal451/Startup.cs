using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(Durandal451.Startup))]

namespace Durandal451
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
