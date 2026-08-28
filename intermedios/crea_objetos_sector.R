# crea_objetos_sector.R - v14 - 28-08-2026

if (!exists("fc_init_motor"))
  source(file.path(dirname(getwd()), "Bibliotecas_R", "funciones_pipeline.R"))

fc_init_motor(c("dplyr", "tidyr", "tibble"))

# ══════════════════════════════════════════════════════════════════════════════
# ANEXO 1 — Sector económico (A1)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


# ______________________________________________________________________________
# TABLA — Empleos formales por sector económico ####
# ______________________________________________________________________________

cats_rama_form <- c(
  "Agricultura, ganadería, silvicultura y pesca formal",
  "Explotación de minas y canteras formal",
  "Industrias manufactureras formal",
  "Suministro de electricidad, gas, vapor y aire acondicionado formal",
  "Suministro de agua formal", "Construcción formal",
  "Comercio al por mayor y al por menor formal",
  "Transporte y almacenamiento formal",
  "Actividades de alojamiento y de servicio de comidas formal",
  "Información y comunicaciones formal",
  "Actividades financieras y de seguros formal",
  "Actividades inmobiliarias formal",
  "Actividades profesionales, científicas y técnicas formal",
  "Actividades de servicios administrativos y de apoyo formal",
  "Administración pública y defensa formal", "Enseñanza formal",
  "Actividades de atención de la salud humana y de asistencia social formal",
  "Actividades artísticas, de entretenimiento y recreativas formal",
  "Otras actividades de servicios formal",
  "Actividades de los hogares como empleadores formal",
  "Actividades de organizaciones y órganos extraterritoriales formal",
  "No sabe - No responde formal"
)

labels_rama_form <- c(
  "Agricultura, ganadería, silvicultura y pesca",
  "Explotación de minas y canteras", "Industrias manufactureras",
  "Suministro de electricidad, gas, vapor y aire acondicionado",
  "Suministro de agua", "Construcción",
  "Comercio al por mayor y al por menor", "Transporte y almacenamiento",
  "Actividades de alojamiento y de servicio de comidas",
  "Información y comunicaciones", "Actividades financieras y de seguros",
  "Actividades inmobiliarias",
  "Actividades profesionales, científicas y técnicas",
  "Actividades de servicios administrativos y de apoyo",
  "Administración pública y defensa", "Enseñanza",
  "Actividades de atención de la salud humana y de asistencia social",
  "Actividades artísticas, de entretenimiento y recreativas",
  "Otras actividades de servicios",
  "Actividades de los hogares como empleadores",
  "Actividades de organizaciones y órganos extraterritoriales",
  "No sabe/No responde"
)

base_rama_form <- dt_ENE_compuesta %>%
  filter(sexo == "AS", categoria %in% cats_rama_form,
         fecha %in% c(fecha_Actual, fecha_MesAnterior, fecha1annos)) %>%
  pivot_wider(id_cols = categoria, names_from = fecha, values_from = valor) %>%
  rename(val_act = as.character(fecha_Actual),
         val_mes = as.character(fecha_MesAnterior),
         val_año = as.character(fecha1annos)) %>%
  mutate(
    dif_mes = val_act - val_mes,
    dif_año = val_act - val_año,
    Sector  = labels_rama_form[match(categoria, cats_rama_form)]
  ) %>%
  arrange(match(categoria, cats_rama_form)) %>%
  select(Sector, val_act, dif_mes, dif_año)

fila_nsr <- data.frame(
  Sector  = "No sabe/No responde",
  val_act = Val_Act_OcupFrm_AS  - sum(base_rama_form$val_act,  na.rm = TRUE),
  dif_mes = Delta_Mes_OcupFrm_AS - sum(base_rama_form$dif_mes, na.rm = TRUE),
  dif_año = Delta_Año_OcupFrm_AS - sum(base_rama_form$dif_año, na.rm = TRUE),
  stringsAsFactors = FALSE
)

