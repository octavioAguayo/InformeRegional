# app.R - v2 - 26-08-2026
# Interfaz Shiny para la publicación de minutas nacionales y regionales ENE.

if (!file.exists("GeneraInformes.R") || !file.exists("Inf_ENE_Sexo_Edad_Region.qmd")) {
  stop("Abre app.R desde la carpeta del proyecto InformeRegional.", call. = FALSE)
}

if (!exists("fc_init_motor")) {
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))
}
fc_init_motor(c("shiny", "shinyjs"), instalar = FALSE)
source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_informe.R"))

ruta_maestra <- file.path(
  dirname(dirname(getwd())), "Datos_Ine", "ENE", "bbdd_minuta", "dt_ENE_Master.RData"
)
ruta_informes <- file.path(dirname(dirname(getwd())), "Datos_Ine", "Procesados", "Informes")

fc_abrir_html_publicados <- function(rutas) {
  html <- rutas[grepl("[.]html$", rutas, ignore.case = TRUE)]
  for (ruta in html) {
    utils::browseURL(normalizePath(ruta, winslash = "/", mustWork = TRUE))
  }
  length(html)
}

fc_estado_fuentes_app <- function() {
  if (!file.exists(ruta_maestra)) {
    stop("No existe la maestra requerida: ", ruta_maestra, call. = FALSE)
  }

  datos <- new.env(parent = emptyenv())
  load(ruta_maestra, envir = datos)
  if (!exists("dt_ENE_Master", envir = datos, inherits = FALSE)) {
    stop("La maestra no contiene el objeto dt_ENE_Master.", call. = FALSE)
  }
  dt <- get("dt_ENE_Master", envir = datos, inherits = FALSE)
  requeridas <- c("fecha", "sexo", "region", "categoria")
  faltantes <- setdiff(requeridas, names(dt))
  if (length(faltantes)) {
    stop("La maestra no contiene columnas requeridas: ",
         paste(faltantes, collapse = ", "), call. = FALSE)
  }

  fecha_actual <- max(as.Date(dt$fecha), na.rm = TRUE)
  dt_regional <- dt[dt$sexo == "AS" & dt$region != "TT", , drop = FALSE]
  frontera <- fc_frontera_fuentes(dt_regional, fecha_actual)

  list(
    fecha_actual = fecha_actual,
    fecha_dta = frontera$dta,
    fecha_efectiva = frontera$efectiva,
    dta_rezagado = frontera$rezagado,
    fechas = sort(unique(as.Date(dt$fecha)))
  )
}

estado_inicial <- fc_estado_fuentes_app()

regiones_disponibles <- c(
  "Arica y Parinacota", "Tarapacá", "Antofagasta", "Atacama", "Coquimbo",
  "Valparaíso", "Metropolitana", "O'Higgins", "Maule", "Ñuble", "Biobío",
  "La Araucanía", "Los Ríos", "Los Lagos", "Aysén", "Magallanes"
)

fc_etiquetas_periodos <- function(fechas) {
  etiquetas <- vapply(fechas, fc_fecha_a_trimestre, character(1))
  stats::setNames(as.character(fechas), etiquetas)
}

