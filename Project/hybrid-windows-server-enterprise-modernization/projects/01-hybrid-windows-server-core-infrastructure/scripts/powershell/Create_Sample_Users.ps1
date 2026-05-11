Import-Module ActiveDirectory

$DomainDN = "DC=corp,DC=democompany1016,DC=local"
$TempPassword = ConvertTo-SecureString "ChangeMe!2026-Lab" -AsPlainText -Force

$Users = @(
    @{First="Emma"; Last="Wilson"; Sam="emma.wilson"; Dept="HR"; Title="HR Manager"; OU="OU=HR,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-HR"},
    @{First="Daniel"; Last="Kim"; Sam="daniel.kim"; Dept="HR"; Title="HR Specialist"; OU="OU=HR,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-HR"},

    @{First="Olivia"; Last="Brown"; Sam="olivia.brown"; Dept="Finance"; Title="Finance Manager"; OU="OU=Finance,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Finance"},
    @{First="Michael"; Last="Lee"; Sam="michael.lee"; Dept="Finance"; Title="Accountant"; OU="OU=Finance,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Finance"},

    @{First="Sophia"; Last="Martinez"; Sam="sophia.martinez"; Dept="IT"; Title="Systems Administrator"; OU="OU=IT,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-IT"},
    @{First="Ethan"; Last="Park"; Sam="ethan.park"; Dept="IT"; Title="Helpdesk Technician"; OU="OU=IT,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-IT"},

    @{First="Ava"; Last="Garcia"; Sam="ava.garcia"; Dept="Sales"; Title="Sales Manager"; OU="OU=Sales,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Sales"},
    @{First="Noah"; Last="Johnson"; Sam="noah.johnson"; Dept="Sales"; Title="Sales Representative"; OU="OU=Sales,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Sales"},

    @{First="Mia"; Last="Davis"; Sam="mia.davis"; Dept="Operations"; Title="Operations Manager"; OU="OU=Operations,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Operations"},
    @{First="James"; Last="Miller"; Sam="james.miller"; Dept="Operations"; Title="Operations Coordinator"; OU="OU=Operations,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Operations"},

    @{First="Grace"; Last="Chen"; Sam="grace.chen"; Dept="Executives"; Title="Chief Operating Officer"; OU="OU=Executives,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Executives"},
    @{First="Ryan"; Last="Anderson"; Sam="ryan.anderson"; Dept="Executives"; Title="Chief Financial Officer"; OU="OU=Executives,OU=Users,OU=SRMG,$DomainDN"; Group="GG-Dept-Executives"}
)

foreach ($User in $Users) {
    $DisplayName = "$($User.First) $($User.Last)"
    $UPN = "$($User.Sam)@corp.democompany1016.local"

    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($User.Sam)'" -ErrorAction SilentlyContinue)) {
        New-ADUser `
            -Name $DisplayName `
            -GivenName $User.First `
            -Surname $User.Last `
            -SamAccountName $User.Sam `
            -UserPrincipalName $UPN `
            -DisplayName $DisplayName `
            -Department $User.Dept `
            -Title $User.Title `
            -Path $User.OU `
            -AccountPassword $TempPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Write-Host "Created user: $DisplayName"
    }
    else {
        Write-Host "User already exists: $DisplayName"
    }

    Add-ADGroupMember -Identity $User.Group -Members $User.Sam -ErrorAction SilentlyContinue
}
