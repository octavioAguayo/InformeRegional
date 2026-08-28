# crea_objetos_desest.R - v9 - 24-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "lubridate", "ggplot2", "ggpp"))

cats_desest <- filtro_tabla_desest$categoria

dt_Desest <- dt_ENE_compuesta %>%
  filter(categoria %in% cats_desest) %>%
  arrange(categoria, sexo, fecha)

# TABLAS DESESTACIONALIZADAS (modelo Tablas 3a/b/c) ####
# res_desest replica el formato ancho de res_filtrado con las llaves de
# filtro_tabla_desest. De ahí en adelante, mismo camino que el Anexo 3.

res_desest <- dt_Desest %>%
  mutate(valor = round(valor, 1)) %>%
  pivot_wider(id_cols = c(sexo, categoria), names_from = fecha, values_from = valor) %>%
  inner_join(filtro_tabla_desest, by = "categoria") %>%
  arrange(sexo, indice) %>%
  select(-indice)

# Las series X13 se publican únicamente para el total nacional. No basta con
# que exista alguna fila: el módulo requiere AS, H y M para todos los
# indicadores en el período de referencia.
categorias_desest_necesarias <- filtro_tabla_desest$categoria
desest_actual <- dt_Desest %>%
  filter(fecha == fecha_Actual,
         sexo %in% c("AS", "H", "M"),
         categoria %in% categorias_desest_necesarias,
         is.finite(valor))
tiene_desest <- nrow(dt_Desest) > 0 &&
  nrow(desest_actual) == length(c("AS", "H", "M")) * length(categorias_desest_necesarias)

