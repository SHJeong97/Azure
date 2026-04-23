Import-Module ActiveDirectory

# Joiner scenario
# Add Liam Brooks to BusinessPortal Users
Add-ADGroupMember -Identity "GG-App-BusinessPortal-Users" -Members "liam.brooks"

# Mover scenario
# Move Emma Reed from Users to Audit
Remove-ADGroupMember -Identity "GG-App-BusinessPortal-Users" -Members "emma.reed" -Confirm:$false
Add-ADGroupMember -Identity "GG-App-BusinessPortal-Audit" -Members "emma.reed"

# Leaver scenario
# Remove Zoe Turner from all BusinessPortal access groups
Remove-ADGroupMember -Identity "GG-App-BusinessPortal-Users" -Members "zoe.turner" -Confirm:$false
Remove-ADGroupMember -Identity "GG-App-BusinessPortal-Admins" -Members "zoe.turner" -Confirm:$false -ErrorAction SilentlyContinue
Remove-ADGroupMember -Identity "GG-App-BusinessPortal-Audit" -Members "zoe.turner" -Confirm:$false -ErrorAction SilentlyContinue

Write-Host "`n=== Final Group State ==="
Get-ADGroupMember "GG-App-BusinessPortal-Users" | Select-Object Name,SamAccountName
Get-ADGroupMember "GG-App-BusinessPortal-Admins" | Select-Object Name,SamAccountName
Get-ADGroupMember "GG-App-BusinessPortal-Audit" | Select-Object Name,SamAccountName
