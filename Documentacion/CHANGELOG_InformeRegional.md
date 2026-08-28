# Changelog — InformeRegional

## 28-08-2026 — Umbral sectorial proporcional por región

- `intermedios/crea_objetos_sector.R` v13→v14 reemplaza el umbral absoluto de
  10.000 ocupados por una base relativa equivalente al 2% del empleo regional,
  redondeada siempre hacia arriba al millar completo. La regla produce un corte
  de 2.000 ocupados para Aysén y de 84.000 para la Región Metropolitana en
  202606, evitando aplicar la misma exigencia a regiones de tamaños muy
  distintos.
- `Inf_ENE_Sexo_Edad_Region.qmd` controla el caso en que ninguna rama supera la
  base mínima: conserva la tabla como referencia descriptiva y omite el
  superlativo sectorial, en lugar de evaluar un signo inexistente y detener el
  render.
- Validación funcional realizada con DOCX de Aysén y Región Metropolitana para
  202606. Ambos extremos de tamaño regional generaron correctamente.

## 26-08-2026 — Normalización del árbol y contrato de limpieza

- `app.R` v1→v2 abre en el navegador cada HTML publicado al finalizar la
  generación. DOCX no abre nada y los HTML siguen guardados en su carpeta de
  publicación.
- `calidad/mapea_proyecto.R` v7→v8 y su evidencia generada
  `calidad/INDICE_objetos.md` salen de la raíz. La cola propia de decisiones
  pasó a `Documentacion/Desafios_Estudios_Futuros.md` v9→v10. `Variables_ENE.R`
  v6→v7 actualiza su referencia al índice.
- `Inf_ENE_Sexo_Edad_Region.qmd`, `mapea_proyecto.R` v6→v7, los trece
  `crea_objetos_*.R` y los cinco `modulo_*.qmd` fueron alineados bajo
  `intermedios/`. El QMD mantiene el orden de carga y el índice ahora recorre
  ambas familias; no se modificó la lógica de cálculo ni la maestra consumida.
- `Documentos/` pasó a `Documentacion/` y el registro se normalizó como
  `CHANGELOG_InformeRegional.md`. Se actualizaron `MANUAL_OPERATIVO.md`,
  `ESTADO_OPERATIVO.md` y `CONTRATO_MODULOS.md` a v2.
- Se adoptó `Bibliotecas_R/calidad/audita_contrato_limpieza.R` v1. Detecta
  cabeceras sin versión, bloques explicativos de tres o más líneas y comentarios
  extensos. La regla operativa quedó explícita: sólo trampas locales en el
  código; historia al changelog, dominio al manual y tareas a desafíos.

No se trasladó todavía el control de consumidores de `Bibliotecas_R`: primero
se estabiliza este consumidor y luego se crea un registro común, no otro
catálogo particular del proyecto.

## 24-08-2026

- Se incorporó `app.R` para generar minutas DOCX/HTML y convertir Word a PDF como etapa editorial independiente.
- Se retiró el desvío de publicación a carpetas personales: las salidas se publican en `Datos_Ine/Procesados/Informes/<AAAAMM>`.
- Se endureció `Prepara_bbdd.R`: carga aislada y validación del contrato de la maestra, región y período; se eliminó `diag.txt` como efecto lateral.
- Se separaron los módulos nacionales X13 del tronco del QMD. Las minutas regionales los omiten cuando no existe cobertura completa.
- `mapea_proyecto.R` incorpora `modulo_*.qmd` al índice de objetos.
- Se deshabilitó la restauración y guardado automático de estado en RStudio.
- Se incorporó la versión 1 de la radiografía territorial bajo los KPI: nivel, cambio anual y brecha nacional para mercado laboral, formalidad y tamaño de empresa. No incorpora aún rankings, pares ni segmentos de género/edad.

## Pendiente de validación de cierre

- Ejecutar una minuta nacional y una regional del último período completo `.dta` y contrastarlas con las salidas de referencia vigentes.
- Revisar los módulos opcionales y diseñar el segundo perfil de minuta sobre el tronco estabilizado.
