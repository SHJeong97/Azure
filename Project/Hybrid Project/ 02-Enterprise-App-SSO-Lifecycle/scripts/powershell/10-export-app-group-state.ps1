Import-Module ActiveDirectory

$groups = @(
    "GG-App-BusinessPortal-Users",
    "GG-App-BusinessPortal-Admins",
    "GG-App-BusinessPortal-Audit"
)

foreach ($group in $groups) {
    Write-Host "`n=== $group ==="
    Get-ADGroupMember $group |
        Select-Object Name, SamAccountName, objectClass |
        Sort-Object SamAccountName
}