if (tiene_desest) {
  tc_desest_mes <- tabla_cambio(res_desest, Fechas["mes_anterior"], Fechas["actual"], sexo = "AS")
  tc_desest_ano <- tabla_cambio(res_desest, Fechas["a_1_anno"],     Fechas["actual"], sexo = "AS")
  tc_desest_pre <- tabla_cambio(res_desest, Fechas["pre_covid"],    Fechas["actual"], sexo = "AS")
  
  # Tablas D1a/b/c: mismo indicador desest., distinta fecha de comparación (AS).
  ft_Desest_DMes_AS <- fc_tabla_cambio_generica(
    tc_desest_mes,
    titulo = paste0("Tabla: Desestacionalizados — variación respecto al ",
                    "trimestre anterior — ", fc_fecha_a_trimestre(fecha_Actual)),
    fuente = paste0("Fuente: Elaboración propia en base a tabulado de ajuste ",
                    "estacional INE (X13-ARIMA-SEATS).")
  )
  ft_Desest_DAnno_AS <- fc_tabla_cambio_generica(
    tc_desest_ano,
    titulo = paste0("Tabla: Desestacionalizados — variación interanual — ",
                    fc_fecha_a_trimestre(fecha_Actual)),
    fuente = paste0("Fuente: Elaboración propia en base a tabulado de ajuste ",
                    "estacional INE (X13-ARIMA-SEATS).")
  )
  ft_Desest_DPreCovid_AS <- fc_tabla_cambio_generica(
    tc_desest_pre,
    titulo = paste0("Tabla: Desestacionalizados — variación vs pre-COVID (",
                    fc_fecha_a_trimestre(Fechas["pre_covid"]), ") — ",
                    fc_fecha_a_trimestre(fecha_Actual)),
    fuente = paste0("Fuente: Elaboración propia en base a tabulado de ajuste ",
                    "estacional INE (X13-ARIMA-SEATS).")
  )
  message("Desest: ft_Desest_DMes/DAnno/DPreCovid_AS listas ",
          "(tabla_cambio + fc_formatear_tabla) | ", nrow(dt_Desest), " filas en dt_Desest")
  
  # TABLA CUERPO: indicador × sexo (brecha de género) ####

  col_act <- as.character(fecha_Actual)
  col_mes <- as.character(fecha_MesAnterior)
  col_ano <- as.character(fecha1annos)
  
  df_desest_sexo <- lapply(seq_len(nrow(filtro_tabla_desest)), function(k) {
    ind <- filtro_tabla_desest[k, ]
    tipo_i <- if (ind$tipo_valor == "tasa") "decimal" else "entero"
    unidad_i <- if (tipo_i == "decimal") " p.p" else ""
    lapply(sexos_informe, function(sx) {
      fila <- res_desest %>% filter(sexo == sx$cod, categoria == ind$categoria)
      v <- fila[[col_act]]
      data.frame(
        grupo    = ind$categoriaNombre,
        brecha   = sx$label,
        Actual   = fmt_num_t1(v, tipo_i),
        Dif_1    = v - fila[[col_mes]], Dif_1_fmt = paste0(fmt_num_t1(v - fila[[col_mes]], tipo_i), unidad_i),
        Dif_2    = v - fila[[col_ano]], Dif_2_fmt = paste0(fmt_num_t1(v - fila[[col_ano]], tipo_i), unidad_i),
        tipo     = tipo_i, es_bueno = ind$es_bueno_si_sube, stringsAsFactors = FALSE)
    }) %>% bind_rows()
  }) %>% bind_rows()
  
  ft_Desest_Sexo <- fc_formatear_tabla(
    df_desest_sexo, n_grupo = length(sexos_informe),
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
    titulo = paste0("Tabla: Indicadores desestacionalizados por sexo (X13-ARIMA-SEATS) — ",
                    fc_fecha_a_trimestre(fecha_Actual)),
    fuente = paste0("Fuente: Elaboración propia en base a tabulado de ajuste ",
                    "estacional INE (X13-ARIMA-SEATS)."),
    ancho_col1 = 1.3)
  message("Desest: ft_Desest_Sexo lista (cuerpo, indicador × sexo, brecha de género)")
  
  # GRÁFICO D1: Tasa de desocupación desestacionalizada por sexo ####

  base_grD_desest <- dt_Desest %>%
    filter(categoria == "Tasa de desocupación desestacionalizado")
  
  pred_grD_desest <- fc_generar_predicciones(base_grD_desest, "valor", "sexo_label", cortes)
  
  puntos_grD_desest <- base_grD_desest %>%
    group_by(categoria, sexo_label) %>%
    filter(fecha %in% Fechas[c("actual", "a_2_annos", "inicio_gob", "a_6_annos", "a_13_annos")]) %>%
    ungroup()
  
  tabla_interna_grD <- puntos_grD_desest %>%
    select(fecha, Sexo = sexo_label, valor) %>%
    mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
    pivot_wider(names_from = fecha, values_from = valor)
  
  tabla_interna_grD_fmt <- tabla_interna_grD %>%
    mutate(across(where(is.numeric),
                  ~ formatC(.x, format = "f", digits = 1, big.mark = ".", decimal.mark = ",")))
  
  tema_tabla_grD <- fc_crear_tema_tabla(tabla_interna_grD)
  # Ancla fija arriba-izquierda, cerca de 2013 (zona despejada). No volver a
  # min*1.1: con tasas altas la tabla cae encima de las series.
  x_pos_grD <- min(base_grD_desest$fecha) %m+% years(3)
  y_pos_grD <- max(base_grD_desest$valor, na.rm = TRUE)
  
  gr_Desest_Tasa_Sexo <- ggplot(base_grD_desest,
                                aes(x = fecha, y = valor, color = sexo_label)) +
    geom_line(size = 1.2) +
    geom_point(size = 0.5) +
    geom_line(data = pred_grD_desest,
              aes(x = fecha, y = prediccion, color = sexo_label, linetype = corte),
              linewidth = 0.8) +
    scale_color_manual(values = colores_sexo) +
    labs(
      title    = "Gráfico: Tasa de desocupación desestacionalizada, 2010 a la fecha, por sexo",
      subtitle = "Serie X13-ARIMA-SEATS y regresiones por sexo, con cambios estructurales",
      x = "Fecha", y = "Porcentaje", color = "Sexo",
      caption  = "Fuente: Elaboración propia en base a tabulado de ajuste estacional INE."
    ) +
    fc_tema_grafico() +
    guides(color = guide_legend(nrow = 1)) +
    geom_table(
      data = data.frame(x = x_pos_grD, y = y_pos_grD),
      aes(x = x, y = y, label = list(tabla_interna_grD_fmt)),
      table.theme = tema_tabla_grD,
      vjust = 1, hjust = 0
    )
  
  message("Desest: gr_Desest_Tasa_Sexo listo (3 sexos, regresiones por ",
          nrow(cortes), " cortes estructurales)")
  
  # GRÁFICO D2: Tasa de participación desestacionalizada por sexo ####
  # T_participación_d = FT_d/PET, derivada en CreaBBDD_Excel_Series.R.

  base_grD2_desest <- dt_Desest %>%
    filter(categoria == "Tasa de participación desestacionalizado")
  
  pred_grD2_desest <- fc_generar_predicciones(base_grD2_desest, "valor", "sexo_label", cortes)
  
  puntos_grD2_desest <- base_grD2_desest %>%
    group_by(categoria, sexo_label) %>%
    filter(fecha %in% Fechas[c("actual", "a_2_annos", "inicio_gob", "a_6_annos", "a_13_annos")]) %>%
    ungroup()
  
  tabla_interna_grD2 <- puntos_grD2_desest %>%
    select(fecha, Sexo = sexo_label, valor) %>%
    mutate(valor = round(valor, 1), fecha = format(fecha, "%Y-%m")) %>%
    pivot_wider(names_from = fecha, values_from = valor)
  
  tabla_interna_grD2_fmt <- tabla_interna_grD2 %>%
    mutate(across(where(is.numeric),
                  ~ formatC(.x, format = "f", digits = 1, big.mark = ".", decimal.mark = ",")))
  
  tema_tabla_grD2 <- fc_crear_tema_tabla(tabla_interna_grD2)
  x_pos_grD2 <- min(base_grD2_desest$fecha) %m+% years(3)
  y_pos_grD2 <- max(base_grD2_desest$valor, na.rm = TRUE)
  
  gr_Desest_Particip_Sexo <- ggplot(base_grD2_desest,
                                    aes(x = fecha, y = valor, color = sexo_label)) +
    geom_line(size = 1.2) +
    geom_point(size = 0.5) +
    geom_line(data = pred_grD2_desest,
              aes(x = fecha, y = prediccion, color = sexo_label, linetype = corte),
              linewidth = 0.8) +
    scale_color_manual(values = colores_sexo) +
    labs(
      title    = "Gráfico: Tasa de participación desestacionalizada, 2010 a la fecha, por sexo",
      subtitle = "FT desestacionalizada / PET (X13-ARIMA-SEATS) y regresiones por sexo, con cambios estructurales",
      x = "Fecha", y = "Porcentaje", color = "Sexo",
      caption  = "Fuente: Elaboración propia en base a tabulado de ajuste estacional INE."
    ) +
    fc_tema_grafico() +
    guides(color = guide_legend(nrow = 1)) +
    geom_table(
      data = data.frame(x = x_pos_grD2, y = y_pos_grD2),
      aes(x = x, y = y, label = list(tabla_interna_grD2_fmt)),
      table.theme = tema_tabla_grD2,
      vjust = 1, hjust = 0
    )
  
  message("Desest: gr_Desest_Particip_Sexo listo (D2, participación desest. por sexo)")
  
  # GRÁFICO D3: Tasa de desocupación — original vs desestacionalizada ####
  # Acá el color distingue serie, no sexo.

  base_grD3 <- dt_ENE_compuesta %>%
    filter(categoria %in% c("Tasa de desocupación", "Tasa de desocupación desestacionalizado"),
           sexo == "AS", fecha >= as.Date("2020-01-01")) %>%
    mutate(Serie = if_else(categoria == "Tasa de desocupación desestacionalizado",
                           "Desestacionalizada", "Original")) %>%
    filter(!is.na(valor))
  
  colores_grD3 <- c("Original" = col_neutro, "Desestacionalizada" = col_malo)
  
  # La regresión va SOLO sobre la serie original, a propósito: la recta de la
  # desestacionalizada heredaría la aceleración espuria del borde del X-13.
  cortes_grD3 <- cortes %>% filter(fin > as.Date("2020-01-01"))
  pred_grD3 <- fc_generar_predicciones(
    base_grD3 %>% filter(Serie == "Original"), "valor", "Serie", cortes_grD3)
  
  gr_Desest_Comparacion <- ggplot(base_grD3, aes(x = fecha, y = valor, color = Serie)) +
    geom_line(size = 1.2) +
    geom_point(size = 0.5) +
    geom_line(data = pred_grD3,
              aes(x = fecha, y = prediccion, linetype = corte),
              color = col_neutro, linewidth = 0.8) +
    scale_color_manual(values = colores_grD3) +
    labs(
      title    = "Gráfico: Tasa de desocupación: serie original vs desestacionalizada, total nacional",
      subtitle = "Ambos sexos, 2020 a la fecha. Tendencia estimada sobre la serie original",
      x = "Fecha", y = "Porcentaje", color = "Serie",
      caption  = "Fuente: Elaboración propia en base a datos ENE y tabulado de ajuste estacional INE (X13-ARIMA-SEATS)."
    ) +
    fc_tema_grafico() +
    guides(color = guide_legend(nrow = 1))
  
  message("Desest: gr_Desest_Comparacion listo (D3, 2020, regresión solo original)")
  
  # ── Variables narrativas: pendientes del último tramo estructural ────────────
  # fc_generar_predicciones descarta los coeficientes; como la recta es lineal,
  # la pendiente se recupera exacta desde los extremos.
  fc_pend_tramo <- function(pred) {
    ult <- tail(sort(unique(pred$corte)), 1)
    pred %>%
      filter(corte == ult) %>%
      group_by(sexo_label) %>%
      arrange(fecha) %>%
      summarise(ini   = first(prediccion),
                fin   = last(prediccion),
                annos = as.numeric(difftime(last(fecha), first(fecha), units = "days")) / 365.25,
                .groups = "drop") %>%
      mutate(pend = (fin - ini) / annos)
  }
  fc_pd <- function(tb, lbl, col) tb[[col]][tb$sexo_label == lbl][1]
  
  # Desocupación
  pend_desoc        <- fc_pend_tramo(pred_grD_desest)
  Pend_Desoc_H      <- fc_pd(pend_desoc, "Hombres", "pend")
  Pend_Desoc_M      <- fc_pd(pend_desoc, "Mujeres", "pend")
  Brecha_Desoc_Ini  <- fc_pd(pend_desoc, "Mujeres", "ini") - fc_pd(pend_desoc, "Hombres", "ini")
  Brecha_Desoc_Fin  <- fc_pd(pend_desoc, "Mujeres", "fin") - fc_pd(pend_desoc, "Hombres", "fin")
  
  # Participación
  pend_partic       <- fc_pend_tramo(pred_grD2_desest)
  Pend_Partic_H     <- fc_pd(pend_partic, "Hombres", "pend")
  Pend_Partic_M     <- fc_pd(pend_partic, "Mujeres", "pend")
  Brecha_Partic_Ini <- fc_pd(pend_partic, "Hombres", "ini") - fc_pd(pend_partic, "Mujeres", "ini")
  Brecha_Partic_Fin <- fc_pd(pend_partic, "Hombres", "fin") - fc_pd(pend_partic, "Mujeres", "fin")
  
  # ── Variables narrativas para las tres tablas desestacionalizadas ────────────
  # tabla_cambio() nombra sus columnas "Categorías" y "Diferencia".
  # Leer "Cambio"/"categoriaNombre" devuelve NULL y Quarto lo imprime vacío.
  fc_ds <- function(tc, cat) tc$Diferencia[tc[["Categorías"]] == cat][1]
  
  DS_Mes_FT     <- fc_ds(tc_desest_mes, "Fuerza de Trabajo desest.")
  DS_Mes_Ocup   <- fc_ds(tc_desest_mes, "Ocupados desest.")
  DS_Mes_Desoc  <- fc_ds(tc_desest_mes, "Desocupados desest.")
  DS_Ano_Ocup   <- fc_ds(tc_desest_ano, "Ocupados desest.")
  DS_Ano_Desoc  <- fc_ds(tc_desest_ano, "Desocupados desest.")
  DS_Ano_TDesoc <- fc_ds(tc_desest_ano, "Tasa de Desocupación desest.")
  DS_Pre_TDesoc <- fc_ds(tc_desest_pre, "Tasa de Desocupación desest.")
  DS_Pre_TPart  <- fc_ds(tc_desest_pre, "Tasa de Participación desest.")
  
} else {
  Pend_Desoc_H <- Pend_Desoc_M <- Brecha_Desoc_Ini <- Brecha_Desoc_Fin <- NA_real_
  Pend_Partic_H <- Pend_Partic_M <- Brecha_Partic_Ini <- Brecha_Partic_Fin <- NA_real_
  DS_Mes_FT <- DS_Mes_Ocup <- DS_Mes_Desoc <- NA_real_
  DS_Ano_Ocup <- DS_Ano_Desoc <- DS_Ano_TDesoc <- NA_real_
  DS_Pre_TDesoc <- DS_Pre_TPart <- NA_real_
  ft_Desest_DMes_AS <- ft_Desest_DAnno_AS <- ft_Desest_DPreCovid_AS <- NULL
  ft_Desest_Sexo <- NULL
  gr_Desest_Tasa_Sexo <- gr_Desest_Particip_Sexo <- gr_Desest_Comparacion <- NULL
  message("Desest: módulo omitido; no hay cobertura X13 nacional completa para ",
          fc_fecha_a_trimestre(fecha_Actual), ".")
}
