require(xml2)
require(stringr)

## Page d'accueil
index <- read_html("index.html", encoding = "UTF-8")
res <- as.character(xml_find_first(index, ".//article"))

## Identifier les chapitres
divs <- xml_find_all(index, ".//div")
for (div in divs)
  if (!is.na(xml_attr(div, 'id')))
    if (xml_attr(div, 'id') == 'tdm')
      tdm <- div

chapitres <- unique(xml_attr(xml_find_all(tdm, ".//a"), 'href'))
chapitres <- chapitres[str_starts(chapitres, "#", negate = TRUE)]

## Récupérer le contenu de chaque chapitre
for (chap in chapitres) {
  page <- read_html(chap, encoding = "UTF-8")
  contenu <- as.character(xml_find_first(page, ".//article"))
  rac <- str_sub(chap, 1, -6)
  contenu <- str_replace_all(contenu, 'id="TOC', 'class="TOC')
  contenu <- str_replace_all(contenu, 'id="', paste0('id="', rac, "_"))
  contenu <- str_replace_all(contenu, 'href="#', paste0('href="#', rac, "_"))
  contenu <- str_replace_all(contenu, '<article>', paste0('<article id="', rac, '">'))
  res <- paste(res, contenu, sep="\n")
}

# Quelques ajustements
res <- str_replace_all(res, '&#13;', '')
for (chap in chapitres) {
  rac <- str_sub(chap, 1, -6)
  res <- str_replace_all(res, paste0('href="', chap, '#'), paste0('href="#', rac, '_'))
  res <- str_replace_all(res, paste0('href="', chap, '"'), paste0('href="#', rac, '"'))
}

## Export final
before <- paste(readLines("include/pdf_before.html", encoding = "UTF-8"), collapse = "\n")
after <- paste(readLines("include/pdf_after.html", encoding = "UTF-8"), collapse = "\n")
res <- paste(before, res, after, sep="\n")

res <- str_replace_all(res, "\r", "")

cat(res, file = file("analyse-R.html", encoding = "UTF-8"), sep="\n")

## Génération du PDF
system('prince analyse-R.html --javascript')
