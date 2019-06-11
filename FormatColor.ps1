# @{'pattern1' = 'Color1'[; ...]}

# Colors

# Black
# Blue
# Cyan
# DarkBlue
# DarkCyan
# DarkGray
# DarkGreen
# DarkMagenta
# DarkRed
# DarkYellow
# Gray
# Green
# Magenta
# Red
# White
# Yellow

function Format-Color([hashtable] $Colors = @{}, [switch] $SimpleMatch) {
  $lines = ($input | Out-String) -replace "`r", "" -split "`n"
  foreach($line in $lines) {
    $color = ''
    foreach($pattern in $Colors.Keys){
      if(!$SimpleMatch -and $line -match $pattern) { $color = $Colors[$pattern] }
      elseif ($SimpleMatch -and $line -like $pattern) { $color = $Colors[$pattern] }
    }
    if($color) {
      Write-Host -ForegroundColor $color $line
    } else {
      Write-Host $line
    }
  }
}
