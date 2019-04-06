if(!require(devtools))
  install.packages("devtools")
if(!require(stringr))
  install.packages("stringr")

require(devtools)
require(stringr)

# 1. Trouver les packages manquants ----------

p <- c()
for (f in list.files(pattern = "Rmd$")) {
  t <- readLines(f)
  p <- unique(c(p, t[grepl("^(library|require)", t)]))

}
p <- gsub("library|require|\\(|\\)", "", p)
p <- gsub("\"", "", p)
p <- gsub(", quietly = TRUE", "", p)
p <- unique(p)
m <- p[!p %in% installed.packages()[, 1]]

if (!length(m)) {
  message("Tous les packages requis pour analyse-R sont installés.")

} else {
  message("Packages manquants : ", paste0(m, collapse = ", "))

}

# 2. Installer les packages manquants (CRAN ou GitHub) ----------------

thru_github <- c("hadley/tidyverse", "juba/questionr", "larmarange/JLutils", "hrbrmstr/ggalt", "ropensci/plotly", "carlganz/svrepmisc", "ewenharrison/finalfit", "mikabr/ggpirate", "thomasp85/patchwork")
github_pkgs <- str_sub(thru_github, str_locate(thru_github, "/")[, 1] + 1)

for (i in m[m %in% github_pkgs])
  install_github(thru_github[which(github_pkgs == i)])

for (i in m[!m %in% github_pkgs])
  install.packages(i, dependencies = TRUE)

if (any(!p %in% installed.packages()[, 1]))
  warning("Certaines installations de package ont échoué.")

# 3. Vérifications manuelles de certains packages --------------

library(lubridate)
if (!exists("time_length"))
  install_github("tidyverse/lubridate")

library(JLutils)
if (!exists("tidy_model"))
  install_github("larmarange/JLutils")

library(questionr)
if (is.null(getS3method("odds.ratio", "numeric", TRUE)))
  install_github("juba/questionr")

# 4. Identifier la version minimal de R requise ---------------

#' @source http://stackoverflow.com/a/30600526/635806
min_r <- function(packages) {
  req <- NULL

  for (p in packages) {
    # get dependencies for the package
    dep <- packageDescription(p, fields = "Depends")

    if (!is.na(dep)) {
      dep <- unlist(strsplit(dep, ","))

      r.dep <- dep[grep("R \\(", dep)]

      if (!length(r.dep))
        r.dep <- NA

    } else {
      r.dep <- NA
    }

    if (any(!is.na(r.dep)))
      req <- c(req, r.dep)

  }

  return(req)

}

v = min_r(p)
v = gsub("\\s?R\\s\\(>=?\\s|\\)", "", v)
v = sort(v)[length(sort(v))]

message("analyse-R requiert R version ", v, " ou supérieure.")
