# DESAFÍOS PARA ESTUDIOS FUTUROS

_v10 · 26-08-2026_

## Preguntas surgidas de la revisión del informe AMJ - 2026

---

## Nota de apertura sugerida

> Esta minuta se construye sobre los preinformes en Excel del INE, condición que permite anticipar el comportamiento de los principales indicadores antes de la publicación oficial. Ese diseño impone trabajar con datos agregados y sin cruces entre dimensiones. Las líneas que siguen no son limitaciones de esta minuta, sino estudios de naturaleza estructural que requieren microdatos de la Encuesta Nacional de Empleo, la Encuesta Suplementaria de Ingresos o CASEN, y que exceden su periodicidad y propósito.

---

## A. Con evidencia observada

**1. Recomposición interna de los servicios personales tras la pandemia.**
El servicio doméstico se redujo aproximadamente a la mitad después del COVID, mientras que los servicios de apoyo empresarial dentro de la misma macro-área crecieron. Esa recomposición modifica el perfil de informalidad y de feminización del agregado, y su análisis requiere seguimiento desagregado en el tiempo. *Es el único de la lista con evidencia previa, no una pregunta abierta: si el bloque cambió de composición, comparar su informalidad contra 2022 puede estar midiendo el cambio de mezcla y no el cambio de condiciones.*

**2. Envejecimiento demográfico versus permanencia laboral.**
El peso del tramo de 55 años y más crece simultáneamente en ocupados y desocupados. Distinguir cuánto de ese aumento corresponde al envejecimiento de la población en edad de trabajar y cuánto a una mayor permanencia en el mercado laboral requiere contrastar ambas series con la composición etaria de la PET. *De los más baratos: los datos ya están en el informe.*

---

## B. Requieren cruces no disponibles en el agregado

**3. Composición de la informalidad en Comercio por tamaño de empresa.**
El informe identifica a Comercio, Transportes y Hotelería como la macro-área de mayor volumen de ocupados, pero no permite distinguir si su informalidad se concentra en microempresa y trabajo por cuenta propia o si se distribuye entre segmentos. La respuesta determina qué instrumentos de formalización resultan pertinentes: si se concentra en el segmento micro, la fiscalización tradicional no alcanza al universo relevante.

**4. Efecto del nivel educacional sobre la informalidad, controlando por rama.**
La informalidad disminuye a mayor nivel educacional, pero el insumo actual no permite establecer si ese gradiente persiste dentro de cada sector o si refleja la composición sectorial del empleo calificado. *Si persiste, son mecanismos independientes y hay dos historias que contar. Si se aplana, el efecto educativo era composición sectorial disfrazada.*

**5. Dispersión interna de las macro-áreas.**
La separación de los servicios en tres bloques reveló una distancia de casi 37 puntos de informalidad entre el más formal y el más precarizado, que el agregado ocultaba. Cabe aplicar el mismo examen a las otras cinco macro-áreas para determinar cuánta heterogeneidad esconde cada una.

**6. Alcance de los mecanismos de habilitación sectorial.**
La hipótesis de que la exigencia de acreditación técnica arrastra formalización requiere identificar qué proporción de los ocupados de cada sector está sujeta a ella, información no disponible en la Encuesta Nacional de Empleo.

---

## C. Requieren datos de ingreso

**7. Informalidad e ingreso: los extremos de la distribución.**
La clasificación de informalidad se basa en la forma de la relación laboral y no en su calidad. En los tramos altos de ingreso esa correspondencia se debilita: quienes emiten boletas de honorarios se clasifican como informales con independencia de su nivel de ingreso, mientras que quienes operan mediante sociedades de su propiedad se clasifican como formales sin mediar contrato de trabajo ni protección asociada. Establecer qué proporción de la informalidad medida corresponde a vulnerabilidad efectiva requiere cruzar con ingreso, vía Encuesta Suplementaria de Ingresos o CASEN.

