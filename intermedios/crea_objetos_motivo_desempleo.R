# crea_objetos_motivo_desempleo.R - v7 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "lubridate", "stringr", "ggplot2"))

# ── 1. Período ───────────────────────────────────────────────────────────────
# fecha_dta_efectiva viene del setup del .qmd, no se calcula acá: si el .dta
# está atrasado ya trae el último período que sí existe.
stopifnot(
  "fecha_dta_efectiva no existe — este módulo se carga desde el .qmd" =
    exists("fecha_dta_efectiva")
)
fecha_MotDes_Actual      <- fecha_dta_efectiva
fecha_MotDes_MesAnterior <- fecha_MotDes_Actual %m-% months(1)
fecha_MotDes_1anno       <- fecha_MotDes_Actual %m-% years(1)

# ── 2. Categorías ────────────────────────────────────────────────────────────
categorias_motivo_desempleo <- c(
  "Desocupados Decisión propia",
  "Desocupados Decisión de otros",
  "Desocupados Circunstancias externas"
)

# ── 3. Tabla AS — a partir del período ya definido arriba ──────────────────────
df_motivo_desempleo <- lapply(categorias_motivo_desempleo, function(cat) {
  v    <- fc_Datos_ENE(fecha_MotDes_Actual,      "AS", cat)
  prev <- fc_Datos_ENE(fecha_MotDes_MesAnterior, "AS", cat)
  anio <- fc_Datos_ENE(fecha_MotDes_1anno,       "AS", cat)
  data.frame(
    Motivo  = str_remove(cat, "^Desocupados "),
    val_act = v,
    dif_mes = v - prev,
    dif_año = v - anio,
    stringsAsFactors = FALSE
  )
}) %>% bind_rows()

