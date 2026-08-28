# crea_objetos_razon_fft.R - v3 - 12-08-2026

# Librerías ####
if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "ggplot2", "tibble"))


# ── Categorías de razones FFT — única fuente para tabla y gráfico ─────────────
# Llave canónica y etiqueta visible en columnas separadas: no derivar la segunda
# recortando la primera, o un cambio de canon se publica solo.
razones_fft <- tibble::tribble(
  ~categoria,                                                        ~etiqueta,
  "Fuera de la fuerza de trabajo por razones familiares permanentes", "Razones familiares permanentes",
  "Fuera de la fuerza de trabajo por estudio",                        "Razones de estudio",
  "Fuera de la fuerza de trabajo por jubilación",                     "Razones de jubilación",
  "Fuera de la fuerza de trabajo por pensión o montepío",             "Razones de pensión o montepiado",
  "Fuera de la fuerza de trabajo por razones de salud permanentes",   "Razones de salud permanentes",
  "Fuera de la fuerza de trabajo por razones personales temporales",  "Razones personales temporales",
  "Fuera de la fuerza de trabajo sin deseos de trabajar",             "Sin deseos de trabajar",
  "Fuera de la fuerza de trabajo por razones estacionales",           "Razones estacionales",
  "Fuera de la fuerza de trabajo por desaliento",                     "Razones de desaliento",
  "Fuera de la fuerza de trabajo por otras razones",                  "Otras razones"
)

cats_fft <- razones_fft$categoria

# ══════════════════════════════════════════════════════════════════════════════
# CAPÍTULO 3.2 — Razones fuera de la fuerza de trabajo (c3s2)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


# ______________________________________________________________________________
# TABLA 2: Razones FFT ####
# ______________________________________________________________________________

fft_base <- dt_ENE_compuesta %>%
  filter(fecha     == fecha_Actual,
         sexo      %in% c("H", "M"),
         categoria %in% cats_fft) %>%
  left_join(razones_fft, by = "categoria") %>%
  select(Categoria = etiqueta, sexo_label, valor)

fft_tabla <- fft_base %>%
  pivot_wider(names_from = sexo_label, values_from = valor) %>%
  filter(!is.na(Hombres), !is.na(Mujeres)) %>%
  transmute(Categoria,
            Total = round(Hombres + Mujeres, 0),
            Femenización = round(100 * Mujeres / (Hombres + Mujeres), 1))

fila_fft <- tibble::tibble(Categoria = "Total razones",
                           Total = sum(fft_tabla$Total),
                           Femenización = round(100 * sum(fft_base$valor[fft_base$sexo_label=="Mujeres"], na.rm=TRUE) /
                                                  sum(fft_tabla$Total), 1))

# Femenización = signo AMBIGUO → escala pastel (ordena sin sentenciar).
dt_fft <- bind_rows(fft_tabla %>% arrange(desc(Femenización)), fila_fft)

ft_Razon_FFT <- fc_formatear_tabla(
  dt_fft,
  columnas = list(
    Categoria    = list(tipo = "texto"),
    Total        = list(tipo = "numero",  decimales = 0),
    Femenización = list(tipo = "ranking", escala = "pastel", decimales = 1)
  ),
  fila_negrita = nrow(dt_fft),
  titulo = paste("Tabla: Razones para estar fuera de la fuerza de trabajo a",
                 fc_fecha_a_trimestre(fecha_Actual)))


# GRÁFICO 3: Razones para no participar en la FT (FFT) ####
# ______________________________________________________________________________

gr_Razon_No_part <- dt_ENE_compuesta %>%
  filter(
    fecha     == fecha_Actual,
    sexo      %in% c("H", "M"),
    categoria %in% cats_fft
  ) %>%
  group_by(categoria) %>%
  mutate(
    porcentaje = valor / sum(valor, na.rm = TRUE) * 100,
    porcentaje = if_else(sexo_label == "Mujeres", -porcentaje, porcentaje)
  ) %>%
  ungroup() %>%
  left_join(razones_fft, by = "categoria") %>%
  ggplot(aes(x = etiqueta, y = porcentaje, fill = sexo_label)) +
  geom_col(width = 0.8) +
  geom_text(aes(label = paste0(abs(round(porcentaje, 1)), "%")),
            position = position_stack(vjust = 0.5), size = 3) +
  coord_flip() +
  scale_fill_manual(values = colores_sexo) +
  scale_y_continuous(labels = function(x) paste0(abs(x), "%")) +
  labs(
    title    = "Gráfico: Caracterización de razones para no participar en la fuerza de trabajo",
    subtitle = "Porcentaje dentro de cada categoría (mujeres a la izquierda, hombres a la derecha)",
    x = NULL, y = "Porcentaje"
  ) +
  fc_tema_grafico()

# ______________________________________________________________________________