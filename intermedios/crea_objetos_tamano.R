# crea_objetos_tamano.R - v8 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "lubridate", "stringr", "ggplot2", "scales"))

categorias_tamano <- c(
  "Ocupados Micro empresa",
  "Ocupados Pequeña empresa",
  "Ocupados Mediana empresa",
  "Ocupados Gran empresa",
  "Ocupados Sin clasificar por tamaño"
)

fechas_hito_tamano <- dt_ENE_compuesta %>%
  filter(
    fecha  >= fecha_inicio_tamano,
    month(fecha) == month(fecha_Actual)
  ) %>%
  pull(fecha) %>%
  unique()


# ______________________________________________________________________________
# TABLA: Ocupados por tamaño de empresa × formalidad ####
# ______________________________________________________________________________

formalidades_tamano <- list(
  list(label = "Total",    sufijo = ""),
  list(label = "Formal",   sufijo = " formal"),
  list(label = "Informal", sufijo = " informal")
)

filas_tamano <- lapply(categorias_tamano, function(cat) {
  lapply(formalidades_tamano, function(frm) {
    cat_bbdd <- paste0(cat, frm$sufijo)
    val  <- fc_Datos_ENE(fecha_Actual,      "AS", cat_bbdd)
    prev <- fc_Datos_ENE(fecha_MesAnterior, "AS", cat_bbdd)
    anio <- fc_Datos_ENE(fecha1annos,       "AS", cat_bbdd)
    data.frame(
      `Tamaño`   = cat,
      Formalidad = frm$label,
      val_act    = val,
      dif_mes    = val - prev,
      dif_año    = val - anio,
      es_bueno   = frm$label != "Informal",
      stringsAsFactors = FALSE,
      check.names      = FALSE
    )
  }) %>% bind_rows()
}) %>% bind_rows()

df_tamano <- filas_tamano %>%
  transmute(
    # Etiqueta de despliegue sin el prefijo "Ocupados": lo dice el encabezado.
    # La categoría canónica no se toca, es la llave contra el diccionario.
    grupo    = sub("^Ocupados ", "", `Tamaño`),
    brecha   = Formalidad,
    val_act, dif_mes, dif_año,
    # Variación relativa interanual. No va en la receta: viaja colgada para que
    # los superlativos del texto salgan de la tabla y no de una afirmación suelta.
    pct_año  = ifelse(val_act - dif_año == 0, NA_real_,
                      round(dif_año / (val_act - dif_año) * 100, 1)),
    es_bueno = es_bueno
  )

