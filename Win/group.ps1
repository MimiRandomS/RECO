param (
    [string]$GroupName
)

if (-not $GroupName) {
    Write-Host "Usage: .\group_creation.ps1 <GroupName>"
    exit 1
}

if (Get-LocalGroup -Name $GroupName -ErrorAction SilentlyContinue) {
    Write-Host "El grupo '$GroupName' ya existe."
    exit 1
}

New-LocalGroup -Name $GroupName
Write-Host "Grupo '$GroupName' creado exitosamente."
