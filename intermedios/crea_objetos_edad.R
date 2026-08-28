# crea_objetos_edad.R - v7 - 12-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "lubridate", "stringr", "ggplot2", "ggpp"))

# Etiquetas compuestas derivadas de los tramos del panel (Parametros_ENE.R)
stocks_edad <- c("Fuerza de trabajo", "Desocupados", "Ocupados")
tramos_jovenes <- fc_cat_tramo(stocks_edad, tramos_edad_jovenes)
tramos_mayores <- fc_cat_tramo(stocks_edad, tramos_edad_mayores)

base_stocks_edad <- dt_ENE_compuesta %>%
  filter(
    sexo == "AS",
    categoria %in% c(tramos_jovenes, tramos_mayores)
  ) %>%
  mutate(
    grupo = case_when(
      str_detect(categoria, paste(tramos_edad_jovenes, collapse = "|")) ~ "jovenes",
      TRUE                                     ~ "mayores"
    ),
    # La derecha es nombre interno, no canon: vive hasta el pivot_wider y
    # base_edad lo consume como columna. No canonizarlo.
    variable = case_when(
      str_starts(categoria, "Fuerza de trabajo") ~ "FT",
      str_starts(categoria, "Desocupados")       ~ "Desocupados",
      str_starts(categoria, "Ocupados")          ~ "Ocupados"
    )
  ) %>%
  group_by(fecha, grupo, variable) %>%
  summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = variable, values_from = valor)
# T_participación no se calcula acá: necesita PET por tramo. Va en base_edad.

# PET por grupo de edad — necesario para T_participación
tramos_pet_jovenes <- fc_cat_tramo("Población en edad de trabajar", tramos_edad_jovenes)
tramos_pet_mayores <- fc_cat_tramo("Población en edad de trabajar", tramos_edad_mayores)

base_pet_edad <- dt_ENE_compuesta %>%
  filter(
    sexo == "AS",
    categoria %in% c(tramos_pet_jovenes, tramos_pet_mayores)
  ) %>%
  mutate(
    grupo = case_when(
      str_detect(categoria, paste(tramos_edad_jovenes, collapse = "|")) ~ "jovenes",
      TRUE                                     ~ "mayores"
    )
  ) %>%
  group_by(fecha, grupo) %>%
  summarise(PET = sum(valor, na.rm = TRUE), .groups = "drop")

# Unir stocks con PET y recalcular tasas
base_edad <- base_stocks_edad %>%
  select(fecha, grupo, FT, Desocupados, Ocupados) %>%
  left_join(base_pet_edad, by = c("fecha", "grupo")) %>%
  mutate(
    T_desocupacion  = round(Desocupados / FT  * 100, 1),
    T_participacion = round(FT          / PET * 100, 1),
    grupo_label = case_when(
      grupo == "jovenes" ~ "Jóvenes 15-24",
      grupo == "mayores" ~ "55 años y más"
    )
  )

# Serie total desde dt_ENE_compuesta
base_total_desoc <- dt_ENE_compuesta %>%
  filter(sexo == "AS", categoria == "Tasa de desocupación") %>%
  select(fecha, valor) %>%
  mutate(grupo_label = "Total", T_desocupacion = valor)

base_total_partic <- dt_ENE_compuesta %>%
  filter(sexo == "AS", categoria == "Tasa de participación") %>%
  select(fecha, valor) %>%
  mutate(grupo_label = "Total", T_participacion = valor)

# ______________________________________________________________________________
# GRÁFICO A — Tasa de desocupación por grupo de edad ####
# ______________________________________________________________________________

base_grA_desocup <- bind_rows(
  base_edad %>% select(fecha, grupo_label, valor = T_desocupacion),
  base_total_desoc %>% select(fecha, grupo_label, valor = T_desocupacion)
)

pred_grA <- fc_generar_predicciones(base_grA_desocup, "valor", "grupo_label", cortes)

puntos_grA <- base_grA_desocup %>%
  filter(fecha %in% c(fecha_Actual, fecha2annos, fecha6annos, fecha13annos))

