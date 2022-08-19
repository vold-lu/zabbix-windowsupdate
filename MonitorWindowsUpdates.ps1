$Searcher = new-object -com "Microsoft.Update.Searcher"
$Updates = $Searcher.Search("IsAssigned=1 and IsInstalled=0").Updates.Count

$Criticals = $Updates | where {$_.MsrcSeverity -eq "Critical"}
$Importants = $Updates | where {$_.MsrcSeverity -eq "Imporant"}
$Others = $Updates | where {$_.MsrcSeverity -eq $null}

Write-Host "critical=$($Criticals.count)"
Write-Host "important=$($Importants.count)"
Write-Host "other=$($Others.count)"

&'C:\Program Files\Zabbix Agent\zabbix_sender.exe' -z 192.168.1.25 -s "srv-test" -k critical.updates -o $Criticals.count
&'C:\Program Files\Zabbix Agent\zabbix_sender.exe' -z 192.168.1.25 -s "srv-test" -k important.updates -o $Importants.count
&'C:\Program Files\Zabbix Agent\zabbix_sender.exe' -z 192.168.1.25 -s "srv-test" -k others.updates -o $Others.count
