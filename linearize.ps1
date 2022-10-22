# linearizes all xml files in a folder
# removes all extra whitespace (double spaces, tabs, returns?)

$count = 0
$folder = 'C:\Users\Chris\Git\test'

$children = Get-ChildItem -path $folder

ForEach ($child in $children) {
  $singlepath = $folder + '\' + $child
  $content = Get-Content -path $singlepath
  $mid = $content -join ''
  $final = $mid -replace '\s+', ' '
  $new = $folder + '\fixed' + $count + '.xml'
  Set-Content -path $new -value $final
  $count++
}