# mapea_proyecto.R - v8 - 26-08-2026
# Genera INDICE_objetos.md midiendo el codigo. No se edita a mano el indice:
# se corre esto. Ver MANUAL_InformeRegional.md, seccion "Indice de objetos".
# Uso: source("calidad/mapea_proyecto.R") desde la raiz del proyecto.

ARCHIVOS_R <- c("Prepara_bbdd.R", "Parametros_ENE.R", "Variables_ENE.R",
                list.files("intermedios", "^crea_objetos_.*\\.R$",
                           full.names = TRUE))
# El tronco puede incluir módulos QMD opcionales. Todos deben entrar al índice:
# de otro modo un objeto usado solo por un módulo aparece falsamente huérfano.
ARCHIVOS_QMD <- c("Inf_ENE_Sexo_Edad_Region.qmd",
                  list.files("intermedios", "^modulo_.*\\.qmd$",
                             full.names = TRUE))
SALIDA      <- file.path("calidad", "INDICE_objetos.md")

leer <- function(f) readLines(f, encoding = "UTF-8", warn = FALSE)

# --- 1. Objetos definidos, por archivo -------------------------------------
# Se aceptan definiciones indentadas: varias viven dentro de if/else (desest).
definiciones <- function(f) {
  l <- leer(f)
  l <- sub("#.*$", "", l)                       # comentario fuera, linea a linea
  # Varias asignaciones por linea: "a <- 1; b <- 2" define DOS objetos.
  # Se corta por ";" antes de buscar, si no solo se veia la primera.
  l <- unlist(strsplit(l, ";", fixed = TRUE))
  m <- regmatches(l, regexpr("^\\s*[\\p{L}_][\\p{L}0-9_.]*\\s*<-", l, perl = TRUE))
  unique(trimws(sub("<-$", "", trimws(m))))
}

# --- 2. Indice de parrafos del .qmd ----------------------------------------
# Etiqueta cXsYpZ: capitulo, seccion, parrafo de prosa. Los chunks se atribuyen
# a su seccion (cXsY) porque un chunk no pertenece a un parrafo.
indice_qmd <- function(f) {
  l <- leer(f); n <- length(l)
  cap <- sec <- NA_character_; par <- 0L; dentro <- FALSE
  et <- character(n); tipo <- character(n)
  for (i in seq_len(n)) {
    li <- l[i]
    if (grepl("^```", li)) { dentro <- !dentro; if (!dentro) par <- par; next }
    if (dentro) { tipo[i] <- "chunk"
    et[i] <- paste0("c", cap, if (!is.na(sec)) paste0("s", sec) else "")
    next }
    h <- regmatches(li, regexec("^#{1,2} +(.*)$", li))[[1]]
    if (length(h)) {
      t <- trimws(gsub("[*_`]", "", h[2]))
      if (grepl("^Anexo [0-9]+", t)) { cap <- paste0("A", sub("^Anexo ([0-9]+).*", "\\1", t)); sec <- NA; par <- 0L }
      else if (grepl("^[0-9]+\\.[0-9]+", t)) { sec <- sub("^[0-9]+\\.([0-9]+).*", "\\1", t); par <- 0L }
      else if (grepl("^[0-9]+\\.", t)) { cap <- sub("^([0-9]+)\\..*", "\\1", t); sec <- NA; par <- 0L }
      next
    }
    if (!nzchar(trimws(li))) next
    if (i == 1 || !nzchar(trimws(l[i - 1])) || grepl("^#{1,2} |^```", l[i - 1])) par <- par + 1L
    tipo[i] <- "texto"
    et[i] <- paste0("c", cap, if (!is.na(sec)) paste0("s", sec) else "", "p", par)
  }
  data.frame(linea = l, etiqueta = et, tipo = tipo, stringsAsFactors = FALSE)
}

