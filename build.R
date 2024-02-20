# Suppression des fichiers HTML
#unlink("graphs/", recursive = TRUE)
for (f in  list.files(pattern = "html$"))
  unlink(f)

# Vérification des dépendances
source("verification_installation_dependances.R")

# Recréer tous les chapitres
chapitres <- list.files(pattern = "Rmd$")
for (f in chapitres) {
  set.seed(100);
  rmarkdown::render(f, envir = new.env())
}

# Générer le PDF
source("make_pdf.R")