**8. Composición interna de la formalidad en Servicios a Empresas y Profesionales.**
La baja informalidad medida en esta macro-área puede reflejar, además de la regulación sectorial, el uso de vehículos societarios por parte de personas naturales con fines tributarios. Distinguir formalidad contractual de protección laboral efectiva requiere información sobre cotizaciones y tipo de vínculo que la ENE no captura.

**9. Relación entre informalidad e ingreso del hogar.**
Requiere fuentes como CASEN. Permite examinar si la informalidad se concentra en hogares de menores ingresos con independencia del sexo de la persona ocupada, lo que pondría a prueba la tesis de que el eje de la informalidad es la posición negociadora y no la composición por sexo.

---

## D. Desarrollos del propio instrumento

**10. Indicador de informalidad del empleo dependiente.**
Aislar cuenta propia del tramo de microempresa y excluirlo de numerador y denominador, para obtener una tasa de informalidad comparable entre tamaños de empresa. El referente nacional pasaría de 27,0% a un valor en torno a 16-17%, lo que reordena la lectura de todos los tramos: un segmento con 22,6% deja de parecer benigno.
*Consideraciones: el indicador debe llamarse por lo que mide y presentarse siempre junto al oficial; el criterio de qué tramos se destacan debe salir de un umbral declarado sobre la diferencia entre tasa bruta y ajustada, no de una lista escrita a mano.*

**11. Sección de categoría ocupacional y migración CISE a CISO.**
Las categorías están disponibles en la base y permiten construir la sección con el patrón de tamaño de empresa. CISO retropoblado permite ventanas largas, pero sus categorías son nuevas y no admiten mapeo directo desde CISE, de modo que las variables no son reciclables y el empalme de series requiere decisión metodológica propia. *Convivencia planificada: un módulo por clasificación, selección por período.*

**12. Definición del segmento "sin clasificar por tamaño".**
El texto afirmaba que incluye servicio doméstico, lo que resulta inconsistente con su informalidad de 22,6%, inferior al promedio nacional. Cabe determinar dónde clasifica la ENE al servicio doméstico en la variable de tamaño y qué compone realmente el residual.

**13. Test del punto de quiebre post-COVID.**
El ancla EFM-2022 se fija por criterio experto —fin de la fase de rebote logarítmico y retorno a comportamiento tendencial— sin test que lo acredite. Ajustar log contra lineal sobre la fase de recuperación y verificar dónde la pendiente converge a la tendencia previa convertiría una decisión editorial en un resultado.

---

## E. Infraestructura

**14. Analizador de tablas.**
`fc_formatear_tabla` ya cuelga los datos y la receta del flextable que devuelve. Sobre esa base, un analizador puede emitir hitos genéricos —concordancia de signos entre ventanas, inflexión, extremos con guarda de base mínima, dispersión, filas que se mueven contra el agregado, composición del cambio— y el texto consumirlos por nombre en vez de leer la tabla. Lo único que falta declarar es el tipo de filas: categorías excluyentes contra variables heterogéneas.
*Los cinco arreglos manuales de esta revisión —argmax sobre base insuficiente, superlativos en duro, distancia entre extremos, fila contracorriente, inflexión entre ventanas— son todos hitos que la tabla emitía sola.*

**15. Convención de flechas y color en tablas de brecha.**
La flecha codifica el signo aritmético y el color el veredicto de cierre o ensanchamiento. En tablas de brecha ambos pueden apuntar en sentidos opuestos y el ojo lee la flecha primero. Revisar la convención global, no tabla por tabla.

**16. Reordenamiento de `Variables_ENE.R` por categoría conceptual.** ✔ Hecho 06-08-2026 (v2→v4).
Ocho bloques por capítulo consumidor. Regla adoptada: la variable vive donde vive su insumo, no donde vive su consumidor —`Techo_CpropInf_Micro_AS` queda en el bloque CISE aunque la imprima el párrafo de tamaño—. `tramos_M55` eliminado en favor de `tramos_edad_mayores`.

