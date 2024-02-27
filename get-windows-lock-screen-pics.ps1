# get-windows-lock-screen-pics
# By Chris Hjelmfelt
#
# Gets current Windows lock screen pictures and saves them 
#
# Usage: 
# First you need to set up a folder you want them to be saved to and put the path into $finishedImageFolder   
# Then change the user from "Legion4" to your user everywhere that a path is required. Including the run command below   
# Then run the following at a windows command prompt:  
# Powershell.exe -executionpolicy remotesigned -File  "C:\Users\Legion5\Git\powershell\get-windows-lock-screen-pics.ps1"  
# 
# You could also set this script up to run automatically on a schedule
# ---------------------------------------------------------------------------------------------


$windowsImagefolder = "C:\Users\Legion5\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$finishedImageFolder = "C:\Users\Legion5\Pictures\Misc\Windows Lock Screen"
$tempfolder = $finishedImageFolder + "\temp"
$shellApp = New-Object -ComObject Shell.Application
$folderNamespaceWin = $shellApp.Namespace($windowsImagefolder)
$folderNamespaceFinished = $shellApp.Namespace($finishedImageFolder)
$folderNamespaceTemp = $shellApp.Namespace($tempfolder)
$count = 100000


Get-ChildItem -Path "$windowsImagefolder"  -File |
  ForEach-Object {
    $image = $folderNamespaceWin.ParseName($_.Name)
    $oldpath = 'C:\Users\Legion5\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\' + $image.Name  
    $temppath = $tempfolder + '\' + $count + '.jpg'

    # Select the correct Size
    if ($image.Size -gt 500KB) {  
      # copy the image to a temp folder in my pictures
      Copy-Item $oldpath $temppath 
      $count++    
    }
  }

$nameNum = '55555555'
function getHighest($myfolder) {
  $highest = 1
  [array]$allImages = Get-ChildItem -Path $myfolder -Include '*.jpg' -Name
  foreach ($item in $allImages) {
    $nameNum = $item.TrimStart("WLS ")
    $nameNum = $nameNum.TrimEnd(".jpg")/1   # divide by 1 to convert to int
    if ($nameNum -gt $highest) {
      $highest = $nameNum
    }
  }
  return $highest
}

$highestNumber = getHighest("$finishedImageFolder")
# Write-Host $highestNumber -ForegroundColor Blue  
$newName = $highestNumber + 1   # new pictures have names incremented from highest existing pic

Get-ChildItem -Path "$tempfolder\*"  -Include '*.jpg' -File |
  ForEach-Object {
    $image = $folderNamespaceTemp.ParseName($_.Name)
    $oldpath = $tempfolder + '\' + $image.Name + '.jpg' 

    # Select only landscape
    if($folderNamespaceTemp.GetDetailsOf($image, 31) -match '(?<width>\d+) x (?<height>\d+)') {      
      if ([int]$Matches.height -lt [int]$Matches.width) {
        # Copy the items over to the folder in Pictures        
        $newpath = $finishedImageFolder + '\WLS ' + $newName + '.jpg'
        Copy-Item $oldpath $newpath 
        $newName++ 
      }      
    }    
    # Remove the temp versions
    Remove-Item $oldpath 
  }    