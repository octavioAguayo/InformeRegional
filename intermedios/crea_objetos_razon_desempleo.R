# crea_objetos_razon_desempleo.R - v7 - 12-08-2026

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
fecha_RazDes_Actual      <- fecha_dta_efectiva
fecha_RazDes_MesAnterior <- fecha_RazDes_Actual %m-% months(1)
fecha_RazDes_1anno       <- fecha_RazDes_Actual %m-% years(1)

# ── 2. Categorías ────────────────────────────────────────────────────────────
categorias_razon_desempleo <- c(
  "Desocupados Despido",
  "Desocupados Renuncia",
  "Desocupados Jubilación",
  "Desocupados Fin del contrato o proyecto",
  "Desocupados Quiebra",
  "Desocupados Otras"  
)

# ── 3. Tabla AS — a partir del período ya definido arriba ──────────────────────
df_razon_desempleo <- lapply(categorias_razon_desempleo, function(cat) {
  v    <- fc_Datos_ENE(fecha_RazDes_Actual,      "AS", cat)
  prev <- fc_Datos_ENE(fecha_RazDes_MesAnterior, "AS", cat)
  anio <- fc_Datos_ENE(fecha_RazDes_1anno,       "AS", cat)
  data.frame(
    Razon   = str_remove(cat, "^Desocupados "),
    val_act = v,
    dif_mes = v - prev,
    dif_año = v - anio,
    stringsAsFactors = FALSE
  )
}) %>% bind_rows()

# Polaridad por fila, no por tabla: solo Despido y Quiebra tienen lectura clara.
# El resto va NA. Criterio por categoría en el manual, § Desocupados: detalle.
razon_es_bueno <- c(
  "Despido"                     = FALSE,
  "Renuncia"                    = NA,
  "Jubilación"                  = NA,
  "Fin del contrato o proyecto" = NA,
  "Quiebra"                     = FALSE,
  "Otras"                       = NA
)
df_razon_desempleo$es_bueno <- razon_es_bueno[df_razon_desempleo$Razon]

# abs_mes va en los datos y no en la receta: así viaja colgada sin imprimirse.
df_razon_desempleo$abs_mes <- abs(df_razon_desempleo$dif_mes)

