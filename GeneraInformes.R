# GeneraInformes.R - v4 - 24-08-2026
# Motor de publicación: puede correrse a mano o ser invocado por app.R.

if (!exists("fc_init_motor")) {
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))
}

fc_init_motor(c("quarto"), instalar = FALSE)

if (!file.exists("Inf_ENE_Sexo_Edad_Region.qmd")) {
  stop("Ejecuta GeneraInformes.R desde el proyecto InformeRegional.", call. = FALSE)
}

# ── Parámetros de entrada ───────────────────────────────────────────────────
# La app los deja en su entorno de sesión antes de sourcear este motor. Los
# defaults conservan la ejecución manual histórica del proyecto.
if (!exists("Trim_Actual", inherits = FALSE) || is.null(Trim_Actual)) {
  Trim_Actual <- "202605"
}
if (!grepl("^[0-9]{6}$", Trim_Actual)) {
  stop("Trim_Actual debe tener formato AAAAMM.", call. = FALSE)
}

regiones_nacional <- "Total nacional"
regiones_regiones <- c(
  "Arica y Parinacota", "Tarapacá", "Antofagasta", "Atacama", "Coquimbo",
  "Valparaíso", "Metropolitana", "O'Higgins", "Maule", "Ñuble", "Biobío",
  "La Araucanía", "Los Ríos", "Los Lagos", "Aysén", "Magallanes"
)
regiones_pruebas <- c("Biobío", "Aysén")
regiones_validas <- c(regiones_nacional, regiones_regiones)

if (!exists("regiones_informes", inherits = FALSE) || is.null(regiones_informes)) {
  if (!exists("modo_region", inherits = FALSE) || is.null(modo_region)) {
    modo_region <- 1L
  }
  regiones_informes <- switch(
    as.character(modo_region),
    "1" = regiones_nacional,
    "2" = regiones_regiones,
    "3" = regiones_pruebas,
    "4" = c(regiones_nacional, regiones_regiones),
    stop("modo_region debe ser 1, 2, 3 o 4.", call. = FALSE)
  )
}
regiones_informes <- unique(as.character(regiones_informes))
regiones_invalidas <- setdiff(regiones_informes, regiones_validas)
if (length(regiones_invalidas)) {
  stop("Regiones no reconocidas: ", paste(regiones_invalidas, collapse = ", "),
       call. = FALSE)
}

if (!exists("formatos_informes", inherits = FALSE) || is.null(formatos_informes)) {
  formatos_informes <- "docx"
}
formatos_informes <- unique(tolower(as.character(formatos_informes)))
formatos_invalidos <- setdiff(formatos_informes, c("docx", "html"))
if (length(formatos_invalidos)) {
  stop("Formatos no reconocidos: ", paste(formatos_invalidos, collapse = ", "),
       ". Solo se admiten docx y html.", call. = FALSE)
}
if (!length(formatos_informes)) {
  stop("Selecciona al menos un formato de salida.", call. = FALSE)
}

dire_inf <- file.path(
  dirname(dirname(getwd())), "Datos_Ine", "Procesados", "Informes", Trim_Actual
)
if (!dir.exists(dire_inf)) {
  dir.create(dire_inf, recursive = TRUE)
}

# ── Publicación segura ──────────────────────────────────────────────────────
fc_publicar_informe <- function(origen, destino) {
  if (!file.exists(origen)) {
    stop("Quarto terminó pero no dejó el archivo esperado: ", origen, call. = FALSE)
  }

  temporal <- paste0(destino, ".tmp")
  if (file.exists(temporal) && !file.remove(temporal)) {
    stop("No se pudo limpiar el temporal de publicación: ", temporal, call. = FALSE)
  }
  if (!file.copy(origen, temporal, overwrite = FALSE)) {
    stop("No se pudo copiar el informe a publicación temporal: ", temporal, call. = FALSE)
  }
  if (file.exists(destino) && !file.remove(destino)) {
    stop("No se pudo reemplazar el informe publicado: ", destino,
         ". Cierra el archivo si está abierto.", call. = FALSE)
  }
  if (!file.rename(temporal, destino)) {
    stop("No se pudo publicar el informe en: ", destino, call. = FALSE)
  }
  if (!file.remove(origen)) {
    warning("El informe se publicó, pero quedó un temporal en el proyecto: ", origen)
  }
  normalizePath(destino, winslash = "/", mustWork = TRUE)
}

# Sin esta marca el guardián del QMD detiene el render.
Sys.setenv(GENERA_INFORMES_ACTIVO = "TRUE")
salidas_generadas <- character()

for (region in regiones_informes) {
  for (formato in formatos_informes) {
    nombre_archivo <- paste0(
      "InformeMensual_", gsub(" ", "_", region), "_", Trim_Actual, ".", formato
    )
    ruta_trabajo <- file.path(getwd(), nombre_archivo)
    ruta_publicada <- file.path(dire_inf, nombre_archivo)

    if (file.exists(ruta_trabajo) && !file.remove(ruta_trabajo)) {
      stop("No se pudo eliminar el temporal previo: ", ruta_trabajo, call. = FALSE)
    }

    message("Generando: ", region, " (", toupper(formato), ") → ", nombre_archivo)
    quarto::quarto_render(
      input          = "Inf_ENE_Sexo_Edad_Region.qmd",
      output_file    = nombre_archivo,
      output_format  = formato,
      execute_dir    = getwd(),
      execute_params = list(region_label = region, Trim_Actual = Trim_Actual)
    )

    salidas_generadas <- c(
      salidas_generadas,
      fc_publicar_informe(ruta_trabajo, ruta_publicada)
    )
    gc()
  }
}

message("Informes generados: ", length(salidas_generadas), " archivo(s) en ", dire_inf)
