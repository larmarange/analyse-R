options(
  knitr.table.format = 'pandoc',
  formatR.indent = 2,
  width = 40
)
knitr::opts_chunk$set(
  comment = NA, # No ## before the results
  dev = "png",
  dev.args = list(bg = 'white'),
  dpi = 150,
  tidy = TRUE
)
