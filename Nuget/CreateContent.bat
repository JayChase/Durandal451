SET sourceDir=Durandal451


::copy source files

xcopy /Y ..\%sourceDir%\app\viewmodels\login.js content\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\register.js content\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\registerExternal.js content\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\manage.js content\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\start.js content\app\viewmodels\
xcopy /Y ..\%sourceDir%\app\viewmodels\welcome.js content\app\viewmodels\

xcopy /Y ..\%sourceDir%\app\views\login.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\manage.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\register.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\registerExternal.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\shell.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\start.html content\app\views\
xcopy /Y ..\%sourceDir%\app\views\welcome.html content\app\views\

xcopy /Y ..\%sourceDir%\App_Start\Startup.Auth.cs "content\App_Start\Startup.Auth.cs.pp"
xcopy /Y ..\%sourceDir%\App_Start\WebApiConfig.cs "content\App_Start\WebApiConfig.cs.pp"

xcopy /Y ..\%sourceDir%\Controllers\AccountController.cs "content\Controllers\AccountController.cs.pp"

xcopy /Y ..\%sourceDir%\Models\AccountBindingModels.cs "content\Models\AccountBindingModels.cs.pp"
xcopy /Y ..\%sourceDir%\Models\AccountViewModels.cs "content\Models\AccountViewModels.cs.pp"

xcopy /Y ..\%sourceDir%\Providers\ApplicationOAuthProvider.cs "content\Providers\ApplicationOAuthProvider.cs.pp"

xcopy /Y ..\%sourceDir%\Results\ChallengeResult.cs "content\Results\ChallengeResult.cs.pp"

xcopy /Y ..\%sourceDir%\Startup.cs "content\Startup.cs.pp"

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& 'C:\Users\Jon\Documents\USS Work\Durandal451\Nuget\transformations.ps1'"
