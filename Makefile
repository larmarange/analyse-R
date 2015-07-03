
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))

all: clean check html pdf


html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding='UTF-8')"


.PHONY: clean
clean:
	$(RM) $(HTML_FILES)


check: clean
	R --slave < verification_installation_dependances.R


pdf: html
	R --slave < make_pdf.R
