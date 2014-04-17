param($installPath, $toolsPath, $package, $project)

$path = [System.IO.Path]
$readmefile = $path::Combine($path::GetDirectoryName($project.FileName), "Durandal.Authenticion.Readme.md")
$DTE.ItemOperations.OpenFile($readmefile)