# Parametros_ENE.R - v7 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("lubridate", "stringr"))

# ── PERILLA MAESTRA ───────────────────────────────────────────────────────────
# Trim_Actual se define en GeneraInformes.R y llega por execute_params. Acá solo
# se consume: no lo definas en este archivo o el informe ignorará el parámetro.
stopifnot("Trim_Actual debe existir antes de cargar Parametros_ENE.R" =
            exists("Trim_Actual"))


# ── FECHAS FUENTE (ancla estáticas) ──────────────────────────────────────────
# Período base: punto de comparación de mediano plazo.
fecha_periodo_base <- make_date(year = 2026, month = 2, day = 1)

# Referencias COVID — agrupadas para poder jubilarlas de un solo bloque.
fecha_Inicio_Covid <- make_date(year = 2020, month = 2, day = 1)
fecha_Centro_Covid <- make_date(year = 2020, month = 6, day = 1)
fecha_Fin_Covid    <- make_date(year = 2022, month = 2, day = 1)

# Inicio de la serie de formalidad (dato estructural de la ENE)
fecha_Formalidad   <- make_date(year = 2017, month = 8, day = 1)


# ── FECHAS DERIVADAS (calculadas desde Trim_Actual) ──────────────────────────
fecha_Actual        <- make_date(
  year  = as.integer(str_sub(Trim_Actual, 1, 4)),
  month = as.integer(str_sub(Trim_Actual, 5, 6)),
  day   = 1L
)
fecha1annos         <- fecha_Actual %m-% years(1)
fecha2annos         <- fecha_Actual %m-% years(2)
fecha3annos         <- fecha_Actual %m-% years(3)
fecha4annos         <- fecha_Actual %m-% years(4)
fecha5annos         <- fecha_Actual %m-% years(5)
fecha6annos         <- fecha_Actual %m-% years(6)
fecha7annos         <- fecha_Actual %m-% years(7)
fecha8annos         <- fecha_Actual %m-% years(8)
fecha9annos         <- fecha_Actual %m-% years(9)
fecha10annos        <- fecha_Actual %m-% years(10)
fecha11annos        <- fecha_Actual %m-% years(11)
fecha12annos        <- fecha_Actual %m-% years(12)
fecha13annos        <- fecha_Actual %m-% years(13)
fecha_MesAnterior   <- fecha_Actual %m-% months(1)

# Fórmula, no constante: se recalcula sola cada trimestre. La distancia a hoy es
# -6 o -7 años según el mes central, y eso es correcto — no la cablees.
fecha_Pre_Covid     <- fecha_Actual
while (fecha_Pre_Covid > fecha_Inicio_Covid)
  fecha_Pre_Covid   <- fecha_Pre_Covid %m-% years(1)

# Nombres de elementos INTACTOS: cortes y otros acceden con Fechas["..."]
Fechas <- c(
  actual        = fecha_Actual,
  a_1_anno      = fecha1annos,
  a_2_annos     = fecha2annos,
  a_3_annos     = fecha3annos,
  a_4_annos     = fecha4annos,
  a_5_annos     = fecha5annos,
  a_6_annos     = fecha6annos,
  a_7_annos     = fecha7annos,
  a_8_annos     = fecha8annos,
  a_9_annos     = fecha9annos,
  a_10_annos    = fecha10annos,
  a_11_annos    = fecha11annos,
  a_12_annos    = fecha12annos,
  a_13_annos    = fecha13annos,
  mes_anterior  = fecha_MesAnterior,
  inicio_gob    = fecha_periodo_base,
  inicio_covid  = fecha_Inicio_Covid,
  pre_covid     = fecha_Pre_Covid,
  Fin_Covid     = fecha_Fin_Covid,
  fecha_Covid   = fecha_Centro_Covid
)

# c() sobre Dates descarta la clase y rompe el filtro de Prepara_bbdd.R sin decir
# por qué. Esta línea la restituye: no la borres ni muevas arriba del c().
Fechas <- setNames(as.Date(unname(Fechas), origin = "1970-01-01"), names(Fechas))
stopifnot(inherits(Fechas, "Date"), !anyNA(Fechas))


# ── ESTÉTICA ──────────────────────────────────────────────────────────────────
# Paleta semántica: verde = bueno | rojo = malo | azul = neutro. Fuente de verdad.
col_bueno  <- "#27ae60"
col_malo   <- "#e74c3c"
col_neutro <- "#2980b9"

