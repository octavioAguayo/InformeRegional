# Indice de objetos - Informe Regional ENE

_Generado por `mapea_proyecto.R` el 26-08-2026. No editar a mano: correr el script._

Objetos: 826 | sin consumidor: 50 | archivos R: 16 | QMD: 6

`qmd` = capitulo/seccion/parrafo donde se usa. `mod` = otro archivo .R que lo consume.

## Prepara_bbdd.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `columnas_maestra` | -- | -- | -- | si |
| `compose` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `dire_out` | -- | -- | -- | si |
| `dt_ENE_Master` | -- | -- | -- | si |
| `dt_ENE_nacional` | -- | -- | `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_sector.R` | si |
| `dt_ENE_regional_sexo` | -- | -- | `intermedios/crea_objetos_region.R` | si |
| `dta_rezagado` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c1` | `intermedios/crea_objetos_dur_desempleo.R` | -- |
| `entorno_maestra` | -- | -- | -- | si |
| `faltantes_maestra` | -- | -- | -- | si |
| `fecha_dta_efectiva` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c1` | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` | -- |
| `fecha_max_dta` | -- | -- | -- | -- |
| `frontera_fuentes` | -- | -- | -- | si |
| `res_completo` | -- | -- | -- | si |
| `res_filtrado` | -- | -- | `intermedios/crea_objetos_ind_varios.R` | -- |
| `ruta_master` | -- | -- | -- | si |
| `tmp_ENE_fechas` | -- | -- | -- | si |

_Sin consumidor (1): `fecha_max_dta`_

## Parametros_ENE.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Fechas` | `modulo_desest_anexo.qmd:cA5p4` | -- | `Prepara_bbdd.R` `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_ind_varios.R` `intermedios/crea_objetos_nucleo.R` | si |
| `fecha11annos` | `Inf_ENE_Sexo_Edad_Region.qmd:c3s1p1` | -- | -- | si |
| `fecha4annos` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` | -- | `Variables_ENE.R` | si |
| `fecha_Actual` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p6` `Inf_ENE_Sexo_Edad_Region.qmd:cA1p1` `Inf_ENE_Sexo_Edad_Region.qmd:cA3p1` | `Inf_ENE_Sexo_Edad_Region.qmd:c1` | `Prepara_bbdd.R` `Variables_ENE.R` `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_ind_varios.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_razon_fft.R` `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_sector.R` `intermedios/crea_objetos_tamano.R` | si |
| `SEP_CAT` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `col_bueno` | -- | -- | `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_region.R` | -- |
| `col_informal` | -- | -- | `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_region.R` | -- |
| `col_malo` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_region.R` | -- |
| `col_neutro` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_sector.R` | -- |
| `col_sexo_hombres` | -- | -- | `intermedios/crea_objetos_formalidad.R` | si |
| `col_sexo_mujeres` | -- | -- | `intermedios/crea_objetos_formalidad.R` | si |
| `col_sexo_total` | -- | -- | `intermedios/crea_objetos_formalidad.R` | si |
| `col_titulo` | -- | -- | `intermedios/crea_objetos_tamano.R` | -- |
| `colores_desocupados_detalle` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` | -- |
| `colores_edad` | -- | -- | `intermedios/crea_objetos_edad.R` | -- |
| `colores_gr4` | -- | -- | `intermedios/crea_objetos_formalidad.R` | -- |
| `colores_gr4_punto` | -- | -- | `intermedios/crea_objetos_formalidad.R` | -- |
| `colores_periodos` | -- | -- | `intermedios/crea_objetos_edad.R` | -- |
| `colores_sexo` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_fft.R` | -- |
| `colores_tamano` | -- | -- | `intermedios/crea_objetos_tamano.R` | -- |
| `cortes` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` | -- |
| `fc_cat_tramo` | -- | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_region.R` | -- |
| `fecha10annos` | -- | -- | -- | si |
| `fecha12annos` | -- | -- | -- | si |
| `fecha13annos` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `fecha1annos` | -- | -- | `Variables_ENE.R` `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_sector.R` `intermedios/crea_objetos_tamano.R` | si |
| `fecha2annos` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `fecha3annos` | -- | -- | -- | si |
| `fecha5annos` | -- | -- | -- | si |
| `fecha6annos` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` | si |
| `fecha7annos` | -- | -- | -- | si |
| `fecha8annos` | -- | -- | -- | si |
| `fecha9annos` | -- | -- | -- | si |
| `fecha_Centro_Covid` | -- | -- | `Variables_ENE.R` | si |
| `fecha_Fin_Covid` | -- | -- | -- | si |
| `fecha_Formalidad` | -- | -- | `intermedios/crea_objetos_formalidad.R` | -- |
| `fecha_Inicio_Covid` | -- | -- | `Variables_ENE.R` | si |
| `fecha_MesAnterior` | -- | -- | `Variables_ENE.R` `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_sector.R` `intermedios/crea_objetos_tamano.R` | si |
| `fecha_Pre_Covid` | -- | -- | -- | si |
| `fecha_inicio_tamano` | -- | -- | `intermedios/crea_objetos_tamano.R` | -- |
| `fecha_periodo_base` | -- | -- | -- | si |
| `filtro_tabla` | -- | -- | `Prepara_bbdd.R` | si |
| `filtro_tabla_desest` | -- | -- | `intermedios/crea_objetos_desest.R` | si |
| `kpi_colores` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `sexos_informe` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | -- |
| `tam_grafico` | -- | -- | -- | -- |
| `tramos_edad_intermedios` | -- | -- | `intermedios/crea_objetos_edad.R` | -- |
| `tramos_edad_jovenes` | -- | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_region.R` | -- |
| `tramos_edad_mayores` | -- | -- | `Variables_ENE.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_region.R` | -- |
| `tramos_ene` | -- | -- | `intermedios/crea_objetos_edad.R` | si |

_Sin consumidor (1): `tam_grafico`_

