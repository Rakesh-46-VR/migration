# Usage: .\new-migration.ps1 create_users_table
param (
    [string]$Name
)

if (-not $Name) {
    Write-Host "Usage: new-migration.ps1 <migration_name>"
    exit 1
}

$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddHHmmss")
$Filename = "${Timestamp}_${Name}.sql"
$Path = Join-Path "migrations/db" $Filename

@"
-- migrate:up

-- migrate:down
"@ | Out-File -Encoding UTF8 $Path

Write-Host "Created $Path"
