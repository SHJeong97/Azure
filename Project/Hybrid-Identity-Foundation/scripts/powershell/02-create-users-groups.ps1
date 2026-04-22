Import-Module ActiveDirectory

$domainDn = "DC=corp,DC=democompany1016,DC=local"
$basePath = "C:\LabSources\HybridIdentity"

$groupsCsv = Join-Path $basePath "data\groups.csv"
$usersCsv  = Join-Path $basePath "data\users.csv"

$groupPathMap = @{
    "Department" = "OU=Departments,OU=Groups,$domainDn"
    "Licensing"  = "OU=Licensing,OU=Groups,$domainDn"
    "Role"       = "OU=Roles,OU=Groups,$domainDn"
}

$usersOuMap = @{
    "Executive"  = "OU=Executive,OU=Employees,$domainDn"
    "IT"         = "OU=IT,OU=Employees,$domainDn"
    "HR"         = "OU=HR,OU=Employees,$domainDn"
    "Finance"    = "OU=Finance,OU=Employees,$domainDn"
    "Sales"      = "OU=Sales,OU=Employees,$domainDn"
    "Operations" = "OU=Operations,OU=Employees,$domainDn"
}

# Create groups
$groups = Import-Csv $groupsCsv
foreach ($group in $groups) {
    $targetPath = $groupPathMap[$group.GroupType]

    $existingGroup = Get-ADGroup -Filter "SamAccountName -eq '$($group.Name)'" -ErrorAction SilentlyContinue
    if (-not $existingGroup) {
        New-ADGroup `
            -Name $group.Name `
            -SamAccountName $group.Name `
            -GroupScope $group.Scope `
            -GroupCategory $group.Category `
            -Path $targetPath `
            -Description $group.Description

        Write-Host "Created group: $($group.Name)"
    }
    else {
        Write-Host "Group already exists: $($group.Name)"
    }
}

# Create standard users
$users = Import-Csv $usersCsv
foreach ($user in $users) {
    $userPath = $usersOuMap[$user.UserOU]
    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force

    $existingUser = Get-ADUser -Filter "SamAccountName -eq '$($user.SamAccountName)'" -ErrorAction SilentlyContinue
    if (-not $existingUser) {
        New-ADUser `
            -Name "$($user.GivenName) $($user.Surname)" `
            -GivenName $user.GivenName `
            -Surname $user.Surname `
            -DisplayName "$($user.GivenName) $($user.Surname)" `
            -SamAccountName $user.SamAccountName `
            -UserPrincipalName $user.UserPrincipalName `
            -Department $user.Department `
            -Title $user.Title `
            -Office $user.Office `
            -Path $userPath `
            -Enabled $true `
            -AccountPassword $securePassword `
            -ChangePasswordAtLogon $false

        Write-Host "Created user: $($user.SamAccountName)"
    }
    else {
        Write-Host "User already exists: $($user.SamAccountName)"
    }

    Add-ADGroupMember -Identity $user.DeptGroup -Members $user.SamAccountName -ErrorAction SilentlyContinue
    Add-ADGroupMember -Identity $user.LicGroup -Members $user.SamAccountName -ErrorAction SilentlyContinue
}

# Create named admin accounts
$adminUsers = @(
    @{
        GivenName         = "Olivia"
        Surname           = "Kim"
        SamAccountName    = "adm.olivia.kim"
        UserPrincipalName = "adm.olivia.kim@democompany1016.onmicrosoft.com"
        Title             = "AD Platform Administrator"
        Office            = "HQ-NYC"
        Path              = "OU=Privileged Users,OU=Admins,$domainDn"
        Password          = "DemoComp!2026Temp#"
        RoleGroup         = "GG-Role-AD-Platform-Admins"
        LicGroup          = "GG-Lic-M365-E5-Privileged-Pilot"
    },
    @{
        GivenName         = "Ethan"
        Surname           = "Park"
        SamAccountName    = "adm.ethan.park"
        UserPrincipalName = "adm.ethan.park@democompany1016.onmicrosoft.com"
        Title             = "Microsoft 365 Administrator"
        Office            = "HQ-NYC"
        Path              = "OU=Privileged Users,OU=Admins,$domainDn"
        Password          = "DemoComp!2026Temp#"
        RoleGroup         = "GG-Role-M365-Admins"
        LicGroup          = "GG-Lic-M365-E5-Privileged-Pilot"
    },
    @{
        GivenName         = "Isabella"
        Surname           = "Chen"
        SamAccountName    = "adm.isabella.chen"
        UserPrincipalName = "adm.isabella.chen@democompany1016.onmicrosoft.com"
        Title             = "Helpdesk Administrator"
        Office            = "HQ-NYC"
        Path              = "OU=Operations,OU=Admins,$domainDn"
        Password          = "DemoComp!2026Temp#"
        RoleGroup         = "GG-Role-Helpdesk-Admins"
        LicGroup          = "GG-Lic-M365-E5-Privileged-Pilot"
    }
)

foreach ($admin in $adminUsers) {
    $securePassword = ConvertTo-SecureString $admin.Password -AsPlainText -Force

    $existingAdmin = Get-ADUser -Filter "SamAccountName -eq '$($admin.SamAccountName)'" -ErrorAction SilentlyContinue
    if (-not $existingAdmin) {
        New-ADUser `
            -Name "$($admin.GivenName) $($admin.Surname) (Admin)" `
            -GivenName $admin.GivenName `
            -Surname $admin.Surname `
            -DisplayName "$($admin.GivenName) $($admin.Surname) (Admin)" `
            -SamAccountName $admin.SamAccountName `
            -UserPrincipalName $admin.UserPrincipalName `
            -Title $admin.Title `
            -Office $admin.Office `
            -Path $admin.Path `
            -Enabled $true `
            -AccountPassword $securePassword `
            -ChangePasswordAtLogon $false

        Write-Host "Created admin account: $($admin.SamAccountName)"
    }
    else {
        Write-Host "Admin account already exists: $($admin.SamAccountName)"
    }

    Add-ADGroupMember -Identity $admin.RoleGroup -Members $admin.SamAccountName -ErrorAction SilentlyContinue
    Add-ADGroupMember -Identity $admin.LicGroup -Members $admin.SamAccountName -ErrorAction SilentlyContinue
}

# Basic validation output
Write-Host "`n--- OUs ---"
Get-ADOrganizationalUnit -Filter * -SearchBase $domainDn | Select-Object Name, DistinguishedName | Sort-Object DistinguishedName

Write-Host "`n--- Groups ---"
Get-ADGroup -Filter * -SearchBase "OU=Groups,$domainDn" | Select-Object Name, GroupCategory, GroupScope | Sort-Object Name

Write-Host "`n--- Users ---"
Get-ADUser -Filter * -SearchBase "OU=Employees,$domainDn" -Properties Department, UserPrincipalName |
    Select-Object Name, SamAccountName, Department, UserPrincipalName | Sort-Object Name

Write-Host "`n--- Admin Accounts ---"
Get-ADUser -Filter * -SearchBase "OU=Admins,$domainDn" -Properties UserPrincipalName, Title |
    Select-Object Name, SamAccountName, Title, UserPrincipalName | Sort-Object Name