## Variables_ENE.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Brecha_Act_TDescp2` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p6` | -- | -- | -- |
| `Brecha_Act_TDescp_J1524` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` | -- | -- | -- |
| `Brecha_Act_TPartic` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p6` `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_AslDpnI_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_AslDpnI_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | -- |
| `Delta_A<U+00F1>o_AslFrm_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_AslPrvF_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` | -- | -- | si |
| `Delta_A<U+00F1>o_AslPubF_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` | -- | -- | si |
| `Delta_A<U+00F1>o_Cprop_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_Dsocpds_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_Dsocpds_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_FT_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_OcupFrm_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c1p3` `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p2` | -- | `intermedios/crea_objetos_sector.R` | -- |
| `Delta_A<U+00F1>o_OcupFrm_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` | -- | -- | -- |
| `Delta_A<U+00F1>o_OcupFrm_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` | -- | -- | -- |
| `Delta_A<U+00F1>o_OcupInf_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c1p3` `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_Ocup_J1524_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p5` | -- | -- | -- |
| `Delta_A<U+00F1>o_Ocup_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` | -- | -- | -- |
| `Delta_A<U+00F1>o_Ocupdos_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p3` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_Ocupdos_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p3` | -- | -- | -- |
| `Delta_A<U+00F1>o_Ocupdos_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p3` | -- | -- | -- |
| `Delta_A<U+00F1>o_SrvDomF_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p4` | -- | -- | -- |
| `Delta_A<U+00F1>o_TAsalDpnI_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | -- |
| `Delta_A<U+00F1>o_TAsalDpnI_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | -- |
| `Delta_A<U+00F1>o_TDescp_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p2` | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TDescp_J1524_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TDescp_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TDescp_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TInform_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TInform_GranEmp_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p1` | -- | -- | -- |
| `Delta_A<U+00F1>o_TPartic_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p1` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TPartic_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` | -- | -- | -- |
| `Delta_Covid_Caida_TPartic_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p1` | -- | -- | -- |
| `Delta_Covid_TPartic_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c3s2p1` | -- | -- | -- |
| `Delta_Covid_TPartic_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p1` | -- | -- | -- |
| `Delta_Mes_Dsocpds_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | -- | -- |
| `Delta_Mes_Dsocpds_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | -- | -- |
| `Delta_Mes_OcupInf_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` | -- | -- | -- |
| `Delta_Mes_TDescp_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_TDescp_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_TInform_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_TPartic_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p1` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Porc_FFTFamil_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` | -- | -- | -- |
| `Tasa_Act_AslDpnI_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | si |
| `Tasa_Act_AslDpnI_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | si |
| `Tasa_Act_TDescp_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_kpi.R` | -- |
| `Tasa_Act_TDescp_J1524_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_kpi.R` | si |
| `Tasa_Act_TDescp_J1524_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` | -- | -- | si |
| `Tasa_Act_TDescp_J1524_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` | -- | -- | si |
| `Tasa_Act_TDescp_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p2` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Tasa_Act_TDescp_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | `intermedios/crea_objetos_kpi.R` | si |
| `Tasa_Act_TInform_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Tasa_Act_TInform_GranEmp_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p1` | -- | -- | si |
| `Tasa_Act_TInform_J1524_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` | -- | -- | -- |
| `Tasa_Act_TInform_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p5` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` | -- | -- | -- |
| `Tasa_Act_TInform_Micro_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p1` | -- | `intermedios/crea_objetos_kpi.R` | si |
| `Tasa_Act_TPartic_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c3s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Tasa_Act_TPartic_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` | -- | -- | -- |
| `Tasa_Act_TPartic_J1524_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | -- |
| `Tasa_Act_TPartic_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` | -- | -- | -- |
| `Tasa_Act_TPartic_M55_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | si |
| `Val_Act_AslDpnI_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2p1` | -- | -- | si |
| `Val_Act_Dsocpds_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` | -- | -- | -- |
| `Val_Act_FT_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` | -- | -- | -- |
| `Val_Act_MicroInf_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p5` | -- | -- | si |
| `Val_Act_Micro_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p5` | -- | -- | si |
| `Val_Act_OcupFrm_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` | -- | `intermedios/crea_objetos_sector.R` | -- |
| `Val_Act_OcupInf_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p7` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p5` | -- | -- | -- |
| `Val_Act_Ocupdos_2022` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` | -- | -- | -- |
| `Val_Act_Ocupdos_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c2p3` `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p5` | -- | `intermedios/crea_objetos_kpi.R` | si |
| `Val_Covid_Centro_TPartic_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c3s2p1` | -- | -- | -- |
| `Val_Covid_Centro_TPartic_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p1` | -- | -- | si |
| `Val_Covid_TPartic_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p1` | -- | -- | si |
| `Val_FFTFamil_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` | -- | -- | si |
| `Brecha_Act_TDescp` | -- | -- | `intermedios/crea_objetos_kpi.R` | si |
| `Delta_A<U+00F1>o_CpropInf_AS` | -- | -- | -- | -- |
| `Delta_A<U+00F1>o_TInform_Micro_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_A<U+00F1>o_TInform_PeqEmp_AS` | -- | -- | -- | -- |
| `Delta_A<U+00F1>o_TPI_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_CpropInf_AS` | -- | -- | -- | -- |
| `Delta_Mes_Cprop_AS` | -- | -- | -- | -- |
| `Delta_Mes_OcupFrm_AS` | -- | -- | `intermedios/crea_objetos_sector.R` | -- |
| `Delta_Mes_Ocupdos_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_TInform_Micro_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Delta_Mes_TPI_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Porc_A<U+00F1>o_MedEmpInf_AS` | -- | -- | -- | -- |
| `Porc_A<U+00F1>o_PeqEmpFrm_AS` | -- | -- | -- | -- |
| `Porc_A<U+00F1>o_SinClasif_AS` | -- | -- | -- | -- |
| `Tasa_A<U+00F1>o_AslDpnI_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_AslDpnI_M` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TDescp_J1524_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TDescp_M55_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TInform_GranEmp_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TInform_Micro_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TInform_PeqEmp_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TPI_AS` | -- | -- | -- | si |
| `Tasa_A<U+00F1>o_TPartic_M55_AS` | -- | -- | -- | si |
| `Tasa_Act_TInform_PeqEmp_AS` | -- | -- | -- | si |
| `Tasa_Act_TPI_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | si |
| `Tasa_Mes_TInform_Micro_AS` | -- | -- | -- | si |
| `Tasa_Mes_TPI_AS` | -- | -- | -- | si |
| `Techo_CpropInf_Micro_AS` | -- | -- | `intermedios/crea_objetos_kpi.R` | -- |
| `Val_A<U+00F1>o_AslDpnI_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_AslDpnI_M` | -- | -- | -- | si |
| `Val_A<U+00F1>o_AslDpnd_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_AslDpnd_M` | -- | -- | -- | si |
| `Val_A<U+00F1>o_CpropInf_AS` | -- | -- | -- | -- |
| `Val_A<U+00F1>o_Cprop_AS` | -- | -- | -- | -- |
| `Val_A<U+00F1>o_Dsoc_J1524_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_Dsoc_M55_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_FT_J1524_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_FT_M55_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_GranEmpInf_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_GranEmp_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_MedEmpInf_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_MedEmp_AS` | -- | -- | -- | -- |
| `Val_A<U+00F1>o_MicroInf_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_Micro_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_Ocup_J1524_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_Ocup_M55_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_Ocupdos_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_PET_M55_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_PeqEmpFrm_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_PeqEmpInf_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_PeqEmp_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_SinClasif_AS` | -- | -- | -- | si |
| `Val_A<U+00F1>o_TPI_AS` | -- | -- | -- | si |
| `Val_Act_AslDpnI_M` | -- | -- | -- | si |
| `Val_Act_AslDpnd_AS` | -- | -- | -- | si |
| `Val_Act_AslDpnd_M` | -- | -- | -- | si |
| `Val_Act_CpropFrm_AS` | -- | -- | -- | -- |
| `Val_Act_CpropFrm_H` | -- | -- | -- | -- |
| `Val_Act_CpropFrm_M` | -- | -- | -- | -- |
| `Val_Act_CpropInf_AS` | -- | -- | -- | si |
| `Val_Act_CpropInf_H` | -- | -- | -- | -- |
| `Val_Act_CpropInf_M` | -- | -- | -- | -- |
| `Val_Act_Cprop_AS` | -- | -- | -- | -- |
| `Val_Act_Cprop_H` | -- | -- | -- | -- |
| `Val_Act_Cprop_M` | -- | -- | -- | -- |
| `Val_Act_Dsoc_J1524_AS` | -- | -- | -- | si |
| `Val_Act_Dsoc_J1524_H` | -- | -- | -- | si |
| `Val_Act_Dsoc_J1524_M` | -- | -- | -- | si |
| `Val_Act_Dsoc_M55_AS` | -- | -- | -- | si |
| `Val_Act_FT_J1524_AS` | -- | -- | -- | si |
| `Val_Act_FT_J1524_H` | -- | -- | -- | si |
| `Val_Act_FT_J1524_M` | -- | -- | -- | si |
| `Val_Act_FT_M55_AS` | -- | -- | -- | si |
| `Val_Act_GranEmpInf_AS` | -- | -- | -- | si |
| `Val_Act_GranEmp_AS` | -- | -- | -- | si |
| `Val_Act_MedEmpInf_AS` | -- | -- | -- | si |
| `Val_Act_MedEmp_AS` | -- | -- | -- | -- |
| `Val_Act_OcupInf_J1524_AS` | -- | -- | -- | si |
| `Val_Act_OcupInf_M55_AS` | -- | -- | -- | si |
| `Val_Act_Ocup_J1524_AS` | -- | -- | -- | si |
| `Val_Act_Ocup_M55_AS` | -- | -- | -- | si |
| `Val_Act_PET_J1524_AS` | -- | -- | -- | si |
| `Val_Act_PET_M55_AS` | -- | -- | -- | si |
| `Val_Act_PeqEmpInf_AS` | -- | -- | -- | si |
| `Val_Act_PeqEmp_AS` | -- | -- | -- | si |
| `Val_Act_SinClasif_AS` | -- | -- | -- | si |
| `Val_Act_TPI_AS` | -- | -- | -- | si |
| `Val_FFTFamil_AS` | -- | -- | -- | si |
| `Val_Mes_CpropInf_AS` | -- | -- | -- | -- |
| `Val_Mes_Cprop_AS` | -- | -- | -- | -- |
| `Val_Mes_MicroInf_AS` | -- | -- | -- | si |
| `Val_Mes_Micro_AS` | -- | -- | -- | si |
| `Val_Mes_Ocupdos_AS` | -- | -- | -- | si |
| `Val_Mes_TPI_AS` | -- | -- | -- | si |

