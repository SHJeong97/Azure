Import-Module Microsoft.Graph.Authentication -ErrorAction Stop
Import-Module Microsoft.Graph.Users -ErrorAction Stop
Import-Module Microsoft.Graph.Groups -ErrorAction Stop
Import-Module Microsoft.Graph.Identity.SignIns -ErrorAction Stop
Import-Module Microsoft.Graph.Identity.Governance -ErrorAction Stop

Connect-MgGraph -Scopes "User.ReadWrite.All","Group.ReadWrite.All","Directory.ReadWrite.All","RoleManagement.ReadWrite.Directory","Policy.Read.All","Policy.ReadWrite.ConditionalAccess","Organization.Read.All"

$context = Get-MgContext
Write-Host "Connected Tenant ID: $($context.TenantId)"
Write-Host "Connected Account : $($context.Account)"
