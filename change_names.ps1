# change_name
# By Chris Hjelmfelt
# Powershell script based on a blog post by The Scripting Guys at
# https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/22/use-powershell-to-rename-files-in-bulk/
# Finds files with a certain string in their name and changes that string to a new one
#
# Usage: Give the path to the script, the path to the folder containing the files you wish to change, 
# the string to find, and the string to change it to
# example:
# C:\Users\chjelmfe\Documents\Dust_Slides\change_name.ps1  "C:\Users\chjelmfe\Documents\hello\" new prev
# ---------------------------------------------------------------------------------------------

Param ( 
	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $folderpath,

	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $oldpiece,

	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $newpiece
	)

Get-ChildItem -Path $folderpath -Filter "*$oldpiece*" -Recurse | 
Rename-Item -NewName {$_.name -replace $oldpiece,$newpiece }  # -whatif

# whatif allows you to test your code, it will print what would happen if this code ran but not actually 
#make the changes

# Unfortunately, when we use –WhatIf, we cannot send our output to a text log file. If you need a log 
# file that shows the results of using -WhatIf, you can follow these steps:
#    Open Windows PowerShell.
#    Run Start-Transcript.
#    Run your command (including the -WhatIf parameter).
#    After the command completes, run Stop-Transcript.
#    Note the location and file name of the transcript file, and open this file to see the results.



