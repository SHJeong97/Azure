Import-Module ActiveDirectory

$AddressPlan = @(
    [PSCustomObject]@{
        SamAccountName = "emma.wilson"
        TargetPrimarySMTP = "emma.wilson@summitridge-mfg.com"
        TenantAlias = "emma.wilson@democompany1016.onmicrosoft.com"
    },
    [PSCustomObject]@{
        SamAccountName = "olivia.brown"
        TargetPrimarySMTP = "olivia.brown@summitridge-mfg.com"
        TenantAlias = "olivia.brown@democompany1016.onmicrosoft.com"
    },
    [PSCustomObject]@{
        SamAccountName = "sophia.martinez"
        TargetPrimarySMTP = "sophia.martinez@summitridge-mfg.com"
        TenantAlias = "sophia.martinez@democompany1016.onmicrosoft.com"
    }
)

$ADAddressUpdateResults = foreach ($Plan in $AddressPlan) {
    try {
        $ADUser = Get-ADUser $Plan.SamAccountName -Properties mail,proxyAddresses,UserPrincipalName,DisplayName -ErrorAction Stop

        $ExistingProxyAddresses = @($ADUser.proxyAddresses)

        $CleanedProxyAddresses = foreach ($Address in $ExistingProxyAddresses) {
            if ([string]::IsNullOrWhiteSpace([string]$Address)) {
                continue
            }

            $AddressString = [string]$Address
            $AddressValue = $AddressString -replace "^SMTP:","" -replace "^smtp:",""

            if (
                $AddressValue -ieq $Plan.TargetPrimarySMTP -or
                $AddressValue -ieq $Plan.TenantAlias
            ) {
                continue
            }

            if ($AddressString -cmatch "^SMTP:") {
                "smtp:$AddressValue"
            }
            else {
                $AddressString
            }
        }

        [string[]]$NewProxyAddresses = @(
            "SMTP:$($Plan.TargetPrimarySMTP)"
            "smtp:$($Plan.TenantAlias)"
        ) + @($CleanedProxyAddresses)

        [string[]]$NewProxyAddresses = $NewProxyAddresses |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
            Sort-Object -Unique |
            ForEach-Object { [string]$_ }

        Set-ADUser `
            -Identity $Plan.SamAccountName `
            -Replace @{
                mail = [string]$Plan.TargetPrimarySMTP
                proxyAddresses = [string[]]$NewProxyAddresses
            } `
            -ErrorAction Stop

        $UpdatedUser = Get-ADUser $Plan.SamAccountName -Properties mail,proxyAddresses,UserPrincipalName,DisplayName -ErrorAction Stop

        [PSCustomObject]@{
            SamAccountName = $UpdatedUser.SamAccountName
            DisplayName = $UpdatedUser.DisplayName
            UserPrincipalName = $UpdatedUser.UserPrincipalName
            Mail = $UpdatedUser.mail
            ProxyAddresses = ($UpdatedUser.proxyAddresses -join ";")
            TargetPrimarySMTP = $Plan.TargetPrimarySMTP
            TenantAlias = $Plan.TenantAlias
            UpdateStatus = "SUCCESS - AD mail and proxyAddresses updated"
        }
    }
    catch {
        [PSCustomObject]@{
            SamAccountName = $Plan.SamAccountName
            DisplayName = $null
            UserPrincipalName = $null
            Mail = $null
            ProxyAddresses = $null
            TargetPrimarySMTP = $Plan.TargetPrimarySMTP
            TenantAlias = $Plan.TenantAlias
            UpdateStatus = "FAILED - $($_.Exception.Message)"
        }
    }
}

$ADAddressUpdateResults

$ADAddressUpdateResults |
Export-Csv "C:\LabEvidence\Project04\Batch06\batch-06-ad-mail-proxyaddress-update-results.csv" -NoTypeInformation