_Sin consumidor (21): `Delta_A<U+00F1>o_CpropInf_AS`, `Delta_A<U+00F1>o_TInform_PeqEmp_AS`, `Delta_Mes_CpropInf_AS`, `Delta_Mes_Cprop_AS`, `Porc_A<U+00F1>o_MedEmpInf_AS`, `Porc_A<U+00F1>o_PeqEmpFrm_AS`, `Porc_A<U+00F1>o_SinClasif_AS`, `Val_A<U+00F1>o_CpropInf_AS`, `Val_A<U+00F1>o_Cprop_AS`, `Val_A<U+00F1>o_MedEmp_AS`, `Val_Act_CpropFrm_AS`, `Val_Act_CpropFrm_H`, `Val_Act_CpropFrm_M`, `Val_Act_CpropInf_H`, `Val_Act_CpropInf_M`, `Val_Act_Cprop_AS`, `Val_Act_Cprop_H`, `Val_Act_Cprop_M`, `Val_Act_MedEmp_AS`, `Val_Mes_CpropInf_AS`, `Val_Mes_Cprop_AS`_

## intermedios/crea_objetos_desest.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Brecha_Desoc_Fin` | `modulo_desest_anexo.qmd:cA5p5` `modulo_desest_principal.qmd:cNAs3p2` | -- | -- | si |
| `Brecha_Desoc_Ini` | `modulo_desest_anexo.qmd:cA5p5` `modulo_desest_principal.qmd:cNAs3p2` | -- | -- | si |
| `Brecha_Partic_Fin` | `modulo_desest_anexo.qmd:cA5p6` | -- | -- | si |
| `Brecha_Partic_Ini` | `modulo_desest_anexo.qmd:cA5p6` | -- | -- | si |
| `DS_Ano_Desoc` | `modulo_desest_anexo.qmd:cA5p3` | -- | -- | si |
| `DS_Ano_Ocup` | `modulo_desest_anexo.qmd:cA5p3` | -- | -- | -- |
| `DS_Ano_TDesoc` | `modulo_desest_anexo.qmd:cA5p3` | -- | -- | si |
| `DS_Mes_Desoc` | `modulo_desest_anexo.qmd:cA5p2` | -- | -- | si |
| `DS_Mes_FT` | `modulo_desest_anexo.qmd:cA5p2` | -- | -- | -- |
| `DS_Mes_Ocup` | `modulo_desest_anexo.qmd:cA5p2` | -- | -- | si |
| `DS_Pre_TDesoc` | `modulo_desest_anexo.qmd:cA5p4` | -- | -- | -- |
| `DS_Pre_TPart` | `modulo_desest_anexo.qmd:cA5p4` | -- | -- | si |
| `Pend_Desoc_H` | `modulo_desest_anexo.qmd:cA5p5` `modulo_desest_principal.qmd:cNAs3p2` | -- | -- | -- |
| `Pend_Desoc_M` | `modulo_desest_anexo.qmd:cA5p5` `modulo_desest_principal.qmd:cNAs3p2` | -- | -- | si |
| `Pend_Partic_H` | `modulo_desest_anexo.qmd:cA5p6` | -- | -- | -- |
| `Pend_Partic_M` | `modulo_desest_anexo.qmd:cA5p6` | -- | -- | si |
| `base_grD2_desest` | -- | -- | -- | si |
| `base_grD3` | -- | -- | -- | si |
| `base_grD_desest` | -- | -- | -- | si |
| `categorias_desest_necesarias` | -- | -- | -- | si |
| `cats_desest` | -- | -- | -- | si |
| `col_act` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `col_ano` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `col_mes` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `colores_grD3` | -- | -- | -- | si |
| `cortes_grD3` | -- | -- | -- | si |
| `desest_actual` | -- | -- | -- | si |
| `df_desest_sexo` | -- | -- | -- | si |
| `dt_Desest` | -- | -- | -- | si |
| `fc_ds` | -- | -- | -- | si |
| `fc_pd` | -- | -- | -- | si |
| `fc_pend_tramo` | -- | -- | -- | si |
| `fila` | -- | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_region.R` | si |
| `ft_Desest_DAnno_AS` | -- | `modulo_desest_anexo.qmd:cA5` | -- | si |
| `ft_Desest_DMes_AS` | -- | `modulo_desest_anexo.qmd:cA5` | -- | -- |
| `ft_Desest_DPreCovid_AS` | -- | `modulo_desest_anexo.qmd:cA5` | -- | si |
| `ft_Desest_Sexo` | -- | `modulo_desest_principal.qmd:cNAs3` | -- | si |
| `gr_Desest_Comparacion` | -- | `modulo_desest_principal.qmd:cNAs3` | -- | si |
| `gr_Desest_Particip_Sexo` | -- | `modulo_desest_anexo.qmd:cA5` | -- | si |
| `gr_Desest_Tasa_Sexo` | -- | `modulo_desest_anexo.qmd:cA5` | -- | si |
| `ind` | -- | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_region.R` | si |
| `pend_desoc` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `pend_partic` | -- | -- | `intermedios/crea_objetos_edad.R` | si |
| `pred_grD2_desest` | -- | -- | -- | si |
| `pred_grD3` | -- | -- | -- | si |
| `pred_grD_desest` | -- | -- | -- | si |
| `puntos_grD2_desest` | -- | -- | -- | si |
| `puntos_grD_desest` | -- | -- | -- | si |
| `res_desest` | -- | -- | -- | si |
| `tabla_interna_grD` | -- | -- | -- | si |
| `tabla_interna_grD2` | -- | -- | -- | si |
| `tabla_interna_grD2_fmt` | -- | -- | -- | si |
| `tabla_interna_grD_fmt` | -- | -- | -- | si |
| `tc_desest_ano` | -- | -- | -- | si |
| `tc_desest_mes` | -- | -- | -- | si |
| `tc_desest_pre` | -- | -- | -- | si |
| `tema_tabla_grD` | -- | -- | -- | si |
| `tema_tabla_grD2` | -- | -- | -- | si |
| `tiene_desest` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2` `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | si |
| `tipo_i` | -- | -- | -- | si |
| `ult` | -- | -- | -- | si |
| `unidad_i` | -- | -- | -- | si |
| `v` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |
| `x_pos_grD` | -- | -- | -- | si |
| `x_pos_grD2` | -- | -- | -- | si |
| `y_pos_grD` | -- | -- | -- | si |
| `y_pos_grD2` | -- | -- | -- | si |

