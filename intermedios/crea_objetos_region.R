# crea_objetos_region.R - v4 - 24-08-2026

# Librerías ####
if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "ggplot2"))

# ══════════════════════════════════════════════════════════════════════════════
# PORTADA REGIONAL — Claves territoriales (versión 1) ####
# Interpreta los KPI sin duplicarlos: composición por sexo, calidad del cambio,
# brecha de informalidad y estructura de tamaño. Rankings, pares y segmentos
# etarios se agregan después de validar esta lectura base.
# ══════════════════════════════════════════════════════════════════════════════

es_informe_regional <- !identical(params$region_label, "Total nacional")

if (es_informe_regional) {
  fc_valor_portada_regional <- function(dt, categoria_objetivo,
                                        fecha_objetivo = fecha_Actual,
                                        sexo_objetivo = "AS") {
    dato <- dt %>%
      filter(.data$fecha == fecha_objetivo,
             .data$sexo == sexo_objetivo,
             .data$categoria == categoria_objetivo) %>%
      pull(valor)
    if (length(dato) != 1L || !is.finite(dato)) {
      stop("No hay un valor único y válido para la radiografía territorial: ",
           categoria_objetivo, " (", format(fecha_objetivo), ").", call. = FALSE)
    }
    dato
  }

  tasa_inf_reg   <- fc_valor_portada_regional(dt_ENE_compuesta, "Tasa de ocupación informal")
  tasa_inf_nac   <- fc_valor_portada_regional(dt_ENE_nacional, "Tasa de ocupación informal")
  ocup_reg       <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados")
  ocup_nac       <- fc_valor_portada_regional(dt_ENE_nacional, "Ocupados")
  ocup_reg_ano   <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados", fecha1annos)
  ocup_h_reg     <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados", sexo_objetivo = "H")
  ocup_h_reg_ano <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados", fecha1annos, "H")
  ocup_m_reg     <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados", sexo_objetivo = "M")
  ocup_m_reg_ano <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados", fecha1annos, "M")
  ocup_for_reg   <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados formal")
  ocup_for_ano   <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados formal", fecha1annos)
  ocup_inf_reg   <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados informal")
  ocup_inf_ano   <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados informal", fecha1annos)
  ocup_micro_reg <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados Micro empresa")
  ocup_micro_nac <- fc_valor_portada_regional(dt_ENE_nacional, "Ocupados Micro empresa")
  ocup_micro_ano <- fc_valor_portada_regional(dt_ENE_compuesta, "Ocupados Micro empresa", fecha1annos)

  brecha_inf_territorial   <- tasa_inf_reg - tasa_inf_nac
  brecha_micro_territorial <- (ocup_micro_reg / ocup_reg * 100) - (ocup_micro_nac / ocup_nac * 100)
  cambio_anual_ocup_territorial <- ocup_reg - ocup_reg_ano
  cambio_anual_ocup_h <- ocup_h_reg - ocup_h_reg_ano
  cambio_anual_ocup_m <- ocup_m_reg - ocup_m_reg_ano
  cambio_anual_formal <- ocup_for_reg - ocup_for_ano
  cambio_anual_informal <- ocup_inf_reg - ocup_inf_ano
  cambio_anual_micro <- ocup_micro_reg - ocup_micro_ano

  fc_brecha_pais <- function(brecha) {
    if (abs(brecha) < 0.05) return("en línea con el promedio nacional")
    paste0(fc_Form_Num(abs(brecha), 1), " pp. ", if (brecha > 0) "sobre" else "bajo", " el promedio nacional")
  }

  fc_movimiento <- function(x) {
    paste(if (x > 0) "aumentaron" else if (x < 0) "disminuyeron" else "no variaron",
          "en", fc_Form_Num(abs(x), 0), "personas")
  }

  texto_radiografia_genero <- if (
    sign(cambio_anual_ocup_h) == sign(cambio_anual_ocup_m) && cambio_anual_ocup_h != 0
  ) {
    aporte_mujeres <- abs(cambio_anual_ocup_m) /
      (abs(cambio_anual_ocup_h) + abs(cambio_anual_ocup_m)) * 100
    paste0(
      "**Composición por sexo.** La variación anual de la ocupación se distribuyó en ambos sexos: ",
      "los ocupados hombres ", fc_movimiento(cambio_anual_ocup_h),
      " y las mujeres ", fc_movimiento(cambio_anual_ocup_m),
      ". Las mujeres explican **", fc_Form_Num(aporte_mujeres, 1),
      "%** del movimiento conjunto."
    )
  } else {
    paste0(
      "**Composición por sexo.** En doce meses, los ocupados hombres ",
      fc_movimiento(cambio_anual_ocup_h), ", mientras las mujeres ",
      fc_movimiento(cambio_anual_ocup_m),
      ". La variación total mezcla trayectorias opuestas entre ambos sexos."
    )
  }
  texto_radiografia_calidad <- paste0(
    "**Calidad del cambio anual.** En doce meses, los ocupados formales ",
    fc_movimiento(cambio_anual_formal), ", y los ocupados informales ",
    fc_movimiento(cambio_anual_informal), ". ",
    if (cambio_anual_formal > 0 && cambio_anual_informal <= 0)
      "Esta recomposición eleva el peso relativo del empleo protegido, aunque el total regional puede moverse en otra dirección."
    else if (cambio_anual_formal <= 0 && cambio_anual_informal > 0)
      "La composición anual se desplaza hacia empleo menos protegido, señal que exige cautela."
    else "La calidad del cambio depende de la intensidad relativa de ambos movimientos."
  )
  texto_radiografia_formalidad <- paste0(
    "**Brecha de formalidad actual.** En el trimestre en curso, la tasa de informalidad regional se ubica ",
    fc_brecha_pais(brecha_inf_territorial),
    ". Esta es una brecha de nivel frente al país; su variación anual se observa en la composición del empleo descrita arriba."
  )
  texto_radiografia_empresas <- paste0(
    "**Estructura empresarial.** En el trimestre actual, las microempresas concentran **", fc_Form_Num(ocup_micro_reg / ocup_reg * 100, 1),
    "%** del empleo regional, ", fc_brecha_pais(brecha_micro_territorial),
    ". En doce meses, sus ocupados ", fc_movimiento(cambio_anual_micro), "."
  )
  texto_radiografia_sintesis <- paste0(
    "**Lectura integrada.** La brecha actual frente al país debe leerse junto con la composición anual del empleo. ",
    if (cambio_anual_formal <= 0 && cambio_anual_informal > 0)
      "Aunque la informalidad regional pueda ubicarse bajo la referencia nacional, el cambio de los últimos doce meses no consolida esa ventaja."
    else if (cambio_anual_formal > 0 && cambio_anual_informal <= 0)
      "La evolución de los últimos doce meses refuerza una trayectoria de mayor protección laboral."
    else "Los movimientos de empleo formal e informal no entregan una señal única y requieren seguimiento en los próximos períodos."
  )
}