tabla_interna_grA <- puntos_grA %>%
  select(fecha, Grupo = grupo_label, valor) %>%
  mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
  pivot_wider(names_from = fecha, values_from = valor)

tabla_interna_grA_fmt <- tabla_interna_grA %>%
  mutate(across(where(is.numeric),
                ~ formatC(.x, format = "f", digits = 1,
                          big.mark = ".", decimal.mark = ",")))

tema_grA       <- fc_crear_tema_tabla(tabla_interna_grA)
x_pos_grA      <- min(base_grA_desocup$fecha) %m+% months(6)
y_pos_grA      <- max(base_grA_desocup$valor, na.rm = TRUE) * 0.92

gr_Tasa_Desocup_Edad <- ggplot(base_grA_desocup,
                               aes(x = fecha, y = valor, color = grupo_label)) +
  geom_line(size = 1.2) +
  geom_point(size = 0.5) +
  geom_line(data = pred_grA,
            aes(x = fecha, y = prediccion, color = grupo_label, linetype = corte),
            linewidth = 0.8) +
  labs(
    title    = "Gráfico: Tasa de desocupación por grupo de edad",
    subtitle = "Jóvenes 15-24, 55 años y más, y Total — series y regresiones con cambios estructurales",
    x = "Fecha", y = "Porcentaje", color = "Grupo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  scale_color_manual(values = colores_edad) +
  fc_tema_grafico() +
  guides(color = guide_legend(nrow = 1)) +
  geom_table(
    data = data.frame(x = x_pos_grA, y = y_pos_grA),
    aes(x = x, y = y, label = list(tabla_interna_grA_fmt)),
    table.theme = tema_grA,
    vjust = 1.2, hjust = 0.1
  ) +
  expand_limits(y = c(min(base_grA_desocup$valor, na.rm = TRUE) - 3, NA))

# ______________________________________________________________________________
# GRÁFICO B — Tasa de participación por grupo de edad ####
# ______________________________________________________________________________

base_grB_partic <- bind_rows(
  base_edad %>% select(fecha, grupo_label, valor = T_participacion),
  base_total_partic %>% select(fecha, grupo_label, valor = T_participacion)
)

pred_grB <- fc_generar_predicciones(base_grB_partic, "valor", "grupo_label", cortes)

puntos_grB <- base_grB_partic %>%
  filter(fecha %in% c(fecha_Actual, fecha2annos, fecha6annos, fecha13annos))

tabla_interna_grB <- puntos_grB %>%
  select(fecha, Grupo = grupo_label, valor) %>%
  mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
  pivot_wider(names_from = fecha, values_from = valor)

tabla_interna_grB_fmt <- tabla_interna_grB %>%
  mutate(across(where(is.numeric),
                ~ formatC(.x, format = "f", digits = 1,
                          big.mark = ".", decimal.mark = ",")))

tema_grB  <- fc_crear_tema_tabla(tabla_interna_grB)
x_pos_grB <- min(base_grB_partic$fecha) %m+% years(1)
y_pos_grB <- min(base_grB_partic$valor, na.rm = TRUE) * 0.8

gr_Tasa_Partic_Edad <- ggplot(base_grB_partic,
                              aes(x = fecha, y = valor, color = grupo_label)) +
  geom_line(size = 1.2) +
  geom_point(size = 0.5) +
  geom_line(data = pred_grB,
            aes(x = fecha, y = prediccion, color = grupo_label, linetype = corte),
            linewidth = 0.8) +
  labs(
    title    = "Gráfico: Tasa de participación por grupo de edad",
    subtitle = "Jóvenes 15-24, 55 años y más, y Total — series y regresiones con cambios estructurales",
    x = "Fecha", y = "Porcentaje", color = "Grupo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  scale_color_manual(values = colores_edad) +
  fc_tema_grafico() +
  guides(color = guide_legend(nrow = 1)) +
  geom_table(
    data = data.frame(x = x_pos_grB, y = y_pos_grB),
    aes(x = x, y = y, label = list(tabla_interna_grB_fmt)),
    table.theme = tema_grB,
    vjust = 0, hjust = 0
  ) +
  expand_limits(y = c(y_pos_grB - 5, NA))


message("Gráficos edad construidos: gr_Tasa_Desocup_Edad, gr_Tasa_Partic_Edad")

# ______________________________________________________________________________
# BASE COMPOSICIÓN — 3 grupos: Jóvenes, Intermedios, 55+ ####
# ______________________________________________________________________________

# Derivados del panel — un solo lugar define qué tramo pertenece a qué grupo
tramos_jovenes_ocup      <- fc_cat_tramo("Ocupados",    tramos_edad_jovenes)
tramos_jovenes_desoc     <- fc_cat_tramo("Desocupados", tramos_edad_jovenes)
tramos_intermedios_ocup  <- fc_cat_tramo("Ocupados",    tramos_edad_intermedios)
tramos_intermedios_desoc <- fc_cat_tramo("Desocupados", tramos_edad_intermedios)
tramos_mayores_ocup      <- fc_cat_tramo("Ocupados",    tramos_edad_mayores)
tramos_mayores_desoc     <- fc_cat_tramo("Desocupados", tramos_edad_mayores)

fc_base_composicion <- function(cats_jovenes, cats_intermedios, cats_mayores) {
  dt_ENE_compuesta %>%
    filter(
      sexo == "AS",
      categoria %in% c(cats_jovenes, cats_intermedios, cats_mayores)
    ) %>%
    mutate(
      grupo = case_when(
        categoria %in% cats_jovenes     ~ "Jóvenes 15-24",
        categoria %in% cats_intermedios ~ "Intermedios 25-54",
        categoria %in% cats_mayores     ~ "55 años y más"
      )
    ) %>%
    group_by(fecha, grupo) %>%
    summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
    group_by(fecha) %>%
    mutate(
      total = sum(valor, na.rm = TRUE),
      pct   = round(valor / total * 100, 1)
    ) %>%
    ungroup() %>%
    mutate(grupo = factor(grupo,
                          levels = c("55 años y más", "Intermedios 25-54", "Jóvenes 15-24")))
}

base_comp_ocup  <- fc_base_composicion(tramos_jovenes_ocup,  tramos_intermedios_ocup,  tramos_mayores_ocup)
base_comp_desoc <- fc_base_composicion(tramos_jovenes_desoc, tramos_intermedios_desoc, tramos_mayores_desoc)

# ______________________________________________________________________________
# GRÁFICO C — Composición % Ocupados por grupo de edad ####
# ______________________________________________________________________________

gr_Comp_Ocupados_Edad <- ggplot(base_comp_ocup,
                                aes(x = fecha, y = pct, fill = grupo)) +
  geom_area(position = "stack", alpha = 0.85, na.rm = TRUE) +
  scale_fill_manual(values = colores_edad) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, NA)) +
  labs(
    title    = "Gráfico: Composición de ocupados por grupo de edad",
    subtitle = "Participación porcentual de cada grupo en el total de ocupados",
    x = NULL, y = "Porcentaje", fill = "Grupo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(fill = guide_legend(nrow = 1))

# ______________________________________________________________________________
# GRÁFICO D — Composición % Desocupados por grupo de edad ####
# ______________________________________________________________________________

gr_Comp_Desocupados_Edad <- ggplot(base_comp_desoc,
                                   aes(x = fecha, y = pct, fill = grupo)) +
  geom_area(position = "stack", alpha = 0.85, na.rm = TRUE) +
  scale_fill_manual(values = colores_edad) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, NA)) +
  labs(
    title    = "Gráfico: Composición de desocupados por grupo de edad",
    subtitle = "Participación porcentual de cada grupo en el total de desocupados",
    x = NULL, y = "Porcentaje", fill = "Grupo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(fill = guide_legend(nrow = 1))


message("Gráficos edad completos: gr_Tasa_Desocup_Edad, gr_Tasa_Partic_Edad, ",
        "gr_Comp_Ocupados_Edad, gr_Comp_Desocupados_Edad")

# ______________________________________________________________________________
# GRÁFICO E — % Informalidad por tramo de edad × 4 fechas — Total AS ####
# GRÁFICO F — % Informalidad por tramo de edad × 4 fechas — Mujeres ####
# Patrón en U: alta informalidad en jóvenes y mayores, menor en núcleo 25-54
# ______________________________________________________________________________

fechas_informalidad <- c(fecha_Actual, fecha1annos, fecha6annos)


# Categorías tasa informalidad por tramo — vienen de ENE_3_Derivadas
cats_inf_edad <- fc_cat_tramo("Tasa de ocupación informal", tramos_ene)

# Orden de tramos para eje X — el orden canónico del panel
orden_tramos <- tramos_ene

fc_base_informalidad_edad <- function(sexo_filtro) {
  dt_ENE_compuesta %>%
    filter(
      sexo     == sexo_filtro,
      fecha    %in% fechas_informalidad,
      categoria %in% cats_inf_edad
    ) %>%
    mutate(
      tramo = str_remove(categoria, fixed(paste0("Tasa de ocupación informal", SEP_CAT))),
      tramo = factor(tramo, levels = orden_tramos),
      periodo_label = factor(
        format(fecha, "%Y-%m"),
        levels = format(sort(fechas_informalidad), "%Y-%m")
      )
    )
}

base_grE <- fc_base_informalidad_edad("AS")
base_grF <- fc_base_informalidad_edad("M")

colores_fechas <- setNames(
  tail(colores_periodos, length(fechas_informalidad)),
  format(sort(fechas_informalidad), "%Y-%m")
)

fc_grafico_informalidad_edad <- function(base, titulo) {
  ggplot(base, aes(x = tramo, y = valor, color = periodo_label, group = periodo_label)) +
    geom_line(linewidth = 1.1) +
    geom_point(size = 2.5) +
    scale_color_manual(values = colores_fechas) +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    labs(
      title   = titulo,
      subtitle = "Tasa de ocupación informal por tramo etario — patrón en U",
      x = "Tramo de edad", y = "% Informalidad", color = "Período",
      caption = "Fuente: Elaboración propia en base a datos ENE."
    ) +
    fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
    guides(color = guide_legend(nrow = 1))
}

gr_Informalidad_Edad_AS <- fc_grafico_informalidad_edad(
  base_grE,
  "Gráfico: Tasa de informalidad por tramo de edad — Ambos sexos"
)

gr_Informalidad_Edad_M <- fc_grafico_informalidad_edad(
  base_grF,
  "Gráfico: Tasa de informalidad por tramo de edad — Mujeres"
)


message("Gráficos informalidad edad agregados: gr_Informalidad_Edad_AS, gr_Informalidad_Edad_M")
# ______________________________________________________________________________
# GRÁFICO EF — Informalidad por tramo edad: Hombres y Mujeres en panel combinado ####
# 3 fechas: actual, año anterior y prepandemia (se saca fecha2annos para no
# saturar el panel — 8 líneas con 4 fechas × 2 sexos era demasiado)
# ______________________________________________________________________________

fechas_grEF <- c(fecha_Actual)

colores_grEF <- setNames(
  tail(colores_periodos, 1),
  format(fecha_Actual, "%Y-%m")
)

fc_base_informalidad_edad_ef <- function(sexo_filtro) {
  dt_ENE_compuesta %>%
    filter(
      sexo      == sexo_filtro,
      fecha     %in% fechas_grEF,
      categoria %in% cats_inf_edad
    ) %>%
    mutate(
      tramo = str_remove(categoria, fixed(paste0("Tasa de ocupación informal", SEP_CAT))),
      tramo = factor(tramo, levels = orden_tramos),
      periodo_label = factor(
        format(fecha, "%Y-%m"),
        levels = format(sort(fechas_grEF), "%Y-%m")
      )
    )
}

base_grEF <- bind_rows(
  fc_base_informalidad_edad_ef("H") %>% mutate(grupo_sexo = "Hombres"),
  fc_base_informalidad_edad_ef("M")  %>% mutate(grupo_sexo = "Mujeres")
) %>%
  mutate(grupo_sexo = factor(grupo_sexo, levels = c("Hombres", "Mujeres")))

gr_Informalidad_Edad_EF <- ggplot(
  base_grEF,
  aes(x        = tramo,
      y        = valor,
      color    = periodo_label,
      group    = interaction(periodo_label, grupo_sexo),
      linetype = grupo_sexo)
) +
  geom_line(linewidth = 1.0) +
  geom_point(size = 2.0) +
  scale_color_manual(values = colores_grEF) +
  scale_linetype_manual(
    values = c("Hombres" = "solid", "Mujeres" = "dashed")
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title    = "Gráfico: Tasa de informalidad por tramo de edad — Hombres y Mujeres",
    subtitle = "Patrón en U — línea sólida = hombres, punteada = mujeres",
    x        = "Tramo de edad",
    y        = "% Informalidad",
    color    = "Período",
    linetype = "Sexo",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(
    color    = guide_legend(nrow = 1, order = 1),
    linetype = guide_legend(nrow = 1, order = 2)
  )


message("Gráfico combinado agregado: gr_Informalidad_Edad_EF (1 fecha: actual — Hombres vs Mujeres)")

# ══════════════════════════════════════════════════════════════════════════════
# TABLA — Indicadores por grupo de edad (ft_Edad_1524, ft_Edad_55mas) ####
# ══════════════════════════════════════════════════════════════════════════════

tramos_joven  <- tramos_edad_jovenes   # supuesto metodológico: Parametros_ENE.R
tramos_mayor  <- tramos_edad_mayores

cats_edad <- c(
  "Desocupados", "Ocupados", "Ocupados formal", "Ocupados informal",
  "Fuerza de trabajo", "Población en edad de trabajar"
)

# Las tasas del grupo agregado se RECALCULAN desde los stocks ya sumados, no se
# promedian entre tramos: promediarlas da una tasa agregada incorrecta.

base_edad_fechas <- dt_ENE_compuesta %>%
  filter(
    fecha %in% c(fecha_Actual, fecha_MesAnterior, fecha1annos),
    str_detect(categoria, " años"),
    sexo %in% c("AS", "H", "M")
  ) %>%
  mutate(
    # El tramo empieza siempre con dígito; la base es todo lo anterior.
    tramo    = str_extract(categoria, "\\d.*$"),
    cat_base = str_remove(categoria, paste0(SEP_CAT, "\\d.*$")),
    rango_edad = case_when(
      tramo %in% tramos_joven ~ "15-24",
      tramo %in% tramos_mayor ~ "55 y más",
      TRUE                    ~ NA_character_
    )
  ) %>%
  filter(!is.na(rango_edad), cat_base %in% cats_edad) %>%
  group_by(sexo, rango_edad, cat_base, fecha) %>%
  summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  pivot_wider(names_from = cat_base, values_from = valor) %>%
  mutate(
    `Tasa de desocupación`       = round(Desocupados / `Fuerza de trabajo` * 100, 1),
    `Tasa de participación`      = round(`Fuerza de trabajo` / `Población en edad de trabajar` * 100, 1),
    `Tasa de ocupación informal` = round(`Ocupados informal` / Ocupados * 100, 1)
  ) %>%
  # Estas tres eran solo insumo de las tasas. Si sobreviven al pivot_wider
  # final, cambian por fecha y las 3 fechas no se fusionan en una fila.
  select(-`Fuerza de trabajo`, -`Ocupados informal`, -`Población en edad de trabajar`) %>%
  pivot_longer(
    cols = c(Desocupados, Ocupados, `Ocupados formal`,
             `Tasa de desocupación`, `Tasa de participación`, `Tasa de ocupación informal`),
    names_to = "cat_base", values_to = "valor"
  ) %>%
  pivot_wider(names_from = fecha, values_from = valor)

indicadores_t5 <- list(
  list(nombre = "Desocupados",             cat = "Desocupados",                tipo = "entero",  es_bueno_si_sube = FALSE),
  list(nombre = "Ocupados",                cat = "Ocupados",                   tipo = "entero",  es_bueno_si_sube = TRUE),
  list(nombre = "Ocupados Formales",       cat = "Ocupados formal",            tipo = "entero",  es_bueno_si_sube = TRUE),
  list(nombre = "Tasa Desocupación",       cat = "Tasa de desocupación",       tipo = "decimal", es_bueno_si_sube = FALSE),
  list(nombre = "Tasa Ocupación Informal", cat = "Tasa de ocupación informal", tipo = "decimal", es_bueno_si_sube = FALSE),
  list(nombre = "Tasa Participación",      cat = "Tasa de participación",      tipo = "decimal", es_bueno_si_sube = TRUE)
)

# sexos_informe vive en Parametros_ENE.R (promovida desde este ladrillo)

hacer_tabla_edad <- function(rango) {
  datos <- base_edad_fechas %>% filter(rango_edad == rango)
  col_act <- as.character(fecha_Actual)
  col_mes <- as.character(fecha_MesAnterior)
  col_ano <- as.character(fecha1annos)
  
  df <- lapply(indicadores_t5, function(ind) {
    lapply(sexos_informe, function(sx) {
      fila <- datos %>% filter(sexo == sx$cod, cat_base == ind$cat)
      # Blindaje: filter() debiera devolver exactamente 1 fila por combo
      # sexo×indicador. Si por lo que sea devuelve 0 (falta el dato) o >1
      # (duplicado en la base), forzar 1 fila con NA en vez de dejar que
      # data.frame() recicle grupo/brecha (escalares) contra columnas de
      # largo distinto — eso generaba filas fantasma con etiquetas repetidas.
      if (nrow(fila) != 1) {
        v <- NA_real_; v_mes <- NA_real_; v_ano <- NA_real_
      } else {
        v     <- fila[[col_act]]
        v_mes <- fila[[col_mes]]
        v_ano <- fila[[col_ano]]
      }
      unidad <- if (ind$tipo == "decimal") " p.p" else ""
      data.frame(grupo = ind$nombre, brecha = sx$label,
                 Actual = fmt_num_t1(v, ind$tipo),
                 Dif_1 = v - v_mes, Dif_1_fmt = paste0(fmt_num_t1(v - v_mes, ind$tipo), unidad),
                 Dif_2 = v - v_ano, Dif_2_fmt = paste0(fmt_num_t1(v - v_ano, ind$tipo), unidad),
                 tipo = ind$tipo, es_bueno = ind$es_bueno_si_sube, stringsAsFactors = FALSE)
    }) %>% bind_rows()
  }) %>% bind_rows()
  
  fc_formatear_tabla(
    df, n_grupo = length(sexos_informe),
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
    titulo = paste0("Tabla: Indicadores grupo ", rango, " — ",
                    fc_fecha_a_trimestre(fecha_Actual)),
    ancho_col1 = 1.3)
}

ft_Edad_1524  <- hacer_tabla_edad("15-24")
ft_Edad_55mas <- hacer_tabla_edad("55 y más")


# ── Variables narrativas para el discurso de los gráficos de edad ─────────────
# Sin esto, el texto afirmaría a mano qué grupo domina y en qué dirección se
# mueve su peso relativo — hechos que cambian con la serie.
fc_comp_edad <- function(base, grp) {
  s <- base %>% filter(grupo == grp) %>% arrange(fecha)
  c(ini = s$pct[1], fin = s$pct[nrow(s)])
}
Edad_Serie_Ini <- format(min(base_comp_ocup$fecha), "%Y")

# Composición de ocupados
idx_o <- which.max(base_comp_ocup$pct[base_comp_ocup$fecha == max(base_comp_ocup$fecha)])
Comp_Ocup_Mayor <- as.character(base_comp_ocup$grupo[base_comp_ocup$fecha == max(base_comp_ocup$fecha)][idx_o])
Comp_Ocup_Top   <- fc_comp_edad(base_comp_ocup, Comp_Ocup_Mayor)
Comp_Ocup_Jov   <- fc_comp_edad(base_comp_ocup, "Jóvenes 15-24")
Comp_Ocup_May  <- fc_comp_edad(base_comp_ocup,  "55 años y más")
Comp_Desoc_May <- fc_comp_edad(base_comp_desoc, "55 años y más")

# Composición de desocupados
Comp_Desoc_Jov  <- fc_comp_edad(base_comp_desoc, "Jóvenes 15-24")

# Informalidad por tramo: U en el período actual, AS y Mujeres
# ── Forma de la curva de informalidad por edad ───────────────────────────────
# Cortes inferiores, uno por tramo. Declararlos es lo que permite preguntar por
# la forma de la curva en vez de afirmarla.
cortes_edad <- c(15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70)

fc_curva_edad <- function(base, sexo_lbl = NULL) {
  d <- base
  if (!is.null(sexo_lbl)) d <- d[d$grupo_sexo == sexo_lbl, ]
  d <- d[d$fecha == max(d$fecha), c("tramo", "valor")]
  d <- d[order(d$tramo), ]
  fc_declarar(as.data.frame(d), fc_filas_intervalos(cortes_edad, col = "tramo"))
}

# tol en puntos porcentuales, no en porcentaje: bajo 1 pp es ruido, no repunte.
U_H     <- fc_forma(fc_curva_edad(base_grEF, "Hombres"), "valor", tol = 1)
U_M_ef  <- fc_forma(fc_curva_edad(base_grEF, "Mujeres"), "valor", tol = 1)
U_AS    <- fc_forma(fc_curva_edad(base_grE), "valor", tol = 1)
U_M     <- fc_forma(fc_curva_edad(base_grF), "valor", tol = 1)

# ── Pendientes por tramo y elasticidad ───────────────────────────────────────
# fc_pendientes devuelve puntos POR AÑO, no por día.
pend_desoc  <- fc_pendientes(pred_grA)
pend_partic <- fc_pendientes(pred_grB)

Pend_Desoc_Jov  <- fc_pendiente_actual(pred_grA, "Jóvenes 15-24")
Pend_Desoc_Tot  <- fc_pendiente_actual(pred_grA, "Total")
Pend_Desoc_May  <- fc_pendiente_actual(pred_grA, "55 años y más")
Pend_Partic_Jov <- fc_pendiente_actual(pred_grB, "Jóvenes 15-24")
Pend_Partic_Tot <- fc_pendiente_actual(pred_grB, "Total")

# Pendiente juvenil de participación en el tramo ANTERIOR al vigente: es lo que
# permite decir que la caída histórica se aplanó.
p_j <- pend_partic[pend_partic$grupo == "Jóvenes 15-24", ]
p_j <- p_j[order(p_j$desde), ]
Pend_Partic_Jov_Prev <- p_j$pendiente[nrow(p_j) - 1]
Partic_Jov_SeAplano  <- abs(Pend_Partic_Jov) < abs(Pend_Partic_Jov_Prev) / 2

# Cuántas veces más rápido se deteriora la desocupación juvenil que la total.
Razon_Pend_Desoc <- if (Pend_Desoc_Tot != 0)
  round(Pend_Desoc_Jov / Pend_Desoc_Tot, 1) else NA_real_

# Elasticidad arco interanual: adimensional, compara series de nivel distinto.
Elast_Desoc_Jov <- fc_elasticidad_arco(
  x_ini = Tasa_Act_TDescp_J1524_AS - Delta_Año_TDescp_J1524_AS,
  x_fin = Tasa_Act_TDescp_J1524_AS,
  y_ini = Tasa_Act_TDescp_AS - Delta_Año_TDescp_AS,
  y_fin = Tasa_Act_TDescp_AS,
  nombre_x = "juvenil", nombre_y = "total")

# ── Tramo donde la informalidad deja de ser comparable ───────────────────────
# Efecto de definición, no precarización. Manual, § Informalidad y edad.
tramo_jubilacion_M  <- "60 a 64 años"
tramo_jubilacion_AS <- "65 a 69 años"