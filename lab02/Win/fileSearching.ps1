$global:BASE_DIR = Get-Location

function Show-Menu {
    Clear-Host
    Write-Host "----------------------------------------------"
    Write-Host "|               MENU DE BUSQUEDA             |"
    Write-Host "----------------------------------------------"
    Write-Host "| 1) Buscar archivo por nombre               |"
    Write-Host "| 2) Buscar palabra en archivo               |"
    Write-Host "| 3) Buscar archivo y palabra dentro         |"
    Write-Host "| 4) Contar lineas de un archivo             |"
    Write-Host "| 5) Mostrar primeras N lineas               |"
    Write-Host "| 6) Mostrar ultimas N lineas                |"
    Write-Host "| 7) Salir                                   |"
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
            1 { Search-File }
            2 { Search-Word }
            3 { Search-File-And-Word }
            4 { Count-Lines }
            5 { Show-First-N-Lines }
            6 { Show-Last-N-Lines }
            7 { Exit-Script }
            default { Write-Host "Opcion no válida, intenta de nuevo." }
        }
        Write-Host "Presione Enter para continuar..."
        $null = Read-Host
    }
}

function Search-File {
    $pattern = Read-Host "Ingrese parte o nombre del archivo a buscar"
    $files = Get-ChildItem -Path $BASE_DIR -Recurse -Filter "*$pattern*" -ErrorAction SilentlyContinue
    if ($files) {
        $files | ForEach-Object { Write-Host $_.FullName }
        Write-Host "Total de archivos encontrados: $($files.Count)"
    } else {
        Write-Host "No se encontraron archivos."
    }
}

function Search-Word {
    $file = Read-Host "Ingrese la ruta del archivo"
    if (Test-Path $file) {
        $word = Read-Host "Ingrese la palabra a buscar"
        $matches = Select-String -Path $file -Pattern $word
        if ($matches) {
            $matches | ForEach-Object { Write-Host "Linea $($_.LineNumber): $($_.Line)" }
            Write-Host "Total de apariciones: $($matches.Count)"
        } else {
            Write-Host "No se encontraron coincidencias."
        }
    } else {
        Write-Host "El archivo no existe."
    }
}

function Search-File-And-Word {
    $BASE_DIR = Read-Host "Ingrese la ruta del directorio donde buscar"

    if (-not (Test-Path $BASE_DIR)) {
        Write-Host "El directorio especificado no existe o no es accesible."
        return
    }

    $pattern = Read-Host "Ingrese parte o nombre del archivo a buscar"
    $files = Get-ChildItem -Path $BASE_DIR -Recurse -File | Where-Object { $_.Name -like "*$pattern*" }

    if ($files.Count -eq 0) {
        Write-Host "No se encontraron archivos que coincidan con '$pattern'."
        return
    }

    Write-Host "Se encontraron $($files.Count) archivos."

    $word = Read-Host "Ingrese la palabra a buscar dentro de los archivos encontrados"

    foreach ($file in $files) {
        $matches = Select-String -Path $file.FullName -Pattern $word

        if ($matches) {
            Write-Host "`nArchivo: $($file.FullName)"
            foreach ($match in $matches) {
                Write-Host "Línea $($match.LineNumber): $($match.Line)"
            }
            Write-Host "Total de apariciones en este archivo: $($matches.Count)"
        } else {
            Write-Host "`nNo se encontraron coincidencias en: $($file.FullName)"
        }
    }
}

function Count-Lines {
    $file = Read-Host "Ingrese la ruta del archivo"
    if (Test-Path $file) {
        $lineCount = (Get-Content $file | Measure-Object -Line).Lines
        Write-Host "El archivo tiene $lineCount lineas."
    } else {
        Write-Host "El archivo no existe."
    }
}

function Show-First-N-Lines {
    $file = Read-Host "Ingrese la ruta del archivo"
    if (Test-Path $file) {
        $n = Read-Host "Ingrese el numero de lineas a mostrar"
        Get-Content $file | Select-Object -First $n
    } else {
        Write-Host "El archivo no existe."
    }
}

function Show-Last-N-Lines {
    $file = Read-Host "Ingrese la ruta del archivo"
    if (Test-Path $file) {
        $n = Read-Host "Ingrese el numero de lineas a mostrar"
        Get-Content $file | Select-Object -Last $n
    } else {
        Write-Host "El archivo no existe."
    }
}

function Exit-Script {
    Show-AsciiArt2
    Write-Host " Saliendo... "
    exit
}

Logic-Program
