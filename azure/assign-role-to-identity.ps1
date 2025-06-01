<#
.SYNOPSIS
Assigns a role (e.g., Reader) to a managed identity (or any SPN) at subscription level.

.PARAMETER AppId
Client ID of the Service Principal or Managed Identity

.PARAMETER Role
Role to assign (e.g., Reader, Contributor)

.AUTHOR
Rahul Chamoli
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$AppId,

    [Parameter(Mandatory=$true)]
    [string]$Role
)

# Connect if needed
if (-not (Get-AzContext)) {
    Connect-AzAccount
}

# Get SPN object
$sp = Get-AzADServicePrincipal -ApplicationId $AppId
if (-not $sp) {
    Write-Error "Service Principal not found for AppId: $AppId"
    return
}

# Get subscription
$subId = (Get-AzContext).Subscription.Id

# Assign role
New-AzRoleAssignment -ObjectId $sp.Id -RoleDefinitionName $Role -Scope "/subscriptions/$subId"

Write-Host "✅ Assigned '$Role' role to $AppId"
