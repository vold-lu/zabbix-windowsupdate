$Searcher = new-object -com "Microsoft.Update.Searcher"
$Updates = $Searcher.Search("IsAssigned=1 and IsInstalled=0").Updates

$Criticals = $Updates | where {$_.MsrcSeverity -eq "Critical"}
$Importants = $Updates | where {$_.MsrcSeverity -eq "Imporant"}
$Others = $Updates | where {$_.MsrcSeverity -eq $null}

Write-Host "critical=$($Criticals.count)"
Write-Host "important=$($Importants.count)"
Write-Host "other=$($Others.count)"
