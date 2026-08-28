# crea_objetos_dur_desempleo.R - v7 - 12-08-2026

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
fecha_DurDes_Actual      <- fecha_dta_efectiva
fecha_DurDes_MesAnterior <- fecha_DurDes_Actual %m-% months(1)
fecha_DurDes_1anno       <- fecha_DurDes_Actual %m-% years(1)

# ── 2. Categorías del tramo ─────────────────────────────────────────────────
categorias_dur_desempleo <- c(
  "Desocupados Menos de 1 mes",
  "Desocupados 1 a 3 meses",
  "Desocupados 4 a 6 meses",
  "Desocupados 7 a 12 meses",
  "Desocupados 13 a 15 meses",
  "Desocupados 16 a 18 meses",
  "Desocupados Más de 18 meses"
)

# ── 3. Construir el objeto, a partir del período ya definido arriba ────────────
df_dur_desempleo <- lapply(categorias_dur_desempleo, function(cat) {
  v    <- fc_Datos_ENE(fecha_DurDes_Actual,      "AS", cat)
  prev <- fc_Datos_ENE(fecha_DurDes_MesAnterior, "AS", cat)
  anio <- fc_Datos_ENE(fecha_DurDes_1anno,       "AS", cat)
  data.frame(
    Tramo   = str_remove(cat, "^Desocupados "),
    val_act = v,
    dif_mes = v - prev,
    dif_año = v - anio,
    stringsAsFactors = FALSE
  )
}) %>% bind_rows()

# es_bueno = FALSE en todos los tramos: más desocupados es peor, sin excepción.
ft_DurDesempleo <- fc_formatear_tabla(
  df_dur_desempleo,
  columnas = list(
    Tramo   = list(tipo = "texto"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_DurDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según duración de la cesantía a ",
                  fc_fecha_a_trimestre(fecha_DurDes_Actual)),
  # Cortes = límite inferior, UNO POR FILA. Un corte de menos corre todos los
  # acumulados un tramo y devuelve cifras plausibles y falsas.
  filas = fc_filas_intervalos(c(0, 1, 4, 7, 13, 16, 19), col = "Tramo"),
  ancho_col1 = 2.0
)

message("Duración desempleo: ft_DurDesempleo lista (Trim_Actual = ", Trim_Actual,
        " → módulo usa ", fc_fecha_a_trimestre(fecha_DurDes_Actual),
        if (dta_rezagado) " [rezagado: .dta no tenía el mes corriente]" else " [al día]")

# ── 4. Segunda tabla: mismo tramo, desglosado por sexo ──────────────────────
df_dur_desempleo_sexo <- lapply(categorias_dur_desempleo, function(cat) {
  lapply(sexos_informe, function(sx) {
    v    <- fc_Datos_ENE(fecha_DurDes_Actual,      sx$cod, cat)
    prev <- fc_Datos_ENE(fecha_DurDes_MesAnterior, sx$cod, cat)
    anio <- fc_Datos_ENE(fecha_DurDes_1anno,       sx$cod, cat)
    data.frame(
      Tramo   = str_remove(cat, "^Desocupados "),
      Sexo    = sx$label,
      val_act = v,
      dif_mes = v - prev,
      dif_año = v - anio,
      stringsAsFactors = FALSE
    )
  }) %>% bind_rows()
}) %>% bind_rows()

ft_DurDesempleo_Sexo <- fc_formatear_tabla(
  df_dur_desempleo_sexo, n_grupo = length(sexos_informe),
  # Las dos claves no se concatenan: una es ordenada y la otra no.
  filas = fc_filas_intervalos_x_grupo(c(0, 1, 4, 7, 13, 16, 19),
                                      col = "Tramo", corte = "Sexo"),
  columnas = list(
    Tramo   = list(tipo = "texto"),
    Sexo    = list(tipo = "texto", label = " "),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_DurDes_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = FALSE,
                   label = "Diferencia\ninteranual")
  ),
  titulo = paste0("Tabla: Desocupados según duración de la cesantía y sexo a ",
                  fc_fecha_a_trimestre(fecha_DurDes_Actual)),
  ancho_col1 = 1.6
)

# ── Variables narrativas para el discurso de la sección 5.5 ────────────────────
h_stock <- fc_extremo(ft_DurDesempleo, "val_act", "max")
h_alza  <- fc_extremo(ft_DurDesempleo, "dif_mes", "max")
h_caida <- fc_extremo(ft_DurDesempleo, "dif_mes", "min")

Tramo_MayorStock        <- h_stock$etiqueta
Pct_Tramo_MayorStock    <- round(h_stock$pct, 0)
Tramo_MayorAlzaMensual  <- h_alza$etiqueta
Tramo_MayorCaidaMensual <- h_caida$etiqueta

c_caida <- fc_cuantas(ft_DurDesempleo, "dif_año", function(x) x < 0)
Tramos_CaidaInteranual       <- c_caida$etiquetas
N_Tramos_CaidaInteranual     <- c_caida$n
Texto_Tramos_CaidaInteranual <- if (N_Tramos_CaidaInteranual == 0) {
  "ningún tramo"
} else {
  paste(paste0('"', Tramos_CaidaInteranual, '"'), collapse = " y ")
}