## intermedios/crea_objetos_dur_desempleo.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Brecha_LargaDuracion` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p6` | -- | -- | -- |
| `Densidad_MasDenso` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p1` | -- | -- | -- |
| `DurTop_Pct_Act` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p4` | -- | -- | -- |
| `DurTop_Pct_Ini` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p4` | -- | -- | -- |
| `Mediana_DurDesempleo` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p1` | -- | -- | -- |
| `Mismo_Tramo_Mayor` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p5` | -- | -- | -- |
| `Pct_LargaDuracion` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p2` | -- | -- | -- |
| `Pct_LargaDuracion_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p5` | -- | -- | si |
| `Pct_LargaDuracion_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p5` | -- | -- | si |
| `Pct_Tramo_MayorStock` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p1` | -- | -- | -- |
| `Texto_Tramos_CaidaInteranual` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p3` | -- | -- | -- |
| `Tramo_MasDenso` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p1` | -- | -- | -- |
| `Tramo_MayorAlzaMensual` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p3` `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p4` | -- | -- | si |
| `Tramo_MayorCaidaMensual` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p3` | -- | -- | -- |
| `Tramo_MayorStock` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p1` | -- | -- | -- |
| `Tramo_MayorStock_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p5` | -- | -- | -- |
| `Tramo_MayorStock_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p5` | -- | -- | -- |
| `Val_LargaDuracion` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p2` | -- | -- | -- |
| `base_comp_dur_desempleo` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p4` | -- | -- | si |
| `N_Tramos_CaidaInteranual` | -- | -- | -- | si |
| `Tramos_CaidaInteranual` | -- | -- | -- | si |
| `anio` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `c_caida` | -- | -- | -- | si |
| `categorias_dur_desempleo` | -- | -- | -- | si |
| `cmp_larga` | -- | -- | -- | si |
| `cmp_stock` | -- | -- | -- | si |
| `colores_dur_desempleo` | -- | -- | -- | si |
| `df_dur_desempleo` | -- | -- | -- | si |
| `df_dur_desempleo_sexo` | -- | -- | -- | si |
| `fecha_DurDes_1anno` | -- | -- | -- | si |
| `fecha_DurDes_Actual` | -- | -- | -- | si |
| `fecha_DurDes_InicioSerie` | -- | -- | -- | -- |
| `fecha_DurDes_MesAnterior` | -- | -- | -- | si |
| `ft_DurDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6` | -- | si |
| `ft_DurDesempleo_Sexo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6` | -- | si |
| `gr_Comp_DurDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s6` | -- | si |
| `h_alza` | -- | -- | -- | si |
| `h_caida` | -- | -- | -- | si |
| `h_dens` | -- | -- | -- | si |
| `h_dens_cerrados` | -- | -- | -- | si |
| `h_larga` | -- | -- | -- | si |
| `h_stock` | -- | -- | -- | si |
| `pct_tramo_top` | -- | -- | -- | si |
| `prev` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `v` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |

_Sin consumidor (1): `fecha_DurDes_InicioSerie`_

## intermedios/crea_objetos_edad.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Elast_Desoc_Jov` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | -- | -- |
| `Partic_Jov_SeAplano` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | -- |
| `Pend_Desoc_Jov` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | -- | si |
| `Pend_Desoc_May` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | -- | -- |
| `Pend_Desoc_Tot` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | -- | si |
| `Pend_Partic_Jov` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | si |
| `Pend_Partic_Jov_Prev` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | si |
| `Pend_Partic_Tot` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` | -- | -- | -- |
| `Razon_Pend_Desoc` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` | -- | -- | -- |
| `U_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p4` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p6` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p7` | -- | -- | -- |
| `U_H` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p6` | -- | -- | -- |
| `U_M` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p6` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p8` | -- | -- | -- |
| `U_M_ef` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p6` | -- | -- | -- |
| `datos` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p7` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p5` | -- | `Prepara_bbdd.R` `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_ind_varios.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_sector.R` `intermedios/crea_objetos_tamano.R` | si |
| `tramo_jubilacion_AS` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p7` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p5` | -- | -- | -- |
| `tramo_jubilacion_M` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p7` `Inf_ENE_Sexo_Edad_Region.qmd:cA4p5` | -- | -- | -- |
| `unidad` | `Inf_ENE_Sexo_Edad_Region.qmd:c3s1p1` | -- | `intermedios/crea_objetos_kpi.R` `intermedios/crea_objetos_nucleo.R` | si |
| `Comp_Desoc_Jov` | -- | -- | -- | -- |
| `Comp_Desoc_May` | -- | -- | -- | -- |
| `Comp_Ocup_Jov` | -- | -- | -- | -- |
| `Comp_Ocup_May` | -- | -- | -- | -- |
| `Comp_Ocup_Mayor` | -- | -- | -- | si |
| `Comp_Ocup_Top` | -- | -- | -- | -- |
| `Edad_Serie_Ini` | -- | -- | -- | -- |
| `base_comp_desoc` | -- | -- | -- | si |
| `base_comp_ocup` | -- | -- | -- | si |
| `base_edad` | -- | -- | -- | si |
| `base_edad_fechas` | -- | -- | -- | si |
| `base_grA_desocup` | -- | -- | -- | si |
| `base_grB_partic` | -- | -- | -- | si |
| `base_grE` | -- | -- | -- | si |
| `base_grEF` | -- | -- | -- | si |
| `base_grF` | -- | -- | -- | si |
| `base_pet_edad` | -- | -- | -- | si |
| `base_stocks_edad` | -- | -- | -- | si |
| `base_total_desoc` | -- | -- | -- | si |
| `base_total_partic` | -- | -- | -- | si |
| `cats_edad` | -- | -- | -- | si |
| `cats_inf_edad` | -- | -- | -- | si |
| `col_act` | -- | -- | `intermedios/crea_objetos_desest.R` | si |
| `col_ano` | -- | -- | `intermedios/crea_objetos_desest.R` | si |
| `col_mes` | -- | -- | `intermedios/crea_objetos_desest.R` | si |
| `colores_fechas` | -- | -- | -- | si |
| `colores_grEF` | -- | -- | -- | si |
| `cortes_edad` | -- | -- | -- | si |
| `d` | -- | -- | -- | si |
| `df` | -- | -- | -- | si |
| `fc_base_composicion` | -- | -- | -- | si |
| `fc_base_informalidad_edad` | -- | -- | -- | si |
| `fc_base_informalidad_edad_ef` | -- | -- | -- | si |
| `fc_comp_edad` | -- | -- | -- | si |
| `fc_curva_edad` | -- | -- | -- | si |
| `fc_grafico_informalidad_edad` | -- | -- | -- | si |
| `fechas_grEF` | -- | -- | -- | si |
| `fechas_informalidad` | -- | -- | -- | si |
| `fila` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_region.R` | si |
| `ft_Edad_1524` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2` | -- | -- |
| `ft_Edad_55mas` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2` | -- | -- |
| `gr_Comp_Desocupados_Edad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | si |
| `gr_Comp_Ocupados_Edad` | -- | -- | -- | si |
| `gr_Informalidad_Edad_AS` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | si |
| `gr_Informalidad_Edad_EF` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2` | -- | si |
| `gr_Informalidad_Edad_M` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | si |
| `gr_Tasa_Desocup_Edad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2` | -- | si |
| `gr_Tasa_Partic_Edad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2` | -- | si |
| `hacer_tabla_edad` | -- | -- | -- | si |
| `idx_o` | -- | -- | -- | si |
| `indicadores_t5` | -- | -- | -- | si |
| `orden_tramos` | -- | -- | -- | si |
| `p_j` | -- | -- | -- | si |
| `pend_desoc` | -- | -- | `intermedios/crea_objetos_desest.R` | -- |
| `pend_partic` | -- | -- | `intermedios/crea_objetos_desest.R` | si |
| `pred_grA` | -- | -- | -- | si |
| `pred_grB` | -- | -- | -- | si |
| `puntos_grA` | -- | -- | -- | si |
| `puntos_grB` | -- | -- | -- | si |
| `s` | -- | -- | -- | si |
| `stocks_edad` | -- | -- | -- | si |
| `tabla_interna_grA` | -- | -- | -- | si |
| `tabla_interna_grA_fmt` | -- | -- | -- | si |
| `tabla_interna_grB` | -- | -- | -- | si |
| `tabla_interna_grB_fmt` | -- | -- | -- | si |
| `tema_grA` | -- | -- | -- | si |
| `tema_grB` | -- | -- | -- | si |
| `tramos_intermedios_desoc` | -- | -- | -- | si |
| `tramos_intermedios_ocup` | -- | -- | -- | si |
| `tramos_joven` | -- | -- | -- | si |
| `tramos_jovenes` | -- | -- | -- | si |
| `tramos_jovenes_desoc` | -- | -- | -- | si |
| `tramos_jovenes_ocup` | -- | -- | -- | si |
| `tramos_mayor` | -- | -- | -- | si |
| `tramos_mayores` | -- | -- | -- | si |
| `tramos_mayores_desoc` | -- | -- | -- | si |
| `tramos_mayores_ocup` | -- | -- | -- | si |
| `tramos_pet_jovenes` | -- | -- | -- | si |
| `tramos_pet_mayores` | -- | -- | -- | si |
| `v` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |
| `v_ano` | -- | -- | -- | si |
| `v_mes` | -- | -- | -- | si |
| `x_pos_grA` | -- | -- | -- | si |
| `x_pos_grB` | -- | -- | -- | si |
| `y_pos_grA` | -- | -- | -- | si |
| `y_pos_grB` | -- | -- | -- | si |

