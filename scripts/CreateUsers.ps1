# Create test users for homelab.local AD environment
# Author: Deborah George

$users = @(
    @{Name="John Smith"; SamAccountName="jsmith"; Department="IT"},
    @{Name="Sarah Connor"; SamAccountName="sconnor"; Department="HR"},
    @{Name="Bob Jenkins"; SamAccountName="bjenkins"; Department="Finance"},
    @{Name="Alice Wong"; SamAccountName="awong"; Department="IT"},
    @{Name="Dave Miller"; SamAccountName="dmiller"; Department="Finance"}
)

$defaultPassword = Read-Host "Enter default password" -AsSecureString

foreach ($user in $users) {
    New-ADUser `
        -Name $user.Name `
        -SamAccountName $user.SamAccountName `
        -AccountPassword $defaultPassword `
        -Enabled $true

    Set-ADUser `
        -Identity $user.SamAccountName `
        -Department $user.Department

    Write-Host "Created user: $($user.Name)" -ForegroundColor Green
}

Write-Host "All users created successfully." -ForegroundColor Cyan


# Note: Never hardcode credentials in scripts.
# This script uses Read-Host to prompt for password at runtime.
# Original version contained a hardcoded credential, detected by GitGuardian and remediated immediately.
