function Show-Menu {
    Clear-Host
    Write-Host "----------------------------------------------"
    Write-Host "|         MENU DE COMANDOS DE RED             |"
    Write-Host "----------------------------------------------"
    Write-Host "| 1) Mostrar configuración completa de red    |" 
    Write-Host "| 2) Mostrar conexiones y puertos abiertos    |"
    Write-Host "| 3) Mostrar tabla de enrutamiento            |"
    Write-Host "| 4) Mostrar adaptadores de red               |"
    Write-Host "| 5) Mostrar conexiones TCP activas           |" 
    Write-Host "| 6) Mostrar puertos en uso                   |" 
    Write-Host "| 7) Salir                                    |"
    Write-Host "----------------------------------------------"
}


function Show-AsciiArt1{
    Clear-Host
    Write-Host "██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗"
    Write-Host "██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝"
    Write-Host "██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗  "
    Write-Host "██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝  "
    Write-Host "╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗"
    Write-Host "╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝"
    Start-Sleep -Seconds 3
    Clear-Host
}

function Show-AsciiArt2{
    Clear-Host
    Write-Host "██████╗ ██╗   ██╗███████╗    ██╗  ██╗███████╗███████╗██╗      █████╗ "
    Write-Host "██╔══██╗╚██╗ ██╔╝██╔════╝    ██║ ██╔╝██╔════╝██╔════╝██║     ██╔══██╗"
    Write-Host "██████╔╝ ╚████╔╝ █████╗      █████╔╝ █████╗  █████╗  ██║     ███████║"
    Write-Host "██╔══██╗  ╚██╔╝  ██╔══╝      ██╔═██╗ ██╔══╝  ██╔══╝  ██║     ██╔══██║"
    Write-Host "██████╔╝   ██║   ███████╗    ██║  ██╗███████╗██║     ███████╗██║  ██║"
    Write-Host "╚═════╝    ╚═╝   ╚══════╝    ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝"
    Start-Sleep -Seconds 3
}

function Logic-Program {
    Show-AsciiArt1
    while ($true) {
        Show-Menu
        $option = Read-Host "Seleccione una opcion"
        Clear-Host
        switch ($option) {
            1 { Show-IPConfig }
            2 { Show-NetstatAll }
            3 { Show-NetstatRoute }
            4 { Show-NetAdapters }
            5 { Show-TCPConnections }
            6 { Show-PortStatus }
            7 { Exit-Script }
            default { Write-Host "Opcion no válida, intenta de nuevo." }
        }
        Write-Host "Presione Enter para continuar..."
        $null = Read-Host
    }
}

function Show-IPConfig {
    Write-Host "Mostrando configuración completa de red (ipconfig /all):"
    ipconfig /all | Out-Host
}

function Show-NetstatAll {
    Write-Host "Mostrando todas las conexiones y puertos en escucha (netstat -a):"
    netstat -a | Out-Host
}

function Show-NetstatRoute {
    Write-Host "Mostrando tabla de enrutamiento (netstat -r):"
    netstat -r | Out-Host
}

function Show-NetAdapters {
    Write-Host "Mostrando información de los adaptadores de red (Get-NetAdapter):"
    Get-NetAdapter | Format-Table -AutoSize | Out-Host
}

function Show-TCPConnections {
    Write-Host "Mostrando conexiones TCP activas (Get-NetTCPConnection):"
    Get-NetTCPConnection | Format-Table -Property LocalAddress, LocalPort, RemoteAddress, RemotePort, State -AutoSize | Out-Host
}

function Exit-Script {
    Show-AsciiArt2
    Write-Host " Saliendo... "
    exit
}

function Show-PortStatus {
    $commonPorts = @(
        @{Port=22;  Protocol="TCP"; Service="SSH"},
        @{Port=25;  Protocol="TCP"; Service="SMTP"},
        @{Port=53;  Protocol="TCP/UDP"; Service="DNS"},
        @{Port=80;  Protocol="TCP"; Service="HTTP"},
        @{Port=110; Protocol="TCP"; Service="POP3"},
        @{Port=143; Protocol="TCP"; Service="IMAP"},
        @{Port=443; Protocol="TCP"; Service="HTTPS"},
        @{Port=631; Protocol="TCP"; Service="IPP (CUPS)"},
        @{Port=3306; Protocol="TCP"; Service="MySQL"},
        @{Port=5432; Protocol="TCP"; Service="PostgreSQL"},
        @{Port=6379; Protocol="TCP"; Service="Redis"}
    )

    Write-Host "---------------------------------------------"
    Write-Host "|  PORT  | PROTOCOL |       SERVICE         |"
    Write-Host "---------------------------------------------"
    foreach ($p in $commonPorts) {
        Write-Host ("| {0,-6} | {1,-8} | {2,-20} |" -f $p.Port, $p.Protocol, $p.Service)
    }
    Write-Host "---------------------------------------------`n"

    $port = Read-Host "Introduce el número de puerto a verificar"

    $connections = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
    if ($connections) {
        Write-Host "`nPuerto $port está ABIERTO.`n"
        foreach ($conn in $connections) {
            $proc = Get-Process -Id $conn.OwningProcess -ErrorAction SilentlyContinue
            $pname = if ($proc) { $proc.ProcessName } else { "Desconocido" }
            Write-Host "Servicio: $pname (PID: $($conn.OwningProcess)) - Estado: $($conn.State)"
        }
    } else {
        Write-Host "`nPuerto $port está CERRADO o no está siendo usado por un proceso conocido."
    }
}


Logic-Program