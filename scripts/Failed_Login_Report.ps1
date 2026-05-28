# Failed Login Report
# Pulls Event ID 4625 from Security log, flags brute force patterns
# Author: Deborah Adeline George
# Date: May 2026

$timeRange = (Get-Date).AddHours(-24)
$events = Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
    StartTime = $timeRange
}

$report = $events | ForEach-Object {
    [PSCustomObject]@{
        TimeCreated    = $_.TimeCreated
        TargetUserName = $_.Properties[5].Value
        IpAddress      = $_.Properties[19].Value
        LogonType      = $_.Properties[10].Value
    }
}

$bruteForce = $report | Group-Object -Property TargetUserName | Where-Object {$_.Count -ge 3} | Select-Object Name, Count

Write-Host "`n=== Failed Login Report - Last 24 Hours ===" -ForegroundColor Cyan
Write-Host "Total Failed Attempts: $($events.Count)" -ForegroundColor Yellow

Write-Host "`n=== Account with 3+ Logon Failed Attempts ===" -ForegroundColor Red
$bruteForce | Format-Table -AutoSize

$report | Export-Csv -Path "C:\Reports\Failed_Login_Report.csv" -NoTypeInformation
Write-Host "`nFull Report Saved to: C:\Reports\Failed_Login_Report.csv" -ForegroundColor Green