ft_RazonDesempleo <- fc_formatear_tabla(
  df_razon_desempleo,
  # Excluyentes y sin orden natural: no son intervalos.
  filas = fc_filas_categorias(col = "Razon"),
  columnas = list(
    Razon   = list(tipo = "texto"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_RazDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según razón de fin de trabajo a ",
                  fc_fecha_a_trimestre(fecha_RazDes_Actual)),
  ancho_col1 = 2.4
)

# ── 4. Segunda tabla: misma razón, desglosada por sexo ──────────────────────
df_razon_desempleo_sexo <- lapply(categorias_razon_desempleo, function(cat) {
  lapply(sexos_informe, function(sx) {
    v    <- fc_Datos_ENE(fecha_RazDes_Actual,      sx$cod, cat)
    prev <- fc_Datos_ENE(fecha_RazDes_MesAnterior, sx$cod, cat)
    anio <- fc_Datos_ENE(fecha_RazDes_1anno,       sx$cod, cat)
    data.frame(
      Razon   = str_remove(cat, "^Desocupados "),
      Sexo    = sx$label,
      val_act = v,
      dif_mes = v - prev,
      dif_año = v - anio,
      stringsAsFactors = FALSE
    )
  }) %>% bind_rows()
}) %>% bind_rows()
df_razon_desempleo_sexo$es_bueno <- razon_es_bueno[df_razon_desempleo_sexo$Razon]

ft_RazonDesempleo_Sexo <- fc_formatear_tabla(
  df_razon_desempleo_sexo, n_grupo = length(sexos_informe),
  filas = fc_filas_categorias_x_grupo(col = "Razon", corte = "Sexo"),
  columnas = list(
    Razon   = list(tipo = "texto"),
    Sexo    = list(tipo = "texto", label = " "),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_RazDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según razón de fin de trabajo y sexo a ",
                  fc_fecha_a_trimestre(fecha_RazDes_Actual)),
  ancho_col1 = 2.0
)

# ── 5. Gráfico de series apiladas — composición histórica por razón ────────────
# Mismo piso histórico que motivo, NO fecha6annos. Razón en el manual,
# § Desocupados: detalle.
fecha_RazDes_InicioSerie <- as.Date("2020-07-01")

colores_razon_desempleo <- setNames(
  colores_desocupados_detalle[c(1, 2, 3, 4, 5, 6)],
  c("Despido", "Renuncia", "Jubilación", "Fin del contrato o proyecto", "Quiebra", "Otras")
)

base_comp_razon_desempleo <- dt_ENE_compuesta %>%
  filter(
    sexo == "AS",
    categoria %in% categorias_razon_desempleo,
    fecha >= fecha_RazDes_InicioSerie, fecha <= fecha_RazDes_Actual
  ) %>%
  mutate(Razon = str_remove(categoria, "^Desocupados ")) %>%
  group_by(fecha, Razon) %>%
  summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  group_by(fecha) %>%
  mutate(pct = round(valor / sum(valor, na.rm = TRUE) * 100, 1)) %>%
  ungroup() %>%
  mutate(Razon = factor(Razon, levels = c(
    "Despido", "Renuncia", "Jubilación", "Fin del contrato o proyecto", "Quiebra", "Otras"
  )))

gr_Comp_RazonDesempleo <- ggplot(base_comp_razon_desempleo,
                                 aes(x = fecha, y = pct, fill = Razon)) +
  geom_area(position = "stack", alpha = 0.85, na.rm = TRUE) +
  scale_fill_manual(values = colores_razon_desempleo) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, NA)) +
  labs(
    title    = "Gráfico: Composición de desocupados por razón de fin de trabajo",
    subtitle = paste0("Participación porcentual de cada razón en el total de desocupados, desde ",
                      fc_fecha_a_trimestre(fecha_RazDes_InicioSerie)),
    x = NULL, y = "Porcentaje", fill = "Razón",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(fill = guide_legend(nrow = 2))

message("Razón desempleo: ft_RazonDesempleo, ft_RazonDesempleo_Sexo y gr_Comp_RazonDesempleo listas (Trim_Actual = ",
        Trim_Actual, " → módulo usa ", fc_fecha_a_trimestre(fecha_RazDes_Actual),
        if (fecha_RazDes_Actual != fecha_Actual) " [rezagado]" else " [al día]")

# ── Variables narrativas para el discurso del Anexo 7 ─────────────────────────
# Ajustar si cambian los labels de sexos_informe (Parametros_ENE.R).
lbl_H <- "Hombres"
lbl_M <- "Mujeres"

# ── Hallazgos: los pide el analizador ────────────────────────────────────────
sx <- c(lbl_H, lbl_M)

# Categoría con mayor movimiento trimestral, en valor absoluto.
h_mov <- fc_extremo(ft_RazonDesempleo, "abs_mes", "max")
Razon_MayorMovMes       <- h_mov$etiqueta
Razon_MayorMovMes_Valor <- fc_valor(ft_RazonDesempleo, Razon_MayorMovMes, "dif_mes")

# Dentro de esa categoría: quién lidera en nivel y quién en variación.
lid_niv <- fc_lidera(ft_RazonDesempleo_Sexo, Razon_MayorMovMes, "val_act", sx)
lid_mes <- fc_lidera(ft_RazonDesempleo_Sexo, Razon_MayorMovMes, "dif_mes", sx)
Razon_Top_Nivel_H  <- lid_niv$valores[[lbl_H]]; Razon_Top_Nivel_M  <- lid_niv$valores[[lbl_M]]
Razon_Top_DifMes_H <- lid_mes$valores[[lbl_H]]; Razon_Top_DifMes_M <- lid_mes$valores[[lbl_M]]
Razon_Top_Lider_Nivel  <- if (lid_niv$grupo == lbl_H) "los hombres" else "las mujeres"
Razon_Top_Lider_DifMes <- if (lid_mes$grupo == lbl_H) "los hombres" else "las mujeres"
Razon_Top_Coincide     <- Razon_Top_Lider_Nivel == Razon_Top_Lider_DifMes

Razon_Jubil_H <- fc_valor(ft_RazonDesempleo_Sexo, "Jubilación", "val_act", lbl_H)
Razon_Jubil_M <- fc_valor(ft_RazonDesempleo_Sexo, "Jubilación", "val_act", lbl_M)

# Umbral de 20.000: sin él se destacan inversiones sobre bases marginales.
razon_niv <- data.frame(
  Razon = fc_etiquetas(ft_RazonDesempleo),
  H = vapply(fc_etiquetas(ft_RazonDesempleo),
             function(r) fc_valor(ft_RazonDesempleo_Sexo, r, "val_act", lbl_H), numeric(1)),
  M = vapply(fc_etiquetas(ft_RazonDesempleo),
             function(r) fc_valor(ft_RazonDesempleo_Sexo, r, "val_act", lbl_M), numeric(1)),
  stringsAsFactors = FALSE)
razon_niv$total <- razon_niv$H + razon_niv$M

Razon_Invertidas <- razon_niv$Razon[razon_niv$M > razon_niv$H & razon_niv$total >= 20000]
Razon_Invertida_Top <- if (length(Razon_Invertidas)) {
  sel <- match(Razon_Invertidas, razon_niv$Razon)
  Razon_Invertidas[which.max(razon_niv$M[sel] / razon_niv$H[sel])]
} else NA_character_
Razon_Inv_H <- if (!is.na(Razon_Invertida_Top))
  fc_valor(ft_RazonDesempleo_Sexo, Razon_Invertida_Top, "val_act", lbl_H) else NA_real_
Razon_Inv_M <- if (!is.na(Razon_Invertida_Top))
  fc_valor(ft_RazonDesempleo_Sexo, Razon_Invertida_Top, "val_act", lbl_M) else NA_real_

# Peso relativo de Jubilación: inicio de serie vs. trimestre actual.
pct_jubil <- base_comp_razon_desempleo %>%
  filter(Razon == "Jubilación") %>% arrange(fecha)
Jubil_Pct_Ini   <- pct_jubil$pct[1]
Jubil_Pct_Act   <- pct_jubil$pct[nrow(pct_jubil)]
Jubil_Pct_Delta <- Jubil_Pct_Act - Jubil_Pct_Ini

h_niv <- fc_extremo(ft_RazonDesempleo, "val_act", "max")
Razon_Mayor_Nivel     <- h_niv$etiqueta
Razon_Mayor_Nivel_Pct <- h_niv$pct / 100

ord_mes <- order(fc_cuerpo(ft_RazonDesempleo)$abs_mes, decreasing = TRUE)
Razon_MovMes_1 <- fc_cuerpo(ft_RazonDesempleo)$abs_mes[ord_mes[1]]
Razon_MovMes_2 <- fc_cuerpo(ft_RazonDesempleo)$abs_mes[ord_mes[2]]

c_baja <- fc_cuantas(ft_RazonDesempleo, "dif_año", function(x) x < 0)
Razon_N_Baja_Anual <- c_baja$n
Razon_Baja_Anual   <- paste(c_baja$etiquetas, collapse = ", ")
