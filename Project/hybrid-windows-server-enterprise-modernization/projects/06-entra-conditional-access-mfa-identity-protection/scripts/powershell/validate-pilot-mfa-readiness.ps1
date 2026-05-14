# Project 06 Batch 3
# Validate pilot MFA readiness for Conditional Access policy testing.

Connect-MgGraph -Scopes `
"User.Read.All",`
"Directory.Read.All",`
"Reports.Read.All",`
"UserAuthenticationMethod.Read.All"

$PilotUPNs = @(
    "emma.wilson@summitridge-mfg.com",
    "olivia.brown@summitridge-mfg.com",
    "sophia.martinez@summitridge-mfg.com"
)

$RegistrationUri = 'https://graph.microsoft.com/v1.0/reports/authenticationMethods/userRegistrationDetails?$top=999'

$AllRegistrationDetails = @()

do {
    $Response = Invoke-MgGraphRequest -Method GET -Uri $RegistrationUri

    if ($Response.value) {
        $AllRegistrationDetails += $Response.value
    }

    $RegistrationUri = $Response.'@odata.nextLink'
}
while ($RegistrationUri)

$PilotMFAReadiness = foreach ($UPN in $PilotUPNs) {
    $User = Get-MgUser `
        -Filter "userPrincipalName eq '$UPN'" `
        -Property Id,DisplayName,UserPrincipalName,AccountEnabled,AssignedLicenses `
        -ErrorAction SilentlyContinue

    $Registration = $AllRegistrationDetails |
    Where-Object { $_.userPrincipalName -eq $UPN }

    if ($User) {
        [PSCustomObject]@{
            UserPrincipalName = $User.UserPrincipalName
            DisplayName = $User.DisplayName
            AccountEnabled = $User.AccountEnabled
            AssignedLicenseCount = if ($User.AssignedLicenses) { ($User.AssignedLicenses | Measure-Object).Count } else { 0 }
            IsMfaRegistered = if ($Registration) { $Registration.isMfaRegistered } else { "" }
            IsMfaCapable = if ($Registration) { $Registration.isMfaCapable } else { "" }
            DefaultMfaMethod = if ($Registration) { $Registration.defaultMfaMethod } else { "" }
            MethodsRegistered = if ($Registration) { ($Registration.methodsRegistered -join ";") } else { "" }
            ReadyForCAPolicy = if (
                $User.AccountEnabled -eq $true -and
                (($User.AssignedLicenses | Measure-Object).Count -gt 0) -and
                $Registration.isMfaRegistered -eq $true
            ) {
                "Yes"
            }
            else {
                "Review required"
            }
        }
    }
    else {
        [PSCustomObject]@{
            UserPrincipalName = $UPN
            DisplayName = ""
            AccountEnabled = ""
            AssignedLicenseCount = ""
            IsMfaRegistered = ""
            IsMfaCapable = ""
            DefaultMfaMethod = ""
            MethodsRegistered = ""
            ReadyForCAPolicy = "User not found"
        }
    }
}

$PilotMFAReadiness