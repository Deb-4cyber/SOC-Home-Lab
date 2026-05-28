# AD User Audit Script
# Identifies stale, inactive, and never-logged-in accounts
# Author: Deborah Adeline George
# Date: May 2026

New-Item -ItemType Directory -Path "C:\Reports" -Force
New-Item -ItemType Directory -Path "C:\Scripts" -Force

$report = Get-ADUser -Filter * -SearchBase "OU=Lab-Users,DC=lab,DC=local" -Properties LastLogonDate, PasswordNeverExpires, Enabled | Select-Object Name, SamAccountName, Enabled, LastLogonDate, PasswordNeverExpires,
@{Name="Status"; Expression={
    if ($_.LastLogonDate -eq $null) {"Never Logged In"}
    elseif ($_.LastLogonDate -lt (Get-Date).AddDays(-30)) {"Stale - Inactive 30+ days"}
    else {"Active"}
}}

$report | Export-Csv -Path "C:\Reports\AD_User_Audit.csv" -NoTypeInformation
Write-Host "Report saved to C:\Reports\AD_User_Audit.csv" -ForegroundColor Green
