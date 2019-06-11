cd C:\Users\devon.parsons\work\rp
Import-Module 'C:\Users\devon.parsons\work\posh-git\posh-git\src\posh-git.psd1'
Import-Module 'C:\Users\devon.parsons\Documents\WindowsPowerShell\FormatColor.ps1'
ssh-agent


for($i = 1; $i -le 5; $i++){
  $u =  "".PadLeft($i,"u")
  $unum =  "u$i"
  $d =  $u.Replace("u","../")
  Invoke-Expression "function $u { push-location $d }"
  Invoke-Expression "function $unum { push-location $d }"
}

Set-Alias ll dir

function rm_rf ($location){
  rm $location -r -fo
}

function ep { subl $profile }
function eg { subl .git\config }
function egg { subl $HOME\.gitconfig }
function egh { subl H:\.gitconfig }

function mysql { docker exec -it adc7 mysql -u root -pProduct123 }

function reload { & $profile }

function dps {
  docker ps --format "{{.Names}}\t{{.Ports}}\t{{.ID}}\t{{.Status}}" |
  ConvertFrom-CSV -Delimiter "`t" -Header ("Names","Ports","ID","Status") |
  Sort-Object Names
}

function rc {
  docker exec -it server_rails 1 rails console
}

function gist {
  $Head, $Body = git show --name-status --oneline |
    Format-Color @{
      '[0-9a-f]{6,}' = 'Cyan';
      '^A' = 'Green';
      '^D' = 'Red';
      '^M' = 'Yellow';
      '^R' = 'Gray';
    }

  @($Head, $Body | Sort-Object)
}


function kill_containers { docker kill $(docker ps -q) }

# Path shortcuts

function work { cd C:\Users\devon.parsons\work }
function rp { cd C:\Users\devon.parsons\work\rp }

function uh {
  echo " -- Functions --`n"
  echo "`tdps             - (improved) docker ps"
  echo "`teg              - edit gitconfig"
  echo "`tegg             - edit global gitconfig"
  echo "`tep              - edit powershell profile"
  echo "`tkill_containers - kill all docker containers"
  echo "`treload          - reload powershell profile"
  echo "`trm_rf           - delete folder"

  echo "`n`-- Paths -- `n"
  echo "`trp"
  echo "`twork"
 }

# function ffm {
#   git diff --summary |
#     sls -Pattern "mode change 100755 => 100644" |
#     %{ $_.Line.Substring(30) } |
#     %{ git update-index --assume-unchanged $_ }

# }

if (!(Test-Path alias:which)) { New-Alias which get-command }
if (!(Test-Path alias:edit)) { New-Alias edit subl }
if (!(Test-Path alias:sub)) { New-Alias sub subl }
if (!(Test-Path alias:vi)) { New-Alias vi subl }