# ══════════════════════════════════════════════════════════════════════════════
# ANEXO 2 — Regiones (A2)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


# ______________________________________________________________________________
# TABLAS REGIÓN (2a, 2b, 2c) ####
# ______________________________________________________________________________

ft_TDesocup_Region_m_y_d12m <- fc_Tabla_Region(
  dt       = dt_ENE_regional %>%
    filter(categoria %in% c("Tasa de desocupación", "Desocupados", "Fuerza de trabajo")),
  cat_tasa = "Tasa de desocupación",
  titulo   = "Tabla: Tasa de desocupación y variaciones según región",
  nota     = "Las regiones se ordenan de mayor a menor según la tasa de desocupación del trimestre actual."
)

cats_inform_region <- c(
  "Ocupados informal", "Ocupados",
  "Asalariados privados formal", "Asalariados públicos formal", "Servicio doméstico formal",
  "Asalariados privados informal", "Asalariados públicos informal", "Servicio doméstico informal"
)

dt_inform_region <- dt_ENE_regional %>%
  filter(categoria %in% cats_inform_region) %>%
  pivot_wider(id_cols = c(fecha, region, region_label),
              names_from = categoria, values_from = valor) %>%
  mutate(
    `Asalariados dependientes formal`     = `Asalariados privados formal` + `Asalariados públicos formal` + `Servicio doméstico formal`,
    `Asalariados dependientes informal`   = `Asalariados privados informal` + `Asalariados públicos informal` + `Servicio doméstico informal`,
    `Asalariados dependientes`          = `Asalariados dependientes formal` + `Asalariados dependientes informal`,
    `Tasa de ocupación informal`        = round(`Ocupados informal` / Ocupados * 100, 1),
    `Tasa de asalariados dependientes informal` = round(`Asalariados dependientes informal` / `Asalariados dependientes` * 100, 1)
  ) %>%
  pivot_longer(cols = c(`Tasa de ocupación informal`, `Tasa de asalariados dependientes informal`, Ocupados, `Ocupados informal`,
                        `Asalariados dependientes`, `Asalariados dependientes informal`),
               names_to = "categoria", values_to = "valor")

