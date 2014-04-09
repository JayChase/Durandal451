$Files = Get-ChildItem ".\package\content\*.pp" -recurse -force
Foreach ($File in $Files)
	{
		(get-content $File) | foreach-object {$_ -replace "Durandal451", '$rootnamespace$'} | set-content $File
  }