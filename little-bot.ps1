
Write-Host "Starting MouseMove"
$MYJOB = Start-Job -ScriptBlock {
  $MOVEMENTSIZE = 100
  $SLEEPTIME = 1
  $RUNCOUNTER = 0  
  Add-Type -AssemblyName System.Windows.Forms
  while ($RUNCOUNTER -lt 2) {
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x += $MOVEMENTSIZE
    $POSITION.y += $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    Start-Sleep -Seconds $SLEEPTIME
    $POSITION = [Windows.Forms.Cursor]::Position
    $POSITION.x -= $MOVEMENTSIZE
    $POSITION.y -= $MOVEMENTSIZE
    [Windows.Forms.Cursor]::Position = $POSITION
    Start-Sleep -Seconds $SLEEPTIME
    $RUNCOUNTER += 1
  }   

  [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic") 
  [Microsoft.VisualBasic.Interaction]::AppActivate((Get-Process -Name notepad).MainWindowTitle)
  [Windows.Forms.SendKeys]::SendWait("{X}")
  [Windows.Forms.SendKeys]::SendWait("{ENTER}")
}
