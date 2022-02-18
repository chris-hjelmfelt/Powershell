# Modified from jrv's answer on https://social.technet.microsoft.com/Forums/windowsserver/en-US/e1c1f26b-6f9d-45ae-bb8c-5f4d4e38058a/powershell-script-to-read-metadata-info-from-pictures

  Function Get-FileMetaData {
	Param (
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline=$true
		)][string]$FolderPath
	)
	
	begin{
		$shell = New-Object -ComObject Shell.Application
	}
	
	Process {
		$FolderPath
		$folder = $shell.namespace($FolderPath)
		$index={}
		for ($i = 0; $i -lt 256; $i++) {
			if ($tag = $folder.GetDetailsOf('.', $i)) {
        $detail = "[" + $i + "] = " + $tag
				Write-Host $detail -fore green
			}
		}		
	}
}

$picdata = Get-FileMetaData -Folder 'C:\Users\Chris\Git\test' 



