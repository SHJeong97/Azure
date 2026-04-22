Import-Module ActiveDirectory

Add-ADGroupMember -Identity "GG-App-BusinessPortal-Users" -Members "emma.reed","zoe.turner"
Add-ADGroupMember -Identity "GG-App-BusinessPortal-Admins" -Members "adm.olivia.kim","adm.ethan.park"
Add-ADGroupMember -Identity "GG-App-BusinessPortal-Audit" -Members "adm.isabella.chen"

Get-ADGroupMember "GG-App-BusinessPortal-Users" | Select-Object Name,SamAccountName
Get-ADGroupMember "GG-App-BusinessPortal-Admins" | Select-Object Name,SamAccountName
Get-ADGroupMember "GG-App-BusinessPortal-Audit" | Select-Object Name,SamAccountName
