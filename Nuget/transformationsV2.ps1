$Files = Get-ChildItem ".\package2\content\*.pp" -recurse -force
Foreach ($File in $Files)
	{
		(get-content $File) | foreach-object {$_ -replace "Durandal451v2", '$rootnamespace$' -replace "\[RequireHttps\]", ''} | set-content $File	
  }