**17. Proyecto gemelo: sexo como filtro en vez de dimensión horneada.**
Hoy el sexo está fundido en el nombre de cada variable —`_AS`, `_M`, `_H`— y en `sexos_informe`, de modo que cada indicador existe tres veces y las brechas se calculan a mano restando. Los `params` del `.qmd` ya son exactamente dos filtros, región y mes; agregar sexo como tercero colapsaría las tres versiones en una sola variable filtrada y convertiría cada brecha en una comparación entre corridas. El resultado sería un gemelo con muchos menos objetos y más flexible: cualquier corte que hoy exige triplicar variables pasaría a ser un argumento. La misma operación aplica después a otras dimensiones ya presentes en el cubo —tramo etario, formalidad— y es el camino natural desde el mecano actual hacia un instrumento parametrizado. Requisito previo: el registro de objetos, para saber qué se cae al colapsar cada familia.

*Nacionalidad y educación son el caso de mayor rendimiento por unidad de trabajo.* Ambas existen en el `.dta` con serie completa desde 201002 y están marcadas como verificadas en el manual, pero ninguna aparece en `ENE_diccionario_categorias.R`: el cubo no las trae. Incorporarlas no es un cambio de este proyecto sino del que arma la base.

Para educación **la variable es `cine11_2d`** —CINE 2011 a dos dígitos, clasificación UNESCO 2013 procesada y validada por INE—, con `cine11_1d` a un dígito para agregados y `cine97` para retrocompatibilidad de series largas. No hay que componer nada desde `nivel`, `curso` y `termino_nivel`: la clasificación ya viene cerrada, lo que reduce el trabajo a declararla en el diccionario con su descomposición. Elegir el nivel de desagregación —uno o dos dígitos— es la única decisión editorial, y depende de si el corte publicable es nivel o categoría.

A cambio abren lo que hoy el instrumento no puede tocar: el punto 4 —efecto del nivel educacional sobre la informalidad controlando por rama— pasa de cruce no disponible a filtro, y la informalidad por nacionalidad es una lectura que el agregado actual no permite ni aproximar.

**18. El índice de objetos se genera, no se escribe.**
Las marcas `→ cXpY` de `Variables_ENE.R` v1 apuntaban a una estructura de capítulos anterior —`c3s3` ya no existe, edad pasó a 5.2, tamaño a 5.3— y llevaban meses mintiendo sin que nada avisara. `mapea_proyecto.R` recalcula el mapa desde el código: objeto, archivo de origen, párrafos que lo usan, módulos que lo consumen, más dos listas de control —lo definido que nadie lee y lo citado que nadie define—. Esa segunda lista es la que habría atrapado el hueco del Anexo 5 antes de publicarlo. Regenerar cada vez que cambie la estructura del `.qmd`; las marcas dentro de los archivos son provisorias y se borran cuando el índice esté andando.

**19. Verificación sobre el producto, no sobre el código.**
Los cuatro defectos de la revisión de mayo se encontraron leyendo el `.docx`, no los `.R`: frases terminadas en espacio-punto, `69.3%` con punto decimal, "Total ramas" donde iba una categoría, prefijos de resumen con puntuación inconsistente. Ninguno rompe la compilación, todos son detectables con un chequeo de texto sobre el documento generado. El patrón común es el largo cero que se propaga —`NULL[x][1]`, `character(0)`— y que `paste0()` absorbe sin advertencia a través de cinco capas.

**20. Resuelto: consistencia de rama trasladada a InformeBBDD.**
La maestra regenerada entrega total, formal e informal coherentes bajo
`r_p_rev4cl_caenes`, y reserva `_b14` para la definición alternativa. Se retiró
de InformeRegional la selección `var_rama` y la advertencia de discrepancia:
la minuta recibe el dato ya resuelto y no necesita exponer una diferencia que
no cambia su lectura sustantiva. `dta_rezagado` se conserva únicamente para sus
otros controles reales de disponibilidad.