fila_total_1a <- data.frame(
  Sector  = "Total ocupados formales",
  val_act = Val_Act_OcupFrm_AS,
  dif_mes = Delta_Mes_OcupFrm_AS,
  dif_año = Delta_Año_OcupFrm_AS,
  stringsAsFactors = FALSE
)

dt_t1a <- bind_rows(base_rama_form, fila_nsr, fila_total_1a)

ft_Empleos_Sector_y_d12m <- fc_formatear_tabla(
  dt_t1a,
  columnas = list(
    Sector  = list(tipo = "texto"),
    val_act = list(tipo = "numero", decimales = 0,
                   label = paste0("Trimestre actual\n(", fc_fecha_a_trimestre(fecha_Actual), ")")),
    dif_mes = list(tipo = "flecha", decimales = 0, es_bueno = TRUE,
                   label = "Diferencia\ntrimestre móvil\nanterior"),
    dif_año = list(tipo = "flecha", decimales = 0, es_bueno = TRUE,
                   label = "Diferencia\ninteranual")
  ),
  fila_negrita = nrow(dt_t1a),
  titulo       = "Tabla: Empleo formal por sector económico, delta mes y año",
  ancho_col1   = 2.8
)


# ══════════════════════════════════════════════════════════════════════════════
# TABLAS DE SEGMENTOS por rama — femenización, informalidad y brecha de género ####
# ══════════════════════════════════════════════════════════════════════════════

labels_rama <- c(
  "Agricultura, ganadería, silvicultura y pesca",
  "Explotación de minas y canteras", "Industrias manufactureras",
  "Suministro de electricidad, gas, vapor y aire acondicionado",
  "Suministro de agua", "Construcción",
  "Comercio al por mayor y al por menor", "Transporte y almacenamiento",
  "Actividades de alojamiento y de servicio de comidas",
  "Información y comunicaciones", "Actividades financieras y de seguros",
  "Actividades inmobiliarias",
  "Actividades profesionales, científicas y técnicas",
  "Actividades de servicios administrativos y de apoyo",
  "Administración pública y defensa", "Enseñanza",
  "Actividades de atención de la salud humana y de asistencia social",
  "Actividades artísticas, de entretenimiento y recreativas",
  "Otras actividades de servicios",
  "Actividades de los hogares como empleadores",
  "Actividades de organizaciones y órganos extraterritoriales"
)
# InformeBBDD entrega total, formal e informal bajo una definición coherente.
# La distinción b14 queda encapsulada aguas arriba y no requiere advertencia.
nota_rama <- "Fuente: Instituto Nacional de Estadísticas (INE)."

cats_form_rama <- paste(labels_rama, "formal")
cats_inf_rama  <- paste(labels_rama, "informal")

# ── TABLA 1b: Feminización del empleo por rama (proporción inline, pastel) ─────
tot_fem <- dt_ENE_compuesta %>%
  filter(fecha == fecha_Actual, sexo %in% c("H", "M"), categoria %in% labels_rama) %>%
  select(categoria, sexo, valor) %>%
  pivot_wider(names_from = sexo, values_from = valor) %>%
  filter(!is.na(H), !is.na(M)) %>%
  transmute(Sector = categoria,
            Ocupados = round(H + M, 0),
            Feminización = round(100 * M / (H + M), 1))

fila_fem <- tibble::tibble(Sector = "Total ramas",
                           Ocupados = sum(tot_fem$Ocupados),
                           Feminización = round(100 * sum(dt_ENE_compuesta %>%
                                                            filter(fecha==fecha_Actual, sexo=="M", categoria %in% labels_rama) %>%
                                                            pull(valor), na.rm=TRUE) / sum(tot_fem$Ocupados), 1))

dt_t1b <- bind_rows(tot_fem %>% arrange(desc(Feminización)), fila_fem)

ft_Sector_Feminizacion <- fc_formatear_tabla(
  dt_t1b,
  filas = fc_filas_categorias(col = "Sector", total = nrow(dt_t1b)),
  columnas = list(
    Sector       = list(tipo = "texto"),
    Ocupados     = list(tipo = "numero",  decimales = 0),
    Feminización = list(tipo = "ranking", escala = "pastel", decimales = 1)
  ),
  fila_negrita = nrow(dt_t1b),
  titulo = paste("Tabla: Feminización del empleo por rama de actividad a",
                 fc_fecha_a_trimestre(fecha_Actual)))

