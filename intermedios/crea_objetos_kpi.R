# crea_objetos_kpi.R - v7 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("flextable"))


# PORTADA — KPI destacados (c0: ft_KPI_Destacados)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════

# ── Definición de los 8 KPIs ─────────────────────────────────────────────────
# La grilla y los índices de celda están en el manual, § Portada de KPI.
kpi_lista <- list(
  
  list(
    label            = "Ocupados",
    subtitulo        = "personas ocupadas",
    valor            = Val_Act_Ocupdos_AS,
    unidad_valor     = "",
    delta_mes        = Delta_Mes_Ocupdos_AS,
    delta_año        = Delta_Año_Ocupdos_AS,
    unidad           = "personas",
    decimal          = 0,
    es_bueno_si_sube = TRUE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 3,
    estilo_mes       = 7,
    estilo_brecha    = 2,
    color            = kpi_colores[1]
  ),
  
  list(
    label            = "Tasa de desocupación",
    subtitulo        = "ambos sexos",
    valor            = Tasa_Act_TDescp_AS,
    unidad_valor     = "%",
    delta_mes        = Delta_Mes_TDescp_AS,
    delta_año        = Delta_Año_TDescp_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = TRUE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 1,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[2]
  ),
  
  list(
    label            = "Tasa de participación",
    subtitulo        = "ambos sexos",
    valor            = Tasa_Act_TPartic_AS,
    unidad_valor     = "%",
    delta_mes        = Delta_Mes_TPartic_AS,
    delta_año        = Delta_Año_TPartic_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = TRUE,
    brecha           = Brecha_Act_TPartic,
    label_brecha     = "participación masculina supera a la femenina en",
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = TRUE,
    estilo_año       = 2,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[3]
  ),
  
  list(
    label            = "Desocupación jóvenes",
    subtitulo        = "15 a 24 años",
    valor            = Tasa_Act_TDescp_J1524_AS,
    unidad_valor     = "%",
    delta_mes        = NULL,
    delta_año        = Delta_Año_TDescp_J1524_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 1,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[4]
  ),
  
  list(
    label            = "Desocupación mujeres",
    subtitulo        = "tasa femenina",
    valor            = Tasa_Act_TDescp_M,
    unidad_valor     = "%",
    delta_mes        = Delta_Mes_TDescp_M,
    delta_año        = Delta_Año_TDescp_M,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = Brecha_Act_TDescp,
    label_brecha     = "tasa femenina supera a la masculina en",
    es_bueno_brecha  = TRUE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = TRUE,
    estilo_año       = 1,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[5]
  ),
  
  list(
    label            = "Tasa de informalidad",
    subtitulo        = "ambos sexos",
    valor            = Tasa_Act_TInform_AS,
    unidad_valor     = "%",
    delta_mes        = Delta_Mes_TInform_AS,
    delta_año        = Delta_Año_TInform_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 9,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[6]
  ),
  
  list(
    label            = "Tiempo parcial involuntario",
    subtitulo        = "% sobre ocupados",
    valor            = Tasa_Act_TPI_AS,
    unidad_valor     = "%",
    delta_mes        = Delta_Mes_TPI_AS,
    delta_año        = Delta_Año_TPI_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 9,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[7]
  ),
  
  list(
    label            = "Desocupación 55 y más",
    subtitulo        = "adultos mayores",
    valor            = Tasa_Act_TDescp_M55_AS,
    unidad_valor     = "%",
    delta_mes        = NULL,
    delta_año        = Delta_Año_TDescp_M55_AS,
    unidad           = "pp.",
    decimal          = 1,
    es_bueno_si_sube = FALSE,
    brecha           = NULL,
    label_brecha     = NULL,
    es_bueno_brecha  = FALSE,
    forzar_mes       = FALSE,
    forzar_año       = TRUE,
    forzar_brecha    = FALSE,
    estilo_año       = 1,
    estilo_mes       = 5,
    estilo_brecha    = 2,
    color            = kpi_colores[8]
  )
  # Este KPI se calcula y NO se compone en la portada: es decisión, no bug.
  # Motivo en el manual, § Portada de KPI. Lo reemplaza kpi_TInform_Micro.
)

# KPI 8: Informalidad micro empresa ####
# Vive fuera de kpi_lista y ocupa su octavo slot (i=4, j=7) en el compose().

