﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;

namespace Durandal451.Providers
{
    public class ApplicationOAuthProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;
        private readonly Func<UserManager<IdentityUser>> _userManagerFactory;

        public ApplicationOAuthProvider(string publicClientId, Func<UserManager<IdentityUser>> userManagerFactory)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }

            if (userManagerFactory == null)
            {
                throw new ArgumentNullException("userManagerFactory");
            }
            _publicClientId = publicClientId;
            _userManagerFactory = userManagerFactory;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            using (var userManager = _userManagerFactory())
            {
                var user = await userManager.FindAsync(context.UserName, context.Password);

                if (user == null)
                {
                    context.SetError("invalid_grant", "The user name or password is incorrect.");
                    return;
                }

                var oAuthIdentity = await userManager.CreateIdentityAsync(user,   context.Options.AuthenticationType);
                var cookiesIdentity = await userManager.CreateIdentityAsync(user, CookieAuthenticationDefaults.AuthenticationType);
                var properties = CreateProperties(user);
                
                context.Validated( new AuthenticationTicket(oAuthIdentity, properties));
                context.Request.Context.Authentication.SignIn(cookiesIdentity);
            }
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (var property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            // Resource owner password credentials does not provide a client ID.
            if (context.ClientId == null)
            {
                context.Validated();
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientRedirectUri(OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId != _publicClientId) return Task.FromResult<object>(null);
            // fix issue as per mare's answer here: https://stackoverflow.com/questions/20693082/setting-the-redirect-uri-in-asp-net-identity

            var expectedRootUri = new Uri(context.Request.Uri, "/");
            // validate if we're at the root url
            if (expectedRootUri.AbsoluteUri == context.RedirectUri)
            {
                context.Validated();
            }
            else
            {   // validate if we're in a virtual directory
                expectedRootUri = new Uri(context.Request.Uri, MvcApplication.Path + "/");
                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }

        public static AuthenticationProperties CreateProperties(IdentityUser user)
        {
            var roles = string.Join(",", user.Roles.Select(iur => iur.Role.Name));

            return new AuthenticationProperties(new Dictionary<string, string>
                                                {
                                                    { "userName",  user.UserName },
                                                    { "userRoles", roles         }
                                                });
        }
    }
}