# ── TABLA 1c: Informalidad del empleo por rama (proporción inline, semáforo) ───
form_as <- dt_ENE_compuesta %>%
  filter(fecha == fecha_Actual, sexo == "AS", categoria %in% cats_form_rama) %>%
  mutate(Sector = gsub(" formal$", "", categoria)) %>% select(Sector, F_ = valor)
inf_as <- dt_ENE_compuesta %>%
  filter(fecha == fecha_Actual, sexo == "AS", categoria %in% cats_inf_rama) %>%
  mutate(Sector = gsub(" informal$", "", categoria)) %>% select(Sector, I_ = valor)

tot_inf <- form_as %>% inner_join(inf_as, by = "Sector") %>%
  filter(!is.na(F_), !is.na(I_)) %>%
  transmute(Sector, Ocupados = round(F_ + I_, 0),
            Informalidad = round(100 * I_ / (F_ + I_), 1))

fila_inf <- tibble::tibble(Sector = "Total ramas",
                           Ocupados = sum(tot_inf$Ocupados),
                           Informalidad = round(100 * sum(inf_as$I_, na.rm=TRUE) / sum(tot_inf$Ocupados), 1))

dt_t1c <- bind_rows(tot_inf %>% arrange(desc(Informalidad)), fila_inf)

ft_Sector_Informalidad <- fc_formatear_tabla(
  dt_t1c,
  filas = fc_filas_categorias(col = "Sector", total = nrow(dt_t1c)),
  columnas = list(
    Sector       = list(tipo = "texto"),
    Ocupados     = list(tipo = "numero",  decimales = 0),
    Informalidad = list(tipo = "ranking", escala = "semaforo", decimales = 1)
  ),
  fila_negrita = nrow(dt_t1c),
  titulo = paste("Tabla: Informalidad del empleo por rama de actividad a",
                 fc_fecha_a_trimestre(fecha_Actual)),
  nota = nota_rama)

# ── TABLA 1d: Informalidad AS (ranking, semáforo) + brecha de género (H-M, muda) ─
# La brecha va sin color a propósito: su signo ya se lee solo. El semáforo se
# reserva al ranking, que sí tiene rango que colorear.
inf_por_sexo <- function(sx) {
  f <- dt_ENE_compuesta %>% filter(fecha==fecha_Actual, sexo==sx, categoria %in% cats_form_rama) %>%
    mutate(Sector = gsub(" formal$","",categoria)) %>% select(Sector, f=valor)
  i <- dt_ENE_compuesta %>% filter(fecha==fecha_Actual, sexo==sx, categoria %in% cats_inf_rama) %>%
    mutate(Sector = gsub(" informal$","",categoria)) %>% select(Sector, i=valor)
  f %>% inner_join(i, by="Sector") %>% transmute(Sector, tasa = 100 * i / (f + i))
}

# Sin este umbral el argmax cae en ramas de muy pocos ocupados, donde una brecha
# de decenas de puntos no dice nada.
Umbral_Base_Rama <- ceiling(0.02 * sum(tot_inf$Ocupados, na.rm = TRUE) / 1000) * 1000

brecha_tabla_base <- inf_por_sexo("H") %>% rename(inf_H = tasa) %>%
  inner_join(inf_por_sexo("M") %>% rename(inf_M = tasa), by="Sector") %>%
  inner_join(tot_inf %>% select(Sector, Informalidad, Ocupados), by="Sector") %>%
  transmute(Sector,
            `Brecha (H-M)` = round(inf_H - inf_M, 1),
            Informalidad = round(Informalidad, 1),
            Ocupados) %>%
  filter(!is.na(`Brecha (H-M)`)) %>%
  arrange(desc(Informalidad))

