# Suppression des fichiers HTML
unlink("graphs/", recursive = TRUE)
for (f in  list.files(pattern = "html$"))
  unlink(f)

# Vérification des dépendances
source("verification_installation_dependances.R")

# Recréer tous les chapitres
for (f in  list.files(pattern = "Rmd$")) {
  set.seed(100);
  rmarkdown::render(f, encoding = "UTF-8")
}

# Généner le PDF
source("make_pdf.R")
