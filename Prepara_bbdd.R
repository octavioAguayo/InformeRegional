# Prepara_bbdd.R - v9 - 24-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "flextable"))

# flextable::compose debe pisar purrr::compose — antes de cargar cualquier script
compose <- flextable::compose

# ── Cargar la base madre y preparar la región del informe ────────────────────
# Contrato de consumidor: este proyecto solo lee dt_ENE_Master; jamás la crea,
# altera ni guarda. Se carga en un entorno aislado para no heredar objetos .RData.
dire_out <- file.path(dirname(dirname(getwd())), "Datos_Ine", "ENE", "bbdd_minuta")
ruta_master <- file.path(dire_out, "dt_ENE_Master.RData")
if (!file.exists(ruta_master)) {
  stop("No existe la maestra requerida: ", ruta_master, call. = FALSE)
}

entorno_maestra <- new.env(parent = emptyenv())
load(ruta_master, envir = entorno_maestra)
if (!exists("dt_ENE_Master", envir = entorno_maestra, inherits = FALSE)) {
  stop("La maestra no contiene el objeto dt_ENE_Master.", call. = FALSE)
}
dt_ENE_Master <- get("dt_ENE_Master", envir = entorno_maestra, inherits = FALSE)
columnas_maestra <- c("periodo", "fecha", "sexo", "sexo_label", "region",
                      "region_label", "categoria", "valor")
faltantes_maestra <- setdiff(columnas_maestra, names(dt_ENE_Master))
if (length(faltantes_maestra)) {
  stop("La maestra no cumple el contrato de columnas: faltan ",
       paste(faltantes_maestra, collapse = ", "), ".", call. = FALSE)
}
if (!nrow(dt_ENE_Master) || all(is.na(dt_ENE_Master$fecha))) {
  stop("La maestra está vacía o no contiene fechas utilizables.", call. = FALSE)
}

fc_preparar_bbdd_informe_dta(
  dt_ENE_dta   = dt_ENE_Master,
  param_region = params$region_label
)

# Referencia nacional compartida: no se vuelve a cargar la maestra en cada
# módulo territorial. Mantiene exactamente las mismas columnas que la serie
# seleccionada y permite calcular brechas regional-país de forma trazable.
dt_ENE_nacional <- dt_ENE_Master %>%
  filter(region == "TT") %>%
  select(periodo, fecha, sexo, sexo_label, region, region_label, categoria, valor)
# Vista territorial completa para rankings desagregados. dt_ENE_regional se
# mantiene en AS por compatibilidad con los anexos históricos.
dt_ENE_regional_sexo <- dt_ENE_Master %>%
  filter(region != "TT") %>%
  select(periodo, fecha, sexo, sexo_label, region, region_label, categoria, valor)
rm(dt_ENE_Master, entorno_maestra)

if (!nrow(dt_ENE_compuesta)) {
  stop("La región solicitada no tiene datos en la maestra: ",
       params$region_label, call. = FALSE)
}
if (!nrow(dt_ENE_nacional)) {
  stop("La maestra no contiene la referencia Total nacional requerida.", call. = FALSE)
}
if (!nrow(dt_ENE_regional_sexo)) {
  stop("La maestra no contiene regiones para los rankings territoriales.", call. = FALSE)
}
if (!fecha_Actual %in% dt_ENE_compuesta$fecha) {
  stop("El período solicitado ", format(fecha_Actual),
       " no está disponible para ", params$region_label, ".", call. = FALSE)
}

# ── Frontera temporal de las fuentes ──────────────────────────────────────────
frontera_fuentes   <- fc_frontera_fuentes(dt_ENE_regional, fecha_Actual)
fecha_max_dta      <- frontera_fuentes$dta
fecha_dta_efectiva <- frontera_fuentes$efectiva
dta_rezagado       <- frontera_fuentes$rezagado


# ── Datos base compartidos — formato ancho para tablas de cambio ──────────────
# res_completo es intermedio: nadie lo consume fuera de este archivo.
tmp_ENE_fechas <- dt_ENE_compuesta %>% filter(fecha %in% Fechas)

res_completo <- tmp_ENE_fechas %>%
  mutate(valor = round(valor, 1)) %>%
  pivot_wider(
    id_cols     = c(sexo, categoria),
    names_from  = fecha,
    values_from = valor
  )

res_filtrado <- res_completo %>%
  inner_join(filtro_tabla, by = "categoria") %>%
  mutate(across(where(is.numeric),
                ~ if_else(tipo_valor == "stock", round(., 0), round(., 1)))) %>%
  arrange(sexo, indice) %>%
  select(-indice)
