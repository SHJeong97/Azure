Connect-MgGraph -Scopes "User.ReadWrite.All"

$pilotUsers = @(
    "emma.reed@democompany1016.onmicrosoft.com",
    "david.cho@democompany1016.onmicrosoft.com",
    "olivia.kim@democompany1016.onmicrosoft.com",
    "ethan.park@democompany1016.onmicrosoft.com",
    "isabella.chen@democompany1016.onmicrosoft.com",
    "sophia.ng@democompany1016.onmicrosoft.com",
    "liam.brooks@democompany1016.onmicrosoft.com",
    "ava.patel@democompany1016.onmicrosoft.com",
    "noah.ross@democompany1016.onmicrosoft.com",
    "mia.garcia@democompany1016.onmicrosoft.com",
    "jackson.lee@democompany1016.onmicrosoft.com",
    "zoe.turner@democompany1016.onmicrosoft.com",
    "mason.hill@democompany1016.onmicrosoft.com",
    "adm.olivia.kim@democompany1016.onmicrosoft.com",
    "adm.ethan.park@democompany1016.onmicrosoft.com",
    "adm.isabella.chen@democompany1016.onmicrosoft.com"
)

foreach ($upn in $pilotUsers) {
    Update-MgUser -UserId $upn -UsageLocation "US"
    Write-Host "Updated UsageLocation to US for $upn"
}