_Sin consumidor (6): `Comp_Desoc_Jov`, `Comp_Desoc_May`, `Comp_Ocup_Jov`, `Comp_Ocup_May`, `Comp_Ocup_Top`, `Edad_Serie_Ini`_

## intermedios/crea_objetos_formalidad.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `base_gr4_apilada` | -- | -- | -- | si |
| `base_gr4_ocup_form` | -- | -- | -- | si |
| `base_gr4_wide` | -- | -- | -- | si |
| `base_gr6_ocup_form_12m` | -- | -- | -- | si |
| `base_gr7_asal_dep_inf` | -- | -- | -- | si |
| `base_gr8_barras` | -- | -- | -- | si |
| `base_gr8_incid` | -- | -- | -- | si |
| `cats_gr4_detalle` | -- | -- | -- | si |
| `cats_ocup_incid` | -- | -- | -- | si |
| `colores_gr6` | -- | -- | -- | si |
| `colores_gr7` | -- | -- | -- | si |
| `colores_gr8` | -- | -- | -- | si |
| `fechas_puntos_gr7` | -- | -- | -- | si |
| `gr_Delta_Ocupados_Inf_12m` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1` | -- | -- |
| `gr_Ocupacion_2017_Actual` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1` | -- | -- |
| `gr_asal_dep_inf_Sexo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2` | -- | -- |
| `gr_delta_Ocup_incid_categ` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c4s2` | -- | -- |
| `punto_actual_gr8` | -- | -- | -- | si |
| `puntos_gr4_ocup` | -- | -- | -- | si |
| `puntos_gr6_ocup_12m` | -- | -- | -- | si |
| `puntos_gr7_asal` | -- | -- | -- | si |
| `tabla_interna_gr6` | -- | -- | -- | si |
| `tabla_interna_gr6_fmt` | -- | -- | -- | si |
| `tema_tabla_gr6` | -- | -- | -- | si |
| `x_pos_gr6` | -- | -- | -- | si |
| `y_pos_gr6` | -- | -- | -- | si |

## intermedios/crea_objetos_ind_varios.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `AsAno` | `Inf_ENE_Sexo_Edad_Region.qmd:cA3p3` | -- | -- | -- |
| `AsMes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA3p2` | -- | -- | -- |
| `AsPre` | `Inf_ENE_Sexo_Edad_Region.qmd:cA3p4` | -- | -- | -- |
| `BrAno` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p2` | -- | -- | -- |
| `BrMes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p1` | -- | -- | -- |
| `BrPre` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p3` | -- | -- | -- |
| `BrPre_TInform` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p3` | -- | -- | -- |
| `BrPre_TPartic` | `Inf_ENE_Sexo_Edad_Region.qmd:cA4p3` | -- | -- | -- |
| `ft_IndVarios_DAnno_AS` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA3` | -- | -- |
| `ft_IndVarios_DAnno_Brecha` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | -- |
| `ft_IndVarios_DMes_AS` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA3` | -- | -- |
| `ft_IndVarios_DMes_Brecha` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | -- |
| `ft_IndVarios_DPostCovid_AS` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA3` | -- | -- |
| `ft_IndVarios_DPostCovid_Brecha` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA4` | -- | -- |
| `tc_as_ano` | -- | -- | -- | si |
| `tc_as_mes` | -- | -- | -- | si |
| `tc_as_pre` | -- | -- | -- | si |
| `tc_brecha_ano` | -- | -- | -- | si |
| `tc_brecha_mes` | -- | -- | -- | si |
| `tc_brecha_pre` | -- | -- | -- | si |

## intermedios/crea_objetos_kpi.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `df_grid` | -- | -- | -- | si |
| `ft_KPI_Destacados` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cNA` | -- | -- |
| `kpi_TInform_Micro` | -- | -- | -- | si |
| `kpi_lista` | -- | -- | -- | si |

## intermedios/crea_objetos_motivo_desempleo.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `MotTop_Pct_Act` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p2` | -- | -- | -- |
| `MotTop_Pct_Ini` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p2` | -- | -- | -- |
| `Mot_CircExt_Niv` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p1` | -- | -- | -- |
| `Mot_DecOtros_Niv` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p1` | -- | -- | -- |
| `Mot_Top_Coincide` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | -- |
| `Mot_Top_Lider_Mes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | si |
| `Mot_Top_Lider_Niv` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | si |
| `Motivo_Divergentes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | -- |
| `Motivo_Mayor_Nivel` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p1` `Inf_ENE_Sexo_Edad_Region.qmd:cA6p2` `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | si |
| `Motivo_Mayor_Nivel_Pct` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p1` | -- | -- | -- |
| `Motivo_N_Divergentes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p3` | -- | -- | -- |
| `fecha_MotDes_InicioSerie` | `Inf_ENE_Sexo_Edad_Region.qmd:cA6p2` | -- | -- | si |
| `Mot_Top_Mes_H` | -- | -- | -- | -- |
| `Mot_Top_Mes_M` | -- | -- | -- | si |
| `Mot_Top_Niv_H` | -- | -- | -- | -- |
| `Mot_Top_Niv_M` | -- | -- | -- | si |
| `anio` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `base_comp_motivo_desempleo` | -- | -- | -- | si |
| `categorias_motivo_desempleo` | -- | -- | -- | si |
| `colores_motivo_desempleo` | -- | -- | -- | si |
| `df_motivo_desempleo` | -- | -- | -- | si |
| `df_motivo_desempleo_sexo` | -- | -- | -- | si |
| `div_mot` | -- | -- | -- | si |
| `fecha_MotDes_1anno` | -- | -- | -- | si |
| `fecha_MotDes_Actual` | -- | -- | -- | si |
| `fecha_MotDes_MesAnterior` | -- | -- | -- | si |
| `ft_MotivoDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA6` | -- | si |
| `ft_MotivoDesempleo_Sexo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA6` | -- | si |
| `gr_Comp_MotivoDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA6` | -- | si |
| `h_mot` | -- | -- | -- | si |
| `lbl_H` | -- | -- | `intermedios/crea_objetos_razon_desempleo.R` | si |
| `lbl_M` | -- | -- | `intermedios/crea_objetos_razon_desempleo.R` | si |
| `lid_mes` | -- | -- | `intermedios/crea_objetos_razon_desempleo.R` | si |
| `lid_niv` | -- | -- | `intermedios/crea_objetos_razon_desempleo.R` | si |
| `pct_mot_top` | -- | -- | -- | si |
| `prev` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `v` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |

