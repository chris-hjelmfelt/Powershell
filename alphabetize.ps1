# read a CSV file, sort items a-z, then print to another file
#
# Usage: 
# Set your file path for the input and output files 
# Then run the following at a windows command prompt  (switch Legion4 for your user name):  
# Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Legion4\Git\powershell\alphabetize.ps1"  

$filepathIn = "C:\Users\Legion4\Desktop\WordList.txt"
$filepathOut = "C:\Users\Legion4\Desktop\WordList-Sorted.txt"
$words = (Get-Content $filepathIn)  -replace '\s', ''
$words = $words -split "," | Sort-Object -Unique 
$result = $words -join ', ' | Out-File $filepathOut  

