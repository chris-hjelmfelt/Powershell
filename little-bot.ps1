# Application to bot must be open and not minimized
# Run Powershell as administrator
# Move powershell out of the way so before you run the following 
# command you can place your mouse where you want it on the other app
# > .\little-bot.ps1
# This was continued is a separate git repo

Write-Host "Starting MouseMove"
$MYJOB = Start-Job -ScriptBlock {  
  #inport forms commands
  Add-Type -AssemblyName System.Windows.Forms
  # import mouse_event
  Add-Type -MemberDefinition '[DllImport("user32.dll")] public static extern void mouse_event(int flags, int dx, int dy, int cButtons, int info);' -Name U32 -Namespace W;

  
  # Make application active
  [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic") 
  # [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process -Name notepad).MainWindowTitle)
  [Microsoft.VisualBasic.Interaction]::AppActivate(11204) # find the App Id in Task Manager process details

  # Get current mouse position and print to file
  # $X = [System.Windows.Forms.Cursor]::Position.X  #762
  # $Y = [System.Windows.Forms.Cursor]::Position.Y  #412
  # $RESULT = "X: $X, Y: $Y"
  # Out-File -FilePath C:\Users\Legion4\Git\powershell\printout.txt -InputObject $RESULT

  # mouse click
  [W.U32]::mouse_event(6,0,0,0,0);

  # wait
  Start-Sleep -Seconds 5  

  # mouse movement
  $POSITION = [Windows.Forms.Cursor]::Position
  $POSITION.x = 762 - 100
  $POSITION.y = 412 - 10
  [Windows.Forms.Cursor]::Position = $POSITION
   
  # mouse click
  [W.U32]::mouse_event(6,0,0,0,0);
  
  #wait
  Start-Sleep -Seconds 30

  # mouse movement
  $POSITION.x += $MOVEMENTSIZE + 90
  $POSITION.y += 5
  [Windows.Forms.Cursor]::Position = $POSITION

  # mouse click
  [W.U32]::mouse_event(6,0,0,0,0);

}
