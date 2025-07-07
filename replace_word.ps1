# Powershell replace_word
# By Chris Hjelmfelt
#
# Does a find / replace in a given file
#
# Usage: 
# Powershell.exe -executionpolicy remotesigned -File "C:\Users\Legion6\Git\powershell\replace_word.ps1"
#
# -------------------------------------------------------------------------------------------------------

$files = Get-ChildItem "C:\Users\Legion6\Desktop\Grids"
foreach ($f in $files){
    $outfile = "C:\Users\Legion6\Desktop\Renamed\" + $f.Name
    Get-Content $f.FullName | 
    ForEach-Object {$_ -replace "brownrock", "Brown Rock "} |
    ForEach-Object {$_ -replace "greyrock", "grey rock "} |
    ForEach-Object {$_ -replace "purplerock", "purple rock "} |
    ForEach-Object {$_ -replace "waterrock", "wet rock "} |
    ForEach-Object {$_ -replace "wetrock", "wet rock "} |
    Set-Content $outfile
}
