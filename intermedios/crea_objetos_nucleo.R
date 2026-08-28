# crea_objetos_nucleo.R - v3 - 12-08-2026

# Librerías ####
if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "lubridate", "ggplot2", "ggpp"))

options(scipen = 999)

# ══════════════════════════════════════════════════════════════════════════════
# CAPÍTULO 2 — Ideas fuerza e indicadores principales (c2)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


# ______________________________________________________________________________
# TABLA 1: Indicadores clave con variaciones trimestral e interanual ####
# ______________________________________________________________________________

indicadores_t1 <- list(
  list(nombre = "Desocupados",             cat = "Desocupados",       tipo = "entero",  es_bueno_si_sube = FALSE),
  list(nombre = "Ocupados",                cat = "Ocupados",          tipo = "entero",  es_bueno_si_sube = TRUE),
  list(nombre = "Ocupados Formales",       cat = "Ocupados formal", tipo = "entero",  es_bueno_si_sube = TRUE),
  list(nombre = "Tasa Desocupación",       cat = "Tasa de desocupación",    tipo = "decimal", es_bueno_si_sube = FALSE),
  list(nombre = "Tasa Ocupación Informal", cat = "Tasa de ocupación informal",        tipo = "decimal", es_bueno_si_sube = FALSE),
  list(nombre = "Tasa Participación",      cat = "Tasa de participación",   tipo = "decimal", es_bueno_si_sube = TRUE)
)

df_t1 <- lapply(indicadores_t1, function(ind) {
  lapply(sexos_informe, function(sx) {
    v      <- fc_Datos_ENE(fecha_Actual,      sx$cod, ind$cat)
    prev   <- fc_Datos_ENE(fecha_MesAnterior, sx$cod, ind$cat)
    anio   <- fc_Datos_ENE(fecha1annos,       sx$cod, ind$cat)
    unidad <- if (ind$tipo == "decimal") " p.p" else ""
    data.frame(grupo = ind$nombre, brecha = sx$label,
               Actual = fmt_num_t1(v, ind$tipo),
               Dif_1 = v - prev, Dif_1_fmt = paste0(fmt_num_t1(v - prev, ind$tipo), unidad),
               Dif_2 = v - anio, Dif_2_fmt = paste0(fmt_num_t1(v - anio, ind$tipo), unidad),
               tipo = ind$tipo, es_bueno = ind$es_bueno_si_sube, stringsAsFactors = FALSE)
  }) %>% bind_rows()
}) %>% bind_rows()

ft_Delta_indicadores <- fc_formatear_tabla(
  df_t1, n_grupo = length(sexos_informe),
  columnas = list(
    grupo  = list(tipo = "texto", label = "Indicador"),
    brecha = list(tipo = "texto", label = " "),
    Actual = list(tipo = "numero", texto_col = "Actual",
                  label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_Actual), ")")),
    Dif_1  = list(tipo = "flecha", texto_col = "Dif_1_fmt", es_bueno = "es_bueno",
                  label = "Diferencia trim.\nmóvil anterior"),
    Dif_2  = list(tipo = "flecha", texto_col = "Dif_2_fmt", es_bueno = "es_bueno",
                  label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Cambios trimestrales e interanuales en indicadores claves, ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  ancho_col1 = 1.3)


# GRÁFICO 1: Tasa de desocupación 2010 a la fecha ####
# ______________________________________________________________________________

base_gr2_tdesocup <- dt_ENE_compuesta %>%
  filter(categoria %in% c("Tasa de desocupación"))

pred_gr2_tdesocup <- fc_generar_predicciones(base_gr2_tdesocup, "valor", "sexo_label", cortes)

puntos_gr2_tdesocup <- base_gr2_tdesocup %>%
  group_by(categoria, sexo_label) %>%
  filter(fecha %in% Fechas[c("actual", "a_2_annos", "inicio_gob", "a_6_annos", "a_13_annos")]) %>%
  ungroup()

tabla_interna_gr2 <- puntos_gr2_tdesocup %>%
  select(fecha, Sexo = sexo_label, valor) %>%
  mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
  pivot_wider(names_from = fecha, values_from = valor)

tabla_interna_gr2_fmt <- tabla_interna_gr2 %>%
  mutate(across(where(is.numeric),
                ~ formatC(.x, format = "f", digits = 1, big.mark = ".", decimal.mark = ",")))