ft_TInform_Region <- fc_Tabla_Region(
  dt       = dt_inform_region %>%
    filter(categoria %in% c("Tasa de ocupación informal", "Ocupados informal", "Ocupados")),
  cat_tasa = "Tasa de ocupación informal",
  titulo   = "Tabla: Tasa de ocupación informal y variaciones según región",
  nota     = "Las regiones se ordenan de mayor a menor según la tasa de informalidad del trimestre actual."
)

ft_TAsal_dep_Inform_Region <- fc_Tabla_Region(
  dt       = dt_inform_region %>%
    filter(categoria %in% c("Tasa de asalariados dependientes informal", "Asalariados dependientes informal", "Asalariados dependientes")),
  cat_tasa = "Tasa de asalariados dependientes informal",
  titulo   = "Tabla: Tasa de asalariados dependientes informales y variaciones según región",
  nota     = paste0(
    "Las regiones se ordenan de mayor a menor según la tasa de asalariados dependientes informales ",
    "del trimestre actual. Asalariados dependientes informales = asalariados privados informales + ",
    "asalariados públicos informales + servicio doméstico informal."
  )
)

# ______________________________________________________________________________
# TABLA: Ocupados por región ####
# ______________________________________________________________________________

base_region_desocup <- dt_ENE_regional %>%
  filter(
    sexo     == "AS",
    categoria == "Desocupados",
    fecha     %in% c(fecha_Actual, fecha_MesAnterior, fecha1annos)
  ) %>%
  pivot_wider(id_cols = region_label, names_from = fecha, values_from = valor) %>%
  rename(
    val_act = as.character(fecha_Actual),
    val_mes = as.character(fecha_MesAnterior),
    val_año = as.character(fecha1annos)
  ) %>%
  mutate(
    dif_mes = val_act - val_mes,
    dif_año = val_act - val_año,
    Región  = region_label
  ) %>%
  arrange(desc(val_act)) %>%
  select(Región, val_act, dif_mes, dif_año)

# Fila total nacional
fila_total_desocup_region <- data.frame(
  Región  = "Total nacional",
  val_act = fc_Datos_ENE(fecha_Actual,      "AS", "Desocupados"),
  dif_mes = fc_Datos_ENE(fecha_Actual,      "AS", "Desocupados") -
    fc_Datos_ENE(fecha_MesAnterior, "AS", "Desocupados"),
  dif_año = fc_Datos_ENE(fecha_Actual,      "AS", "Desocupados") -
    fc_Datos_ENE(fecha1annos,        "AS", "Desocupados"),
  stringsAsFactors = FALSE
)

dt_desocup_region <- bind_rows(base_region_desocup, fila_total_desocup_region)

