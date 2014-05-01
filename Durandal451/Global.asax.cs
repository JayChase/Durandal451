using System;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Durandal451
{
    public class MvcApplication : HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
        internal static string Path
        {
            get
            {
                var path = AppDomain.CurrentDomain.FriendlyName;
                path = path.Substring(path.LastIndexOf("/", StringComparison.Ordinal));
                path = path.Substring(0, path.IndexOf("-", StringComparison.Ordinal));
                return path;
            }
        }
    }
}
