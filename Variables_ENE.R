# Variables_ENE.R - v7 - 26-08-2026
# Sin dependencias de paquetes: solo base R sobre objetos ya construidos.

# Marca:  vN → qmd <cXsYpZ> | mod <ladrillo> | int <variable de este archivo>
# PROVISORIAS: se borran cuando calidad/mapea_proyecto.R este andando. Ver desafio 18.

# ______________________________________________________________________________
# BASE COMÚN — stocks y tasas nacionales que consumen dos o más capítulos ####
# Insumo de c1, c2 y de los bloques de edad, TPI y tamaño. Si se toca algo acá, se mueve todo el informe.
# ______________________________________________________________________________

Val_Act_Ocupdos_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Ocupados")  # v2 → qmd c1p2 c2p3 c4s1p1 | mod kpi | int Tasa_Act_TPI_AS
Val_Act_OcupFrm_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Ocupados formal")  # v3 → qmd c1p2 c4s1p1 | mod sector
Val_Act_OcupInf_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Ocupados informal")  # v4 → qmd c1p2 c2p7 c4s1p1
Val_Act_Dsocpds_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Desocupados")  # v6 → qmd c1p2
Val_Act_FT_AS                <- fc_Datos_ENE(fecha_Actual, "AS", "Fuerza de trabajo")  # v7 → qmd c1p2
Tasa_Act_TInform_AS          <- fc_Datos_ENE(fecha_Actual, "AS", "Tasa de ocupación informal")  # v8 → qmd c2p5 c2p7 c5s2p1 c5s2p2 c5s4p2 c5s5p9 | mod kpi
Tasa_Act_TDescp_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Tasa de desocupación")  # v9 → qmd c2p2 c2p5 c5s2p1 c5s2p3 | mod kpi
Tasa_Act_TDescp_M            <- fc_Datos_ENE(fecha_Actual, "M",  "Tasa de desocupación")  # v10 → qmd c2p2 | mod kpi
Tasa_Act_TPartic_AS          <- fc_Datos_ENE(fecha_Actual, "AS", "Tasa de participación")  # v11 → qmd c2p1 c3s2p1 c5s2p4 | mod kpi
Tasa_Act_TPartic_M           <- fc_Datos_ENE(fecha_Actual, "M",  "Tasa de participación")  # v12 → qmd c5s1p1 c5s1p3
Tasa_Act_TPartic_H           <- fc_Datos_ENE(fecha_Actual, "H",  "Tasa de participación")  # v13 → qmd c5s1p3
Brecha_Act_TPartic           <- fc_Brecha_ENE(fecha_Actual, "Tasa de participación")  # v14 → qmd c2p6 c5s1p3 | mod kpi
Brecha_Act_TDescp            <- fc_Brecha_ENE(fecha_Actual, "Tasa de desocupación")  # v15 → mod kpi | int Brecha_Act_TDescp2
Brecha_Act_TDescp2            <- -1*Brecha_Act_TDescp  # v16 → qmd c2p6
Val_Mes_Ocupdos_AS           <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Ocupados")  # v24 → int Tasa_Mes_TPI_AS
Val_Año_Ocupdos_AS           <- fc_Datos_ENE(fecha1annos, "AS", "Ocupados")  # v36 → int Tasa_Año_TPI_AS
Val_Act_Ocupdos_2022         <- fc_Datos_ENE(fecha4annos, "AS", "Ocupados")  # v95 → qmd c4s1p1

# ______________________________________________________________________________
# c2 — Ideas fuerza: variaciones mensuales e interanuales de los indicadores principales ####
# Si se apaga el capítulo 2, este bloque cae completo salvo lo que la base común ya sostiene.
# ______________________________________________________________________________