ft_Desocupados_Region <- fc_formatear_tabla(
  dt_desocup_region,
  columnas = list(
    Región  = list(tipo = "texto"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ninteranual")
  ),
  fila_negrita = nrow(dt_desocup_region),
  titulo       = "Tabla: Desocupados según región",
  ancho_col1   = 2.3
)

# ── Variables narrativas para el Anexo 2 ─────────────────────────────────────
# El total nacional va en la última fila: el mínimo es la PENÚLTIMA, no la última.

RegDesoc  <- fc_region_extremos(ft_TDesocup_Region_m_y_d12m)
RegInform <- fc_region_extremos(ft_TInform_Region)
RegAsalI  <- fc_region_extremos(ft_TAsal_dep_Inform_Region)
RegDesocN <- fc_region_extremos(ft_Desocupados_Region)

# ── Posición de la región elegida: Anexo territorial ─────────────────────────
# El gráfico sigue SOLO a la región de la minuta. Las 16 regiones permanecen
# en las tablas de respaldo: no se dibujan dieciséis líneas ilegibles.
if (es_informe_regional) {
  config_ranking_territorial <- tibble::tribble(
    ~categoria,                     ~sexo, ~Indicador,       ~Filtro,              ~orden, ~orden_fila,
    "Tasa de desocupación",         "AS",  "Desocupación",  "Desocupación",      "asc",       1,
    "Tasa de desocupación",         "M",   "Desocupación",  "- Mujeres",         "asc",       2,
    "Tasa de ocupación informal",  "AS",  "Informalidad",  "Informalidad",      "asc",       5,
    "Tasa de ocupación informal",  "M",   "Informalidad",  "- Mujeres",         "asc",       6,
    "Tasa de participación",       "AS",  "Participación", "Participación",     "desc",      9,
    "Tasa de participación",       "M",   "Participación", "- Mujeres",         "desc",     10
  )
  # Trece fechas permiten mostrar 12 períodos y, a la vez, comparar el actual
  # con el mismo trimestre móvil de hace un año.
  fechas_ranking_territorial <- tail(sort(unique(dt_ENE_regional$fecha[dt_ENE_regional$fecha <= fecha_Actual])), 13)
  fechas_grafico_ranking <- tail(fechas_ranking_territorial, 12)
  if (length(fechas_ranking_territorial) < 13L) {
    stop("No hay historia suficiente para el ranking territorial.", call. = FALSE)
  }

  ranking_directo_territorial <- dt_ENE_regional_sexo %>%
    filter(fecha %in% fechas_ranking_territorial,
           categoria %in% config_ranking_territorial$categoria, is.finite(valor)) %>%
    inner_join(config_ranking_territorial, by = c("categoria", "sexo"))

  # Jóvenes y 55+ se derivan con los mismos numeradores y denominadores que el
  # módulo de edad; así su ranking es comparable entre las 16 regiones.
  fc_ranking_por_edad <- function(tramos, etiqueta, orden_inicio) {
    categorias <- c(fc_cat_tramo(c("Fuerza de trabajo", "Desocupados", "Ocupados",
                                   "Ocupados informal", "Población en edad de trabajar"), tramos))
    dt_ENE_regional %>%
      filter(sexo == "AS", fecha %in% fechas_ranking_territorial,
             categoria %in% categorias) %>%
      mutate(variable = dplyr::case_when(
        grepl("^Fuerza de trabajo", categoria) ~ "FT",
        grepl("^Desocupados", categoria) ~ "Desocupados",
        grepl("^Ocupados informal", categoria) ~ "Ocupados informal",
        grepl("^Ocupados", categoria) ~ "Ocupados",
        TRUE ~ "PET"
      )) %>%
      group_by(fecha, region_label, variable) %>% summarise(valor = sum(valor), .groups = "drop") %>%
      pivot_wider(names_from = variable, values_from = valor) %>%
      transmute(fecha, region_label,
        Desocupación = Desocupados / FT * 100,
        Informalidad = `Ocupados informal` / Ocupados * 100,
        Participación = FT / PET * 100) %>%
      pivot_longer(-c(fecha, region_label), names_to = "Indicador", values_to = "valor") %>%
      mutate(Filtro = paste0("- ", etiqueta),
             orden = if_else(Indicador == "Participación", "desc", "asc"),
             orden_fila = orden_inicio + match(Indicador, c("Desocupación", "Informalidad", "Participación")) * 4 - 4)
  }
  ranking_edad_territorial <- bind_rows(
    fc_ranking_por_edad(tramos_edad_jovenes, "Jóvenes 15–24", 3),
    fc_ranking_por_edad(tramos_edad_mayores, "55 años y más", 4)
  )
  ranking_territorial <- bind_rows(ranking_directo_territorial, ranking_edad_territorial) %>%
    group_by(fecha, Indicador, Filtro, orden, orden_fila) %>%
    mutate(posicion = if_else(orden == "asc", min_rank(valor), min_rank(desc(valor))),
           n_regiones = n()) %>%
    ungroup() %>%
    filter(region_label == params$region_label)

  fc_posicion_ranking <- function(indicador, filtro, fecha_consulta) {
    fila <- ranking_territorial %>% filter(Indicador == indicador, Filtro == filtro, fecha == fecha_consulta)
    if (nrow(fila) != 1L) {
      stop("No se pudo determinar el puesto regional para ", indicador,
           " en ", format(fecha_consulta), ".", call. = FALSE)
    }
    paste0(fila$posicion, "º de ", fila$n_regiones)
  }
  filas_ranking_territorial <- ranking_territorial %>% distinct(Indicador, Filtro, orden_fila) %>% arrange(orden_fila)
  resumen_ranking_territorial <- lapply(seq_len(nrow(filas_ranking_territorial)), function(i) {
    ind <- filas_ranking_territorial$Indicador[i]; filtro <- filas_ranking_territorial$Filtro[i]
    serie <- ranking_territorial %>% filter(Indicador == ind, Filtro == filtro, fecha %in% fechas_grafico_ranking)
    data.frame(
      Indicador = filtro,
      Actual = fc_posicion_ranking(ind, filtro, fecha_Actual),
      `Mes anterior` = fc_posicion_ranking(ind, filtro, fecha_MesAnterior),
      `Hace un año` = fc_posicion_ranking(ind, filtro, fecha1annos),
      `Máx.–mín. en 12 períodos` = paste0(min(serie$posicion), "º–", max(serie$posicion), "º de ", max(serie$n_regiones)),
      stringsAsFactors = FALSE,
      check.names = FALSE
    )
  }) %>% bind_rows()

  ft_Posicion_Ranking_Territorial <- fc_formatear_tabla(
    resumen_ranking_territorial,
    columnas = list(
      Indicador = list(tipo = "texto"), Actual = list(tipo = "texto"),
      `Mes anterior` = list(tipo = "texto"), `Hace un año` = list(tipo = "texto"),
      `Máx.–mín. en 12 períodos` = list(tipo = "texto")
    ),
    titulo = paste0("Tabla: Posición de ", params$region_label, " en rankings regionales"),
    nota = "Puesto 1 corresponde a menor desocupación e informalidad, y a mayor participación. El total nacional no se incluye en el ranking.",
    ancho_col1 = 1.7
  )

  ranking_grafico_territorial <- ranking_territorial %>% filter(Filtro == Indicador, fecha %in% fechas_grafico_ranking)
  ultimo_ranking_territorial <- ranking_grafico_territorial %>% filter(fecha == fecha_Actual)
  max_regiones_ranking <- max(ranking_grafico_territorial$n_regiones)
  # Cada panel muestra el tramo realmente recorrido por la región, con una
  # ventana mínima de cinco puestos. Los puntos invisibles fuerzan esa escala
  # por faceta sin dibujar las otras once posiciones vacías.
  limites_ranking_territorial <- ranking_grafico_territorial %>%
    group_by(Indicador) %>%
    summarise(mejor = min(posicion), peor = max(posicion), .groups = "drop") %>%
    mutate(limite_superior = pmax(1, mejor - 1),
           limite_inferior = pmin(max_regiones_ranking, peor + 1),
           limite_inferior = pmax(limite_inferior, pmin(max_regiones_ranking, limite_superior + 4)),
           limite_superior = pmin(limite_superior, pmax(1, limite_inferior - 4)))
  anclas_limites_ranking <- bind_rows(
    limites_ranking_territorial %>% transmute(Indicador, fecha = min(fechas_grafico_ranking), posicion = limite_superior),
    limites_ranking_territorial %>% transmute(Indicador, fecha = min(fechas_grafico_ranking), posicion = limite_inferior)
  )
  gr_Posicion_Ranking_Territorial <- ggplot(ranking_grafico_territorial, aes(fecha, posicion, color = Indicador)) +
    geom_blank(data = anclas_limites_ranking,
               aes(fecha, posicion), inherit.aes = FALSE) +
    geom_line(linewidth = 1) + geom_point(size = 2) +
    geom_point(data = ultimo_ranking_territorial, size = 3) +
    facet_wrap(~ Indicador, ncol = 1, scales = "free_y") +
    scale_y_reverse(breaks = seq_len(max_regiones_ranking)) +
    scale_x_date(date_breaks = "2 months", date_labels = "%b\n%Y") +
    scale_color_manual(values = c("Desocupación" = col_malo,
                                  "Informalidad" = col_informal,
                                  "Participación" = col_bueno)) +
    labs(title = paste0("Gráfico: Trayectoria de ", params$region_label, " en el ranking regional"),
         subtitle = "Últimos 12 trimestres móviles. El puesto 1 representa una mejor posición relativa.",
         x = NULL, y = "Puesto entre regiones", color = NULL,
         caption = "Fuente: Elaboración propia en base a datos ENE.") +
    fc_tema_grafico() + theme(legend.position = "none")
}
