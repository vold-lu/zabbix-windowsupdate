#Get all updates that are not install
$Searcher = new-object -com "Microsoft.Update.Searcher"
$Searcher.Search("IsAssigned=1 and IsInstalled=0").Updates | Format-Table title, MsrcSeverity, IsInstalled

#Type of Windows updates by severity
$Critical = $Searcher.updates |

      where {$_.MsrcSeverity -eq "Critical"}

$Important = $Searcher.updates |

      where {$_.MsrcSeverity -eq "Imporant"}

$other = $Searcher.updates |
 
      where {$_.MsrcSeverity -eq $null}

#Write results 
Write-Host "total=$($Searcher.updates.count)"
Write-Host "critical=$($Critical.count)"
Write-Host "important=$($Important.count)"
Write-Host "other=$($other.count)"
