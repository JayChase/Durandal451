using System;
using System.Web.Http;
using System.Web.Mvc;

namespace Durandal451.Areas.HelpPage.Controllers
{
    /// <summary>
    /// The controller that will handle requests for the help page.
    /// </summary>
    public class HelpController : Controller
    {
        public HelpController()
            : this(GlobalConfiguration.Configuration)
        {
        }

        public HelpController(HttpConfiguration config)
        {
            Configuration = config;
        }

        public HttpConfiguration Configuration { get; private set; }

        public ActionResult Index()
        {
            ViewBag.DocumentationProvider = Configuration.Services.GetDocumentationProvider();
            return View(Configuration.Services.GetApiExplorer().ApiDescriptions);
        }

        public ActionResult Api(string apiId)
        {
            if (String.IsNullOrEmpty(apiId)) return View("Error");
            var apiModel = Configuration.GetHelpPageApiModel(apiId);

            return apiModel != null ? View(apiModel) : View("Error");
        }
    }
}