ft_Tamano_Formalidad <- fc_formatear_tabla(
  df_tamano, n_grupo = length(formalidades_tamano),
  # Tamaño es la dimensión principal y Formalidad la de corte.
  filas = fc_filas_categorias_x_grupo(col = "grupo", corte = "brecha"),
  columnas = list(
    grupo   = list(tipo = "texto", label = "Ocupados por tamaño"),
    brecha  = list(tipo = "texto", label = "Formalidad"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia trim.\nmóvil anterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = "es_bueno",
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste("Tabla: Ocupados por tamaño de empresa y formalidad a",
                 fc_fecha_a_trimestre(fecha_Actual)),
  ancho_col1 = 1.4)


# ______________________________________________________________________________
# BASE COMÚN: ocupados por tamaño, tres fechas ####
# ______________________________________________________________________________

base_tamano <- dt_ENE_compuesta %>%
  filter(
    sexo      == "AS",
    categoria %in% categorias_tamano,
    fecha     %in% c(fecha_Actual, fecha_MesAnterior, fecha1annos)
  ) %>%
  pivot_wider(id_cols = categoria, names_from = fecha, values_from = valor) %>%
  rename(
    val_act = as.character(fecha_Actual),
    val_mes = as.character(fecha_MesAnterior),
    val_año = as.character(fecha1annos)
  ) %>%
  mutate(
    dif_mes          = val_act - val_mes,
    dif_año          = val_act - val_año,
    `Tamaño empresa` = factor(categoria, levels = categorias_tamano)
  ) %>%
  arrange(`Tamaño empresa`) %>%
  select(`Tamaño empresa`, val_act, dif_mes, dif_año)

# ______________________________________________________________________________
# GRÁFICO 1: Barras — snapshot trimestre actual (total + franja informal) ####
# ______________________________________________________________________________

dat_informal_snap <- dt_ENE_compuesta %>%
  filter(
    sexo      == "AS",
    categoria %in% paste(categorias_tamano, "informal"),
    fecha     == fecha_Actual
  ) %>%
  mutate(
    `Tamaño empresa` = factor(
      str_remove(categoria, " informal"),
      levels = categorias_tamano
    )
  ) %>%
  select(`Tamaño empresa`, val_inf = valor)

dat_barras_tamano <- base_tamano %>%
  left_join(dat_informal_snap, by = "Tamaño empresa") %>%
  mutate(x_num = as.numeric(`Tamaño empresa`))

# Barra total centrada en X, ancho completo
# Barra informal superpuesta y desplazada 15% a la derecha
ancho_barra  <- 0.6
offset_barra <- ancho_barra * 0.15

gr_Tamano_Barras <- ggplot(dat_barras_tamano) +
  # Barra total — centrada, color pálido
  geom_col(
    aes(x = x_num, y = val_act, fill = `Tamaño empresa`),
    width = ancho_barra, alpha = 0.35
  ) +
  # Barra informal — superpuesta, desplazada 15% a la derecha, color sólido
  geom_col(
    aes(x = x_num + offset_barra, y = val_inf, fill = `Tamaño empresa`),
    width = ancho_barra, alpha = 1.0
  ) +
  # Etiqueta total — arriba barra izquierda
  geom_text(
    aes(x     = x_num,
        y     = val_act,
        label = format(round(val_act), big.mark = ".", decimal.mark = ",")),
    vjust  = -0.4, size = 2.5, family = "Arial Narrow", colour = "gray30"
  ) +
  # Etiqueta informal — arriba barra derecha
  geom_text(
    aes(x     = x_num + offset_barra,
        y     = val_inf,
        label = format(round(val_inf), big.mark = ".", decimal.mark = ",")),
    vjust  = -0.4, size = 2.5, family = "Arial Narrow", colour = "gray30"
  ) +
  # Leyenda manual — coordenadas relativas al máximo del gráfico
  annotate("rect",
           xmin = 4.55, xmax = 4.75,
           ymin = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.88,
           ymax = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.95,
           fill = "gray50", alpha = 0.3
  ) +
  annotate("text",
           x = 4.8,
           y = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.915,
           label = "Total",
           hjust = 0, size = 2.6, family = "Arial Narrow", colour = "gray30"
  ) +
  annotate("rect",
           xmin = 4.55, xmax = 4.75,
           ymin = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.76,
           ymax = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.83,
           fill = "gray50", alpha = 1.0
  ) +
  annotate("text",
           x = 4.8,
           y = max(dat_barras_tamano$val_act, na.rm = TRUE) * 0.795,
           label = "Informal",
           hjust = 0, size = 2.6, family = "Arial Narrow", colour = "gray30"
  ) +
  # La paleta se indexa por la categoría canónica; solo se limpia la etiqueta.
  scale_fill_manual(values = colores_tamano,
                    labels = function(x) sub("^Ocupados ", "", x)) +
  scale_x_continuous(
    breaks = 1:5,
    labels = sub("^Ocupados ", "", categorias_tamano)
  ) +
  scale_y_continuous(
    labels = function(x) format(x, big.mark = ".", decimal.mark = ",", scientific = FALSE),
    expand = expansion(mult = c(0, 0.16))
  ) +
  labs(
    title   = paste0("Gráfico: Ocupados según tamaño de empresa (",
                     fc_fecha_a_trimestre(fecha_Actual), ")"),
    x       = NULL,
    y       = "Miles de personas",
    caption = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(legend_pos = "none", extra = theme(
    text               = element_text(family = "Arial Narrow"),
    axis.text.x        = element_text(angle = 0, hjust = 0.5),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    plot.title         = element_text(size = 10, face = "bold", colour = col_titulo)
  ))


# GRÁFICO 2: Área 100% — Composición por tamaño, total vs informal ####
# Facetado y no dos gráficos sueltos: comparten leyenda, eje y escala, así el
# salto de la franja de microempresa entre paneles se lee de un vistazo.

dat_area_tamano <- bind_rows(
  dt_ENE_compuesta %>%
    filter(sexo == "AS", categoria %in% categorias_tamano,
           fecha >= fecha_inicio_tamano) %>%
    mutate(universo = "Total de ocupados"),
  dt_ENE_compuesta %>%
    filter(sexo == "AS", categoria %in% paste(categorias_tamano, "informal"),
           fecha >= fecha_inicio_tamano) %>%
    mutate(categoria = str_remove(categoria, " informal"),
           universo  = "Solo ocupados informales")
) %>%
  mutate(
    categoria = factor(categoria, levels = rev(categorias_tamano)),
    universo  = factor(universo, levels = c("Total de ocupados",
                                            "Solo ocupados informales"))
  )

gr_Tamano_Area_Comparada <- dat_area_tamano %>%
  ggplot(aes(x = fecha, y = valor, fill = categoria)) +
  geom_area(position = "fill", alpha = 0.85) +
  facet_wrap(~ universo, nrow = 1) +
  scale_fill_manual(
    values = colores_tamano,
    breaks = categorias_tamano,
    labels = sub("^Ocupados ", "", categorias_tamano)
  ) +
  scale_y_continuous(
    labels = scales::percent_format(accuracy = 1),
    expand = expansion(mult = c(0, 0))
  ) +
  scale_x_date(
    date_breaks = "2 years",
    date_labels = "%Y",
    expand      = expansion(mult = c(0.02, 0.02))
  ) +
  guides(fill = guide_legend(nrow = 1)) +
  labs(
    title    = "Gráfico: Composición de ocupados por tamaño de empresa",
    subtitle = paste0("Participación en el total y en el empleo informal | desde ",
                      format(fecha_inicio_tamano, "%Y")),
    x = NULL, y = NULL, fill = NULL,
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(
    text               = element_text(family = "Arial Narrow"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    panel.spacing.x    = unit(1.2, "lines"),
    strip.text         = element_text(size = 9, face = "bold", colour = col_titulo),
    plot.title         = element_text(size = 10, face = "bold", colour = col_titulo),
    plot.subtitle      = element_text(size = 7, colour = "gray40")
  ))


# ______________________________________________________________________________
# GRÁFICO 4: Líneas — Tasa de informalidad por tamaño desde 2020 ####
# ______________________________________________________________________________

dat_tasa_tamano <- dt_ENE_compuesta %>%
  filter(
    sexo      == "AS",
    categoria %in% c(categorias_tamano, paste(categorias_tamano, "informal")),
    !categoria %in% c("Ocupados Sin clasificar por tamaño", "Ocupados Sin clasificar por tamaño informal"),
    fecha     >= fecha_inicio_tamano
  ) %>%
  mutate(
    tipo = if_else(str_ends(categoria, " informal"), "informal", "total"),
    cat  = str_remove(categoria, " informal")
  ) %>%
  select(fecha, cat, tipo, valor) %>%
  pivot_wider(names_from = tipo, values_from = valor) %>%
  mutate(
    tasa      = informal / total * 100,
    categoria = factor(cat, levels = categorias_tamano)
  ) %>%
  filter(!is.na(tasa))

hitos_tasa_tamano <- dat_tasa_tamano %>%
  filter(fecha %in% fechas_hito_tamano)

gr_Tamano_Tasa_Informalidad <- dat_tasa_tamano %>%
  ggplot(aes(x = fecha, y = tasa, colour = categoria)) +
  geom_line(linewidth = 0.8) +
  geom_point(
    data = hitos_tasa_tamano,
    size = 2.0, show.legend = FALSE
  ) +
  geom_point(
    data = dat_tasa_tamano %>% filter(fecha == fecha_Actual),
    size = 2.8
  ) +
  geom_text(
    data  = dat_tasa_tamano %>% filter(fecha == fecha_Actual),
    aes(label = paste0(format(round(tasa, 1), decimal.mark = ","), "%")),
    hjust = -0.2, size = 2.8, family = "Arial Narrow", fontface = "bold"
  ) +
  scale_colour_manual(values = colores_tamano,
                      labels = function(x) sub("^Ocupados ", "", x)) +
  scale_y_continuous(
    labels = function(x) paste0(format(x, decimal.mark = ","), "%"),
    expand = expansion(mult = c(0.05, 0.1))
  ) +
  scale_x_date(
    date_breaks = "1 year",
    date_labels = "%Y",
    expand      = expansion(mult = c(0.02, 0.12))
  ) +
  labs(
    title    = "Gráfico: Tasa de informalidad por tamaño de empresa",
    subtitle = "Ocupados informales / ocupados del mismo tamaño | desde 2020",
    x        = NULL,
    y        = NULL,
    colour   = NULL,
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(
    text               = element_text(family = "Arial Narrow"),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    plot.title         = element_text(size = 10, face = "bold", colour = col_titulo),
    plot.subtitle      = element_text(size = 7, colour = "gray40")
  ))

# tot_inf_areas la construye crea_objetos_sector.R, que corre antes en el .qmd.
i_vol <- which.max(tot_inf_areas$Ocupados)
Area_Vol_Nom <- tot_inf_areas$`Área Económica`[i_vol]
Area_Vol_Val <- tot_inf_areas$Ocupados[i_vol]
Area_Vol_Pct <- Area_Vol_Val / sum(tot_inf_areas$Ocupados)

# ── Composición del cambio por tamaño ────────────────────────────────────────
# La tabla guarda la etiqueta sin prefijo: buscar por esa y no por la categoría
# canónica de la BBDD.
tamanos_lbl <- sub("^Ocupados ", "", categorias_tamano)
comp_tamano <- setNames(lapply(tamanos_lbl, function(g)
  fc_composicion_cambio(ft_Tamano_Formalidad, g, "dif_año",
                        total = "Total", partes = c("Formal", "Informal"))),
  tamanos_lbl)


c_micro <- comp_tamano[[grep("Micro",   tamanos_lbl, value = TRUE)]]
c_peq   <- comp_tamano[[grep("Pequeña", tamanos_lbl, value = TRUE)]]
c_med   <- comp_tamano[[grep("Mediana", tamanos_lbl, value = TRUE)]]
c_gran  <- comp_tamano[[grep("Gran",    tamanos_lbl, value = TRUE)]]

# Segmento con más recomposición detrás de su cifra neta
razones      <- vapply(comp_tamano, function(x) x$razon_bn %||% NA_real_, numeric(1))
Tam_MasRecomp     <- names(which.max(razones))
Tam_MasRecomp_Raz <- max(razones, na.rm = TRUE)
Tam_MasRecomp_Bru <- comp_tamano[[which.max(razones)]]$bruto

# Proporción de empleo nuevo de la microempresa que es informal
Micro_Pct_NuevoInf <- round(c_micro$partes[["Informal"]] /
                              (c_micro$partes[["Formal"]] + c_micro$partes[["Informal"]]) * 100, 0)