_Sin consumidor (2): `Mot_Top_Mes_H`, `Mot_Top_Niv_H`_

## intermedios/crea_objetos_nucleo.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `unidad` | `Inf_ENE_Sexo_Edad_Region.qmd:c3s1p1` | -- | `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_kpi.R` | si |
| `anio` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `base_gr2_tdesocup` | -- | -- | -- | si |
| `base_gr3_tparticip` | -- | -- | -- | si |
| `df_t1` | -- | -- | -- | si |
| `ft_Delta_indicadores` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c2` | -- | -- |
| `gr_Tasa_Desocup_2010_Actual` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c3s1` | -- | -- |
| `gr_Tasa_Particip_2010_Actual` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c3s2` | -- | -- |
| `indicadores_t1` | -- | -- | -- | si |
| `pred_gr2_tdesocup` | -- | -- | -- | si |
| `pred_gr3_tparticip` | -- | -- | -- | si |
| `prev` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `puntos_gr2_tdesocup` | -- | -- | -- | si |
| `puntos_gr3_tparticip` | -- | -- | -- | si |
| `tabla_interna_gr2` | -- | -- | -- | si |
| `tabla_interna_gr2_fmt` | -- | -- | -- | si |
| `tabla_interna_gr3` | -- | -- | -- | si |
| `tabla_interna_gr3_fmt` | -- | -- | -- | si |
| `tema_tabla_gr2` | -- | -- | -- | si |
| `tema_tabla_gr3` | -- | -- | -- | si |
| `v` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |
| `x_pos_gr2` | -- | -- | -- | si |
| `x_pos_gr3` | -- | -- | -- | si |
| `y_pos_gr2` | -- | -- | -- | si |
| `y_pos_gr3` | -- | -- | -- | si |

## intermedios/crea_objetos_razon_desempleo.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Jubil_Pct_Act` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p2` | -- | -- | si |
| `Jubil_Pct_Ini` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p2` | -- | -- | si |
| `Razon_Baja_Anual` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_Inv_H` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | -- |
| `Razon_Inv_M` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | -- |
| `Razon_Invertida_Top` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | si |
| `Razon_Jubil_H` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | -- |
| `Razon_Jubil_M` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | -- |
| `Razon_MayorMovMes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | si |
| `Razon_Mayor_Nivel` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_Mayor_Nivel_Pct` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_MovMes_1` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_MovMes_2` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_N_Baja_Anual` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p1` | -- | -- | -- |
| `Razon_Top_Coincide` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | -- |
| `Razon_Top_Lider_DifMes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | si |
| `Razon_Top_Lider_Nivel` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p3` | -- | -- | si |
| `fecha_RazDes_InicioSerie` | `Inf_ENE_Sexo_Edad_Region.qmd:cA7p2` | -- | -- | si |
| `Jubil_Pct_Delta` | -- | -- | -- | -- |
| `Razon_Invertidas` | -- | -- | -- | si |
| `Razon_MayorMovMes_Valor` | -- | -- | -- | -- |
| `Razon_Top_DifMes_H` | -- | -- | -- | -- |
| `Razon_Top_DifMes_M` | -- | -- | -- | si |
| `Razon_Top_Nivel_H` | -- | -- | -- | -- |
| `Razon_Top_Nivel_M` | -- | -- | -- | si |
| `anio` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `base_comp_razon_desempleo` | -- | -- | -- | si |
| `c_baja` | -- | -- | -- | si |
| `categorias_razon_desempleo` | -- | -- | -- | si |
| `colores_razon_desempleo` | -- | -- | -- | si |
| `df_razon_desempleo` | -- | -- | -- | si |
| `df_razon_desempleo_sexo` | -- | -- | -- | si |
| `fecha_RazDes_1anno` | -- | -- | -- | si |
| `fecha_RazDes_Actual` | -- | -- | -- | si |
| `fecha_RazDes_MesAnterior` | -- | -- | -- | si |
| `ft_RazonDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA7` | -- | si |
| `ft_RazonDesempleo_Sexo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA7` | -- | si |
| `gr_Comp_RazonDesempleo` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA7` | -- | si |
| `h_mov` | -- | -- | -- | si |
| `h_niv` | -- | -- | -- | si |
| `lbl_H` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` | si |
| `lbl_M` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` | si |
| `lid_mes` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` | si |
| `lid_niv` | -- | -- | `intermedios/crea_objetos_motivo_desempleo.R` | si |
| `ord_mes` | -- | -- | -- | si |
| `pct_jubil` | -- | -- | -- | si |
| `prev` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_tamano.R` | si |
| `razon_es_bueno` | -- | -- | -- | si |
| `razon_niv` | -- | -- | -- | si |
| `sel` | -- | -- | -- | si |
| `sx` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_sector.R` | si |
| `v` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` | si |

_Sin consumidor (4): `Jubil_Pct_Delta`, `Razon_MayorMovMes_Valor`, `Razon_Top_DifMes_H`, `Razon_Top_Nivel_H`_

## intermedios/crea_objetos_razon_fft.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `cats_fft` | -- | -- | -- | si |
| `dt_fft` | -- | -- | -- | si |
| `fft_base` | -- | -- | -- | si |
| `fft_tabla` | -- | -- | -- | si |
| `fila_fft` | -- | -- | -- | si |
| `ft_Razon_FFT` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1` | -- | -- |
| `gr_Razon_No_part` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1` | -- | -- |
| `razones_fft` | -- | -- | -- | si |

