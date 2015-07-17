options(
  knitr.table.format = 'pandoc',
  formatR.indent = 2,
  width = 50
)
filename <- knitr::current_input()
filename <- substr(filename, 1, nchar(filename)-4)
knitr::opts_chunk$set(
  comment = NA, # No ## before the results
  dev = "png",
  dev.args = list(bg = 'white'),
  dpi = 150,
  tidy = TRUE,
  fig.path = paste0("graphs/", filename, "/"),
  cache = TRUE,
  cache.path = paste0("cache/", filename, "/")
)

