$global:BASE_DIR = Get-Location

function Show-Menu {
    Clear-Host
    Write-Host "----------------------------------------------"
    Write-Host "|            MENU DE ORDEN Y FILTRO          |"
    Write-Host "----------------------------------------------"
    Write-Host "| 0) Fijar directorio                        |"
    Write-Host "| 1) Mas recientes                           |"
    Write-Host "| 2) Mas antiguos                            |"
    Write-Host "| 3) Tamano (de mayor a menor)               |"
    Write-Host "| 4) Tamano (de menor a mayor)               |"
    Write-Host "| 5) Tipo de archivo (Archivo/Directorio)    |"
    Write-Host "----------------------------------------------"
    Write-Host "| 6) Empieza con una cadena especifica       |"
    Write-Host "| 7) Termina con una cadena especifica       |"
    Write-Host "| 8) Contiene una cadena especifica          |"
    Write-Host "| 9) Salir                                   |"
    Write-Host "----------------------------------------------"
    Write-Host "Directorio actual: $BASE_DIR"
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


function Logic-Program {
    Show-AsciiArt1
    while ($true) {
        Show-Menu
        $option = Read-Host "Seleccione una opcion"
        Clear-Host
        switch ($option) {
            0 { Set-Directory }
            1 { Get-Most-Recent }
            2 { Get-Oldest }
            3 { Get-Size-Desc }
            4 { Get-Size-Asc }
            5 { Get-By-Type }
            6 { Find-Starts-With }
            7 { Find-Ends-With }
            8 { Find-Contains }
            9 { Exit-Script }
            default { Write-Host " Opción no válida, intenta de nuevo." }
        }
        Write-Host "Presione Enter para continuar..."
        $null = Read-Host
    }
}

function Set-Directory {
    $newDir = Read-Host "Ingrese el nuevo directorio o deje vacío para usar '$global:BASE_DIR'"
    if ($newDir -ne "") {
        if (Test-Path -Path $newDir -PathType Container) {
            $global:BASE_DIR = $newDir
            Write-Host " Directorio cambiado a: $global:BASE_DIR"
        } else {
            Write-Host " Error: El directorio no existe."
        }
    } else {
        Write-Host "Manteniendo directorio: $global:BASE_DIR"
    }
}

function Get-Most-Recent {
    Write-Host " Ordenando por archivos más recientes... "
    Get-ChildItem -Path $global:BASE_DIR | Sort-Object LastWriteTime -Descending
}

function Get-Oldest {
    Write-Host " Ordenando por archivos más antiguos... "
    Get-ChildItem -Path $global:BASE_DIR | Sort-Object LastWriteTime
}

function Get-Size-Desc {
    Write-Host " Ordenando por tamaño (mayor a menor)... "
    Get-ChildItem -Path $global:BASE_DIR | Sort-Object Length -Descending
}

function Get-Size-Asc {
    Write-Host " Ordenando por tamaño (menor a mayor)... "
    Get-ChildItem -Path $global:BASE_DIR | Sort-Object Length
}

function Get-By-Type {
    Write-Host " Agrupando por tipo de archivo... "
    Get-ChildItem -Path $global:BASE_DIR | Sort-Object Mode, Name | Format-Table Mode, Name -AutoSize
}

function Find-Starts-With {
    $cadena = Read-Host "Ingrese la cadena inicial"
    Write-Host "Filtrando archivos que contienen '$cadena'..."
    Get-ChildItem -Path $global:BASE_DIR | Where-Object { $_.Name -match "^$cadena" }
}

function Find-Ends-With {
    $cadena = Read-Host "Ingrese la cadena final"
    Write-Host "Filtrando archivos que contienen '$cadena'..."
    Get-ChildItem -Path $global:BASE_DIR | Where-Object { $_.Name -match "$cadena$" }
}

function Find-Contains {
    $cadena = Read-Host "Ingrese la cadena contenida"
    Write-Host "Filtrando archivos que contienen '$cadena'..."
    Get-ChildItem -Path $global:BASE_DIR | Where-Object { $_.Name -match "$cadena" }
}

function Exit-Script {
    Show-AsciiArt2
    Write-Host " Saliendo... "
    exit
}

Logic-Program