tema_tabla_gr2 <- fc_crear_tema_tabla(tabla_interna_gr2)
x_pos_gr2 <- min(base_gr2_tdesocup$fecha) %m+% years(9)
y_pos_gr2 <- min(base_gr2_tdesocup$valor) * 1.1

# ══════════════════════════════════════════════════════════════════════════════
# CAPÍTULO 3.1 — Tasa de desocupación histórica (c3s1: g1)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


gr_Tasa_Desocup_2010_Actual <- ggplot(base_gr2_tdesocup, aes(x = fecha, y = valor, color = sexo_label)) +
  geom_line(size = 1.2) +
  geom_point(size = 0.5) +
  geom_line(data = pred_gr2_tdesocup,
            aes(x = fecha, y = prediccion, color = sexo_label, linetype = corte),
            linewidth = 0.8) +
  scale_color_manual(values = colores_sexo) +
  labs(
    title    = "Gráfico: Tasa de desocupación entre 2010 a la Fecha, por sexo",
    subtitle = "Series y regresiones por Sexo, con cambios estructurales",
    x = "Fecha", y = "Porcentaje", color = "Sexo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico() +
  guides(color = guide_legend(nrow = 1)) +
  geom_table(
    data = data.frame(x = x_pos_gr2, y = y_pos_gr2),
    aes(x = x, y = y, label = list(tabla_interna_gr2_fmt)),
    table.theme = tema_tabla_gr2,
    vjust = 1.2, hjust = 0.1
  ) +
  expand_limits(y = c(min(base_gr2_tdesocup$valor, na.rm = TRUE) - 3, NA))

# ______________________________________________________________________________
# GRÁFICO 2: Tasa de participación 2010 a la fecha ####
# ______________________________________________________________________________

base_gr3_tparticip <- dt_ENE_compuesta %>%
  filter(categoria %in% c("Tasa de participación"))

pred_gr3_tparticip <- fc_generar_predicciones(base_gr3_tparticip, "valor", "sexo_label", cortes)

puntos_gr3_tparticip <- base_gr3_tparticip %>%
  group_by(categoria, sexo_label) %>%
  filter(fecha %in% Fechas[c("actual", "a_2_annos", "inicio_gob", "a_6_annos", "a_13_annos")]) %>%
  ungroup()

tabla_interna_gr3 <- puntos_gr3_tparticip %>%
  select(fecha, Sexo = sexo_label, valor) %>%
  mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
  pivot_wider(names_from = fecha, values_from = valor)

tabla_interna_gr3_fmt <- tabla_interna_gr3 %>%
  mutate(across(where(is.numeric),
                ~ formatC(.x, format = "f", digits = 1, big.mark = ".", decimal.mark = ",")))

tema_tabla_gr3 <- fc_crear_tema_tabla(tabla_interna_gr3)
x_pos_gr3 <- min(base_gr3_tparticip$fecha) %m+% years(1)
y_pos_gr3 <- min(base_gr3_tparticip$valor) * 0.8

# ══════════════════════════════════════════════════════════════════════════════
# CAPÍTULO 3.2 — Participación y razones fuera de la FT (c3s2: g2, g3)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


gr_Tasa_Particip_2010_Actual <- ggplot(base_gr3_tparticip, aes(x = fecha, y = valor, color = sexo_label)) +
  geom_line(size = 1.2) +
  geom_point(size = 0.5) +
  geom_line(data = pred_gr3_tparticip,
            aes(x = fecha, y = prediccion, color = sexo_label, linetype = corte),
            linewidth = 0.8) +
  scale_color_manual(values = colores_sexo) +
  labs(
    title    = "Gráfico: Tasa de participación en Chile, 2010 a la fecha",
    subtitle = "Por sexo y líneas de tendencia",
    x = "Fecha", y = "Porcentaje", color = "Sexo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico() +
  guides(color = guide_legend(nrow = 1)) +
  geom_table(
    data = data.frame(x = x_pos_gr3, y = y_pos_gr3),
    aes(x = x, y = y, label = list(tabla_interna_gr3_fmt)),
    table.theme = tema_tabla_gr3,
    vjust = 0, hjust = 0
  ) +
  expand_limits(y = c(y_pos_gr3 - 5, NA))

# ______________________________________________________________________________
