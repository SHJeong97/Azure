Import-Module ActiveDirectory

Get-ADOrganizationalUnit -Identity "OU=Apps,OU=Groups,DC=corp,DC=democompany1016,DC=local"

Get-ADGroup -Filter * -SearchBase "OU=Apps,OU=Groups,DC=corp,DC=democompany1016,DC=local" |
    Select-Object Name, GroupScope, GroupCategory, DistinguishedName |
    Sort-Object Name