# --- 3. Cruce ---------------------------------------------------------------
message("Leyendo ", length(ARCHIVOS_R), " archivos .R ...")
defs <- lapply(ARCHIVOS_R, definiciones); names(defs) <- ARCHIVOS_R
origen <- unlist(lapply(names(defs), function(f) setNames(rep(f, length(defs[[f]])), defs[[f]])))
objetos <- names(origen)

message("Indexando ", length(ARCHIVOS_QMD), " archivo(s) QMD ...")
qmd_partes <- lapply(ARCHIVOS_QMD, indice_qmd)
qmd <- do.call(rbind, Map(function(x, archivo) {
  x$etiqueta <- paste0(basename(archivo), ":", x$etiqueta)
  x
}, qmd_partes, ARCHIVOS_QMD))

usa <- function(v, sub) {
  pat <- paste0("(?<![\\p{L}0-9_.])", gsub("([.])", "\\\\\\1", v), "(?![\\p{L}0-9_.])")
  unique(sub$etiqueta[grepl(pat, sub$linea, perl = TRUE)])
}
qtexto <- qmd[qmd$tipo == "texto", ]; qchunk <- qmd[qmd$tipo == "chunk", ]

message("Cruzando ", length(objetos), " objetos ...")
res <- data.frame(objeto = objetos, origen = unname(origen),
                  qmd_texto = "", qmd_chunk = "", modulos = "", interno = FALSE,
                  stringsAsFactors = FALSE)
otros <- lapply(ARCHIVOS_R, leer); names(otros) <- ARCHIVOS_R
for (i in seq_along(objetos)) {
  v <- objetos[i]
  res$qmd_texto[i] <- paste(usa(v, qtexto), collapse = " ")
  res$qmd_chunk[i] <- paste(usa(v, qchunk), collapse = " ")
  pat <- paste0("(?<![\\p{L}0-9_.])", v, "(?![\\p{L}0-9_.])")
  cons <- names(Filter(function(f) any(grepl(pat, sub("#.*$", "", otros[[f]]), perl = TRUE)),
                       setNames(names(otros), names(otros))))
  res$modulos[i] <- paste(setdiff(cons, res$origen[i]), collapse = " ")
  # Uso DENTRO de su propio archivo: se descuentan las lineas donde se asigna.
  # Sin esto, todo objeto intermedio aparecia como muerto.
  prop <- sub("#.*$", "", otros[[res$origen[i]]])
  prop <- prop[!grepl(paste0("^\\s*", v, "\\s*<-"), prop, perl = TRUE)]
  res$interno[i] <- any(grepl(pat, prop, perl = TRUE))
}
# Variables de trabajo de bucles (i, f, n, x...) no son objetos del informe:
# se marcan aparte para que "sin consumidor" signifique algo.
res$trabajo <- nchar(res$objeto) <= 3 | grepl("^(i|j|k|n|f|x|y|v|tmp|aux)[0-9_]*$", res$objeto)
res$sin_consumidor <- !nzchar(res$qmd_texto) & !nzchar(res$qmd_chunk) &
  !nzchar(res$modulos) & !res$interno & !res$trabajo

# --- 4. Salida --------------------------------------------------------------
esc <- function(x) ifelse(nzchar(x), paste0("`", gsub(" ", "` `", x), "`"), "--")
OUT <- character(0)
w <- function(...) OUT <<- c(OUT, paste0(...))

w("# Indice de objetos - Informe Regional ENE")
w("");  w("_Generado por `mapea_proyecto.R` el ", format(Sys.Date(), "%d-%m-%Y"),
          ". No editar a mano: correr el script._")
w(""); w("Objetos: ", nrow(res), " | sin consumidor: ", sum(res$sin_consumidor),
         " | archivos R: ", length(ARCHIVOS_R), " | QMD: ", length(ARCHIVOS_QMD))
