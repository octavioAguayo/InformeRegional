# crea_objetos_ind_varios.R - v3 - 12-08-2026
# Sin dependencias de paquetes: consume tablas ya construidas.


# ══════════════════════════════════════════════════════════════════════════════
# ANEXO 3 — Indicadores varios (A3)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════


# TABLAS VARIACIÓN ENTRE PERÍODOS (fc_tabla_cambio_generica) ####
# La regla de color la fija color_delta(), única fuente. Ver el manual,
# § Regla de color semántico — no reimplementarla ni describirla acá.

# Los tres cortes se capturan como objetos: alimentan la tabla formateada y las
# variables narrativas del anexo.
tc_as_mes <- tabla_cambio(res_filtrado, Fechas["mes_anterior"], Fechas["actual"], sexo = "AS")
tc_as_ano <- tabla_cambio(res_filtrado, Fechas["a_1_anno"],     Fechas["actual"], sexo = "AS")
tc_as_pre <- tabla_cambio(res_filtrado, Fechas["Fin_Covid"],    Fechas["actual"], sexo = "AS")

ft_IndVarios_DMes_AS <- fc_tabla_cambio_generica(
  tc_as_mes,
  titulo = paste0("Tabla: Variación respecto al trimestre anterior — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = FALSE
)

ft_IndVarios_DAnno_AS <- fc_tabla_cambio_generica(
  tc_as_ano,
  titulo = paste0("Tabla: Variación interanual — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = FALSE
)

ft_IndVarios_DPostCovid_AS <- fc_tabla_cambio_generica(
  tc_as_pre,
  titulo = paste0("Tabla: Variación acumulada post-COVID — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = FALSE
)

# ── Variables narrativas para el Anexo 3 ─────────────────────────────────────
# Sin columna ensancha, el veredicto sale de la valencia. Qué filas se excluyen
# y por qué: manual, § Indicadores varios.

AsMes <- fc_as_resumen(tc_as_mes)
AsAno <- fc_as_resumen(tc_as_ano)
AsPre <- fc_as_resumen(tc_as_pre)

# ══════════════════════════════════════════════════════════════════════════════
# ANEXO 4 — Indicadores varios y brecha (A4)   ####
# (bloque separable — módulo mecano)
# ══════════════════════════════════════════════════════════════════════════════

# TABLAS ANEXO 4: BRECHA DE GÉNERO ####
# Cambio = (H(t0) - M(t0)) - (H(t-n) - M(t-n)). La convergencia es el objetivo
# para todas las variables sin excepción.

tc_brecha_mes <- tabla_cambio(res_filtrado, Fechas["mes_anterior"], Fechas["actual"], sexo = "Brecha")
tc_brecha_ano <- tabla_cambio(res_filtrado, Fechas["a_1_anno"],     Fechas["actual"], sexo = "Brecha")
tc_brecha_pre <- tabla_cambio(res_filtrado, Fechas["Fin_Covid"],    Fechas["actual"], sexo = "Brecha")


ft_IndVarios_DMes_Brecha <- fc_tabla_cambio_generica(
  tc_brecha_mes,
  titulo = paste0("Tabla: Brecha de género (H-M) respecto al trimestre anterior — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = TRUE
)

ft_IndVarios_DAnno_Brecha <- fc_tabla_cambio_generica(
  tc_brecha_ano,
  titulo = paste0("Tabla: Brecha de género (H-M) respecto al año anterior — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = TRUE
)

ft_IndVarios_DPostCovid_Brecha <- fc_tabla_cambio_generica(
  tc_brecha_pre,
  titulo = paste0("Tabla: Brecha de género (H-M) variación acumulada post-COVID — ",
                  fc_fecha_a_trimestre(fecha_Actual)),
  fuente = "Fuente: Elaboración propia en base a datos ENE.",
  es_brecha = TRUE
)


# ── Variables narrativas para el Anexo 4 ─────────────────────────────────────

BrMes <- fc_brecha_resumen(tc_brecha_mes)
BrAno <- fc_brecha_resumen(tc_brecha_ano)
BrPre <- fc_brecha_resumen(tc_brecha_pre)

# Las dos tasas que sostienen el hallazgo del período post-COVID: la brecha de
# participación converge mientras la de informalidad diverge.
BrPre_TPartic <- tc_brecha_pre$Diferencia[tc_brecha_pre[[1]] == "Tasa de Participación"][1]
BrPre_TInform <- tc_brecha_pre$Diferencia[tc_brecha_pre[[1]] == "Tasa de Ocupación Informal"][1]