# Gama apagada, deliberadamente distinta de la semántica: categoría no es juicio.
col_sexo_hombres <- "#5DADE2"   # celeste
col_sexo_mujeres <- "#58D68D"   # verde claro
col_sexo_total   <- "#7E57C2"
#col_sexo_total  <- "#AF7AC5"   # morado suave (alternativa)

colores_sexo <- c(
  "Hombres"     = col_sexo_hombres,
  "Mujeres"     = col_sexo_mujeres,
  "Ambos sexos" = col_sexo_total
)


# Código semántico propio del informe: NARANJA = informalidad
# (consistente en gr4/gr6; el rojo queda reservado para "malo"/brecha)
col_informal <- "#E6550D"

# ── PALETAS DE CONTENIDO ──────────────────────────────────────────────────────
# Los módulos las consumen por nombre y NO deben redefinirlas localmente.
# Rampa ordinal: menor a mayor tamaño, micro en el tono más oscuro.
colores_tamano <- c(
  "Ocupados Micro empresa"             = "#08519C",
  "Ocupados Pequeña empresa"           = "#3182BD",
  "Ocupados Mediana empresa"           = "#6BAED6",
  "Ocupados Gran empresa"              = "#BDD7E7",
  "Ocupados Sin clasificar por tamaño" = "#BFBFBF"
)

# Color institucional de títulos (gráficos y tablas).
col_titulo <- "#1a5276"

# Paleta de los 8 KPI de portada.
kpi_colores <- c(
  "#e67e22",  # 1 Ocupados         — naranja
  "#17a589",  # 2 T. desocupación  — verde agua
  "#2e86c1",  # 3 T. participación — azul
  "#d4ac0d",  # 4 Desocup. jóvenes — dorado
  "#cb4335",  # 5 Desocup. mujeres — coral
  "#8e44ad",  # 6 T. informalidad  — púrpura
  "#16a085",  # 7 Tasa TPI         — turquesa
  "#2e86c1"   # 8 Informalidad micro empresa — azul
)

# Informalidad: relleno (gr4/gr6) y variante oscura para puntos/etiquetas.
colores_gr4 <- c(
  "Ocupados formal"          = "#1B7837",
  "Resto ocupados informales"  = "#FDAE61",
  "Asalariados informales"     = "#EB8C1B",
  "Cuenta propia informal"   = "#B35806"
)
colores_gr4_punto <- c(
  "Ocupados formal"          = "#145a22",
  "Resto ocupados informales"  = "#d48000",
  "Asalariados informales"     = "#a05c00",
  "Cuenta propia informal"   = "#7f3e00"
)

# Rampa ordinal: claro = joven, oscuro = mayor. Incluye "Total" de los gráficos
# A/B, que sin él cae en los defaults de ggplot.
colores_edad <- c(
  "Jóvenes 15-24"     = "#D7BDE2",
  "Intermedios 25-54" = "#8E44AD",
  "55 años y más"     = "#4A235A",
  "Total"             = "#7F8C8D"
)

# Los consumidores toman tail(colores_periodos, n_fechas), así que el orden
# importa: la fecha actual va al final y siempre queda con el tono destacado.
colores_periodos <- c("#D5D8DC", "#ABB2B9", "#7F8C8D", "#4A235A")

# Set NO nombrado por diseño: cada módulo de la familia "Desocupados: detalle"
# lo aplica a sus propios niveles, y la posición no significa lo mismo entre los 3.
colores_desocupados_detalle <- c("#1a9850", "#91cf60", "#d9ef8b", "#fee08b", "#fc8d59", "#e34a33", "#d73027")