ui <- shiny::fluidPage(
  shinyjs::useShinyjs(),
  shiny::tags$head(shiny::tags$style(shiny::HTML("\
    .panel-controles { background: #f8f9fa; border: 1px solid #dfe4ea;
      border-radius: 8px; padding: 20px; margin-bottom: 20px; }
    .estado-fuentes { border-radius: 6px; padding: 12px 16px; margin-bottom: 16px; }
    .estado-total { background: #e8f5e9; color: #1b5e20; }
    .estado-excel { background: #fff3e0; color: #7f4100; }
  "))),
  shiny::titlePanel("Generador de minutas ENE"),
  shiny::uiOutput("estado_fuentes"),
  shiny::div(
    class = "panel-controles",
    shiny::fluidRow(
      shiny::column(4, shiny::selectInput(
        "periodo", "Período", choices = fc_etiquetas_periodos(estado_inicial$fechas),
        selected = as.character(estado_inicial$fecha_actual)
      )),
      shiny::column(4, shiny::radioButtons(
        "alcance", "Alcance", inline = TRUE,
        choices = c("Nacional" = "nacional", "Todas las regiones" = "regiones",
                    "Regiones seleccionadas" = "seleccion"),
        selected = "nacional"
      )),
      shiny::column(4, shiny::checkboxGroupInput(
        "formatos", "Salidas", choices = c("Word (.docx)" = "docx", "HTML" = "html"),
        selected = "docx", inline = TRUE
      ))
    ),
    shiny::conditionalPanel(
      "input.alcance === 'seleccion'",
      shiny::selectizeInput("regiones", "Regiones", choices = regiones_disponibles,
                            multiple = TRUE)
    ),
    shiny::tags$small(
      "La generación solo produce Word y/o HTML. La conversión PDF es una etapa editorial separada."
    ),
    shiny::br(), shiny::br(),
    shiny::fluidRow(
      shiny::column(4, shiny::actionButton(
        "generar", "Generar minutas", class = "btn-primary", width = "100%"
      )),
      shiny::column(4, shiny::actionButton(
        "convertir_pdf", "Convertir Word a PDF", width = "100%"
      ))
    )
  ),
  shiny::h4("Resultado de la sesión"),
  shiny::verbatimTextOutput("resultado")
)

server <- function(input, output, session) {
  resultado_texto <- shiny::reactiveVal("Aún no se han generado minutas en esta sesión.")

  output$estado_fuentes <- shiny::renderUI({
    estado <- fc_estado_fuentes_app()
    if (estado$dta_rezagado) {
      shiny::div(
        class = "estado-fuentes estado-excel",
        shiny::strong("Ventana Excel: "),
        "el período ", fc_fecha_a_trimestre(estado$fecha_actual),
        " está disponible para la minuta nacional. Los informes regionales solo ",
        "pueden generarse hasta ", fc_fecha_a_trimestre(estado$fecha_dta), "."
      )
    } else {
      shiny::div(
        class = "estado-fuentes estado-total",
        shiny::strong("Fuentes calzadas: "),
        "la maestra y los módulos regionales están disponibles hasta ",
        fc_fecha_a_trimestre(estado$fecha_dta), "."
      )
    }
  })

  output$resultado <- shiny::renderText(resultado_texto())

  shiny::observeEvent(input$generar, {
    if (isTRUE(session$userData$corriendo)) {
      shiny::showNotification("Ya hay una generación en curso.", type = "warning")
      return(invisible(NULL))
    }
    if (!length(input$formatos)) {
      shiny::showNotification("Selecciona al menos una salida.", type = "error")
      return(invisible(NULL))
    }

    estado <- fc_estado_fuentes_app()
    fecha_seleccionada <- as.Date(input$periodo)
    regiones <- switch(
      input$alcance,
      nacional = "Total nacional",
      regiones = regiones_disponibles,
      seleccion = input$regiones
    )
    if (!length(regiones)) {
      shiny::showNotification("Selecciona al menos una región.", type = "error")
      return(invisible(NULL))
    }
    if (any(regiones != "Total nacional") && fecha_seleccionada > estado$fecha_dta) {
      shiny::showNotification(
        paste0("No se pueden generar regionales para ", fc_fecha_a_trimestre(fecha_seleccionada),
               ": las variables regionales llegan hasta ", fc_fecha_a_trimestre(estado$fecha_dta), "."),
        type = "error", duration = NULL
      )
      return(invisible(NULL))
    }

    if (!dir.exists(ruta_informes)) dir.create(ruta_informes, recursive = TRUE)
    bloqueo <- file.path(ruta_informes, ".generacion_en_curso")
    if (!dir.create(bloqueo, showWarnings = FALSE)) {
      shiny::showNotification("Ya existe una generación en curso en otra sesión.", type = "warning")
      return(invisible(NULL))
    }
    on.exit(unlink(bloqueo, recursive = TRUE, force = TRUE), add = TRUE)

    session$userData$corriendo <- TRUE
    shinyjs::disable("generar")
    shinyjs::disable("convertir_pdf")
    on.exit({
      session$userData$corriendo <- FALSE
      shinyjs::enable("generar")
      shinyjs::enable("convertir_pdf")
    }, add = TRUE)

    resultado_texto("Generando minutas. Espera a que el proceso termine.")

    resultado <- tryCatch({
      ejecucion <- new.env(parent = globalenv())
      ejecucion$Trim_Actual <- format(fecha_seleccionada, "%Y%m")
      ejecucion$regiones_informes <- regiones
      ejecucion$formatos_informes <- input$formatos

      shiny::withProgress(message = "Generando minutas ENE", value = 0.2, {
        source("GeneraInformes.R", local = ejecucion, encoding = "UTF-8")
        shiny::incProgress(0.8)
      })

      ejecucion$salidas_generadas
    }, error = function(e) {
      mensaje <- conditionMessage(e)
      message("Error completo al generar minutas: ", mensaje)
      shiny::showNotification(mensaje, type = "error", duration = NULL)
      NULL
    })

    if (!is.null(resultado)) {
      n_html <- fc_abrir_html_publicados(resultado)
      resultado_texto(paste(c("Publicación completada:", basename(resultado)), collapse = "\n"))
      aviso <- if (n_html) {
        paste0("Minutas publicadas. Se abri", if (n_html == 1L) "ó " else "eron ",
               n_html, " HTML en el navegador.")
      } else {
        "Minutas publicadas."
      }
      shiny::showNotification(aviso, type = "message")
    } else {
      resultado_texto("La generación no terminó. Revisa el mensaje de error.")
    }
  })

  shiny::observeEvent(input$convertir_pdf, {
    if (isTRUE(session$userData$corriendo)) {
      shiny::showNotification("Ya hay una operación en curso.", type = "warning")
      return(invisible(NULL))
    }

    fecha_seleccionada <- as.Date(input$periodo)
    trim_actual <- format(fecha_seleccionada, "%Y%m")
    directorio_periodo <- file.path(ruta_informes, trim_actual)
    documentos <- list.files(directorio_periodo, pattern = "\\.docx$", full.names = TRUE,
                             ignore.case = TRUE)
    if (!length(documentos)) {
      shiny::showNotification(
        paste0("No hay archivos Word para convertir en ", directorio_periodo, "."),
        type = "warning"
      )
      return(invisible(NULL))
    }

    if (!dir.exists(ruta_informes)) dir.create(ruta_informes, recursive = TRUE)
    bloqueo <- file.path(ruta_informes, ".generacion_en_curso")
    if (!dir.create(bloqueo, showWarnings = FALSE)) {
      shiny::showNotification("Ya existe una operación en curso en otra sesión.", type = "warning")
      return(invisible(NULL))
    }
    on.exit(unlink(bloqueo, recursive = TRUE, force = TRUE), add = TRUE)

    session$userData$corriendo <- TRUE
    shinyjs::disable("generar")
    shinyjs::disable("convertir_pdf")
    on.exit({
      session$userData$corriendo <- FALSE
      shinyjs::enable("generar")
      shinyjs::enable("convertir_pdf")
    }, add = TRUE)

    resultado_texto("Convirtiendo Word a PDF. Puedes haber editado los DOCX antes de esta etapa.")
    resultado <- tryCatch({
      ejecucion <- new.env(parent = globalenv())
      ejecucion$Trim_Actual <- trim_actual
      shiny::withProgress(message = "Convirtiendo Word a PDF", value = 0.2, {
        source("ConviertePDF.R", local = ejecucion, encoding = "UTF-8")
        shiny::incProgress(0.8)
      })
      list.files(directorio_periodo, pattern = "\\.pdf$", full.names = TRUE,
                 ignore.case = TRUE)
    }, error = function(e) {
      mensaje <- conditionMessage(e)
      message("Error completo al convertir PDF: ", mensaje)
      shiny::showNotification(mensaje, type = "error", duration = NULL)
      NULL
    })

    if (!is.null(resultado)) {
      resultado_texto(paste(
        c("Conversión PDF completada:", basename(resultado)), collapse = "\n"
      ))
      shiny::showNotification("PDFs generados.", type = "message")
    } else {
      resultado_texto("La conversión PDF no terminó. Revisa el mensaje de error.")
    }
  })
}

shiny::shinyApp(ui, server)
