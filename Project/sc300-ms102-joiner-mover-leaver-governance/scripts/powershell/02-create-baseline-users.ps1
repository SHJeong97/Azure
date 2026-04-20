param(
    [string]$CsvPath = ".\data\users\baseline-users.csv",
    [string]$TempPassword = ""
)

if ([string]::IsNullOrWhiteSpace($TempPassword)) {
    $TempPassword = Read-Host "Enter temporary password for baseline users"
}

$users = Import-Csv $CsvPath
$results = @()

foreach ($u in $users) {
    try {
        $existing = Get-MgUser -UserId $u.UserPrincipalName -ErrorAction SilentlyContinue

        if ($existing) {
            $results += [pscustomobject]@{
                UserPrincipalName = $u.UserPrincipalName
                Status            = "AlreadyExists"
                Notes             = "User already present"
            }
            continue
        }

        $mailNickname = $u.UserPrincipalName.Split("@")[0]

        $params = @{
            AccountEnabled    = $true
            DisplayName       = $u.DisplayName
            GivenName         = $u.FirstName
            Surname           = $u.LastName
            UserPrincipalName = $u.UserPrincipalName
            MailNickname      = $mailNickname
            Department        = $u.Department
            JobTitle          = $u.JobTitle
            UsageLocation     = $u.UsageLocation
            PasswordProfile   = @{
                ForceChangePasswordNextSignIn = $true
                Password                      = $TempPassword
            }
        }

        New-MgUser @params | Out-Null

        $results += [pscustomobject]@{
            UserPrincipalName = $u.UserPrincipalName
            Status            = "Created"
            Notes             = "Baseline user created"
        }
    }
    catch {
        $results += [pscustomobject]@{
            UserPrincipalName = $u.UserPrincipalName
            Status            = "Failed"
            Notes             = $_.Exception.Message
        }
    }
}

$results | Export-Csv ".\evidence\cli-output\baseline-users-created.csv" -NoTypeInformation
$results