# ── CONFIGURACIÓN DE INDICADORES (Tabla 1 y base res_filtrado) ────────────────
# tipo_valor fija los decimales (stock = 0 / tasa = 1) y es_bueno_si_sube la
# polaridad que consume color_delta(); NA = neutro. tibble:: explícito a propósito.
filtro_tabla <- tibble::tribble(
  ~categoria,              ~categoriaNombre,                    ~tipo_valor,  ~es_bueno_si_sube,
  "Población en edad de trabajar",         "PET",                               "stock",      TRUE,
  "Fuerza de trabajo",                    "Fuerza de Trabajo",                 "stock",      TRUE,
  "Ocupados",              "Ocupados",                          "stock",      TRUE,
  "Desocupados",           "Desocupados",                       "stock",      FALSE,
  "Ocupados formal",     "Ocupados Formales",                 "stock",      TRUE,
  "Ocupados sector privado",       "Ocupados sin Asalariados Públicos", "stock",      TRUE,
  "Asalariados privados",  "Asalariados Privados",              "stock",      TRUE,
  "Asalariados públicos",   "Asalariados Públicos",              "stock",      NA,
  "Tasa de desocupación",        "Tasa de Desocupación",              "tasa",       FALSE,
  "Tasa de ocupación informal",            "Tasa de Ocupación Informal",        "tasa",       FALSE,
  "Tasa de ocupación",           "Tasa de Ocupación",                 "tasa",       TRUE,
  "Tasa de participación",       "Tasa de Participación",             "tasa",       TRUE
)
filtro_tabla$indice <- seq_len(nrow(filtro_tabla))

# Mismo contrato que filtro_tabla, con los códigos _d de la maestra. Solo AS/H/M.
filtro_tabla_desest <- tibble::tribble(
  ~categoria,           ~categoriaNombre,                  ~tipo_valor,  ~es_bueno_si_sube,
  "Fuerza de trabajo desestacionalizado",               "Fuerza de Trabajo desest.",     "stock",      TRUE,
  "Ocupados desestacionalizado",                        "Ocupados desest.",              "stock",      TRUE,
  "Desocupados desestacionalizado",                     "Desocupados desest.",           "stock",      FALSE,
  "Tasa de desocupación desestacionalizado",            "Tasa de Desocupación desest.",  "tasa",       FALSE,
  "Tasa de participación desestacionalizado",           "Tasa de Participación desest.", "tasa",       TRUE
)
filtro_tabla_desest$indice <- seq_len(nrow(filtro_tabla_desest))

# Desagregación por sexo estándar de las tablas multi-indicador.
sexos_informe <- list(
  list(label = "Total (ambos sexos)", cod = "AS"),
  list(label = "Hombres",             cod = "H"),
  list(label = "Mujeres",             cod = "M")
)

# La consume fc_tema_grafico(): único lugar para redimensionar todos los gráficos.
tam_grafico <- c(
  base           = 10,   # tamaño base de todo el texto del gráfico
  leyenda_titulo = 9,
  leyenda_texto  = 8,
  nota           = 8     # plot.caption (fuente al pie)
)

# ── SUPUESTOS METODOLÓGICOS ───────────────────────────────────────────────────
# Cortes para regresiones por tramos estructurales (pre / intra / post-COVID).
cortes <- data.frame(
  inicio = c(as.Date("2010-02-01"), as.Date("2013-01-01"), Fechas["Fin_Covid"]),
  fin    = c(as.Date("2012-12-01"), Fechas["inicio_covid"] %m-% months(1), Fechas["actual"])
)

# Fecha de inicio del gráfico de líneas por tamaño de empresa
fecha_inicio_tamano <- as.Date("2020-01-01")

# ── TRAMOS ETARIOS (supuesto metodológico) ────────────────────────────────────
# ÚNICA definición de los 12 tramos ENE. NO redefinir listas localmente: para
# mover un corte (ej. jóvenes hasta 29) basta ajustar los índices de acá abajo.
tramos_ene <- c(
  "15 a 19 años", "20 a 24 años", "25 a 29 años", "30 a 34 años",
  "35 a 39 años", "40 a 44 años", "45 a 49 años", "50 a 54 años",
  "55 a 59 años", "60 a 64 años", "65 a 69 años", "70 años o más"
)
tramos_edad_jovenes     <- tramos_ene[1:2]    # 15-24
tramos_edad_intermedios <- tramos_ene[3:8]    # 25-54
tramos_edad_mayores     <- tramos_ene[9:12]   # 55 y más

# ── Composición de categorías con tramo etario ────────────────────────────────
# El separador se declara acá una sola vez. Si un módulo lo tipea aparte y no
# calza con el canon, no falla: devuelve cero filas.
SEP_CAT <- " "

fc_cat_tramo <- function(bases, tramos) {
  paste(rep(bases, each = length(tramos)), tramos, sep = SEP_CAT)
}