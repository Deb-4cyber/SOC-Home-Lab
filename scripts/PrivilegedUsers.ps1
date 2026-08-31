# Privileged Users Report
# Author: Deborah George
# Purpose: Identify all members of high privilege AD groups and their departments

$privG = @("Domain Admins", "Enterprise Admins", "Schema Admins")
$results = @()

foreach ($user in $privG) {
    $members = Get-ADGroupMember -Identity $user

    foreach ($member in $members) {
        $mDetails = Get-ADUser -Identity $member.SamAccountName -Properties Department

        $results += [PSCustomObject]@{
            Name        = $mDetails.Name
            AccountName = $mDetails.SamAccountName
            Department  = $mDetails.Department
            GroupName   = $user
        }
    }
}

$results | Format-Table -AutoSize
