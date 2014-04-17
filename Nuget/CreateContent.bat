SET sourceDir=Durandal451
SET destinationDir=package\content

::Clear any existing files 
RMDIR %destinationDir% /S /Q

::copy source files

xcopy /Y ..\%sourceDir%\app\main.js %destinationDir%\app\

xcopy /Y ..\%sourceDir%\app\global\session.js %destinationDir%\app\global\

xcopy /Y ..\%sourceDir%\app\services\logger.js %destinationDir%\app\services\
xcopy /Y ..\%sourceDir%\app\services\security.js %destinationDir%\app\services\

xcopy /Y ..\%sourceDir%\app\viewmodels\login.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\register.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\registerExternal.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\manage.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\shell.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\start.js %destinationDir%\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\welcome.js %destinationDir%\app\viewmodels\

xcopy /Y ..\%sourceDir%\app\views\login.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\manage.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\register.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\registerExternal.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\shell.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\start.html %destinationDir%\app\views\
xcopy /Y ..\%sourceDir%\app\views\welcome.html %destinationDir%\app\views\

xcopy /Y ..\%sourceDir%\Scripts\jquery.utilities.js %destinationDir%\Scripts\

echo F | xcopy /Y ..\%sourceDir%\App_Start\DurandalBundleConfig.cs "%destinationDir%\App_Start\DurandalBundleConfig.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\App_Start\Startup.Auth.cs "%destinationDir%\App_Start\Startup.Auth.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\App_Start\WebApiConfig.cs "%destinationDir%\App_Start\WebApiConfig.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\App_Start\RouteConfig.cs "%destinationDir%\App_Start\RouteConfig.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Controllers\AccountController.cs "%destinationDir%\Controllers\AccountController.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Models\AccountBindingModels.cs "%destinationDir%\Models\AccountBindingModels.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Models\AccountViewModels.cs "%destinationDir%\Models\AccountViewModels.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Models\IdentityDbInitializer.cs "%destinationDir%\Models\IdentityDbInitializer.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Providers\ApplicationOAuthProvider.cs "%destinationDir%\Providers\ApplicationOAuthProvider.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Results\ChallengeResult.cs "%destinationDir%\Results\ChallengeResult.cs.pp"

xcopy /Y ..\%sourceDir%\Views\Durandal\Index.cshtml %destinationDir%\Views\Durandal\

echo F | xcopy /Y ..\%sourceDir%\Startup.cs "%destinationDir%\Startup.cs.pp"

echo F | xcopy /Y ..\readme.md "%destinationDir%\Durandal.Authenticion.Readme.md"

::sort out the namespace in cs files

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\Jon\Documents\USS Work\Durandal451\Nuget\transformations.ps1'"

::create the nuget package
nuget pack package\Durandal.Authentication.nuspec