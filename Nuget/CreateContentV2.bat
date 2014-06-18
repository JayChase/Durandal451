SET sourceDir=Durandal451v2
SET destinationDir=package2\content

::Clear any existing files 
RMDIR %destinationDir% /S /Q

::clear any existing packages from this folder
DEL Durandal.Authentication.*.nupkg /F /Q

::copy source files
echo F | xcopy /Y ..\%sourceDir%\Web.config.install.xdt %destinationDir%\Web.config.install.xdt

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
xcopy /Y ..\%sourceDir%\Scripts\knockout.validation.js %destinationDir%\Scripts\

echo F | xcopy /Y ..\%sourceDir%\App_Start\DurandalBundleConfig.cs "%destinationDir%\App_Start\DurandalBundleConfig.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\App_Start\WebApiConfig.cs "%destinationDir%\App_Start\WebApiConfig.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\App_Start\RouteConfig.cs "%destinationDir%\App_Start\RouteConfig.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Controllers\AccountController.cs "%destinationDir%\Controllers\AccountController.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Controllers\DurandalController.cs "%destinationDir%\Controllers\DurandalController.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Filters\RequireHttpsAttribute.cs "%destinationDir%\Filters\RequireHttpsAttribute.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Models\AccountBindingModels.cs "%destinationDir%\Models\AccountBindingModels.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Models\AccountViewModels.cs "%destinationDir%\Models\AccountViewModels.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Models\ApplicationDbInitializer.cs "%destinationDir%\Models\ApplicationDbInitializer.cs.pp"
echo F | xcopy /Y ..\%sourceDir%\Models\IdentityModels.cs "%destinationDir%\Models\IdentityModels.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Providers\ApplicationOAuthProvider.cs "%destinationDir%\Providers\ApplicationOAuthProvider.cs.pp"

echo F | xcopy /Y ..\%sourceDir%\Results\ChallengeResult.cs "%destinationDir%\Results\ChallengeResult.cs.pp"

xcopy /Y ..\%sourceDir%\Views\Durandal\Index.cshtml %destinationDir%\Views\Durandal\

echo F | xcopy /Y ..\%sourceDir%\Startup.cs "%destinationDir%\Startup.cs.pp"

echo F | xcopy /Y ..\readme.md "%destinationDir%\Durandal.Authenticion.Readme.md"

::sort out the namespace in cs files

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\Jon\Documents\USS Work\AwesomeWeb\Durandal451\Nuget\transformationsV2.ps1'"

::create the nuget package
nuget pack package2\Durandal.Authentication.v2.nuspec

DEL CC:\Users\Jon\Documents\USS Work\AwesomeWeb\Durandal451\Nuget\Durandal.Authentication.*.nupkg /F /Q

echo F | xcopy /Y Durandal.Authentication.*.nupkg "C:\Users\Jon\Documents\USS Work\LocalNuget\Durandal.Authentication.*.nupkg"