$Searcher = new-object -com "Microsoft.Update.Searcher"
$Updates = $Searcher.Search("IsAssigned=1 and IsInstalled=0").Updates

$Criticals = $Updates | where {$_.MsrcSeverity -eq "Critical"}
$Importants = $Updates | where {$_.MsrcSeverity -eq "Important"}
$Others = $Updates | where {$_.MsrcSeverity -eq $null}

zabbix_sender.exe -c "C:\Program Files\Zabbix Agent\zabbix_agentd.conf" -k windows.critical.updates -o $Criticals.count
zabbix_sender.exe -c "C:\Program Files\Zabbix Agent\zabbix_agentd.conf" -k windows.important.updates -o $Importants.count
zabbix_sender.exe -c "C:\Program Files\Zabbix Agent\zabbix_agentd.conf" -k windows.others.updates -o $Others.count
