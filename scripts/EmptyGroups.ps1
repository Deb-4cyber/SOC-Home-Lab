# Empty Groups Report
# Author: Deborah George
# Purpose: Identify all AD security groups with no members

$displayAllGroups = Get-ADGroup -Filter * | Select-Object Name
$results = @()

foreach ($group in $displayAllGroups) {
    $members = Get-ADGroupMember -Identity $group.Name

    if ($members.Count -eq 0) {
        $results += [PSCustomObject]@{
            GroupName = $group.Name
        }
    }
}

$results | Format-Table -AutoSize
