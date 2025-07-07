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
    ForEach-Object {$_ -replace "small brown rocks/brownrock", "brown rocks/Brown Rock "} |
    ForEach-Object {$_ -replace "grey rocks/greyrock", "grey rocks/grey rock "} |
    ForEach-Object {$_ -replace "purple rocks/purplerock", "purple rocks/purple rock "} |
    ForEach-Object {$_ -replace "wet rocks/waterrock", "wet rocks/wet rock "} |
    ForEach-Object {$_ -replace "wet rocks/wetrock", "wet rocks/wet rock "} |
    Set-Content $outfile
}
