using System.Web.Mvc;

namespace Durandal451v2.Controllers {
    
    [RequireHttps]    
    public class DurandalController : Controller {
    public ActionResult Index() {
      return View();
    }
  }
}