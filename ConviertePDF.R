# ConviertePDF.R - v4 - 24-08-2026
# Requiere Windows con Word instalado. Sin paquetes de R adicionales.

# Usa el Trim_Actual del environment si ya existe (ej. tras correr GeneraInformes.R);
# si no, usa el valor por defecto de abajo
if (!exists("Trim_Actual") || is.null(Trim_Actual)) {
  Trim_Actual <- "202604"
}

dire_inf <- file.path(dirname(dirname(getwd())), "Datos_Ine", "Procesados",
                      "Informes", Trim_Actual)

# Normalizar a ruta Windows con backslashes para PowerShell
dire_win <- normalizePath(dire_inf, winslash = "\\", mustWork = TRUE)

# El Start-Sleep de abajo va después de CADA archivo, no solo tras un fallo:
# sin él aparecen RPC_E_CALL_REJECTED cada 3-5 archivos. No lo borres.
ps_script <- sprintf('
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$carpeta = "%s"
$docs = Get-ChildItem -LiteralPath $carpeta -Filter *.docx
$fallidos = @()
$exitosos = 0
foreach ($d in $docs) {
    $pdf = [System.IO.Path]::ChangeExtension($d.FullName, ".pdf")
    Write-Host "Convirtiendo:" $d.Name
    try {
        $doc = $word.Documents.Open($d.FullName, $false, $true)  # ReadOnly
        # 17 = wdFormatPDF
        $doc.SaveAs([ref]$pdf, [ref]17)
        $doc.Close($false)
        $exitosos++
        Start-Sleep -Milliseconds 800
    } catch {
        Write-Host "  FALLÓ:" $_.Exception.Message
        $fallidos += $d.Name
        # Reiniciar Word entero es más confiable que cerrar el documento
        # problemático a mano cuando quedó un diálogo atascado.
        try { $word.Quit() } catch {}
        try { [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null } catch {}
        Start-Sleep -Seconds 2
        $word = New-Object -ComObject Word.Application
        $word.Visible = $false
        $word.DisplayAlerts = 0
    }
}
$word.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
Write-Host "Conversion completa:" $exitosos "de" $docs.Count "archivos"
if ($fallidos.Count -gt 0) {
    Write-Host "FALLARON (revisar contenido/fuentes de estos archivos):"
    $fallidos | ForEach-Object { Write-Host "  -" $_ }
    exit 1
}
', dire_win)

# El BOM es obligatorio: sin él, PowerShell 5 rompe las tildes.
ps_file <- tempfile(fileext = ".ps1")
con <- file(ps_file, open = "wb")
writeBin(charToRaw('\xEF\xBB\xBF'), con)                 # BOM UTF-8
writeBin(charToRaw(enc2utf8(ps_script)), con)
close(con)

message("Convirtiendo .docx a .pdf en: ", dire_inf)

salida <- system2(
  "powershell",
  args   = c("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", ps_file),
  stdout = TRUE,
  stderr = TRUE
)

cat(salida, sep = "\n")

unlink(ps_file)

estado <- attr(salida, "status")
if (!is.null(estado) && estado != 0) {
  stop("La conversión a PDF tuvo errores. Revisa los archivos informados arriba.",
       call. = FALSE)
}

n_pdf <- length(list.files(dire_inf, pattern = "\\.pdf$"))
message("PDFs en el directorio: ", n_pdf)