**21. La guardia de vocabulario está en el log y no en el código.** *Verificado el 12-08-2026: las dos mitades son ciertas.*
`CHANGELOG_InformeRegional.md` registra un v3 de `Prepara_bbdd.R` con una guardia posterior al `load()` —cuatro categorías de control del canon y cinco patrones previos: `^FFT `, `^T_`, `^PET$`, `^FT$`, `^B_t_p_v$`—; el archivo vigente no la tiene. La entrada del log describe una intención que no llegó al disco. Falta decidir si la guardia se escribe. El diagnóstico que la motivó sigue vigente y sigue sin cubrirse: una base sin migrar no produce error sino `filter()` que no encuentran nada, y el fallo aparece cinco pasos después, dentro de `crea_objetos_razon_fft.R`, con "objeto 'Hombres' no encontrado". La entrada del 30-07 no se corrige: registra lo que se decidió ese día.

**22. Las dos funciones de tendencia son una sola.**
`fc_tendencia_lp` y `fc_tendencia_lp_2` conviven en `funciones_series_temporales.R`
haciendo lo mismo con contratos incompatibles: la primera lee `dt_ENE_compuesta`
del entorno y calibra `sensibilidad` sobre la propia serie; la segunda recibe
`dt` como argumento y usa umbrales fijos según `es_tasa`. La fusión debería
conservar la sensibilidad calibrable y tomar la serie por argumento, que es lo
único que hoy amarra una biblioteca compartida a `Parametros_ENE.R` de este
proyecto. Requisito previo: rastrear si `fc_tendencia_lp_2` tiene consumidores
fuera de InformeRegional —hoy no verificado, y es la única razón por la que se
conserva—. Misma familia que la fusión pendiente de las familias 1 y 2 del
módulo; conviene resolverlas juntas.

**23. `crea_objetos_region.R` recalcula lo que la base ya trae.**
`dt_ENE_Master` ya incluye Asalariados dependientes, su versión formal e
informal y la tasa de ocupación informal para todas las regiones —ENE_3 las
calcula sobre el cubo, que tiene región—. El ladrillo las vuelve a derivar desde
sus componentes en el `mutate` de `dt_inform_region`. Si los valores coinciden,
ese `mutate` sobra y basta un `filter`. Verificarlo es barato: comparar ambas
series para un par de regiones y períodos. Si no coinciden, la pregunta cambia
de "sobra el cálculo" a "cuál de los dos está mal", que es más importante. La
única que no tiene contraparte es "Tasa de asalariados dependientes informal",
que nace en el ladrillo y no se publica.

**24. `crea_objetos_desest.R` declara sus paquetes y no los carga.** ✔ Hecho 12-08-2026 (v7→v8). Declaraba `ggplot2` y usa cinco; ahora los pide todos y llama a `fc_init_motor()`. La dependencia de orden con `nucleo` desapareció.
La línea 3 asigna `paquetes_requeridos <- c("ggplot2")` y **no llama a
`fc_init_motor()`**, a diferencia de todos los otros ladrillos. Hoy funciona
porque `crea_objetos_nucleo.R` carga ggplot2 antes en el orden del `.qmd`. Es
una dependencia de orden que nada declara: si desest se moviera antes que
nucleo, o nucleo dejara de pedir ggplot2, este ladrillo caería con un error de
función no encontrada lejos de su causa. Agregar la llamada es una línea, pero
es cambio de código y hay que correr el informe después.

