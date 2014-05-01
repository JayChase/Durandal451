using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using Owin;
using Durandal451.Providers;
using Durandal451.Models;

namespace Durandal451
{
    public partial class Startup
    {
        static Startup()
        {
            PublicClientId = "self";

            UserManagerFactory = () =>
            {
                SetInitializer();

                return new UserManager<IdentityUser>(
                           new UserStore<IdentityUser>(
                               new IdentityDbContext())
                                   {
                                       DisposeContext = true
                                   });
            };

            RoleManagerFactory = () =>
            {
                SetInitializer();

                return new RoleManager<IdentityRole>(
                           new RoleStore<IdentityRole>(
                               new IdentityDbContext()));
            };

            OAuthOptions = ServerOptions();
        }

        private static OAuthAuthorizationServerOptions ServerOptions()
        {
            return new OAuthAuthorizationServerOptions
            {
                TokenEndpointPath = new PathString("/Token"),
                Provider = new ApplicationOAuthProvider(PublicClientId, UserManagerFactory),
                AuthorizeEndpointPath = new PathString("/api/Account/ExternalLogin"),
                AccessTokenExpireTimeSpan = TimeSpan.FromDays(14),
                AllowInsecureHttp = true
            };
        }

        private static void SetInitializer()
        {
            System.Data.Entity.Database.SetInitializer(new IdentityDbInitializer());
        }

        public static OAuthAuthorizationServerOptions OAuthOptions { get; private set; }

        public static Func<UserManager<IdentityUser>> UserManagerFactory { get; private set; }

        private static Func<RoleManager<IdentityRole>> RoleManagerFactory { get; set; }

        public static string PublicClientId { get; private set; }

    // For more information on configuring authentication, please visit http://go.microsoft.com/fwlink/?LinkId=301864
        private static void ConfigureAuth(IAppBuilder app)
        {
            // Enable the application to use a cookie to store information for the signed in user
            // and to use a cookie to temporarily store information about a user logging in with a third party login provider
            app.UseCookieAuthentication(new CookieAuthenticationOptions());
            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            // Enable the application to use bearer tokens to authenticate users
            app.UseOAuthBearerTokens(OAuthOptions);

            // Uncomment the following lines to enable logging in with third party login providers
            //app.UseMicrosoftAccountAuthentication(
            //    clientId: "",
            //    clientSecret: "");

            //app.UseTwitterAuthentication(
            //    consumerKey: "",
            //    consumerSecret: "");

            //app.UseFacebookAuthentication(
            //    appId: "",
            //    appSecret: "");

            app.UseGoogleAuthentication();
        }
    }
}
