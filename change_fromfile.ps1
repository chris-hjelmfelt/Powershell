# change_fromfile
# By Chris Hjelmfelt
# Powershell script which changes a filenames in a folder to the names found in a textfile
#
# Usage: Give the path to the script, the path to the folder containing the files you wish to change 
# and the path to the new names file name
# filenames must be listed one to a line without file extensions
# C:\Users\chjelmfe\Documents\Dust_Slides\change_fromfile.ps1  "C:\Users\chjelmfe\Documents\hello\" "C:\Users\chjelmfe\Documents\names.txt"
# ---------------------------------------------------------------------------------------------

Param ( 
	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $folderpath,

	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $names
	)

$newnames = $names

# Reading stings from text file 
$inputdata = Get-Content $newnames

# Count number of files
$filenum = (Get-ChildItem -Path $folderpath -Recurse).count 

# Get the list of files
$filelist = get-ChildItem -Path $folderpath  #-Recurse  

# Change the names
$i=0
while ($i -lt $filenum )
{ 
	$newfilename = $inputdata[$i] + ".xlsx"
	$filelist[$i] | Rename-Item -NewName {$_.name -replace $filelist[$i], $newfilename }  # -whatif 
	$i = $i + 1
}