Delta_Mes_TDescp_AS          <- fc_Delta(fecha_MesAnterior, "AS", "Tasa de desocupación")  # v26 → qmd c2p2 | mod kpi
Delta_Mes_TDescp_M           <- fc_Delta(fecha_MesAnterior, "M",  "Tasa de desocupación")  # v27 → qmd c2p2 | mod kpi
Delta_Mes_Ocupdos_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Ocupados")  # v28 → mod kpi
Delta_Mes_Dsocpds_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Desocupados")  # v30 → qmd c2p2
Delta_Mes_Dsocpds_M          <- fc_Delta(fecha_MesAnterior, "M",  "Desocupados")  # v31 → qmd c2p2
Delta_Mes_TPartic_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Tasa de participación")  # v32 → qmd c2p1 | mod kpi
Delta_Mes_OcupFrm_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Ocupados formal")  # v33 → mod sector
Delta_Mes_OcupInf_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Ocupados informal")  # v34 → qmd c2p7
Delta_Mes_TInform_AS         <- fc_Delta(fecha_MesAnterior, "AS", "Tasa de ocupación informal")  # v35 → qmd c2p7 | mod kpi
Delta_Año_Ocupdos_AS         <- fc_Delta(fecha1annos, "AS", "Ocupados")  # v41 → qmd c1p2 c2p3 c4s1p2 c4s2p2 | mod kpi
Delta_Año_Ocupdos_M          <- fc_Delta(fecha1annos, "M",  "Ocupados")  # v42 → qmd c2p3
Delta_Año_Ocupdos_H          <- fc_Delta(fecha1annos, "H",  "Ocupados")  # v43 → qmd c2p3
Delta_Año_Dsocpds_AS         <- fc_Delta(fecha1annos, "AS", "Desocupados")  # v44 → qmd c1p2 c2p2
Delta_Año_Dsocpds_M          <- fc_Delta(fecha1annos, "M",  "Desocupados")  # v45 → qmd c2p2
Delta_Año_FT_AS              <- fc_Delta(fecha1annos, "AS", "Fuerza de trabajo")  # v47 → qmd c4s1p2
Delta_Año_OcupFrm_AS         <- fc_Delta(fecha1annos, "AS", "Ocupados formal")  # v48 → qmd c1p2 c1p3 c2p4 c4s1p2 | mod sector
Delta_Año_OcupFrm_M          <- fc_Delta(fecha1annos, "M",  "Ocupados formal")  # v49 → qmd c2p4
Delta_Año_OcupFrm_H          <- fc_Delta(fecha1annos, "H",  "Ocupados formal")  # v50 → qmd c2p4
Delta_Año_OcupInf_AS         <- fc_Delta(fecha1annos, "AS", "Ocupados informal")  # v51 → qmd c1p2 c1p3 c2p7 c4s1p2
Delta_Año_TDescp_AS          <- fc_Delta(fecha1annos, "AS", "Tasa de desocupación")  # v60 → qmd c2p2 c4s1p2 | mod kpi
Delta_Año_TDescp_M           <- fc_Delta(fecha1annos, "M",  "Tasa de desocupación")  # v61 → qmd c2p2 | mod kpi
Delta_Año_TPartic_AS         <- fc_Delta(fecha1annos, "AS", "Tasa de participación")  # v62 → qmd c2p1 | mod kpi
Delta_Año_TInform_AS         <- fc_Delta(fecha1annos, "AS", "Tasa de ocupación informal")  # v65 → qmd c2p7 | mod kpi

# ______________________________________________________________________________
# c3s2 — Participación femenina y razones de no participación ####
# Referencias COVID y fuera de la fuerza de trabajo. Consumidor único: capítulo 3, sección 2.
# ______________________________________________________________________________

Val_Covid_TPartic_M          <- fc_Datos_ENE(fecha_Inicio_Covid, "M",  "Tasa de participación")  # v82 → qmd c5s1p1 | int Delta_Covid_Caida_TPartic_M
Val_Covid_Centro_TPartic_M   <- fc_Datos_ENE(fecha_Centro_Covid, "M",  "Tasa de participación")  # v83 → qmd c5s1p1 | int Delta_Covid_Caida_TPartic_M
Val_Covid_Centro_TPartic_AS  <- fc_Datos_ENE(fecha_Centro_Covid, "AS",  "Tasa de participación")  # v83 → qmd c3s2p1
Delta_Covid_TPartic_M        <- fc_Delta(fecha_Inicio_Covid, "M",  "Tasa de participación")  # v85 → qmd c5s1p1
Delta_Covid_TPartic_AS       <- fc_Delta(fecha_Inicio_Covid, "AS", "Tasa de participación")  # v86 → qmd c3s2p1
Delta_Covid_Caida_TPartic_M  <- Val_Covid_TPartic_M-Val_Covid_Centro_TPartic_M  # v87 → qmd c5s1p1
Val_FFTFamil_M               <- fc_Datos_ENE(fecha_Actual, "M",  "Fuera de la fuerza de trabajo por razones familiares permanentes")  # v102 → qmd c5s1p3 | int Porc_FFTFamil_M
Val_FFTFamil_AS              <- fc_Datos_ENE(fecha_Actual, "AS", "Fuera de la fuerza de trabajo por razones familiares permanentes")  # v103 → int Porc_FFTFamil_M
Porc_FFTFamil_M              <- round(100 * Val_FFTFamil_M / Val_FFTFamil_AS, 1)  # v104 → qmd c5s1p2 c5s1p3

