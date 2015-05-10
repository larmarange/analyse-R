
HTML_FILES := $(patsubst %.Rmd, %.html ,$(wildcard *.Rmd))

all: clean html pdf


html: $(HTML_FILES)

%.html: %.Rmd
	R --slave -e "set.seed(100);rmarkdown::render('$<', encoding='UTF-8')"


.PHONY: clean
clean:
	$(RM) $(HTML_FILES)

pdf: html
	R --slave < make_pdf.R
