# Disabled Accounts Report
# Author: Deborah George
# Purpose: Identify all disabled accounts in Active Directory

$accountInfo = Get-ADUser -Filter {Enabled -eq $false} -Properties Department | Select-Object Name, SamAccountName, Department, Enabled
$results = @()

foreach ($info in $accountInfo) {
    $results += [PSCustomObject]@{
        Name            = $info.Name
        UserName        = $info.SamAccountName
        Department      = $info.Department
        AccountDisabled = $info.Enabled
    }
}

$results | Format-Table -AutoSize
