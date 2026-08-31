# Stale Accounts Report
# Author: Deborah George
# Purpose: Identify accounts that have not logged in for more than 30 days

$displayUsers = Get-ADUser -Filter * -Properties LastLogonDate | Select-Object Name, SamAccountName, LastLogonDate
$cutoffDate = (Get-Date).AddDays(-30)
$results = @()

foreach ($info in $displayUsers) {
    if ($info.LastLogonDate -lt $cutoffDate -or $info.LastLogonDate -eq $null) {
        $staleAccount = $true
    } else {
        $staleAccount = $false
    }

    $results += [PSCustomObject]@{
        Name         = $info.Name
        UserName     = $info.SamAccountName
        LastLogon    = $info.LastLogonDate
        StaleAccount = $staleAccount
    }
}

$results | Format-Table -AutoSize
