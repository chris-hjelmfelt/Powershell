
Write-Host "Starting MouseMove"
$MYJOB = Start-Job -ScriptBlock {  
  Add-Type -AssemblyName System.Windows.Forms

  # mouse movement
  # $MOVEMENTSIZE = 100
  # $SLEEPTIME = 1
  # $POSITION = [Windows.Forms.Cursor]::Position
  # $POSITION.x += $MOVEMENTSIZE
  # $POSITION.y += $MOVEMENTSIZE
  # [Windows.Forms.Cursor]::Position = $POSITION
  # Start-Sleep -Seconds $SLEEPTIME
  # $POSITION = [Windows.Forms.Cursor]::Position
  # $POSITION.x -= $MOVEMENTSIZE
  # $POSITION.y -= $MOVEMENTSIZE
  # [Windows.Forms.Cursor]::Position = $POSITION
  # Start-Sleep -Seconds $SLEEPTIME

  # Make application active
  [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic") 
  # [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process -Name notepad).MainWindowTitle)
  [Microsoft.VisualBasic.Interaction]::AppActivate(11204) # find the App Id in Task Manager process details
 
  # import mouse_event & left click
  Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;
  [W.U32]::mouse_event(6,0,0,0,0);
}
