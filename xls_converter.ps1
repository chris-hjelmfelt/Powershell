# .xls to .xlsx converter
# By Chris Hjelmfelt
# Powershell script based on ConvertXLS.ps1 by gabceb at https://gist.github.com/gabceb/954418
# Usage: takes the name of a folder in the same directory as the script that contains 
# any number of files and folders. It will search through them, change every .xls file to an 
# .xlsx then move the old .xls file into a separate folder named old 
# (In case Excel has a glitch or something else in the process fails you have the old files to try again)
# example:
# C:\Users\chjelmfe\Documents\Dust_Slides\xls_converter.ps1  "09-15-16 Photomultiplier"
# ----------------------------------------------------------------------------------------------

Param ( 
	[parameter(Mandatory=$true)]  
	[ValidateNotNull()]
        $folder
         )
Add-Type -AssemblyName Microsoft.Office.Interop.Excel
$xlFixedFormat = [Microsoft.Office.Interop.Excel.XlFileFormat]::xlOpenXMLWorkbook

$excel = New-Object -ComObject excel.application
$excel.visible = $true

$path = split-path $SCRIPT:MyInvocation.MyCommand.Path -parent
$folderpath = $path + "\" + $folder
write $folderpath
$filetype ="*xls"

Get-ChildItem -Path $folderpath -Include $filetype -recurse | 
ForEach-Object `
{
	$path = ($_.fullname).substring(0, ($_.FullName).lastindexOf("."))		
	$workbook = $excel.workbooks.open($_.fullname)

	$path += ".xlsx"
	$workbook.saveas($path, $xlFixedFormat)
	$workbook.close()

	$oldFolder = $path.substring(0, $path.lastIndexOf("\")) + "\old"
	$currentfolder = Split-Path (Split-Path $path -Parent) -Leaf   

	#write $oldFolder
	if(-not (test-path $oldFolder))
	{
		"Folder:  $currentfolder "
		new-item $oldFolder -type directory | Out-Null
	}
	
	move-item $_.fullname $oldFolder
	"Converted  $path"	
}

$excel.Quit()
$excel = $null
[gc]::collect()
[gc]::WaitForPendingFinalizers()

# print to screen: variables can use the write command, strings and combos need parenthsis
# examples: 
# "Hello World"
# write $path
# "You are here: $path"

# Find path to script: split-path $SCRIPT:MyInvocation.MyCommand.Path -parent