# ______________________________________________________________________________
# c4 + cA5 — Edad: jóvenes 15-24 ####
# Tasas reconstruidas desde stocks (suma de numeradores / suma de denominadores). Consumidores: c2p5, c4p1, cA5p1, cA5p2.
# ______________________________________________________________________________

Val_Act_FT_J1524_AS    <- fc_Datos_ENE(fecha_Actual, "AS", "Fuerza de trabajo 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "AS", "Fuerza de trabajo 20 a 24 años")  # v107 → int Tasa_Act_TDescp_J1524_AS Tasa_Act_TPartic_J1524_AS
Val_Act_FT_J1524_M     <- fc_Datos_ENE(fecha_Actual, "M",  "Fuerza de trabajo 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "M",  "Fuerza de trabajo 20 a 24 años")  # v108 → int Tasa_Act_TDescp_J1524_M
Val_Act_FT_J1524_H     <- fc_Datos_ENE(fecha_Actual, "H",  "Fuerza de trabajo 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "H",  "Fuerza de trabajo 20 a 24 años")  # v109 → int Tasa_Act_TDescp_J1524_H
Val_Act_PET_J1524_AS   <- fc_Datos_ENE(fecha_Actual, "AS", "Población en edad de trabajar 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "AS", "Población en edad de trabajar 20 a 24 años")  # v110 → int Tasa_Act_TPartic_J1524_AS
Val_Act_Ocup_J1524_AS  <- fc_Datos_ENE(fecha_Actual, "AS", "Ocupados 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "AS", "Ocupados 20 a 24 años")  # v111 → int Delta_Año_Ocup_J1524_AS Tasa_Act_TInform_J1524_AS
Val_Act_Dsoc_J1524_AS  <- fc_Datos_ENE(fecha_Actual, "AS", "Desocupados 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "AS", "Desocupados 20 a 24 años")  # v114 → int Tasa_Act_TDescp_J1524_AS
Val_Act_Dsoc_J1524_M   <- fc_Datos_ENE(fecha_Actual, "M",  "Desocupados 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "M",  "Desocupados 20 a 24 años")  # v115 → int Tasa_Act_TDescp_J1524_M
Val_Act_Dsoc_J1524_H   <- fc_Datos_ENE(fecha_Actual, "H",  "Desocupados 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "H",  "Desocupados 20 a 24 años")  # v116 → int Tasa_Act_TDescp_J1524_H
Val_Act_OcupInf_J1524_AS  <- fc_Datos_ENE(fecha_Actual, "AS", "Ocupados informal 15 a 19 años") + fc_Datos_ENE(fecha_Actual, "AS", "Ocupados informal 20 a 24 años")  # v118 → int Tasa_Act_TInform_J1524_AS
Tasa_Act_TDescp_J1524_AS  <- round(Val_Act_Dsoc_J1524_AS  / Val_Act_FT_J1524_AS   * 100, 1)  # v119 → qmd c2p5 c5s2p1 c5s2p3 | mod kpi | int Delta_Año_TDescp_J1524_AS
Tasa_Act_TDescp_J1524_M   <- round(Val_Act_Dsoc_J1524_M   / Val_Act_FT_J1524_M    * 100, 1)  # v120 → qmd c5s2p1 | int Brecha_Act_TDescp_J1524
Tasa_Act_TDescp_J1524_H   <- round(Val_Act_Dsoc_J1524_H   / Val_Act_FT_J1524_H    * 100, 1)  # v121 → qmd c5s2p1 | int Brecha_Act_TDescp_J1524
Tasa_Act_TPartic_J1524_AS <- round(Val_Act_FT_J1524_AS    / Val_Act_PET_J1524_AS  * 100, 1)  # v122 → qmd c5s2p4
Tasa_Act_TInform_J1524_AS <- round(Val_Act_OcupInf_J1524_AS / Val_Act_Ocup_J1524_AS * 100, 1)  # v123 → qmd c2p5 c5s2p1 c5s2p5
Brecha_Act_TDescp_J1524   <- round(Tasa_Act_TDescp_J1524_H - Tasa_Act_TDescp_J1524_M, 1)  # v124 → qmd c5s2p1
Val_Año_FT_J1524_AS    <- fc_Datos_ENE(fecha1annos, "AS", "Fuerza de trabajo 15 a 19 años") +  fc_Datos_ENE(fecha1annos, "AS", "Fuerza de trabajo 20 a 24 años")  # v125 → int Tasa_Año_TDescp_J1524_AS
Val_Año_Ocup_J1524_AS  <- fc_Datos_ENE(fecha1annos, "AS", "Ocupados 15 a 19 años") + fc_Datos_ENE(fecha1annos, "AS", "Ocupados 20 a 24 años")  # v126 → int Delta_Año_Ocup_J1524_AS
Val_Año_Dsoc_J1524_AS  <- fc_Datos_ENE(fecha1annos, "AS", "Desocupados 15 a 19 años") + fc_Datos_ENE(fecha1annos, "AS", "Desocupados 20 a 24 años")  # v127 → int Tasa_Año_TDescp_J1524_AS
Tasa_Año_TDescp_J1524_AS  <- round(Val_Año_Dsoc_J1524_AS / Val_Año_FT_J1524_AS * 100, 1)  # v128 → int Delta_Año_TDescp_J1524_AS
Delta_Año_Ocup_J1524_AS   <- Val_Act_Ocup_J1524_AS  - Val_Año_Ocup_J1524_AS  # v129 → qmd c2p5 c5s2p1
Delta_Año_TDescp_J1524_AS <- Tasa_Act_TDescp_J1524_AS - Tasa_Año_TDescp_J1524_AS  # v130 → qmd c2p5 c5s2p3 | mod kpi

# ______________________________________________________________________________
# c4 + cA5 — Edad: 55 años y más ####
# Los tramos vienen de Parametros_ENE.R; no redefinirlos acá.
# ______________________________________________________________________________

Val_Act_FT_M55_AS    <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha_Actual, "AS", paste0("Fuerza de trabajo ", t))))  # v132 → int Tasa_Act_TDescp_M55_AS Tasa_Act_TPartic_M55_AS
Val_Act_PET_M55_AS   <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha_Actual, "AS", paste0("Población en edad de trabajar ", t))))  # v135 → int Tasa_Act_TPartic_M55_AS
Val_Act_Ocup_M55_AS  <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha_Actual, "AS", paste0("Ocupados ", t))))  # v136 → int Delta_Año_Ocup_M55_AS Tasa_Act_TInform_M55_AS
Val_Act_Dsoc_M55_AS  <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha_Actual, "AS", paste0("Desocupados ", t))))  # v139 → int Tasa_Act_TDescp_M55_AS
Val_Act_OcupInf_M55_AS <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha_Actual, "AS", paste0("Ocupados informal ", t))))  # v143 → int Tasa_Act_TInform_M55_AS
Tasa_Act_TDescp_M55_AS  <- round(Val_Act_Dsoc_M55_AS    / Val_Act_FT_M55_AS   * 100, 1)  # v144 → qmd c2p5 c5s2p2 c5s2p3 | mod kpi | int Delta_Año_TDescp_M55_AS
Tasa_Act_TPartic_M55_AS <- round(Val_Act_FT_M55_AS      / Val_Act_PET_M55_AS  * 100, 1)  # v147 → qmd c5s2p2 c5s2p4 | int Delta_Año_TPartic_M55_AS
Tasa_Act_TInform_M55_AS <- round(Val_Act_OcupInf_M55_AS / Val_Act_Ocup_M55_AS * 100, 1)  # v148 → qmd c2p5 c5s2p2 c5s2p5
Val_Año_FT_M55_AS    <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha1annos, "AS", paste0("Fuerza de trabajo ", t))))  # v150 → int Tasa_Año_TDescp_M55_AS Tasa_Año_TPartic_M55_AS
Val_Año_Ocup_M55_AS  <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha1annos, "AS", paste0("Ocupados ", t))))  # v151 → int Delta_Año_Ocup_M55_AS
Val_Año_Dsoc_M55_AS  <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha1annos, "AS", paste0("Desocupados ", t))))  # v152 → int Tasa_Año_TDescp_M55_AS
Val_Año_PET_M55_AS   <- sum(sapply(tramos_edad_mayores, \(t) fc_Datos_ENE(fecha1annos, "AS", paste0("Población en edad de trabajar ", t))))  # v153 → int Tasa_Año_TPartic_M55_AS
Tasa_Año_TDescp_M55_AS  <- round(Val_Año_Dsoc_M55_AS / Val_Año_FT_M55_AS   * 100, 1)  # v154 → int Delta_Año_TDescp_M55_AS
Tasa_Año_TPartic_M55_AS <- round(Val_Año_FT_M55_AS   / Val_Año_PET_M55_AS  * 100, 1)  # v155 → int Delta_Año_TPartic_M55_AS
Delta_Año_Ocup_M55_AS    <- Val_Act_Ocup_M55_AS   - Val_Año_Ocup_M55_AS  # v156 → qmd c2p5 c5s2p2
Delta_Año_TDescp_M55_AS  <- Tasa_Act_TDescp_M55_AS  - Tasa_Año_TDescp_M55_AS  # v157 → qmd c2p5 c5s2p2 c5s2p3 | mod kpi
Delta_Año_TPartic_M55_AS <- Tasa_Act_TPartic_M55_AS - Tasa_Año_TPartic_M55_AS  # v158 → qmd c5s2p2 c5s2p4

