# The plan is to pickout the landscape lockscreen images and place them in a directory in Pictures

$folder = "C:\Users\Chris\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"

$shellApp = New-Object -ComObject Shell.Application
$folderNamespace = $shellApp.Namespace($folder)
Get-ChildItem -Path "$folder"  |
    ForEach-Object {
        $image = $folderNamespace.ParseName($_.Name)
        $size = $image | Measure-Object -Property Length
        if($folderNamespace.GetDetailsOf($image, 1) -lt 100KB) {
            [PsCustomObject]@{
                    Image      = $_.Name
                    Size       = $_.Size
                    Length     = $_.Length
                    Width      = $_.Width
                    #Height     = $Matches.Height
                    #IsLandscape = $([int]$Matches.Height -lt [int]$Matches.Width)
            }
        }
    }
