# crea_objetos_formalidad.R - v3 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "lubridate", "ggplot2", "ggpp", "scales"))

# GRÁFICO 4: Ocupados por formalidad detallada desde JAS-2017 ####
# ______________________________________________________________________________

cats_gr4_detalle <- c(
  "Ocupados informal", "Ocupados formal",
  "Cuenta propia informal",
  "Asalariados privados informal", "Asalariados públicos informal"
)

base_gr4_wide <- dt_ENE_compuesta %>%
  filter(sexo_label == "Ambos sexos", categoria %in% cats_gr4_detalle) %>%
  pivot_wider(names_from = categoria, values_from = valor) %>%
  arrange(fecha) %>%
  mutate(
    `Asalariados informales`    = `Asalariados privados informal` + `Asalariados públicos informal`,
    `Resto ocupados informales` = `Ocupados informal` - `Cuenta propia informal` - `Asalariados informales`
  ) %>%
  filter(fecha >= fecha_Formalidad)

base_gr4_ocup_form <- base_gr4_wide %>%
  select(fecha,
         `Ocupados formal`,
         `Resto ocupados informales`,
         `Asalariados informales`,
         `Cuenta propia informal`) %>%
  pivot_longer(-fecha, names_to = "categoria", values_to = "valor") %>%
  mutate(categoria = factor(categoria, levels = c(
    "Ocupados formal",
    "Resto ocupados informales",
    "Asalariados informales",
    "Cuenta propia informal"
  )))

base_gr4_apilada <- base_gr4_ocup_form %>%
  mutate(categoria = factor(categoria, levels = rev(levels(categoria)))) %>%
  arrange(fecha, categoria) %>%
  group_by(fecha) %>%
  mutate(y_pos = cumsum(valor)) %>%
  mutate(categoria = factor(categoria, levels = rev(levels(categoria)))) %>%
  ungroup()

puntos_gr4_ocup <- base_gr4_apilada %>%
  filter(fecha %in% Fechas[c("actual", "a_1_anno", "a_2_annos", "a_3_annos", "a_4_annos",
                             "a_5_annos", "fecha_Covid", "a_6_annos", "a_7_annos", "a_8_annos",
                             "a_9_annos", "a_10_annos")])

# ══════════════════════════════════════════════════════════════════════════════
# CAPÍTULO 3.3 — Evolución de la ocupación (c3s3: g4–g7)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