# ______________________________________________________________________________
# c5 — Tamaño de empresa e informalidad por segmento ####
# Consumidores: c5p1, c5p2, c5p3. Techo_CpropInf_Micro_AS NO está acá: se calcula sobre CISE y vive en ese bloque.
# ______________________________________________________________________________

Val_Act_Micro_AS            <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Micro empresa")  # v167 → int Tasa_Act_TInform_Micro_AS
Val_Act_MicroInf_AS         <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Micro empresa informal")  # v168 → int Tasa_Act_TInform_Micro_AS Techo_CpropInf_Micro_AS
Val_Act_PeqEmp_AS           <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Pequeña empresa")  # v169 → int Porc_Año_PeqEmpFrm_AS Tasa_Act_TInform_PeqEmp_AS
Val_Act_PeqEmpInf_AS        <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Pequeña empresa informal")  # v170 → int Porc_Año_PeqEmpFrm_AS Tasa_Act_TInform_PeqEmp_AS
Val_Act_MedEmp_AS           <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Mediana empresa")  # v171 → SIN CONSUMIDOR
Val_Act_MedEmpInf_AS        <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Mediana empresa informal")  # v172 → int Porc_Año_MedEmpInf_AS
Val_Act_GranEmp_AS          <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Gran empresa")  # v173 → int Tasa_Act_TInform_GranEmp_AS
Val_Act_GranEmpInf_AS       <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Gran empresa informal")  # v174 → int Tasa_Act_TInform_GranEmp_AS
Val_Act_SinClasif_AS        <- fc_Datos_ENE(fecha_Actual,      "AS", "Ocupados Sin clasificar por tamaño")  # v175 → int Porc_Año_SinClasif_AS
Val_Mes_Micro_AS            <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Ocupados Micro empresa")  # v178 → int Tasa_Mes_TInform_Micro_AS
Val_Mes_MicroInf_AS         <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Ocupados Micro empresa informal")  # v179 → int Tasa_Mes_TInform_Micro_AS
Val_Año_Micro_AS            <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Micro empresa")  # v180 → int Tasa_Año_TInform_Micro_AS
Val_Año_MicroInf_AS         <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Micro empresa informal")  # v181 → int Tasa_Año_TInform_Micro_AS
Val_Año_PeqEmp_AS           <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Pequeña empresa")  # v182 → int Tasa_Año_TInform_PeqEmp_AS
Val_Año_PeqEmpInf_AS        <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Pequeña empresa informal")  # v183 → int Tasa_Año_TInform_PeqEmp_AS
Val_Año_PeqEmpFrm_AS        <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Pequeña empresa formal")  # v184 → int Porc_Año_PeqEmpFrm_AS
Val_Año_MedEmp_AS           <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Mediana empresa")  # v185 → SIN CONSUMIDOR
Val_Año_MedEmpInf_AS        <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Mediana empresa informal")  # v186 → int Porc_Año_MedEmpInf_AS
Val_Año_GranEmp_AS          <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Gran empresa")  # v187 → int Tasa_Año_TInform_GranEmp_AS
Val_Año_GranEmpInf_AS       <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Gran empresa informal")  # v188 → int Tasa_Año_TInform_GranEmp_AS
Val_Año_SinClasif_AS        <- fc_Datos_ENE(fecha1annos,       "AS", "Ocupados Sin clasificar por tamaño")  # v189 → int Porc_Año_SinClasif_AS
Tasa_Act_TInform_Micro_AS   <- round(Val_Act_MicroInf_AS   / Val_Act_Micro_AS   * 100, 1)  # v191 → qmd c5s3p2 | mod kpi | int Delta_Año_TInform_Micro_AS Delta_Mes_TInform_Micro_AS
Tasa_Año_TInform_Micro_AS   <- round(Val_Año_MicroInf_AS   / Val_Año_Micro_AS   * 100, 1)  # v192 → int Delta_Año_TInform_Micro_AS
Tasa_Mes_TInform_Micro_AS   <- round(Val_Mes_MicroInf_AS   / Val_Mes_Micro_AS   * 100, 1)  # v193 → int Delta_Mes_TInform_Micro_AS
Tasa_Act_TInform_PeqEmp_AS  <- round(Val_Act_PeqEmpInf_AS  / Val_Act_PeqEmp_AS  * 100, 1)  # v194 → qmd c5s3p1 | int Delta_Año_TInform_PeqEmp_AS
Tasa_Año_TInform_PeqEmp_AS  <- round(Val_Año_PeqEmpInf_AS  / Val_Año_PeqEmp_AS  * 100, 1)  # v195 → int Delta_Año_TInform_PeqEmp_AS
Tasa_Act_TInform_GranEmp_AS <- round(Val_Act_GranEmpInf_AS / Val_Act_GranEmp_AS  * 100, 1)  # v198 → qmd c5s3p2 c5s3p3 | int Delta_Año_TInform_GranEmp_AS
Tasa_Año_TInform_GranEmp_AS <- round(Val_Año_GranEmpInf_AS / Val_Año_GranEmp_AS  * 100, 1)  # v199 → int Delta_Año_TInform_GranEmp_AS
Delta_Año_TInform_Micro_AS   <- round(Tasa_Act_TInform_Micro_AS   - Tasa_Año_TInform_Micro_AS,   1)  # v200 → mod kpi
Delta_Mes_TInform_Micro_AS   <- round(Tasa_Act_TInform_Micro_AS   - Tasa_Mes_TInform_Micro_AS,   1)  # v201 → mod kpi
Delta_Año_TInform_PeqEmp_AS  <- round(Tasa_Act_TInform_PeqEmp_AS  - Tasa_Año_TInform_PeqEmp_AS,  1)  # v202 → qmd c5s3p1
Delta_Año_TInform_GranEmp_AS <- round(Tasa_Act_TInform_GranEmp_AS - Tasa_Año_TInform_GranEmp_AS, 1)  # v204 → qmd c5s3p3
Porc_Año_PeqEmpFrm_AS        <- round((Val_Act_PeqEmp_AS - Val_Act_PeqEmpInf_AS -
                                         Val_Año_PeqEmpFrm_AS) / Val_Año_PeqEmpFrm_AS * 100, 1)  # v205 → qmd c5s3p1
