
Write-Host "Starting MouseMove"
$MYJOB = Start-Job -ScriptBlock {
  $MOVEMENTSIZE = 100
  $SLEEPTIME = 2
  $RUNCOUNTER = 0
  Add-Type -AssemblyName System.Windows.Forms
  while ($RUNCOUNTER -lt 5) {
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
}