## intermedios/crea_objetos_region.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `RegAsalI` | `Inf_ENE_Sexo_Edad_Region.qmd:cA2p3` | -- | -- | -- |
| `RegDesoc` | `Inf_ENE_Sexo_Edad_Region.qmd:cA2p1` | -- | -- | -- |
| `RegDesocN` | `Inf_ENE_Sexo_Edad_Region.qmd:cA2p4` | -- | -- | -- |
| `RegInform` | `Inf_ENE_Sexo_Edad_Region.qmd:cA2p2` | -- | -- | -- |
| `dato` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | si |
| `serie` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p6` `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p4` `Inf_ENE_Sexo_Edad_Region.qmd:cA6p2` `Inf_ENE_Sexo_Edad_Region.qmd:cA7p2` `modulo_desest_principal.qmd:cNAs3p2` | -- | `intermedios/crea_objetos_desest.R` | si |
| `texto_radiografia_calidad` | `modulo_radiografia_territorial.qmd:cNAp2` | -- | -- | -- |
| `texto_radiografia_empresas` | `modulo_radiografia_territorial.qmd:cNAp4` | -- | -- | -- |
| `texto_radiografia_formalidad` | `modulo_radiografia_territorial.qmd:cNAp3` | -- | -- | -- |
| `texto_radiografia_genero` | `modulo_radiografia_territorial.qmd:cNAp1` | -- | -- | -- |
| `texto_radiografia_sintesis` | `modulo_radiografia_territorial.qmd:cNAp5` | -- | -- | -- |
| `anclas_limites_ranking` | -- | -- | -- | si |
| `aporte_mujeres` | -- | -- | -- | si |
| `base_region_desocup` | -- | -- | -- | si |
| `brecha_inf_territorial` | -- | -- | -- | si |
| `brecha_micro_territorial` | -- | -- | -- | si |
| `cambio_anual_formal` | -- | -- | -- | si |
| `cambio_anual_informal` | -- | -- | -- | si |
| `cambio_anual_micro` | -- | -- | -- | si |
| `cambio_anual_ocup_h` | -- | -- | -- | si |
| `cambio_anual_ocup_m` | -- | -- | -- | si |
| `cambio_anual_ocup_territorial` | -- | -- | -- | -- |
| `categorias` | -- | -- | -- | si |
| `cats_inform_region` | -- | -- | -- | si |
| `config_ranking_territorial` | -- | -- | -- | si |
| `dt_desocup_region` | -- | -- | -- | si |
| `dt_inform_region` | -- | -- | -- | si |
| `es_informe_regional` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cNA` `Inf_ENE_Sexo_Edad_Region.qmd:cA1` `Inf_ENE_Sexo_Edad_Region.qmd:cA2` | `intermedios/crea_objetos_sector.R` | si |
| `fc_brecha_pais` | -- | -- | -- | si |
| `fc_movimiento` | -- | -- | -- | si |
| `fc_posicion_ranking` | -- | -- | -- | si |
| `fc_ranking_por_edad` | -- | -- | -- | si |
| `fc_valor_portada_regional` | -- | -- | -- | si |
| `fechas_grafico_ranking` | -- | -- | -- | si |
| `fechas_ranking_territorial` | -- | -- | -- | si |
| `fila` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` | si |
| `fila_total_desocup_region` | -- | -- | -- | si |
| `filas_ranking_territorial` | -- | -- | -- | si |
| `filtro` | -- | -- | -- | si |
| `ft_Desocupados_Region` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA2` | -- | si |
| `ft_Posicion_Ranking_Territorial` | -- | `modulo_ranking_territorial.qmd:cNA` | -- | -- |
| `ft_TAsal_dep_Inform_Region` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA2` | -- | si |
| `ft_TDesocup_Region_m_y_d12m` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA2` | -- | si |
| `ft_TInform_Region` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA2` | -- | si |
| `gr_Posicion_Ranking_Territorial` | -- | `modulo_ranking_territorial.qmd:cNA` | -- | -- |
| `ind` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_nucleo.R` | si |
| `limites_ranking_territorial` | -- | -- | -- | si |
| `max_regiones_ranking` | -- | -- | -- | si |
| `ocup_for_ano` | -- | -- | -- | si |
| `ocup_for_reg` | -- | -- | -- | si |
| `ocup_h_reg` | -- | -- | -- | si |
| `ocup_h_reg_ano` | -- | -- | -- | si |
| `ocup_inf_ano` | -- | -- | -- | si |
| `ocup_inf_reg` | -- | -- | -- | si |
| `ocup_m_reg` | -- | -- | -- | si |
| `ocup_m_reg_ano` | -- | -- | -- | si |
| `ocup_micro_ano` | -- | -- | -- | si |
| `ocup_micro_nac` | -- | -- | -- | si |
| `ocup_micro_reg` | -- | -- | -- | si |
| `ocup_nac` | -- | -- | -- | si |
| `ocup_reg` | -- | -- | -- | si |
| `ocup_reg_ano` | -- | -- | -- | si |
| `ranking_directo_territorial` | -- | -- | -- | si |
| `ranking_edad_territorial` | -- | -- | -- | si |
| `ranking_grafico_territorial` | -- | -- | -- | si |
| `ranking_territorial` | -- | -- | -- | si |
| `resumen_ranking_territorial` | -- | -- | -- | si |
| `tasa_inf_nac` | -- | -- | -- | si |
| `tasa_inf_reg` | -- | -- | -- | si |
| `ultimo_ranking_territorial` | -- | -- | -- | si |

_Sin consumidor (1): `cambio_anual_ocup_territorial`_