Porc_Año_MedEmpInf_AS        <- round((Val_Act_MedEmpInf_AS  - Val_Año_MedEmpInf_AS)  /
                                        Val_Año_MedEmpInf_AS  * 100, 1)  # v206 → qmd c5s3p1
Porc_Año_SinClasif_AS        <- round((Val_Act_SinClasif_AS  - Val_Año_SinClasif_AS)  /
                                        Val_Año_SinClasif_AS  * 100, 1)  # v208 → qmd c5s3p1

# ______________________________________________________________________________
# TPI — Tiempo parcial involuntario ####
# Tasa = personas TPI / ocupados totales. Consumidor: tarjeta KPI 7 (crea_objetos_kpi.R), no el texto del qmd.
# ______________________________________________________________________________

Val_Act_TPI_AS          <- fc_Datos_ENE(fecha_Actual,      "AS", "Personas tiempo parcial involuntario (TPI)")  # v159 → int Tasa_Act_TPI_AS
Val_Año_TPI_AS          <- fc_Datos_ENE(fecha1annos,       "AS", "Personas tiempo parcial involuntario (TPI)")  # v160 → int Tasa_Año_TPI_AS
Val_Mes_TPI_AS          <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Personas tiempo parcial involuntario (TPI)")  # v161 → int Tasa_Mes_TPI_AS
Tasa_Act_TPI_AS         <- round(Val_Act_TPI_AS / Val_Act_Ocupdos_AS * 100, 1)  # v162 → mod kpi | int Delta_Año_TPI_AS Delta_Mes_TPI_AS
Tasa_Año_TPI_AS         <- round(Val_Año_TPI_AS / Val_Año_Ocupdos_AS * 100, 1)  # v163 → int Delta_Año_TPI_AS
Tasa_Mes_TPI_AS         <- round(Val_Mes_TPI_AS / Val_Mes_Ocupdos_AS * 100, 1)  # v164 → int Delta_Mes_TPI_AS
Delta_Año_TPI_AS        <- round(Tasa_Act_TPI_AS - Tasa_Año_TPI_AS, 1)  # v165 → mod kpi
Delta_Mes_TPI_AS        <- round(Tasa_Act_TPI_AS - Tasa_Mes_TPI_AS, 1)  # v166 → mod kpi