# Larga duración: desde el corte 13. "Más de 12 meses" y "desde 13" son el mismo
# conjunto, así que la suma es exacta y no interpola.
h_larga <- fc_acumulado(ft_DurDesempleo, "val_act", desde = 13)
Val_LargaDuracion  <- h_larga$valor
Pct_LargaDuracion  <- h_larga$pct

# Devuelve NA si la mediana cae en el tramo abierto: ahí no hay ancho y
# cualquier valor sería un supuesto escondido. El texto debe ramificar.
Mediana_DurDesempleo <- fc_mediana_intervalo(ft_DurDesempleo, "val_act")

# Personas por mes de tramo. Los anchos difieren, así que comparar frecuencias
# crudas premia al tramo más ancho. El tramo abierto queda NA.
h_dens <- fc_densidad(ft_DurDesempleo, "val_act")
h_dens_cerrados     <- h_dens[!is.na(h_dens$densidad), ]
Tramo_MasDenso      <- h_dens_cerrados$tramo[which.max(h_dens_cerrados$densidad)]
Densidad_MasDenso   <- max(h_dens_cerrados$densidad, na.rm = TRUE)

# ── ¿Es igual el perfil de duración entre hombres y mujeres? ──────────────────
cmp_larga <- fc_comparar_grupos(ft_DurDesempleo_Sexo, fc_acumulado,
                                col = "val_act", desde = 13,
                                grupos = c("Hombres", "Mujeres"))
Pct_LargaDuracion_H <- cmp_larga$por_grupo[["Hombres"]]$pct
Pct_LargaDuracion_M <- cmp_larga$por_grupo[["Mujeres"]]$pct
Brecha_LargaDuracion <- round(Pct_LargaDuracion_M - Pct_LargaDuracion_H, 1)

cmp_stock <- fc_comparar_grupos(ft_DurDesempleo_Sexo, fc_extremo,
                                col = "val_act", tipo = "max",
                                grupos = c("Hombres", "Mujeres"))
Tramo_MayorStock_H  <- cmp_stock$por_grupo[["Hombres"]]$etiqueta
Tramo_MayorStock_M  <- cmp_stock$por_grupo[["Mujeres"]]$etiqueta
Mismo_Tramo_Mayor   <- cmp_stock$coinciden

# ── 5. Gráfico de series apiladas — composición histórica por tramo ────────────
# Acá el set compartido SÍ se lee como escala ordinal, corto→largo. En motivo y
# razón el mismo set no significa eso: no copies el orden entre módulos.
colores_dur_desempleo <- setNames(
  colores_desocupados_detalle,
  c("Menos de 1 mes", "1 a 3 meses", "4 a 6 meses", "7 a 12 meses",
    "13 a 15 meses", "16 a 18 meses", "Más de 18 meses")
)

base_comp_dur_desempleo <- dt_ENE_compuesta %>%
  filter(
    sexo == "AS",
    categoria %in% categorias_dur_desempleo,
    fecha >= fecha6annos, fecha <= fecha_DurDes_Actual
  ) %>%
  mutate(Tramo = str_remove(categoria, "^Desocupados ")) %>%
  group_by(fecha, Tramo) %>%
  summarise(valor = sum(valor, na.rm = TRUE), .groups = "drop") %>%
  group_by(fecha) %>%
  mutate(pct = round(valor / sum(valor, na.rm = TRUE) * 100, 1)) %>%
  ungroup() %>%
  mutate(Tramo = factor(Tramo, levels = c(
    "Menos de 1 mes", "1 a 3 meses", "4 a 6 meses", "7 a 12 meses",
    "13 a 15 meses", "16 a 18 meses", "Más de 18 meses"
  )))

gr_Comp_DurDesempleo <- ggplot(base_comp_dur_desempleo,
                               aes(x = fecha, y = pct, fill = Tramo)) +
  geom_area(position = "stack", alpha = 0.85, na.rm = TRUE) +
  scale_fill_manual(values = colores_dur_desempleo) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), limits = c(0, NA)) +
  labs(
    title    = "Gráfico: Composición de desocupados por duración de la cesantía",
    subtitle = "Participación porcentual de cada tramo en el total de desocupados",
    x = NULL, y = "Porcentaje", fill = "Duración",
    caption  = "Fuente: Elaboración propia en base a datos ENE."
  ) +
  fc_tema_grafico(extra = theme(panel.grid.minor = element_blank())) +
  guides(fill = guide_legend(nrow = 2))

message("Duración desempleo: ft_DurDesempleo_Sexo y gr_Comp_DurDesempleo listas")

# Peso relativo del tramo de mayor alza: inicio de serie vs. trimestre actual.
fecha_DurDes_InicioSerie <- min(base_comp_dur_desempleo$fecha)
pct_tramo_top <- base_comp_dur_desempleo %>%
  filter(Tramo == Tramo_MayorAlzaMensual) %>% arrange(fecha)
DurTop_Pct_Ini <- pct_tramo_top$pct[1]
DurTop_Pct_Act <- pct_tramo_top$pct[nrow(pct_tramo_top)]