## intermedios/crea_objetos_sector.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Area_Ctr_Br` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Area_Ctr_Fem` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Area_Ctr_Nom` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | si |
| `Area_Ctr_Rank` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Area_Ctr_Val` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Area_Inf_EsFem` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | si |
| `Area_Inf_Fem` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | si |
| `Area_Inf_Nom` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Area_Inf_Val` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p7` | -- | -- | -- |
| `Brecha_Comercio` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Brecha_ServPersonales` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Fem_Comercio` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Fem_ServPersonales` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Fem_ServPublicos` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Inf_Comercio` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Inf_ServEmpresas` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p8` `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Inf_ServPersonales` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p8` `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Inf_ServPublicos` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `N_Areas_Analizadas` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p1` | -- | -- | -- |
| `N_Ramas_BrechaInf_Hombres` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `N_Ramas_BrechaInf_Mujeres` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `N_Ramas_Brecha_Inf` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `Rama_Fem_Alta` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p3` | -- | -- | -- |
| `Rama_Fem_AltaVal` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p3` | -- | -- | si |
| `Rama_Fem_Baja` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p3` | -- | -- | -- |
| `Rama_Fem_BajaVal` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p3` | -- | -- | si |
| `Rama_Inf_Alta` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p2` | -- | -- | -- |
| `Rama_Inf_AltaVal` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p2` | -- | -- | si |
| `Rama_Inf_Baja` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p2` | -- | -- | -- |
| `Rama_Inf_BajaVal` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p2` | -- | -- | si |
| `Rama_MayorBrechaInf` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `SecAno` | `Inf_ENE_Sexo_Edad_Region.qmd:cA1p3` | -- | -- | -- |
| `SecMes` | `Inf_ENE_Sexo_Edad_Region.qmd:cA1p2` | -- | -- | -- |
| `Signo_MayorBrechaInf` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `Valor_MayorBrechaInf` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4p4` | -- | -- | -- |
| `otras` | `Inf_ENE_Sexo_Edad_Region.qmd:c1p1` | -- | `intermedios/crea_objetos_razon_fft.R` | si |
| `total` | `Inf_ENE_Sexo_Edad_Region.qmd:c4s1p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p1` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p3` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p4` `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p4` `Inf_ENE_Sexo_Edad_Region.qmd:c5s6p2` | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_razon_desempleo.R` `intermedios/crea_objetos_region.R` `intermedios/crea_objetos_tamano.R` | si |
| `Area_Mayor_Feminizacion` | -- | -- | -- | -- |
| `Area_Mayor_Informalidad` | -- | -- | -- | -- |
| `Brecha_Construccion` | -- | -- | -- | -- |
| `Brecha_ServEmpresas` | -- | -- | -- | -- |
| `Fem_Construccion` | -- | -- | -- | -- |
| `Fem_ServEmpresas` | -- | -- | -- | -- |
| `Inf_Construccion` | -- | -- | -- | -- |
| `Ocup_Comercio` | -- | -- | -- | -- |
| `Umbral_Base_Rama` | -- | -- | -- | si |
| `areas_inf_fem` | -- | -- | -- | si |
| `base_rama_form` | -- | -- | -- | si |
| `brecha_tabla_areas` | -- | -- | -- | si |
| `brecha_tabla_base` | -- | -- | -- | si |
| `cand` | -- | -- | -- | si |
| `cats_form_rama` | -- | -- | -- | si |
| `cats_inf_rama` | -- | -- | -- | si |
| `cats_rama_form` | -- | -- | -- | si |
| `df_mapeo_areas` | -- | -- | -- | si |
| `dt_areas_t1b` | -- | -- | -- | si |
| `dt_areas_t1c` | -- | -- | -- | si |
| `dt_t1a` | -- | -- | -- | si |
| `dt_t1b` | -- | -- | -- | si |
| `dt_t1c` | -- | -- | -- | si |
| `estructura_sectorial_territorial` | -- | -- | -- | si |
| `f` | -- | -- | `intermedios/crea_objetos_desest.R` `intermedios/crea_objetos_edad.R` `intermedios/crea_objetos_formalidad.R` `intermedios/crea_objetos_nucleo.R` | si |
| `fc_sector_participacion` | -- | -- | -- | si |
| `fila_fem` | -- | -- | -- | si |
| `fila_fem_areas_total` | -- | -- | -- | si |
| `fila_inf` | -- | -- | -- | si |
| `fila_inf_areas_total` | -- | -- | -- | si |
| `fila_nsr` | -- | -- | -- | si |
| `fila_total_1a` | -- | -- | -- | si |
| `form_as` | -- | -- | -- | si |
| `ft_Area_Brecha_Inf` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5` | -- | si |
| `ft_Area_Feminizacion` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5` | -- | si |
| `ft_Area_Informalidad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5` | -- | si |
| `ft_Empleos_Sector_y_d12m` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:cA1` | -- | si |
| `ft_Estructura_Sectorial_Territorial` | -- | `modulo_sector_territorial.qmd:cNA` | -- | -- |
| `ft_Sector_Brecha_Inf` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4` | -- | si |
| `ft_Sector_Feminizacion` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4` | -- | si |
| `ft_Sector_Informalidad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s4` | -- | si |
| `gr_Estructura_Sectorial_Territorial` | -- | `modulo_sector_territorial.qmd:cNA` | -- | -- |
| `h_br` | -- | -- | -- | si |
| `h_fem_a` | -- | -- | -- | si |
| `h_fem_b` | -- | -- | -- | si |
| `h_inf_a` | -- | -- | -- | si |
| `h_inf_b` | -- | -- | -- | si |
| `i` | -- | -- | `intermedios/crea_objetos_kpi.R` `intermedios/crea_objetos_region.R` | si |
| `i_inf` | -- | -- | -- | si |
| `inf_as` | -- | -- | -- | si |
| `inf_por_sexo` | -- | -- | -- | si |
| `inf_por_sexo_area` | -- | -- | -- | si |
| `j` | -- | -- | `intermedios/crea_objetos_kpi.R` | si |
| `labels_rama` | -- | -- | -- | si |
| `labels_rama_form` | -- | -- | -- | si |
| `nota_rama` | -- | -- | -- | si |
| `part_nacional` | -- | -- | -- | si |
| `part_region` | -- | -- | -- | si |
| `tot_fem` | -- | -- | -- | si |
| `tot_fem_areas` | -- | -- | -- | si |
| `tot_inf` | -- | -- | -- | si |
| `tot_inf_areas` | -- | -- | `intermedios/crea_objetos_tamano.R` | si |

_Sin consumidor (8): `Area_Mayor_Feminizacion`, `Area_Mayor_Informalidad`, `Brecha_Construccion`, `Brecha_ServEmpresas`, `Fem_Construccion`, `Fem_ServEmpresas`, `Inf_Construccion`, `Ocup_Comercio`_

## intermedios/crea_objetos_tamano.R

| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |
|---|---|---|---|---|
| `Area_Vol_Pct` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | -- |
| `Area_Vol_Val` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s5p9` | -- | -- | si |
| `Micro_Pct_NuevoInf` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p4` | -- | -- | -- |
| `c_med` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p4` | -- | -- | -- |
| `c_micro` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p4` | -- | -- | si |
| `c_peq` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3p4` | -- | -- | -- |
| `razones` | `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p2` `Inf_ENE_Sexo_Edad_Region.qmd:c5s1p3` `Inf_ENE_Sexo_Edad_Region.qmd:c5s2p6` | -- | `Variables_ENE.R` `intermedios/crea_objetos_razon_fft.R` | si |
| `Area_Vol_Nom` | -- | -- | -- | -- |
| `Tam_MasRecomp` | -- | -- | -- | -- |
| `Tam_MasRecomp_Bru` | -- | -- | -- | -- |
| `Tam_MasRecomp_Raz` | -- | -- | -- | -- |
| `ancho_barra` | -- | -- | -- | si |
| `anio` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |
| `base_tamano` | -- | -- | -- | si |
| `c_gran` | -- | -- | -- | -- |
| `cat_bbdd` | -- | -- | -- | si |
| `categorias_tamano` | -- | -- | -- | si |
| `comp_tamano` | -- | -- | -- | si |
| `dat_area_tamano` | -- | -- | -- | si |
| `dat_barras_tamano` | -- | -- | -- | si |
| `dat_informal_snap` | -- | -- | -- | si |
| `dat_tasa_tamano` | -- | -- | -- | si |
| `df_tamano` | -- | -- | -- | si |
| `fechas_hito_tamano` | -- | -- | -- | si |
| `filas_tamano` | -- | -- | -- | si |
| `formalidades_tamano` | -- | -- | -- | si |
| `ft_Tamano_Formalidad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3` | -- | si |
| `gr_Tamano_Area_Comparada` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3` | -- | -- |
| `gr_Tamano_Barras` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3` | -- | -- |
| `gr_Tamano_Tasa_Informalidad` | -- | `Inf_ENE_Sexo_Edad_Region.qmd:c5s3` | -- | -- |
| `hitos_tasa_tamano` | -- | -- | -- | si |
| `i_vol` | -- | -- | -- | si |
| `offset_barra` | -- | -- | -- | si |
| `prev` | -- | -- | `intermedios/crea_objetos_dur_desempleo.R` `intermedios/crea_objetos_motivo_desempleo.R` `intermedios/crea_objetos_nucleo.R` `intermedios/crea_objetos_razon_desempleo.R` | si |
| `tamanos_lbl` | -- | -- | -- | si |
| `val` | -- | -- | -- | si |

_Sin consumidor (5): `Area_Vol_Nom`, `Tam_MasRecomp`, `Tam_MasRecomp_Bru`, `Tam_MasRecomp_Raz`, `c_gran`_

## Citados en el .qmd y no definidos en estos archivos

Se busca solo dentro de codigo (inline `` `r ...` `` y chunks), no en la prosa.

**Probablemente de las bibliotecas** (12). Normal si existen 
en `funciones_informe.R` o `funciones_textoActivo.R`:

`fc_Form_Num`, `fc_banda_proporcion`, `fc_banda_razon`, `fc_fecha_a_trimestre`, `fc_frase_cambio`, `fc_nota_periodo`, `fc_texto_as`, `fc_texto_brecha`, `fc_texto_region`, `fc_texto_region_nivel`, `fc_texto_sector`, `fc_texto_tendencia`

**Sin origen identificado** (2). **Revisar uno por uno**: 
aca aparecio el hueco del Anexo 5. Un objeto citado que nadie define no rompe 
el render, imprime vacio:

`Trim_Actual`, `knit_child`

