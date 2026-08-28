# Estado operativo — InformeRegional

_v2 · 26-08-2026_

Actualizado: 26-08-2026.

## Contrato de datos

- Este proyecto es **consumidor** de `dt_ENE_Master.RData`; no debe modificarla ni guardarla.
- Ruta esperada: `Datos_Ine/ENE/bbdd_minuta/dt_ENE_Master.RData`.
- `Prepara_bbdd.R` carga una única copia aislada, valida el objeto, las columnas y el período solicitado.
- La frontera `.dta` se determina con `fc_frontera_fuentes()` sobre la categoría exclusiva `Desocupados 1 a 3 meses` en RM. No se deduce leyendo insumos crudos.

## Estado de fuentes

- **Ventana total:** la fecha de la maestra y de la frontera `.dta` coinciden; se pueden generar nacional y regionales del período actual.
- **Ventana Excel:** la maestra ya contiene el período nuevo pero la frontera `.dta` está atrás; se puede generar la minuta nacional, pero la app bloquea regionales del período nuevo. Los regionales de períodos anteriores siguen permitidos.

## Ejecución segura

1. Abrir `app.R` desde este proyecto.
2. Revisar el aviso de estado de fuentes.
3. Generar DOCX y/o HTML.
4. Editar el DOCX manualmente si corresponde.
5. Usar el botón separado de conversión para crear PDF desde cualquier Word de la carpeta del período.

La publicación va a `Datos_Ine/Procesados/Informes/<AAAAMM>` mediante un archivo temporal. PDF no es un formato de render de Quarto.

## Módulos

- Tronco obligatorio: `Parametros_ENE.R` → `Prepara_bbdd.R` → `Variables_ENE.R`.
- Los módulos `intermedios/crea_objetos_*.R` consumen ese tronco y no cargan ni escriben la maestra.
- Los módulos desestacionalizados solo se incorporan si la cobertura nacional X13 está completa.
- Los módulos QMD opcionales se nombran `modulo_*.qmd`; `calidad/mapea_proyecto.R` los incluye al regenerar el índice.