kpi_TInform_Micro <- list(
  label            = "Informalidad micro empresa",
  subtitulo        = paste0("Hasta un ", fc_Form_Num(Techo_CpropInf_Micro_AS, 1),
                            "% corresponde a cuenta propia"),
  valor            = Tasa_Act_TInform_Micro_AS,
  unidad_valor     = "%",
  delta_mes        = Delta_Mes_TInform_Micro_AS,
  delta_año        = Delta_Año_TInform_Micro_AS,
  unidad           = "pp.",
  decimal          = 1,
  es_bueno_si_sube = FALSE,
  brecha           = NULL,
  label_brecha     = NULL,
  es_bueno_brecha  = FALSE,
  forzar_mes       = FALSE,
  forzar_año       = TRUE,
  forzar_brecha    = FALSE,
  estilo_año       = 1,
  estilo_mes       = 5,
  estilo_brecha    = 2,
  color            = kpi_colores[8]
)

# ── Grilla 4 filas × 7 columnas ──────────────────────────────────────────────
df_grid <- data.frame(
  K1 = rep("", 4), S1 = rep("", 4),
  K2 = rep("", 4), S2 = rep("", 4),
  K3 = rep("", 4), S3 = rep("", 4),
  K4 = rep("", 4),
  stringsAsFactors = FALSE
)

ft_KPI_Destacados <- flextable(df_grid) %>%
  # ── 1. Eliminar header automático ────────────────────────────────────────
  delete_rows(part = "header") %>%
  # ── 2. Limpiar bordes ────────────────────────────────────────────────────
  border_remove() %>%
  # ── 3. Contenido KPIs fila 2 y 4 ────────────────────────────────────────
  compose(i = 2, j = 1, value = fc_contenido_kpi(kpi_lista[[1]])) %>%
  compose(i = 2, j = 3, value = fc_contenido_kpi(kpi_lista[[2]])) %>%
  compose(i = 2, j = 5, value = fc_contenido_kpi(kpi_lista[[3]])) %>%
  compose(i = 2, j = 7, value = fc_contenido_kpi(kpi_lista[[4]])) %>%
  compose(i = 4, j = 1, value = fc_contenido_kpi(kpi_lista[[5]])) %>%
  compose(i = 4, j = 3, value = fc_contenido_kpi(kpi_lista[[6]])) %>%
  compose(i = 4, j = 5, value = fc_contenido_kpi(kpi_lista[[7]])) %>%
  compose(i = 4, j = 7, value = fc_contenido_kpi(kpi_TInform_Micro)) %>%
  # ── 4. Anchos ────────────────────────────────────────────────────────────
  width(j = c(1, 3, 5, 7), width = 1.7) %>%
  width(j = c(2, 4, 6),    width = 0.15) %>%
  # ── 5. Alturas ───────────────────────────────────────────────────────────
  height(i = c(1, 3), height = 0.15) %>%
  fontsize(i = c(1, 3), size = 4, part = "body") %>%
  height(i = c(2, 4), height = 1.3)  %>%
  # ── 6. Color de fondo en filas de borde (i=1 y i=3) ─────────────────────
  bg(i = 1, j = 1, bg = kpi_lista[[1]]$color, part = "body") %>%
  bg(i = 1, j = 3, bg = kpi_lista[[2]]$color, part = "body") %>%
  bg(i = 1, j = 5, bg = kpi_lista[[3]]$color, part = "body") %>%
  bg(i = 1, j = 7, bg = kpi_lista[[4]]$color, part = "body") %>%
  bg(i = 3, j = 1, bg = kpi_lista[[5]]$color, part = "body") %>%
  bg(i = 3, j = 3, bg = kpi_lista[[6]]$color, part = "body") %>%
  bg(i = 3, j = 5, bg = kpi_lista[[7]]$color, part = "body") %>%
  bg(i = 3, j = 7, bg = kpi_TInform_Micro$color, part = "body") %>%
  # ── 7. Padding ───────────────────────────────────────────────────────────
  padding(i = c(1, 3), padding.top = 0, padding.bottom = 0,
          padding.left = 0, padding.right = 0, part = "body") %>%
  padding(i = c(2, 4), j = c(1, 3, 5, 7),
          padding.top = 6, padding.bottom = 8,
          padding.left = 5, padding.right = 5, part = "body") %>%
  padding(i = c(2, 4), j = c(2, 4, 6),
          padding.top = 0, padding.bottom = 0,
          padding.left = 0, padding.right = 0, part = "body") %>%
  set_table_properties(opts_word = list(split = FALSE))

# ══════════════════════════════════════════════════════════════════════════════
