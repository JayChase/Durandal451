using System.Web.Optimization;

[assembly: WebActivator.PostApplicationStartMethod(typeof(Durandal451.DurandalConfig), "PreStart")]

namespace Durandal451
{
    public static class DurandalConfig
    {
        public static void PreStart()
        {
            // Add your start logic here
            DurandalBundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}