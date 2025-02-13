param (
    [string]$Username,
    [string]$Group,
    [string]$FullName,
    [string]$HomeDir,
    [string]$Password,
    [int]$PermDir,
    [int]$PermGroup,
    [int]$PermOther
)

if (-not $Username -or -not $Group -or -not $FullName -or -not $HomeDir -or -not $Password) {
    Write-Host "Usage: .\user_creation.ps1 <Username> <Group> <FullName> <HomeDir> <Password> <PermDir> <PermGroup> <PermOther>"
    exit 1
}


if (-not (Get-LocalGroup -Name $Group -ErrorAction SilentlyContinue)) {
    Write-Host "Grupo '$Group' no existe. Creando..."
    New-LocalGroup -Name $Group -ErrorAction Stop
}

Write-Host "Creando usuario '$Username'..."
New-LocalUser -Name $Username -FullName $FullName -Password (ConvertTo-SecureString $Password -AsPlainText -Force) -PasswordNeverExpires $true -AccountNeverExpires $true
Add-LocalGroupMember -Group $Group -Member $Username

if (-not (Test-Path $HomeDir)) {
    New-Item -ItemType Directory -Path $HomeDir
}

$acl = Get-Acl $HomeDir
$ruleUser = New-Object System.Security.AccessControl.FileSystemAccessRule("$Username", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$ruleGroup = New-Object System.Security.AccessControl.FileSystemAccessRule("$Group", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")

$acl.SetAccessRule($ruleUser)
$acl.SetAccessRule($ruleGroup)
Set-Acl -Path $HomeDir -AclObject $acl

Write-Host "Usuario '$Username' creado con éxito en el grupo '$Group' y permisos establecidos."
