# -----------------------------------------------------------------
# This space is for pieces of code that are totally not working yet
# -----------------------------------------------------------------


# Trying to figure out how to use the [System.Drawing] Assembly

<#
# Define Assembly path
[string]$assemblyPath = 'C:\Assemblies\System.Drawing.dll'

# Add assembly DLL
Add-Type -Path $assemblyPath

# using namespace System.Drawing.Common
# Add-Type -AssemblyName System.Drawing.Common # Specify System.Drawing.Common on PS Core
$imgloc = 'C:\Users\Chris\Pictures\Windows Lock Screen\'   #'# dummy comment to restore syntax highlighting in SO

# the various System.Photo.Orientation values
# See: https://docs.microsoft.com/en-us/windows/win32/properties/props-system-photo-orientation
#      https://docs.microsoft.com/en-gb/windows/win32/gdiplus/-gdiplus-constant-property-item-descriptions#propertytagorientation
$orientation = 'Unknown', 'Normal', 'FlipHorizontal', 'Rotate180', 'FlipVertical', 'Transpose', 'Rotate270', 'Transverse', 'Rotate90'

Get-ChildItem -Path $imgloc -Filter '*.jpg' | ForEach-Object {
    $img = [System.Drawing.Image]::Fromfile($_.FullName)
    # return the properties
    $value = $img.GetPropertyItem(274).Value[0]
    [PsCustomObject]@{
        'Path'        = $_.FullName
        'Width'       = $img.Size.width
        'Height'      = $img.Size.Height
        'Orientation' = $orientation[$value]
    }
}
#>

### Regex Examples
<#
Read from the requested file, put double quotes around each item between commas
ex: one, two, three -->  "one, "two", "three"
$words = (Get-Content $filepathIn)  -replace '\w+', '"$&"' 

Remove the space after the comma
$words = $words -replace '\s', ''
#>

### Sorting 
<#
https://www.educba.com/powershell-sort-object/
this works:
$students = "Ranjan","Ajay","Vijay","Sujit","Ajeet","Akash","Vikash"
$students | Sort-Object
this doesn't:
$filepathTest = Get-Content "C:\Users\Legion4\Desktop\TestWords.txt"
$filepathTest | Sort-Object
but this does, because reading the file created one object, but split turns it back into separate objects:
$filepathTest -split "," | Sort-Object
#>

<#
Function Get-Image{
    begin{        
         [void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") |Out-Null 
    } 
     process{
          $fi=[System.IO.FileInfo]$_           
          if( $fi.Exists){
               $img = [System.Drawing.Image]::FromFile($_)
               $img.Clone()
               $img.Dispose()       
          }else{
               Write-Host "File not found: $_" -fore yellow       
          }   
     }    
    end{}
}
dir "C:\Chris\Git\test\*.jpg" | Get-Image |select width, Height
$images =  dir "C:\Chris\Git\test\*.jpg" | Get-Image
$images[0].HorizontalResolution
$images| ft Height, Width -auto
#>


# --------------------------
# Leftovers
# --------------------------

$targetFolder = "C:\Users\Chris\Git\test"
$shellApp = New-Object -ComObject 'shell.application'
$folderNamespace = $shellApp.Namespace($targetFolder)

Get-ChildItem -Path "$targetFolder\*" -Include '*.jpg','*.png' -File |
    ForEach-Object {
        $image = $folderNamespace.ParseName($_.Name)
        if($folderNamespace.GetDetailsOf($image, 31) -match '(?<width>\d+) x (?<height>\d+)') {
            [PsCustomObject]@{
                    Image      = $_.FullName
                    Width      = $Matches.width
                    Height     = $Matches.height
                    IsPortrait = $([int]$Matches.height -gt [int]$Matches.width)
            }
        }
    }


<#
$file = 'C:\Users\Chris\Documents\Affirmations.rtf'
Write-Host((Get-Item $file).length)
Write-Host((Get-Item $file).length/1KB)
Write-Host((Get-Item $file).length/1MB)

Get-ChildItem $folder -recurse | Select-Object Name, @{Name="MegaBytes";Expression={"{0:F2}" -f ($_.length/1MB)}}
#>