**25. Una paleta escrita a mano en `crea_objetos_formalidad.R`.**
`colores_gr8` declara sus tres colores como hexadecimales literales
—`#1f77b4`, `#17becf`, `#d62728`, los defaults de matplotlib— en vez de
componerlos desde las perillas de `Parametros_ENE.R`. Es el único caso del
proyecto: `colores_gr6` y `colores_gr7`, en el mismo archivo, sí se arman desde
`col_bueno`, `col_informal` y la paleta de sexo. La consecuencia práctica es que
un cambio en el panel deja ese gráfico desalineado del resto sin que nada avise,
que es exactamente el problema que la repatriación de paletas vino a resolver.
Definirlos en el panel junto a las otras familias temáticas es media hora, y
conviene hacerlo junto con el punto 15, que también toca convención visual.

**26. Los nombres de las 21 ramas están escritos tres veces.**
`crea_objetos_sector.R` declara `cats_rama_form` (22 categorías con sufijo
"formal"), `labels_rama_form` (22 etiquetas visibles) y `labels_rama` (las
mismas 21 sin "No sabe/No responde"), las tres a mano y en el mismo archivo. Las
dos últimas son idénticas salvo por una fila. Un renombre en el canon obliga a
editar tres listas y el que se olvide de una no falla: el `match()` devuelve
`NA` y la fila sale sin etiqueta. Deberían salir de
`ENE_diccionario_categorias.R`, que ya tiene la descomposición de cada categoría
en medida y dimensiones. Emparejarlo con el punto 11, que también toca la
relación entre módulos y canon.

**27. `crea_objetos_tamano.R` depende de un objeto de `crea_objetos_sector.R`.**
`Area_Vol_Nom`, `Area_Vol_Val` y `Area_Vol_Pct` se calculan sobre
`tot_inf_areas`, que nace en sector. Es la única dependencia entre ladrillos del
proyecto y nada la declara: se sostiene en que el `.qmd` carga sector antes que
tamaño. Si esas tres variables son de área y no de tamaño, el lugar natural es
sector; si de verdad pertenecen al capítulo de tamaño, entonces `tot_inf_areas`
debería viajar como argumento y no como global. Lo detectaría solo el registro
de objetos del punto 18.

**28. Veintinueve variables narrativas que ningún párrafo usa.**
Verificadas por grep contra el `.qmd` el 05-08-2026, repartidas así:
`dur_desempleo` (8): `Mismo_Tramo_Alza_AmbosSexos`, `Tramo_MayorAlzaMensual_H`,
`Tramo_MayorAlzaMensual_M`, `Tramo_MayorDivergenciaSexo`,
`Tramo_MayorTotal_Mujeres`, `Tramos_CaidaInteranual`, `Valor_Divergencia_H`,
`Valor_Divergencia_M`. `motivo_desempleo` (4): `Mot_Top_Mes_H`, `Mot_Top_Mes_M`,
`Mot_Top_Niv_H`, `Mot_Top_Niv_M`. `razon_desempleo` (7): `Jubil_Pct_Delta`,
`Razon_Invertidas`, `Razon_MayorMovMes_Valor`, `Razon_Top_DifMes_H`,
`Razon_Top_DifMes_M`, `Razon_Top_Nivel_H`, `Razon_Top_Nivel_M`. `sector` (9):
`Area_Mayor_Feminizacion`, `Area_Mayor_Informalidad`, `Brecha_Construccion`,
`Brecha_ServEmpresas`, `Fem_Construccion`, `Fem_ServEmpresas`,
`Inf_Construccion`, `Ocup_Comercio`, `Umbral_Base_Rama`. `tamano` (1):
`Area_Vol_Nom`.

El caso a mirar primero es `sector`: calcula el bloque completo de macro-áreas y
el `.qmd` no lo usa, porque la sección 5.5 se redactó con `Area_Inf_Nom` y
`Area_Ctr_*` y el bloque anterior quedó del intento previo. **No moverlas
todavía** — decisión pendiente, no peso muerto confirmado.

