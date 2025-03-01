# Windows Log Viewer Menu in PowerShell

Clear-Host  # Limpia la pantalla al inicio

function Show-Menu {
    Clear-Host
    Write-Host "============================================"
    Write-Host "|       Windows Log Viewer Menu            |"
    Write-Host "============================================"
    Write-Host "| 1) Show last 15 lines of system logs     |"
    Write-Host "| 2) Filter last 15 lines for a word       |"
    Write-Host "| 3) Exit                                  |"
    Write-Host "============================================"
    $choice = Read-Host "Select an option"
    return $choice
}

function Show-AsciiArt1{
    Clear-Host
    Write-Host "__     __     ______     __         ______     ______     __    __     ______    "
    Write-Host "/\ \  _ \\ \   /\  ___\   /\ \       /\  ___\   /\  __ \   /\ \\/  \   /\  ___\   "
    Write-Host "\ \ \/ \.\ \  \ \  __\   \ \ \____  \ \ \____  \ \ \/\ \  \ \ \-./\ \  \ \  __\   "
    Write-Host "\ \__/\\_\  \ \_____\  \ \_____\  \ \_____\  \ \_____\  \ \_\ \ \_\  \ \_____\ "
    Write-Host "\/_/   \/_/   \/_____/   \/_____/   \/_____/   \/_____/   \/_/  \/_/   \/_____/ "
    Write-Host "-------------------------------------------------------------------------------"
    Start-Sleep -Seconds 3
    Clear-Host
}

function Show-AsciiArt2{
    Clear-Host
    Write-Host "          ______     __  __     ______    "
    Write-Host "          /\  == \   /\ \_\ \   /\  ___\   "
    Write-Host "          \ \  __<   \ \____ \  \ \  __\   "
    Write-Host "          \ \_____\  \/\_____\  \ \_____\ "
    Write-Host "          \/_____/   \/_____/   \/_____/ "
    Write-Host "--------------------------------------------------------------------"
    Start-Sleep -Seconds 3
}

function Show-Logs {
    Write-Host "===== System Logs ====="
    Get-EventLog -LogName System -Newest 15 | Format-Table -AutoSize
    Write-Host ""

    Write-Host "===== Application Logs ====="
    Get-EventLog -LogName Application -Newest 15 | Format-Table -AutoSize
    Write-Host ""

    Write-Host "===== Security Logs ====="
    Get-EventLog -LogName Security -Newest 15 | Format-Table -AutoSize
    Write-Host ""
}

function Filter-Logs {
    $keyword = Read-Host "Enter the word to search for"

    Write-Host "===== System Logs (Filtered) ====="
    Get-EventLog -LogName System -Newest 15 | Where-Object { $_.Message -match $keyword } | Format-Table -AutoSize
    Write-Host ""

    Write-Host "===== Application Logs (Filtered) ====="
    Get-EventLog -LogName Application -Newest 15 | Where-Object { $_.Message -match $keyword } | Format-Table -AutoSize
    Write-Host ""

    Write-Host "===== Security Logs (Filtered) ====="
    Get-EventLog -LogName Security -Newest 15 | Where-Object { $_.Message -match $keyword } | Format-Table -AutoSize
    Write-Host ""
}

function Exit-Script {
    Show-AsciiArt2
    Write-Host " Saliendo... "
    exit
}

function Main {
    Show-AsciiArt1
    while ($true) {
        $option = Show-Menu
        Clear-Host
        switch ($option) {
            "1" { Show-Logs }
            "2" { Filter-Logs }
            "3" { Exit-Script }
            default { Write-Host "Invalid option, try again." }
        }
        Write-Host "Press Enter to continue..."
        Read-Host
    }
}

Main
