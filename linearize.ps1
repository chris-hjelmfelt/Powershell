# linearizes all files in a folder
# removes all extra whitespace (double spaces, tabs, returns?)
#
# Usage: 
# Set your file path for folder your files are in
# Set the file type (txt, xml, etc) 
# Then run the following at a windows command prompt  (switch Chris for your user name):  
# Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Chris\Git\powershell\linearize.ps1" 

$count = 0
$folder = 'C:\Users\Legion6\Git\test'
$filetype = '.txt'

$children = Get-ChildItem -path $folder

ForEach ($child in $children) {
  $singlepath = $folder + '\' + $child
  $content = Get-Content -path $singlepath
  $mid = $content -join ' '
  $final = $mid -replace '\s+', ' '
  $new = $folder + '\fixed' + $count + $filetype
  Set-Content -path $new -value $final
  $count++
}