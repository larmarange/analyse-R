# Conversion Rmd vers qmd

library(tidyverse)

fichiers <- list.files(pattern = ".Rmd")
fichiers <- fichiers[fichiers != 'index_fonctions.Rmd']
fichiers <- fichiers[fichiers != 'index_extensions.Rmd']
fichiers <- fichiers[fichiers != 'index_concepts.Rmd']

clean <- function(f) {
  content <- readLines(f, encoding = "UTF-8")

  # fonctions
  pattern_fonctions <- '`([a-zA-Z0-9._%]+)`[{]data-pkg="([a-zA-Z0-9._]+)"[^}]*[}]'
  content <- str_replace_all(
    content,
    pattern_fonctions,
    "`\\2::\\1()`"
  )

  # packages
  pattern_packages <- '`([a-zA-Z0-9._%]+)`\\{\\.pkg\\}'
  content <- str_replace_all(
    content,
    pattern_packages,
    "`{\\1}`"
  )

  # dfn
  pattern_dfn <- '</?dfn[^>]*>'
  content <- str_remove_all(content, pattern_dfn)

  # pipe
  content <- str_replace_all(content, "%>%", "|>")

  f2 <- paste0("qmd/", str_sub(f, 1, -5), ".qmd")
  writeLines(content, f2, useBytes = TRUE)
}

for (f in fichiers) {
  clean(f)
}

qmd_files <- list.files(pattern = ".qmd", path = "qmd/")
for (f in qmd_files)
  knitr::convert_chunk_header(paste0("qmd/", f), output = identity)