# es_bueno = NA en todas: ninguna categoría tiene polaridad clara por sí sola.
ft_MotivoDesempleo <- fc_formatear_tabla(
  df_motivo_desempleo,
  # Excluyentes y sin orden natural: no son intervalos.
  filas = fc_filas_categorias(col = "Motivo"),
  columnas = list(
    Motivo  = list(tipo = "texto"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_MotDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = NA,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = NA,
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según motivo del desempleo a ",
                  fc_fecha_a_trimestre(fecha_MotDes_Actual)),
  ancho_col1 = 2.2
)

# ── 4. Segunda tabla: mismo motivo, desglosado por sexo ─────────────────────
df_motivo_desempleo_sexo <- lapply(categorias_motivo_desempleo, function(cat) {
  lapply(sexos_informe, function(sx) {
    v    <- fc_Datos_ENE(fecha_MotDes_Actual,      sx$cod, cat)
    prev <- fc_Datos_ENE(fecha_MotDes_MesAnterior, sx$cod, cat)
    anio <- fc_Datos_ENE(fecha_MotDes_1anno,       sx$cod, cat)
    data.frame(
      Motivo  = str_remove(cat, "^Desocupados "),
      Sexo    = sx$label,
      val_act = v,
      dif_mes = v - prev,
      dif_año = v - anio,
      stringsAsFactors = FALSE
    )
  }) %>% bind_rows()
}) %>% bind_rows()

ft_MotivoDesempleo_Sexo <- fc_formatear_tabla(
  df_motivo_desempleo_sexo, n_grupo = length(sexos_informe),
  filas = fc_filas_categorias_x_grupo(col = "Motivo", corte = "Sexo"),
  columnas = list(
    Motivo  = list(tipo = "texto"),
    Sexo    = list(tipo = "texto", label = " "),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_MotDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = NA,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = NA,
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según motivo del desempleo y sexo a ",
                  fc_fecha_a_trimestre(fecha_MotDes_Actual)),
  ancho_col1 = 1.8
)

# ── 5. Gráfico de series apiladas — composición histórica por motivo ───────────
# Piso histórico propio, NO fecha6annos: la serie no existe antes de JJA-2020.
# Razón documentada en MANUAL_InformeRegional.md § Desocupados: detalle.
fecha_MotDes_InicioSerie <- as.Date("2020-07-01")

# Toma 3 de los 7 tonos del set compartido. La posición no significa severidad.
colores_motivo_desempleo <- setNames(
  colores_desocupados_detalle[c(1, 3, 5)],
  c("Decisión propia", "Decisión de otros", "Circunstancias externas")
)

base_comp_motivo_desempleo <- dt_ENE_compuesta %>%
  filter(
    sexo == "AS",
    categoria %in% categorias_motivo_desempleo,
    fecha >= fecha_MotDes_InicioSerie, fecha <= fecha_MotDes_Actual
  ) %>%
  mutate(Motivo = str_remove(categoria, "^Desocupados ")) %>%
  group_by(fecha, Motivo) %>%
  summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  group_by(fecha) %>%
  mutate(pct = round(valor / sum(valor, na.rm = TRUE) * 100, 1)) %>%
  ungroup() %>%
  mutate(Motivo = factor(Motivo, levels = c(
    "Decisión propia", "Decisión de otros", "Circunstancias externas"
  )))

gr_Comp_MotivoDesempleo <- ggplot(base_comp_motivo_desempleo,
                                  aes(x = fecha, y = pct, fill = Motivo)) +
  geom_area(position = "stack", alpha = 0.85, na.rm = TRUE) +
  scale_fill_manual(values = colores_motivo_desempleo) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, NA)) +
  labs(
    title    = "Gráfico: Composición de desocupados por motivo del desempleo",
    subtitle = paste0("Participación porcentual de cada motivo en el total de desocupados, desde ",
                      fc_fecha_a_trimestre(fecha_MotDes_InicioSerie)),
    x = NULL, y = "Porcentaje", fill = "Motivo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(fill = guide_legend(nrow = 1))

message("Motivo desempleo: ft_MotivoDesempleo, ft_MotivoDesempleo_Sexo y gr_Comp_MotivoDesempleo listas (Trim_Actual = ",
        Trim_Actual, " → módulo usa ", fc_fecha_a_trimestre(fecha_MotDes_Actual),
        if (fecha_MotDes_Actual != fecha_Actual) " [rezagado]" else " [al día]")

# ── Variables narrativas para el discurso del Anexo 6 ─────────────────────────
# Ajustar si cambian los labels de sexos_informe (Parametros_ENE.R).
lbl_H <- "Hombres"
lbl_M <- "Mujeres"

# ── Hallazgos: los pide el analizador ────────────────────────────────────────
h_mot <- fc_extremo(ft_MotivoDesempleo, "val_act", "max")
Motivo_Mayor_Nivel     <- h_mot$etiqueta
Motivo_Mayor_Nivel_Pct <- h_mot$pct / 100

# Dentro de la dominante: quién lidera en nivel y quién en variación mensual.
lid_niv <- fc_lidera(ft_MotivoDesempleo_Sexo, Motivo_Mayor_Nivel, "val_act", c(lbl_H, lbl_M))
lid_mes <- fc_lidera(ft_MotivoDesempleo_Sexo, Motivo_Mayor_Nivel, "dif_mes", c(lbl_H, lbl_M))
Mot_Top_Niv_H <- lid_niv$valores[[lbl_H]]; Mot_Top_Niv_M <- lid_niv$valores[[lbl_M]]
Mot_Top_Mes_H <- lid_mes$valores[[lbl_H]]; Mot_Top_Mes_M <- lid_mes$valores[[lbl_M]]
Mot_Top_Lider_Niv <- if (lid_niv$grupo == lbl_H) "los hombres" else "las mujeres"
Mot_Top_Lider_Mes <- if (lid_mes$grupo == lbl_H) "los hombres" else "las mujeres"
Mot_Top_Coincide  <- Mot_Top_Lider_Niv == Mot_Top_Lider_Mes

# Categorías donde hombres y mujeres se mueven en direcciones opuestas.
div_mot <- fc_divergentes(ft_MotivoDesempleo_Sexo, "dif_mes", c(lbl_H, lbl_M))
Motivo_Divergentes   <- div_mot$etiquetas
Motivo_N_Divergentes <- div_mot$n

# Peso relativo de la categoría dominante: inicio de serie vs. actual
pct_mot_top <- base_comp_motivo_desempleo %>%
  filter(Motivo == Motivo_Mayor_Nivel) %>% arrange(fecha)
MotTop_Pct_Ini <- pct_mot_top$pct[1]
MotTop_Pct_Act <- pct_mot_top$pct[nrow(pct_mot_top)]

Mot_CircExt_Niv  <- fc_valor(ft_MotivoDesempleo, "Circunstancias externas", "val_act")
Mot_DecOtros_Niv <- fc_valor(ft_MotivoDesempleo, "Decisión de otros", "val_act")