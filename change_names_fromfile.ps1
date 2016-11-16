# change_names_fromfile
# By Chris Hjelmfelt
# Powershell script which changes a filenames in a folder to the names found in a textfile
#
# Usage: Give the path to the script, the path to the folder containing the files you wish to change 
# the path to the new names file name, and the file extension of the files to change
# Caution: this changes all filenames in order to what you give, make sure there aren't extra files
# in your folder
# filenames must be listed one to a line without file extensions
# C:\Users\chjelmfe\Documents\Dust_Slides\change_fromfile.ps1  "C:\Users\chjelmfe\Documents\hello\" "C:\Users\chjelmfe\Documents\names.txt" txt
# ---------------------------------------------------------------------------------------------

Param ( 
	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $folderpath,

	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $newnames,

	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $ftype
	)

# Reading stings from text file 
$inputdata = Get-Content $newnames

$ftype = "*" + $ftype

# Count number of files
$filenum = (get-ChildItem -Path $folderpath -Filter $ftype).count 

# Get the list of files
$filelist = get-ChildItem -Path $folderpath -Filter $ftype

# If files are found, change the names
if(!($filelist))
{
write "No files of that type found"
}else{
$i=0
while ($i -lt $filenum )
{ 
	$newfilename = $inputdata[$i] 
	$stringname = $filelist[$i].ToString()
	$oldfilename = $stringname.substring(0, $stringname.LastIndexOf(".")) 
	$filelist[$i] | Rename-Item -NewName {$_.name -replace $oldfilename, $newfilename }  #-whatif 
	$i = $i + 1
}
}

# use Write-Host to print a variable
# use .GetType() to see what a variable type is
