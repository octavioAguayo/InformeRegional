# Contrato de módulos — InformeRegional

_v2 · 26-08-2026_

Todos los módulos intermedios se ubican en `intermedios/`. El QMD es el único
orquestador autorizado para cargarlos. Los prefijos son obligatorios:
`crea_objetos_*.R` para cálculo y `modulo_*.qmd` para composición editorial.

Todos los módulos se ejecutan en el orden fijado por `Inf_ENE_Sexo_Edad_Region.qmd`. No cargan archivos `.RData` ni escriben datos; consumen el tronco ya preparado.

| Módulo | Dependencias declaradas | Salida principal |
|---|---|---|
| `intermedios/crea_objetos_kpi.R` | `Variables_ENE.R`, funciones de formato | KPI de portada |
| `intermedios/crea_objetos_nucleo.R` | `dt_ENE_compuesta`, `Fechas`, parámetros | tablas y gráficos del núcleo |
| `intermedios/crea_objetos_formalidad.R` | `dt_ENE_compuesta`, `Fechas`, parámetros | formalidad |
| `intermedios/crea_objetos_razon_fft.R` | `dt_ENE_compuesta`, `Fechas`, parámetros | razones de no participación |
| `intermedios/crea_objetos_region.R` | `dt_ENE_regional`, `fecha_Actual` | comparación regional |
| `intermedios/crea_objetos_sector.R` | `dt_ENE_compuesta`, `Fechas`, rama canónica `r_p_rev4cl_caenes` | sector económico |
| `intermedios/crea_objetos_edad.R` | `dt_ENE_compuesta`, `Fechas`, tramos de `Parametros_ENE.R` | edad e informalidad |
| `intermedios/crea_objetos_tamano.R` | `dt_ENE_compuesta`, `Fechas`, categorías de tamaño | tamaño de empresa |
| `intermedios/crea_objetos_desest.R` | `dt_ENE_compuesta`, `Fechas`, `filtro_tabla_desest`, `cortes` | X13 nacional condicional |
| `intermedios/crea_objetos_ind_varios.R` | tablas del tronco y `Variables_ENE.R` | indicadores varios |
| `intermedios/crea_objetos_dur_desempleo.R` | `dt_ENE_compuesta`, `fecha_dta_efectiva` | duración del desempleo |
| `intermedios/crea_objetos_motivo_desempleo.R` | `dt_ENE_compuesta`, `fecha_dta_efectiva` | motivo del desempleo |
| `intermedios/crea_objetos_razon_desempleo.R` | `dt_ENE_compuesta`, `fecha_dta_efectiva` | razón de fin de trabajo |

Los últimos tres son módulos `.dta`: en ventana Excel se publican con la fecha efectiva documentada por `fc_nota_periodo()`. Los regionales nuevos se bloquean en la app mientras la frontera `.dta` esté atrasada.

## Contrato de limpieza

En el código solo permanece una **trampa local**: comentario breve, de hasta dos
líneas, pegado a la instrucción que protege. Historia y decisiones van al
changelog; reglas de dominio al manual; tareas pendientes a
`Documentacion/Desafios_Estudios_Futuros.md`. No se permiten bloques explicativos dentro de
los módulos.

Antes de incorporar un módulo o modificar uno existente, ejecutar el control
sobre **ese archivo** y corregir toda observación:

```r
source(file.path(dirname(getwd()), "Bibliotecas_R", "calidad",
                 "audita_contrato_limpieza.R"))
fc_auditar_limpieza(
  archivos = "intermedios/crea_objetos_sector.R",
  detener = TRUE
)
```

Sin `archivos`, la función reporta la deuda histórica completa; hoy registra 78
bloques a limpiar gradualmente. Esa deuda no autoriza a agregar comentarios
nuevos al archivo que se interviene.