# ______________________________________________________________________________
# CISE — Categoría ocupacional (clasificación en retirada, reemplazo por CISO) ####
# BLOQUE SUSTITUIBLE: todo lo que se calcula sobre categoría ocupacional CISE vive acá, aunque su
# consumidor sea otro capítulo. Al migrar a CISO se reemplaza este bloque completo.
# Capítulos que dependen de él: c2p4, c3s3p2, c3s3p3 y c5p2 (vía Techo_CpropInf_Micro_AS).
# ______________________________________________________________________________

Val_Act_AslDpnd_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Asalariados dependientes")  # v17 → int Tasa_Act_AslDpnI_AS
Val_Act_AslDpnI_AS           <- fc_Datos_ENE(fecha_Actual, "AS", "Asalariados dependientes informal")  # v18 → qmd c4s2p1 | int Tasa_Act_AslDpnI_AS
Val_Act_AslDpnd_M            <- fc_Datos_ENE(fecha_Actual, "M",  "Asalariados dependientes")  # v19 → int Tasa_Act_AslDpnI_M
Val_Act_AslDpnI_M            <- fc_Datos_ENE(fecha_Actual, "M",  "Asalariados dependientes informal")  # v20 → int Tasa_Act_AslDpnI_M
Tasa_Act_AslDpnI_AS          <- round(Val_Act_AslDpnI_AS / Val_Act_AslDpnd_AS * 100, 1)  # v21 → qmd c4s2p1 | int Delta_Año_TAsalDpnI_AS
Tasa_Act_AslDpnI_M           <- round(Val_Act_AslDpnI_M  / Val_Act_AslDpnd_M  * 100, 1)  # v22 → qmd c4s2p1 | int Delta_Año_TAsalDpnI_M
Val_Año_AslDpnd_AS           <- fc_Datos_ENE(fecha1annos, "AS", "Asalariados dependientes")  # v37 → int Tasa_Año_AslDpnI_AS
Val_Año_AslDpnI_AS           <- fc_Datos_ENE(fecha1annos, "AS", "Asalariados dependientes informal")  # v38 → int Tasa_Año_AslDpnI_AS
Val_Año_AslDpnd_M            <- fc_Datos_ENE(fecha1annos, "M",  "Asalariados dependientes")  # v39 → int Tasa_Año_AslDpnI_M
Val_Año_AslDpnI_M            <- fc_Datos_ENE(fecha1annos, "M",  "Asalariados dependientes informal")  # v40 → int Tasa_Año_AslDpnI_M
Delta_Año_AslPrvF_AS         <- fc_Delta(fecha1annos, "AS", "Asalariados privados formal")  # v56 → qmd c2p4 | int Delta_Año_AslFrm_AS
Delta_Año_AslPubF_AS         <- fc_Delta(fecha1annos, "AS", "Asalariados públicos formal")  # v58 → qmd c2p4 | int Delta_Año_AslFrm_AS
Delta_Año_SrvDomF_AS         <- fc_Delta(fecha1annos, "AS", "Servicio doméstico formal")  # v59 → qmd c2p4
Delta_Año_AslFrm_AS          <- Delta_Año_AslPubF_AS+Delta_Año_AslPrvF_AS  # → qmd c4s2p2
Delta_Año_AslDpnI_AS         <- fc_Delta(fecha1annos, "AS", "Asalariados dependientes informal")  # v66 → qmd c4s2p1 c4s2p2
Delta_Año_AslDpnI_M          <- fc_Delta(fecha1annos, "M",  "Asalariados dependientes informal")  # v67 → qmd c4s2p1
Tasa_Año_AslDpnI_AS          <- round(Val_Año_AslDpnI_AS / Val_Año_AslDpnd_AS * 100, 1)  # v69 → int Delta_Año_TAsalDpnI_AS
Tasa_Año_AslDpnI_M           <- round(Val_Año_AslDpnI_M  / Val_Año_AslDpnd_M  * 100, 1)  # v70 → int Delta_Año_TAsalDpnI_M
Delta_Año_TAsalDpnI_AS       <- round(Tasa_Act_AslDpnI_AS - Tasa_Año_AslDpnI_AS, 1)  # v71 → qmd c4s2p1
Delta_Año_TAsalDpnI_M        <- round(Tasa_Act_AslDpnI_M  - Tasa_Año_AslDpnI_M,  1)  # v72 → qmd c4s2p1
Val_Act_Cprop_AS      <- fc_Datos_ENE(fecha_Actual,      "AS", "Cuenta propia")  # → SIN CONSUMIDOR
Val_Act_CpropFrm_AS   <- fc_Datos_ENE(fecha_Actual,      "AS", "Cuenta propia formal")  # → SIN CONSUMIDOR
Val_Act_CpropInf_AS   <- fc_Datos_ENE(fecha_Actual,      "AS", "Cuenta propia informal")  # v177 → int Techo_CpropInf_Micro_AS
Val_Act_Cprop_M       <- fc_Datos_ENE(fecha_Actual,      "M",  "Cuenta propia")  # → SIN CONSUMIDOR
Val_Act_CpropFrm_M    <- fc_Datos_ENE(fecha_Actual,      "M",  "Cuenta propia formal")  # → SIN CONSUMIDOR
Val_Act_CpropInf_M    <- fc_Datos_ENE(fecha_Actual,      "M",  "Cuenta propia informal")  # → SIN CONSUMIDOR
Val_Act_Cprop_H       <- fc_Datos_ENE(fecha_Actual,      "H",  "Cuenta propia")  # → SIN CONSUMIDOR
Val_Act_CpropFrm_H    <- fc_Datos_ENE(fecha_Actual,      "H",  "Cuenta propia formal")  # → SIN CONSUMIDOR
Val_Act_CpropInf_H    <- fc_Datos_ENE(fecha_Actual,      "H",  "Cuenta propia informal")  # → SIN CONSUMIDOR
Val_Mes_Cprop_AS      <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Cuenta propia")  # → SIN CONSUMIDOR
Val_Mes_CpropInf_AS   <- fc_Datos_ENE(fecha_MesAnterior, "AS", "Cuenta propia informal")  # → SIN CONSUMIDOR
Val_Año_Cprop_AS      <- fc_Datos_ENE(fecha1annos,       "AS", "Cuenta propia")  # → SIN CONSUMIDOR
Val_Año_CpropInf_AS   <- fc_Datos_ENE(fecha1annos,       "AS", "Cuenta propia informal")  # → SIN CONSUMIDOR
Delta_Mes_Cprop_AS    <- fc_Delta(fecha_MesAnterior, "AS", "Cuenta propia")  # → SIN CONSUMIDOR
Delta_Mes_CpropInf_AS <- fc_Delta(fecha_MesAnterior, "AS", "Cuenta propia informal")  # → SIN CONSUMIDOR
Delta_Año_Cprop_AS    <- fc_Delta(fecha1annos,       "AS", "Cuenta propia")  # → qmd c4s2p2
Delta_Año_CpropInf_AS <- fc_Delta(fecha1annos,       "AS", "Cuenta propia informal")  # → SIN CONSUMIDOR
Techo_CpropInf_Micro_AS       <- round(Val_Act_CpropInf_AS / Val_Act_MicroInf_AS * 100, 1)  # v211 → mod kpi