w(""); w("`qmd` = capitulo/seccion/parrafo donde se usa. `mod` = otro archivo .R que lo consume.")
w("")
for (f in ARCHIVOS_R) {
  sub <- res[res$origen == f, ]
  if (!nrow(sub)) next
  w("## ", f); w("")
  w("| objeto | qmd (texto) | qmd (chunk) | consumido por | uso interno |")
  w("|---|---|---|---|---|")
  sub <- sub[order(!nzchar(sub$qmd_texto), sub$objeto), ]
  for (j in seq_len(nrow(sub)))
    w("| `", sub$objeto[j], "` | ", esc(sub$qmd_texto[j]), " | ",
      esc(sub$qmd_chunk[j]), " | ", esc(sub$modulos[j]), " | ",
      if (sub$interno[j]) "si" else "--", " |")
  w("")
  h <- sub$objeto[sub$sin_consumidor]
  if (length(h)) { w("_Sin consumidor (", length(h), "): ",
                     paste0("`", h, "`", collapse = ", "), "_"); w("") }
}

# --- 5. Contraste inverso: lo que el .qmd cita y nadie define ---------------
# Solo se mira DENTRO de codigo: los inline `r ...` y los chunks. Buscar en la
# prosa barria el castellano entero ("Minuta", "Enseñanza") y enterraba lo util.
inline <- unlist(regmatches(qmd$linea, gregexpr("`r [^`]+`", qmd$linea)))
codigo <- c(inline, qchunk$linea)
# Fuera comentarios y literales de texto: dentro de un chunk hay prosa en ambos
# ("# Nota: ...", paste0("aumentaron en ")) y sin esto la lista se llena de
# castellano y de nombres de archivo pasados a source().
codigo <- gsub('"[^"]*"', " ", codigo)
codigo <- gsub("'[^']*'", " ", codigo)
codigo <- sub("#.*$", "", codigo)
tok <- unique(unlist(regmatches(codigo,
                                gregexpr("(?<![\\p{L}0-9_.$@])[\\p{L}_][\\p{L}0-9_.]{2,}", codigo, perl = TRUE))))
base_r <- c(ls("package:base"), ls("package:stats"), ls("package:utils"),
            "TRUE", "FALSE", "NULL", "NA", "Inf", "NaN", "params", "knitr", "here")
# Argumentos con nombre (aparecen como "nombre =") y opciones de chunk no son
# objetos: se descuentan para que la lista quede accionable.
argum <- unique(unlist(regmatches(codigo,
                                  gregexpr("(?<![\\p{L}0-9_.])[\\p{L}_][\\p{L}0-9_.]*(?=\\s*=[^=])", codigo, perl = TRUE))))
opciones <- c("echo", "eval", "warning", "message", "include", "opts_chunk",
              "fig.width", "fig.height", "dpi", "ragg", "else", "call.")
falta <- setdiff(tok, c(objetos, base_r, argum, opciones))
# Se parten en dos: lo que parece venir de las bibliotecas (prefijos conocidos)
# y lo demas, que son los candidatos reales a fallo silencioso.
biblio  <- sort(falta[grepl("^(fc_|ft_|gr_|dt_|mt_|tc_)", falta)])
sospech <- sort(setdiff(falta, biblio))
w("## Citados en el .qmd y no definidos en estos archivos"); w("")
w("Se busca solo dentro de codigo (inline `` `r ...` `` y chunks), no en la prosa.")
w("")
w("**Probablemente de las bibliotecas** (", length(biblio), "). Normal si existen ")
w("en `funciones_informe.R` o `funciones_textoActivo.R`:"); w("")
w(paste0("`", biblio, "`", collapse = ", ")); w("")
w("**Sin origen identificado** (", length(sospech), "). **Revisar uno por uno**: ")
w("aca aparecio el hueco del Anexo 5. Un objeto citado que nadie define no rompe ")
w("el render, imprime vacio:"); w("")
w(paste0("`", sospech, "`", collapse = ", ")); w("")

con <- file(SALIDA, open = "w", encoding = "UTF-8")
writeLines(OUT, con)
close(con)

message("Listo: ", SALIDA, " (", nrow(res), " objetos, ",
        sum(res$sin_consumidor), " sin consumidor)")
