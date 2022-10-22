# read a CSV file, sort items a-z, then print to another file
 

$filepathIn = "C:\Users\Legion4\Desktop\WordList.txt"
$filepathOut = "C:\Users\Legion4\Desktop\WordList-Sorted.txt"
$words = (Get-Content $filepathIn)  -replace '\w+', '"$&"' 
$words = $words -replace '\s', ''