Dos advertencias sobre la lista. `Umbral_Base_Rama` **sí se usa**, dentro del
propio `crea_objetos_sector.R`, en la llamada a `fc_con_base()`: la lista mide
uso en el `.qmd`, no uso total, y hay que releerla con ese filtro. Y la lista es
del 05-08: `mapea_proyecto.R` la recalcula sola y con el criterio correcto —
`INDICE_objetos.md` distingue consumo desde el `.qmd` del consumo desde otro
`.R`. Antes de tocar nada, regenerar el índice.

**29. Veintitrés punteros `vN` muertos en `Variables_ENE.R`.**
Apuntan a variables borradas: `v196`, `v197`, `v207`, `v209`, `v210`, `v77`.
Concentrados en el bloque de tamaño de empresa. Es el mismo problema del punto
18 en su versión menor: marcas escritas a mano que envejecen sin avisar. La
decisión de fondo es si el sistema `vN` se mantiene o se reemplaza por nombres,
que no se desfasan. Si el índice generado se adopta, se borran todas.

**30. Falta `Delta_Año_TInform_Mediana_AS`.**
Micro, Pequeña y Gran empresa tienen su variación interanual de informalidad;
Mediana no. `Val_Act_MedEmp_AS` y `Val_Año_MedEmp_AS` existen y no las consume
nadie, lo que sugiere que el cálculo se empezó y no se cerró. No es peso muerto
sino una asimetría en lo que el informe puede decir: cualquier lectura
comparativa entre tamaños tiene un hueco en el tramo del medio. Junto a esto,
diecisiete variables del bloque CISE (familia cuenta propia por sexo) tampoco
tienen consumidor.

**31. Brecha de género en el tramo de 55 y más.**
Quedó anotada y sin terminar en `Variables_ENE.R` v1: probablemente un intento de
`Brecha_Act_TDescp_M55` análoga a la de jóvenes. La pista que la hace
interesante es de dominio: en Chile la edad legal de jubilación femenina es unos
cinco años menor, de modo que el tramo 55+ no es comparable entre sexos de la
misma forma que los demás, **y la diferencia se expresa mejor en participación
que en desocupación** — una mujer de 60 que sale del mercado deja de contarse
como desocupada. Se emparenta con el efecto de definición del manual, § Edad:
quien jubila puede conservar el mismo empleo y pasar a contarse como informal.
Los dos son el mismo problema —la jubilación cambia cómo se clasifica a la
persona, no lo que le pasa— y conviene resolverlos juntos.

**32. Barrido de agregación de tasas en InformeBBDD.**
La regla —cómo se agrega una tasa, por qué el defecto es el peso ausente y no el
promedio, y la salvedad del recálculo de factores de expansión— está en la
sección 8 de `CONVENCIONES_Proyectos_ENE.md`. Acá queda solo el trabajo
pendiente.

Buscar `weighted.mean`, `mean(` y `summarise` sobre columnas cuyo nombre empiece
por `T_` o contenga «tasa». InformeBBDD es donde más duele, porque produce la
base que todos consumen, y tiene dos agravantes propios.

**Las tasas no comparten denominador** —informalidad sobre ocupados,
participación sobre PET, desocupación sobre fuerza de trabajo—, así que una
función genérica que agregue «las tasas» con un solo vector de pesos acierta en
una y falla en las otras dos, en silencio.

**Las series desestacionalizadas no se agregan de ninguna forma.** La salida del
X-13 no es aditiva: la suma de dos regiones desestacionalizadas no es la
desestacionalizada de la suma. Ahí ni sumar numeradores sirve, hay que pedirle el
agregado a X-13. Por eso `T_participación_d` se deriva como `FT_d/PET`.

El módulo estadístico —`estimar_factor_longitudinal()` y
`construir_totales_calibracion()`— **no entra en el barrido**: ahí ponderar es el
procedimiento correcto. Quien barra sin esa salvedad va a «arreglar» el único
lugar donde está bien.