gr_Ocupacion_2017_Actual <- base_gr4_ocup_form %>%
  ggplot(aes(x = fecha, y = valor, fill = categoria)) +
  geom_area(position = "stack", alpha = 0.8) +
  geom_point(data = puntos_gr4_ocup,
             aes(x = fecha, y = y_pos, color = categoria),
             size = 2.5, show.legend = FALSE) +
  geom_label(data = puntos_gr4_ocup,
             aes(x = fecha, y = y_pos, color = categoria,
                 label = scales::comma(round(valor / 1000, 0), big.mark = ".", decimal.mark = ",")),
             size = 2.0, fontface = "bold", label.padding = unit(0.12, "lines"),
             fill = "white", show.legend = FALSE, vjust = -0.6) +
  scale_fill_manual(values  = colores_gr4) +
  scale_color_manual(values = colores_gr4_punto) +
  scale_y_continuous(labels = scales::comma_format(big.mark = ".", decimal.mark = ",")) +
  scale_x_date(date_breaks = "6 months", date_labels = "%b\n%Y") +
  labs(
    title    = "Gráfico: Personas ocupadas en Chile: JAS-2017 a la fecha",
    subtitle = "Desglose de Ocupados por Formalidad e Informalidad",
    x = NULL, y = "Personas", fill = "Categoría",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(legend_pos = "right",
                  extra = theme(panel.grid.minor = element_blank())) +
  guides(fill  = guide_legend(ncol = 1, byrow = TRUE, label.hjust = 0),
         color = "none")

# ______________________________________________________________________________
# GRÁFICO 5: Variación 12 meses ocupados por formalidad ####
# ______________________________________________________________________________

base_gr6_ocup_form_12m <- dt_ENE_compuesta %>%
  filter(
    categoria  %in% c("Ocupados formal", "Ocupados informal"),
    sexo_label == "Ambos sexos"
  ) %>%
  mutate(fecha = as.Date(fecha)) %>%
  group_by(categoria, fecha) %>%
  summarise(valorOri = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  arrange(categoria, fecha) %>%
  group_by(categoria) %>%
  mutate(
    valor_12m_antes = dplyr::lag(valorOri, 12),
    valor           = valorOri - valor_12m_antes
  ) %>%
  ungroup() %>%
  filter(fecha >= as.Date("2019-01-01"))

colores_gr6 <- c("Ocupados formal" = col_bueno, "Ocupados informal" = col_informal)

puntos_gr6_ocup_12m <- base_gr6_ocup_form_12m %>%
  group_by(categoria) %>%
  filter(fecha %in% Fechas[c("actual", "a_1_anno", "a_2_annos", "a_3_annos",
                             "a_4_annos", "a_5_annos", "a_6_annos", "a_7_annos")]) %>%
  ungroup()

tabla_interna_gr6 <- puntos_gr6_ocup_12m %>%
  select(fecha, Categoría = categoria, valor) %>%
  mutate(valor = round(valor, 0), fecha = format(fecha, "%Y-%m")) %>%
  pivot_wider(names_from = fecha, values_from = valor) %>%
  bind_rows(summarise(., Categoría = "Deficit-Superávit",
                      across(where(is.numeric), sum, na.rm = TRUE)))

tabla_interna_gr6_fmt <- tabla_interna_gr6 %>%
  mutate(across(where(is.numeric),
                ~ formatC(.x, format = "f", digits = 0, big.mark = ".", decimal.mark = ",")))

tema_tabla_gr6 <- fc_crear_tema_tabla(tabla_interna_gr6_fmt)
x_pos_gr6 <- min(base_gr6_ocup_form_12m$fecha) %m+% months(18)
y_pos_gr6 <- max(base_gr6_ocup_form_12m$valor) * 0.95

gr_Delta_Ocupados_Inf_12m <- base_gr6_ocup_form_12m %>%
  ggplot(aes(x = fecha, y = valor, fill = categoria)) +
  geom_col(position = "stack", alpha = 0.8, color = NA) +
  scale_fill_manual(values = colores_gr6) +
  labs(
    title    = "Gráfico: Desglose Ocupados medidos en Cambio 12 meses",
    subtitle = "Separados por formalidad",
    x = "Fecha", y = "Valor", fill = "Categoría"
  ) +
  fc_tema_grafico(legend_pos = "right", extra = theme(
    legend.box        = "vertical",
    legend.spacing.y  = unit(0.3, "cm"),
    legend.text.align = 0
  )) +
  guides(fill = guide_legend(ncol = 1, byrow = TRUE, label.hjust = 0,
                             title.position = "top", title.hjust = 0.5)) +
  geom_table(
    data = data.frame(x = x_pos_gr6, y = y_pos_gr6),
    aes(x = x, y = y, label = list(tabla_interna_gr6_fmt)),
    table.theme = tema_tabla_gr6,
    vjust = 4, hjust = -0.2
  ) +
  expand_limits(y = c(y_pos_gr6 - 5, NA))

# ______________________________________________________________________________
# GRÁFICO 6: Tasa asalariados dependientes informales por sexo ####
# ______________________________________________________________________________

base_gr7_asal_dep_inf <- dt_ENE_compuesta %>%
  filter(sexo %in% c("AS", "H", "M"),
         categoria %in% c("Asalariados dependientes informal", "Asalariados dependientes")) %>%
  pivot_wider(names_from = categoria, values_from = valor) %>%
  filter(!is.na(`Asalariados dependientes informal`), !is.na(`Asalariados dependientes`), `Asalariados dependientes` > 0) %>%
  mutate(
    tasa       = round(`Asalariados dependientes informal` / `Asalariados dependientes` * 100, 1),
    sexo_label = factor(sexo, levels = c("H", "M", "AS"),
                        labels = c("Tasa hombres", "Tasa mujeres", "Tasa total país"))
  ) %>%
  arrange(sexo_label, fecha)

fechas_puntos_gr7 <- Fechas[c("actual", "a_1_anno", "a_2_annos", "a_3_annos", "a_4_annos",
                              "a_5_annos", "a_6_annos", "a_7_annos", "a_8_annos",
                              "a_9_annos", "a_10_annos")]
puntos_gr7_asal <- base_gr7_asal_dep_inf %>% filter(fecha %in% fechas_puntos_gr7)

colores_gr7 <- c("Tasa hombres"    = col_sexo_hombres,
                 "Tasa mujeres"    = col_sexo_mujeres,
                 "Tasa total país" = col_sexo_total)

gr_asal_dep_inf_Sexo <- base_gr7_asal_dep_inf %>%
  ggplot(aes(x = fecha, y = tasa, color = sexo_label)) +
  geom_line(linewidth = 0.7) +
  geom_point(data = puntos_gr7_asal, aes(x = fecha, y = tasa),
             size = 2.5, show.legend = FALSE) +
  geom_label(data = puntos_gr7_asal,
             aes(x = fecha, y = tasa, label = paste0(format(tasa, nsmall = 1), "%")),
             size = 2.2, fontface = "bold", label.padding = unit(0.15, "lines"),
             show.legend = FALSE, vjust = -0.6) +
  scale_color_manual(values = colores_gr7) +
  scale_y_continuous(labels = scales::percent_format(scale = 1, suffix = "%")) +
  scale_x_date(date_breaks = "3 months", date_labels = "%b\n%Y") +
  labs(
    title    = "Gráfico: Evolución tasa asalariados informales según sexo y total país",
    subtitle = "Asalariados Dependientes: Asalariados Privados, Públicos y Servicios personales",
    x = NULL, y = "Tasa asalariados informales (%)", color = NULL, caption = NULL
  ) +
  fc_tema_grafico(extra = theme(
    plot.title       = element_text(face = "bold", size = 9, hjust = 0),
    plot.subtitle    = element_text(size = 7, color = "gray40", hjust = 0),
    axis.text.x      = element_text(angle = 45, hjust = 1, size = 6),
    axis.title.y     = element_text(size = 7),
    legend.key.width = unit(1.5, "cm"),
    panel.grid.minor = element_blank()
  )) +
  guides(color = guide_legend(override.aes = list(linewidth = 1.5)))

# ______________________________________________________________________________
# GRÁFICO 7: Variación interanual ocupados e incidencias por categoría ####
# ______________________________________________________________________________

cats_ocup_incid <- c(
  "Ocupados",
  "Cuenta propia formal", "Cuenta propia informal",
  "Asalariados privados formal", "Asalariados públicos formal", "Servicio doméstico formal",
  "Asalariados privados informal", "Asalariados públicos informal", "Servicio doméstico informal"
)

base_gr8_incid <- dt_ENE_compuesta %>%
  filter(sexo == "AS", categoria %in% cats_ocup_incid, fecha >= as.Date("2017-07-01")) %>%
  pivot_wider(names_from = categoria, values_from = valor) %>%
  arrange(fecha) %>%
  mutate(
    Asal_Form   = `Asalariados privados formal` + `Asalariados públicos formal` + `Servicio doméstico formal`,
    Asal_Inform = `Asalariados privados informal` + `Asalariados públicos informal` + `Servicio doméstico informal`,
    TCP_total   = `Cuenta propia formal` + `Cuenta propia informal`,
    Ocup_lag        = lag(Ocupados, 12),
    dOcup           = Ocupados    - lag(Ocupados,    12),
    dAsal_Form      = Asal_Form   - lag(Asal_Form,   12),
    dAsal_Inform    = Asal_Inform - lag(Asal_Inform, 12),
    dTCP            = TCP_total   - lag(TCP_total,   12),
    Var_Ocup_pct    = dOcup / Ocup_lag * 100,
    Inc_Asal_Form   = dAsal_Form   / Ocup_lag * 100,
    Inc_Asal_Inform = dAsal_Inform / Ocup_lag * 100,
    Inc_TCP         = dTCP         / Ocup_lag * 100
  ) %>%
  filter(!is.na(Var_Ocup_pct))

punto_actual_gr8 <- base_gr8_incid %>% filter(fecha == fecha_Actual)

base_gr8_barras <- base_gr8_incid %>%
  select(fecha, Inc_Asal_Form, Inc_Asal_Inform, Inc_TCP) %>%
  pivot_longer(cols = -fecha, names_to = "componente", values_to = "valor") %>%
  mutate(componente = factor(componente,
                             levels = c("Inc_Asal_Form", "Inc_Asal_Inform", "Inc_TCP"),
                             labels = c("Inc. Asalariados formales",
                                        "Inc. Asalariados informales",
                                        "Inc. Trabajadores por cuenta propia")))

colores_gr8 <- c(
  "Inc. Asalariados formales"           = "#1f77b4",
  "Inc. Asalariados informales"         = "#17becf",
  "Inc. Trabajadores por cuenta propia" = "#d62728"
)

gr_delta_Ocup_incid_categ <- ggplot() +
  geom_col(data = base_gr8_barras,
           aes(x = fecha, y = valor, fill = componente),
           position = "stack", alpha = 0.85, width = 25) +
  geom_line(data = base_gr8_incid,
            aes(x = fecha, y = Var_Ocup_pct, color = "Variación % 12 meses Ocupados"),
            linewidth = 0.8) +
  geom_point(data = punto_actual_gr8, aes(x = fecha, y = Var_Ocup_pct),
             color = col_bueno, size = 3, show.legend = FALSE) +
  geom_label(data = punto_actual_gr8,
             aes(x = fecha, y = Var_Ocup_pct,
                 label = paste0(format(round(Var_Ocup_pct, 1), nsmall = 1), "%")),
             color = col_bueno, size = 2.5, fontface = "bold",
             label.padding = unit(0.2, "lines"), vjust = -0.6, show.legend = FALSE) +
  scale_fill_manual(values = colores_gr8) +
  scale_color_manual(values = c("Variación % 12 meses Ocupados" = col_bueno)) +
  scale_y_continuous(labels = scales::number_format(suffix = "%", decimal.mark = ",")) +
  scale_x_date(date_breaks = "3 months", date_labels = "%Y\n%b") +
  labs(
    title    = "Gráfico: Variación interanual ocupados e incidencias según categoría ocupacional",
    subtitle = "Series líderes de categorías",
    x = NULL, y = "Variación / Incidencia (%)", fill = NULL, color = NULL
  ) +
  fc_tema_grafico(extra = theme(
    plot.title       = element_text(face = "bold", size = 9, hjust = 0),
    axis.text.x      = element_text(angle = 45, hjust = 1, size = 6),
    axis.title.y     = element_text(size = 7),
    legend.key.width = unit(1, "cm"),
    panel.grid.minor = element_blank()
  )) +
  guides(fill  = guide_legend(nrow = 2, byrow = TRUE),
         color = guide_legend(override.aes = list(linewidth = 1.5)))
