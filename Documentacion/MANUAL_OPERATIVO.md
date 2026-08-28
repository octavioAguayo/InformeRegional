# Manual operativo — InformeRegional

_v2 · 26-08-2026_

## Qué hace este proyecto

Construye minutas nacionales y regionales a partir de la maestra procesada por `InformeBBDD`. No procesa la fuente INE ni reconstruye variables.

## Regla de publicación

La generación produce DOCX/HTML. El PDF se obtiene después de la edición humana mediante `ConviertePDF.R`, invocado por la app. Así Word y PDF conservan el mismo contenido editorial.

## Reglas que no se deben romper

- No editar, sobrescribir ni regenerar `dt_ENE_Master.RData` desde este proyecto.
- No renderizar directamente el QMD: usar `GeneraInformes.R` o la app, que fijan período y región.
- No generar regionales para un período en ventana Excel.
- No devolver la publicación a Descargas u otra carpeta personal.
- No restaurar `.RData` ni usar historiales como entrada de ejecución.

## Índice de objetos

Ejecutar `source("calidad/mapea_proyecto.R")` desde la raíz del proyecto después de agregar o retirar objetos o módulos. El archivo `calidad/INDICE_objetos.md` se genera automáticamente y no se edita a mano. Los módulos viven en `intermedios/`; el QMD es su único orquestador.
