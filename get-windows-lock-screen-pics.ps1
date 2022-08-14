# Picks out the large lockscreen images, filters only the landscape ones, and places them in a directory in Pictures
# Still needs to rename them correctly, and then be automated to run by itself


$windowsImagefolder = "C:\Users\Legion4\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$finishedImageFolder = "C:\Users\Legion4\Pictures\Misc\Windows Lock Screen"
$tempfolder = $finishedImageFolder + "\temp"
$shellApp = New-Object -ComObject Shell.Application
$folderNamespace = $shellApp.Namespace($windowsImagefolder)
$count = 100000

Get-ChildItem -Path "$windowsImagefolder"  -File |
  ForEach-Object {
    $image = $folderNamespace.ParseName($_.Name)
    $oldpath = 'C:\Users\Legion4\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\' + $image.Name  
    $temppath = $tempfolder + '\' + $count + '.jpg'

    # Select the correct Size
    if ($image.Size -gt 500KB) {  
      # copy the image to a temp folder in my pictures
      Copy-Item $oldpath $temppath 
      $count++    
    }
  }


$folderNamespace = $shellApp.Namespace($tempfolder)
Get-ChildItem -Path "$tempfolder\*"  -Include '*.jpg','*.png' -File |
  ForEach-Object {
    $image = $folderNamespace.ParseName($_.Name)
    $oldpath = $tempfolder + '\' + $image.Name + '.jpg' 
    $newpath = $finishedImageFolder + '\' + $image.Name + '.jpg'

    # Select only landscape
    if($folderNamespace.GetDetailsOf($image, 31) -match '(?<width>\d+) x (?<height>\d+)') {      
      if ([int]$Matches.height -lt [int]$Matches.width) {
        # Copy the items over to the folder in Pictures
        Copy-Item $oldpath $newpath  
      }      
    }    
    # Remove the temp versions
    Remove-Item $oldpath
  }    