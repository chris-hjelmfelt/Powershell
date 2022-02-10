# The plan is to pickout the large lockscreen images, filter only the landscape ones, and place them in a directory in Pictures

$folder = "C:\Users\Chris\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$shellApp = New-Object -ComObject Shell.Application
$folderNamespace = $shellApp.Namespace($folder)
$count = 1000

Get-ChildItem -Path "$folder"  |
  ForEach-Object {
    $image = $folderNamespace.ParseName($_.Name)

    # Select the correct Size
    if ($image.Size -gt 1000KB) {
      # [PsCustomObject]@{
      #         Image      = $_.Name
      #         #Size       = $_.Size
      #         Length     = $_.Length
      #         #Width      = $Matches.Width
      #         #Height     = $Matches.Height
      #         #IsLandscape = $([int]$Matches.Height -lt [int]$Matches.Width)
      # }
      #Write-Host $image.Size -fore blue

      # Copy the items over to the folder in Pictures
      $oldpath = 'C:\Users\Chris\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\' + $image.Name
      $newpath = 'C:\Users\Chris\Pictures\Windows Lock Screen\' + $count + '.jpg'
      Copy-Item $oldpath $newpath        
      $count++
    }
  }

<#
$file = 'C:\Users\Chris\Documents\Affirmations.rtf'
Write-Host((Get-Item $file).length)
Write-Host((Get-Item $file).length/1KB)
Write-Host((Get-Item $file).length/1MB)

Get-ChildItem $folder -recurse | Select-Object Name, @{Name="MegaBytes";Expression={"{0:F2}" -f ($_.length/1MB)}}
#>