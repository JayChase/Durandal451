define(['jquery'],
    function ($) {
        var baseUrl = $('head base').attr('href');

        var accountUrl = baseUrl + "api/Account/";
        // Routes
        window.addExternalLoginUrl = accountUrl + "AddExternalLogin",
        window.changePasswordUrl = accountUrl + "changePassword",
        window.loginUrl = "/Token",
        window.logoutUrl = accountUrl + "Logout",
        window.registerUrl = accountUrl + "Register",
        window.registerExternalUrl = accountUrl + "RegisterExternal",
        window.removeLoginUrl = accountUrl + "RemoveLogin",
        window.setPasswordUrl = accountUrl + "setPassword",
        window.siteUrl = baseUrl,
        window.userInfoUrl = accountUrl + "UserInfo";

        // Route operations
        function externalLoginsUrl(returnUrl, generateState) {
            return accountUrl + "ExternalLogins?returnUrl=" + (encodeURIComponent(returnUrl)) +
                "&generateState=" + (generateState ? "true" : "false");
        }

        function manageInfoUrl(returnUrl, generateState) {
            return accountUrl + "ManageInfo?returnUrl=" + (encodeURIComponent(returnUrl)) +
                "&generateState=" + (generateState ? "true" : "false");
        }

        // Other private operations
        function getSecurityHeaders() {
            var accessToken = sessionStorage["accessToken"] || localStorage["accessToken"];

            if (accessToken) {
                return { "Authorization": "Bearer " + accessToken };
            }

            return {};
        }

        function toErrorString(data) {
            var errors = undefined, items;

            if (!data || !data.message) {
                return null;
            }

            if (data.modelState) {
                for (var key in data.modelState) {
                    items = data.modelState[key];

                    if (items.length) {
                        for (var i = 0; i < items.length; i++) {
                            errors += ", " + items[i];
                        }
                    }
                }
            }

            if (errors === undefined) {
                errors = data.message;
            }

            return errors;
        };

        var securityService = {
            addExternalLogin: addExternalLogin,
            changePassword: changePassword,
            getExternalLogins: getExternalLogins,
            getManageInfo: getManageInfo,
            getUserInfo: getUserInfo,
            login: login,
            logout: logout,
            register: register,
            registerExternal: registerExternal,
            removeLogin: removeLogin,
            setPassword: setPassword,
            returnUrl: siteUrl,
            toErrorString: toErrorString
        };

        $.ajaxPrefilter(function (options, originalOptions, jqXhr) {
            jqXhr.failJSON = function (callback) {
// ReSharper disable once InconsistentNaming
                jqXhr.fail(function (jqXHR, textStatus, error) {
                    var data;

                    try {
                        data = $.parseJSON(jqXHR.responseText);
                    }
                    catch (e) {
                        data = null;
                    }

                    callback(data, textStatus, jqXHR);
                });
            };
        });

        return securityService;
  
        // Data access operations
        function addExternalLogin(data) {
            return $.ajax(window.addExternalLoginUrl, {
                type: "POST",
                data: data,
                headers: getSecurityHeaders()
            });
        }

        function changePassword(data) {
            return $.ajax(changePasswordUrl, {
                type: "POST",
                data: data,
                headers: getSecurityHeaders()
            });
        }

        function getExternalLogins(returnUrl, generateState) {
            return $.ajax(externalLoginsUrl(returnUrl, generateState), {
                cache: false,
                headers: getSecurityHeaders()
            });
        }

        function getManageInfo(returnUrl, generateState) {
            return $.ajax(manageInfoUrl(returnUrl, generateState), {
                cache: false,
                headers: getSecurityHeaders()
            });
        }

        function getUserInfo(accessToken) {
            var headers;

            if (typeof (accessToken) !== "undefined") {
                headers = {
                    "Authorization": "Bearer " + accessToken
                };
            } else {
                headers = getSecurityHeaders();
            }

            return $.ajax(userInfoUrl, {
                cache: false,
                headers: headers
            });
        }

        function login(data) {
            return $.ajax(loginUrl, {
                type: "POST",
                data: data
            });
        }

        function logout() {
            return $.ajax(logoutUrl, {
                type: "POST",
                headers: getSecurityHeaders()
            });
        }

        function register(data) {
            return $.ajax(registerUrl, {
                type: "POST",
                data: data
            });
        }

        function registerExternal(accessToken, data) {
            return $.ajax(registerExternalUrl, {
                type: "POST",
                data: data,
                headers: {
                    "Authorization": "Bearer " + accessToken
                }
            });
        }

        function removeLogin(data) {
            return $.ajax(removeLoginUrl, {
                type: "POST",
                data: data,
                headers: getSecurityHeaders()
            });
        }

        function setPassword(data) {
            return $.ajax(setPasswordUrl, {
                type: "POST",
                data: data,
                headers: getSecurityHeaders()
            });
        }
    });