#Durandal 451

Durandal 2.0.1 running with ASP.NET 4.5.1 using OWIN security to provide:

* site based and 3rd party user authentication,
* local SPA authorization and customization based on role membership.

For more information please see the series of blog posts on this project [here](http://netdevplus.wordpress.com/?s=Durandal+4.5.1).

#Getting started

During the database initialization two roles are created:

* Administrators
* RegisteredUsers

A user called **Administrator** is also created with the password '**Administrator451**' and added to both roles. Edit IdentityDbInitializer if you need to change this, or add more roles and users.

To configure route based authorization add a property  **requiredRoles** to each route that needs to be checked when setting up the route map.

```javascript
{ route: 'start', moduleId: 'viewmodels/start', nav: true, requiredRoles: ['RegisteredUsers'] },
{ route: 'siteAdmin', moduleId: 'viewmodels/start', nav: true, requiredRoles: ['Administrators','PowerUsers'] }
```

To render areas of a view based on the role membership use the **ifIsInRole** custom KO binding.

```html
<div data-bind="ifIsInRole: 'Admnistrators' ">
    <h2>Admin</h2>
    <p>This is an admin section which will only be visible if the current user is in the 'Admnistrators' role.</p>
</div>
```

#References

This project is based on the following packages and components:

* [ASP.NET Single Page Application template](http://www.asp.net/single-page-application)
* [Durandal StarterKit With Bootstrap 3](https://www.nuget.org/packages/ProvenStyle.Durandal.StarterKit/0.0.10)
