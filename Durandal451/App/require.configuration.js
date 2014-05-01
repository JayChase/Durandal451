(function () {
    var siteBase = document.getElementById('base').href;
    var appBaseUrl = siteBase + 'App';
    var scriptBase = siteBase + 'Scripts/';
   
    window.require = {
        baseUrl: appBaseUrl,
        paths: {
            'text':     scriptBase + 'text',
            'durandal': scriptBase + 'durandal',
            'plugins': scriptBase + 'durandal/plugins',
            'transitions': scriptBase + 'durandal/transitions',
            'knockout': scriptBase + 'knockout-2.3.0',
            'knockout.validation': scriptBase + 'knockout.validation',
            'bootstrap': scriptBase + 'bootstrap',
            'jquery': scriptBase + 'jquery-1.10.2',
            'jquery.utilities': scriptBase + 'jquery.utilities',
            'toastr': scriptBase + 'toastr'
        },
        shim: {
            'bootstrap': {
                deps: ['jquery'],
                exports: 'jQuery'
            },
            'knockout.validation': {
                deps: ['knockout']
            },
            'jquery.utilities': {
                dep: ['jquery']
            }
        },
    }
})();