# Ocupados no se poda: no está en la receta, así que no se imprime, pero viaja
# colgada y fc_con_base() la usa como umbral de base muestral.
ft_Sector_Brecha_Inf <- fc_formatear_tabla(
  brecha_tabla_base,
  columnas = list(
    Sector           = list(tipo = "texto"),
    `Brecha (H-M)`   = list(tipo = "numero",  decimales = 1),
    Informalidad     = list(tipo = "ranking", escala = "semaforo", decimales = 1)
  ),
  filas = fc_filas_categorias(col = "Sector"),
  titulo = paste("Tabla: Informalidad y brecha de género por rama a",
                 fc_fecha_a_trimestre(fecha_Actual)),
  nota = nota_rama)

# ── Variables narrativas para el discurso de la sección 5.4 ────────────────────
# Conteos sobre la tabla completa, para que cuadren con lo impreso; superlativo
# solo sobre las ramas con base suficiente.
N_Ramas_Brecha_Inf        <- nrow(fc_cuerpo(ft_Sector_Brecha_Inf))
N_Ramas_BrechaInf_Hombres <- fc_cuantas(ft_Sector_Brecha_Inf, "Brecha (H-M)", function(x) x > 0)$n
N_Ramas_BrechaInf_Mujeres <- fc_cuantas(ft_Sector_Brecha_Inf, "Brecha (H-M)", function(x) x < 0)$n

h_br <- fc_extremo_abs(fc_con_base(ft_Sector_Brecha_Inf, "Ocupados", Umbral_Base_Rama),
                       "Brecha (H-M)")
Hay_Rama_MayorBrechaInf <- !is.null(h_br)

if (Hay_Rama_MayorBrechaInf) {
  Rama_MayorBrechaInf  <- h_br$etiqueta
  Valor_MayorBrechaInf <- h_br$valor
  Signo_MayorBrechaInf <- h_br$signo
} else {
  Rama_MayorBrechaInf  <- NA_character_
  Valor_MayorBrechaInf <- NA_real_
  Signo_MayorBrechaInf <- NA_real_
}

# ── Análisis agrupado por áreas económicas (macrosectores) ────────────────────
# El área NO es derivable del código de rama: necesita este mapeo. Por eso las
# tres tablas de área se recalculan y no se agregan desde las de rama.
# Criterio de cada grupo: manual, § Macro-áreas económicas.

df_mapeo_areas <- tibble::tibble(
  Sector = labels_rama,
  Area_Economica = case_when(
    # Categoría 1: Servicios Públicos, Sociales y Estratégicos (Alta Formalidad)
    Sector %in% c("Enseñanza", 
                  "Actividades de atención de la salud humana y de asistencia social", 
                  "Administración pública y defensa") ~ "Servicios Públicos y de Protección Social",
    
    # Categoría 2: Servicios a Empresas y Profesionales
    Sector %in% c("Actividades financieras y de seguros",
                  "Actividades profesionales, científicas y técnicas",
                  "Actividades inmobiliarias",
                  "Información y comunicaciones",
                  "Actividades de organizaciones y órganos extraterritoriales") ~ "Servicios a Empresas y Profesionales",
    
    # Categoría 3: Servicios Personales, Comunitarios y del Hogar
    Sector %in% c("Actividades de los hogares como empleadores", 
                  "Otras actividades de servicios",
                  "Actividades de servicios administrativos y de apoyo",
                  "Actividades artísticas, de entretenimiento y recreativas") ~ "Servicios Personales, Comunitarios y del Hogar",
    
    Sector %in% c("Comercio al por mayor y al por menor", 
                  "Transporte y almacenamiento", 
                  "Actividades de alojamiento y de servicio de comidas") ~ "Comercio, Transportes y Hotelería",
    
    Sector %in% c("Explotación de minas y canteras", 
                  "Industrias manufactureras", 
                  "Agricultura, ganadería, silvicultura y pesca", 
                  "Suministro de electricidad, gas, vapor y aire acondicionado", 
                  "Suministro de agua") ~ "Sectores Productivos e Industriales",
    
    Sector == "Construcción" ~ "Construcción e Infraestructura",
    
    TRUE ~ NA_character_  # no debiera quedar ningún sector sin asignar; si aparece NA, falta clasificarlo
  )
)



