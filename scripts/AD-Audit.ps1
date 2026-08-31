# AD Access Audit Script
# Author: Deborah George
# Purpose: Audit AD users, group memberships and flag privileged access violations

Write-Host "=================================" -ForegroundColor Cyan
Write-Host "   AD Access Audit Report" -ForegroundColor Cyan
Write-Host "   Generated: $(Get-Date)" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

$displayusers = Get-ADUser -Filter * -Properties Department | Select-Object Name, SamAccountName, Department
$results = @()

foreach ($user in $displayusers) {
    $group = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName
    $groupName = $group.Name -join ", "

    $results += [PSCustomObject]@{
        Name           = $user.Name
        SamAccountName = $user.SamAccountName
        Department     = $user.Department
        Groups         = $groupName
    }

    if ($user.Department -ne "IT" -and $groupName -like "*Domain-Admins-Custom*") {
        Write-Host "WARNING: $($user.Name) has admin access but NOT in IT Department" -ForegroundColor Red
    }
}

$results | Format-Table -AutoSize

$results | Export-Csv -Path "C:\Users\Administrator\Desktop\AD-Audit-Report.csv" -NoTypeInformation

Write-Host "Report exported to Desktop as AD-Audit-Report.csv" -ForegroundColor Cyan
