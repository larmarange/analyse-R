if(!require(devtools))
  install.packages("devtools")

require(devtools)

# 1. find missing packages

p = c()
for(f in list.files(pattern = "Rmd$")) {

  t = readLines(f)
  p = unique(c(p, t[ grepl("^(library|require)", t) ]))

}
p = gsub("library|require|\\(|\\)", "", p)
m = p[ !p %in% installed.packages()[, 1] ]

if(!length(m)) {

  message("Tous les packages du cours sont installés.")

} else {

  message("Packages manquants: ", paste0(m, collapse = ", "))

}

# 2. process either through CRAN or devtools

thru_github = c("lubridate", "questionr", "JLutils")
repo_github = c("hadley", "juba", "larmarange")

for(i in m[ m %in% thru_github])
  install_github(i, username = repo_github[ which(thru_github == i) ])

for(i in m[ !m %in% thru_github])
  install.packages(i)

if(any(!p %in% installed.packages()[, 1]))
  warning("Certaines installations ont échoué.")

# 3. find minimal R version

#' @source http://stackoverflow.com/a/30600526/635806
min_r <- function(packages) {

  req <- NULL

  for (p in packages) {

    # get dependencies for the package
    dep = packageDescription(p, fields = "Depends")

    if(!is.na(dep)) {

      dep = unlist(strsplit(dep, ","))

      r.dep = dep[ grep("R \\(", dep) ]

      if(!length(r.dep))
        r.dep = NA

    } else {

      r.dep = NA
    }

    if(!is.na(r.dep))
      req = c(req, r.dep)

  }

  return(req)

}

v = min_r(p)
v = gsub("\\s?R\\s\\(>=\\s|\\)", "", v)
v = sort(v)[ length(sort(v)) ]

message("Le cours requiert R version ", v, " ou supérieure.")
