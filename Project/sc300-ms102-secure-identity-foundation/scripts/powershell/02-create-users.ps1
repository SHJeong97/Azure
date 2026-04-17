param(
    [string]$CsvPath = "C:\Users\vm1\Desktop\planned-users.csv",
    [string]$TempPassword = "Northstar!Temp2026#"
)

$users = Import-Csv $CsvPath
$results = @()

foreach ($u in $users) {
    try {
        $existing = Get-MgUser -UserId $u.UserPrincipalName -ErrorAction SilentlyContinue

        if ($existing) {
            $results += [pscustomobject]@{
                UserPrincipalName = $u.UserPrincipalName
                Status            = "AlreadyExists"
                Notes             = "User already present in tenant"
            }
            continue
        }

        $mailNickname = ($u.UserPrincipalName.Split("@")[0])

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
            Notes             = "User created successfully"
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

$results | Export-Csv "C:\Users\vm1\Desktop\users-created.csv" -NoTypeInformation
$results