# ── NUEVA TABLA: Informalidad del empleo por Área Económica ───────────────────
tot_inf_areas <- form_as %>% 
  inner_join(inf_as, by = "Sector") %>%
  left_join(df_mapeo_areas, by = "Sector") %>%
  group_by(Area_Economica) %>%
  summarise(
    F_ = sum(F_, na.rm = TRUE),
    I_ = sum(I_, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  transmute(
    `Área Económica` = Area_Economica,
    Ocupados = round(F_ + I_, 0),
    Informalidad = round(100 * I_ / (F_ + I_), 1)
  ) %>%
  arrange(desc(Informalidad))

fila_inf_areas_total <- tibble::tibble(
  `Área Económica` = "Total Nacional",
  Ocupados = sum(tot_inf_areas$Ocupados),
  Informalidad = round(100 * sum(inf_as$I_, na.rm = TRUE) / sum(tot_inf_areas$Ocupados), 1)
)

dt_areas_t1c <- bind_rows(tot_inf_areas, fila_inf_areas_total)

ft_Area_Informalidad <- fc_formatear_tabla(
  dt_areas_t1c,
  filas = fc_filas_categorias(col = "Área Económica", total = nrow(dt_areas_t1c)),
  columnas = list(
    `Área Económica` = list(tipo = "texto"),
    Ocupados         = list(tipo = "numero",  decimales = 0),
    Informalidad     = list(tipo = "ranking", escala = "semaforo", decimales = 1)
  ),
  fila_negrita = nrow(dt_areas_t1c),
  titulo = paste("Tabla: Informalidad del empleo por Área Económica a",
                 fc_fecha_a_trimestre(fecha_Actual)),
  nota = nota_rama
)


# ── NUEVA TABLA: Feminización del empleo por Área Económica ───────────────────
tot_fem_areas <- dt_ENE_compuesta %>%
  filter(fecha == fecha_Actual, sexo %in% c("H", "M"), categoria %in% labels_rama) %>%
  select(categoria, sexo, valor) %>%
  pivot_wider(names_from = sexo, values_from = valor) %>%
  rename(Sector = categoria) %>%
  left_join(df_mapeo_areas, by = "Sector") %>%
  group_by(Area_Economica) %>%
  summarise(
    H = sum(H, na.rm = TRUE),
    M = sum(M, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  transmute(
    `Área Económica` = Area_Economica,
    Ocupados = round(H + M, 0),
    Feminización = round(100 * M / (H + M), 1)
  ) %>%
  arrange(desc(Feminización))

fila_fem_areas_total <- tibble::tibble(
  `Área Económica` = "Total Nacional",
  Ocupados = sum(tot_fem_areas$Ocupados),
  Feminización = round(100 * sum(dt_ENE_compuesta %>%
                                   filter(fecha == fecha_Actual, sexo == "M", categoria %in% labels_rama) %>%
                                   pull(valor), na.rm = TRUE) / sum(tot_fem_areas$Ocupados), 1)
)

dt_areas_t1b <- bind_rows(tot_fem_areas, fila_fem_areas_total)

ft_Area_Feminizacion <- fc_formatear_tabla(
  dt_areas_t1b,
  filas = fc_filas_categorias(col = "Área Económica", total = nrow(dt_areas_t1b)),
  columnas = list(
    `Área Económica` = list(tipo = "texto"),
    Ocupados         = list(tipo = "numero",  decimales = 0),
    Feminización     = list(tipo = "ranking", escala = "pastel", decimales = 1)
  ),
  fila_negrita = nrow(dt_areas_t1b),
  titulo = paste("Tabla: Feminización del empleo por Área Económica a",
                 fc_fecha_a_trimestre(fecha_Actual))
)


# ── NUEVA TABLA: Informalidad y brecha de género por Área Económica ───────────
inf_por_sexo_area <- function(sx) {
  f <- dt_ENE_compuesta %>% filter(fecha == fecha_Actual, sexo == sx, categoria %in% cats_form_rama) %>%
    mutate(Sector = gsub(" formal$", "", categoria)) %>% select(Sector, f = valor)
  i <- dt_ENE_compuesta %>% filter(fecha == fecha_Actual, sexo == sx, categoria %in% cats_inf_rama) %>%
    mutate(Sector = gsub(" informal$", "", categoria)) %>% select(Sector, i = valor)
  
  f %>% 
    inner_join(i, by = "Sector") %>% 
    left_join(df_mapeo_areas, by = "Sector") %>%
    group_by(Area_Economica) %>%
    summarise(f = sum(f, na.rm = TRUE), i = sum(i, na.rm = TRUE), .groups = "drop") %>%
    transmute(Area_Economica, tasa = 100 * i / (f + i))
}

brecha_tabla_areas <- inf_por_sexo_area("H") %>% rename(inf_H = tasa) %>%
  inner_join(inf_por_sexo_area("M") %>% rename(inf_M = tasa), by = "Area_Economica") %>%
  inner_join(tot_inf_areas %>% select(`Área Económica`, Informalidad), by = c("Area_Economica" = "Área Económica")) %>%
  transmute(
    `Área Económica` = Area_Economica,
    `Brecha (H-M)`   = round(inf_H - inf_M, 1),
    Informalidad     = round(Informalidad, 1)
  ) %>%
  arrange(desc(Informalidad))

ft_Area_Brecha_Inf <- fc_formatear_tabla(
  brecha_tabla_areas,
  filas = fc_filas_categorias(col = "Área Económica", total = nrow(brecha_tabla_areas)),
  columnas = list(
    `Área Económica` = list(tipo = "texto"),
    `Brecha (H-M)`   = list(tipo = "numero",  decimales = 1),
    Informalidad     = list(tipo = "ranking", escala = "semaforo", decimales = 1)
  ),
  titulo = paste("Tabla: Informalidad y brecha de género por Área Económica a",
                 fc_fecha_a_trimestre(fecha_Actual)),
  nota = nota_rama
)

# ── Variables narrativas para el discurso macro de áreas ──────────────────────
N_Areas_Analizadas        <- nrow(brecha_tabla_areas)
Area_Mayor_Informalidad   <- fc_extremo(ft_Area_Brecha_Inf, "Informalidad", "max")$etiqueta
Area_Mayor_Feminizacion   <- fc_extremo(ft_Area_Feminizacion, "Feminización", "max")$etiqueta


# ── Variables dinámicas del texto discursivo de macro-áreas (sección 5.4a) ────
# fc_valor() se detiene listando las etiquetas existentes si el nombre no calza.
# No volver al filter() por cadena literal: devolvía cero filas en silencio.
Inf_Construccion <- fc_valor(ft_Area_Informalidad, "Construcción e Infraestructura", "Informalidad")
Fem_Construccion <- fc_valor(ft_Area_Feminizacion, "Construcción e Infraestructura", "Feminización")
Brecha_Construccion <- fc_valor(ft_Area_Brecha_Inf, "Construcción e Infraestructura", "Brecha (H-M)")

Inf_ServPublicos <- fc_valor(ft_Area_Informalidad, "Servicios Públicos y de Protección Social", "Informalidad")
Fem_ServPublicos <- fc_valor(ft_Area_Feminizacion, "Servicios Públicos y de Protección Social", "Feminización")

Inf_ServPersonales <- fc_valor(ft_Area_Informalidad, "Servicios Personales, Comunitarios y del Hogar", "Informalidad")
Fem_ServPersonales <- fc_valor(ft_Area_Feminizacion, "Servicios Personales, Comunitarios y del Hogar", "Feminización")
Brecha_ServPersonales <- fc_valor(ft_Area_Brecha_Inf, "Servicios Personales, Comunitarios y del Hogar", "Brecha (H-M)")

Inf_ServEmpresas <- fc_valor(ft_Area_Informalidad, "Servicios a Empresas y Profesionales", "Informalidad")
Fem_ServEmpresas <- fc_valor(ft_Area_Feminizacion, "Servicios a Empresas y Profesionales", "Feminización")
Brecha_ServEmpresas <- fc_valor(ft_Area_Brecha_Inf, "Servicios a Empresas y Profesionales", "Brecha (H-M)")

Ocup_Comercio <- fc_valor(ft_Area_Informalidad, "Comercio, Transportes y Hotelería", "Ocupados")
Fem_Comercio <- fc_valor(ft_Area_Feminizacion, "Comercio, Transportes y Hotelería", "Feminización")
Inf_Comercio <- fc_valor(ft_Area_Informalidad, "Comercio, Transportes y Hotelería", "Informalidad")
Brecha_Comercio <- fc_valor(ft_Area_Brecha_Inf, "Comercio, Transportes y Hotelería", "Brecha (H-M)")

message("Macro-Áreas: Las 3 tablas agrupadas (Area_Feminizacion, Area_Informalidad, Area_Brecha_Inf) listas con fc_formatear_tabla")

SecMes <- fc_sector_resumen(ft_Empleos_Sector_y_d12m, "dif_mes")
SecAno <- fc_sector_resumen(ft_Empleos_Sector_y_d12m, "dif_año")

# ── Estructura sectorial territorial: especialización y tendencia ───────────
# Solo para minutas regionales. La selección favorece ramas con peso, con
# especialización frente al país o con cambio material de participación.
if (exists("es_informe_regional") && es_informe_regional) {
  fc_sector_participacion <- function(dt) {
    total <- dt %>% filter(sexo == "AS", categoria == "Ocupados",
                           fecha %in% c(fecha_Actual, fecha1annos)) %>%
      select(fecha, total = valor)
    dt %>% filter(sexo == "AS", categoria %in% labels_rama,
                 fecha %in% c(fecha_Actual, fecha1annos)) %>%
      select(fecha, Sector = categoria, valor) %>%
      left_join(total, by = "fecha") %>%
      mutate(participacion = 100 * valor / total) %>%
      select(fecha, Sector, participacion)
  }
  part_region <- fc_sector_participacion(dt_ENE_compuesta) %>%
    pivot_wider(names_from = fecha, values_from = participacion) %>%
    rename(part_reg_actual = as.character(fecha_Actual),
           part_reg_anio = as.character(fecha1annos))
  part_nacional <- fc_sector_participacion(dt_ENE_nacional) %>%
    filter(fecha == fecha_Actual) %>%
    transmute(Sector, part_nac_actual = participacion)
  estructura_sectorial_territorial <- part_region %>%
    inner_join(part_nacional, by = "Sector") %>%
    mutate(especializacion = part_reg_actual / part_nac_actual,
           cambio_pp_12m = part_reg_actual - part_reg_anio,
           relevante = part_reg_actual >= 3 | especializacion >= 1.3 | abs(cambio_pp_12m) >= 1) %>%
    filter(relevante) %>%
    mutate(prioridad = pmax(part_reg_actual / 3, especializacion / 1.3,
                            abs(cambio_pp_12m) / 1)) %>%
    arrange(desc(prioridad), desc(part_reg_actual)) %>%
    slice_head(n = 6) %>%
    arrange(desc(part_reg_actual))

  ft_Estructura_Sectorial_Territorial <- fc_formatear_tabla(
    estructura_sectorial_territorial %>%
      transmute(Sector,
                `Empleo regional` = round(part_reg_actual, 1),
                `Empleo nacional` = round(part_nac_actual, 1),
                Especialización = round(especializacion, 2),
                `Diferencia interanual` = round(cambio_pp_12m, 1)),
    columnas = list(
      Sector = list(tipo = "texto"),
      `Empleo regional` = list(tipo = "numero", decimales = 1, label = "Empleo regional\n(%)"),
      `Empleo nacional` = list(tipo = "numero", decimales = 1, label = "Empleo nacional\n(%)"),
      Especialización = list(tipo = "numero", decimales = 2),
      `Diferencia interanual` = list(tipo = "flecha", decimales = 1,
                                     es_bueno = TRUE,
                                     label = "Diferencia\ninteranual (pp.)")
    ),
    titulo = paste0("Tabla: Estructura y especialización sectorial de ", params$region_label),
    nota = "Especialización = participación del sector en el empleo regional / participación nacional. Un valor mayor que 1 indica sobrerrepresentación regional.",
    # Las ramas caben en dos líneas; priorizamos las cuatro medidas comparables.
    ancho_col1 = 2.05
  )

  gr_Estructura_Sectorial_Territorial <- estructura_sectorial_territorial %>%
    select(Sector, Regional = part_reg_actual, Nacional = part_nac_actual) %>%
    pivot_longer(-Sector, names_to = "Referencia", values_to = "participacion") %>%
    ggplot(aes(x = reorder(Sector, participacion), y = participacion, fill = Referencia)) +
    geom_col(position = position_dodge(width = 0.75), width = 0.65) +
    coord_flip() +
    scale_fill_manual(values = c("Regional" = col_neutro, "Nacional" = "#BFBFBF")) +
    labs(title = paste0("Gráfico: Sectores seleccionados de ", params$region_label),
         subtitle = "Participación en el empleo regional frente a la referencia nacional",
         x = NULL, y = "Porcentaje del empleo", fill = NULL,
         caption = "Fuente: Elaboración propia en base a datos ENE.") +
    fc_tema_grafico()
}

# ── Macro-área más informal y su contraejemplo ───────────────────────────────
# Todo se indexa por el mismo argmax para que el nombre del área y sus atributos
# no puedan desincronizarse. El contraejemplo se busca en el extremo opuesto de
# feminización, así el texto vale igual si el área más informal resulta
# feminizada o masculinizada.
areas_inf_fem <- brecha_tabla_areas %>%
  inner_join(tot_fem_areas %>% select(`Área Económica`, Feminización),
             by = "Área Económica")

i_inf <- which.max(areas_inf_fem$Informalidad)
Area_Inf_Nom   <- areas_inf_fem$`Área Económica`[i_inf]
Area_Inf_Val   <- areas_inf_fem$Informalidad[i_inf]
Area_Inf_Fem   <- areas_inf_fem$Feminización[i_inf]
Area_Inf_EsFem <- Area_Inf_Fem > 50

otras <- areas_inf_fem[-i_inf, ]
cand  <- if (Area_Inf_EsFem) otras[otras$Feminización <= 50, ] else otras[otras$Feminización > 50, ]
if (nrow(cand) == 0) cand <- otras
j <- which.max(cand$Informalidad)
Area_Ctr_Nom <- cand$`Área Económica`[j]
Area_Ctr_Val <- cand$Informalidad[j]
Area_Ctr_Fem <- cand$Feminización[j]
Area_Ctr_Br  <- cand$`Brecha (H-M)`[j]
Area_Ctr_Rank <- which(areas_inf_fem$`Área Económica` == Area_Ctr_Nom)

# ── Extremos de las tablas de ranking por rama ───────────────────────────────
# La fila de total está declarada, así que fc_extremo la excluye sola. Indexar a
# mano fue lo que produjo "hasta 26,9% en Total ramas".
h_inf_a <- fc_extremo(ft_Sector_Informalidad, "Informalidad", "max")
h_inf_b <- fc_extremo(ft_Sector_Informalidad, "Informalidad", "min")
Rama_Inf_Alta <- h_inf_a$etiqueta; Rama_Inf_AltaVal <- h_inf_a$valor
Rama_Inf_Baja <- h_inf_b$etiqueta; Rama_Inf_BajaVal <- h_inf_b$valor

h_fem_a <- fc_extremo(ft_Sector_Feminizacion, "Feminización", "max")
h_fem_b <- fc_extremo(ft_Sector_Feminizacion, "Feminización", "min")
Rama_Fem_Alta <- h_fem_a$etiqueta; Rama_Fem_AltaVal <- h_fem_a$valor
Rama_Fem_Baja <- h_fem_b$etiqueta; Rama_Fem_BajaVal <- h_fem_b$valor
