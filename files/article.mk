#!/usr/bin/make

.SUFFIXES:
.SUFFIXES: .Rmd .html .pdf

PROJECT:= $(notdir $(CURDIR))
R	= /usr/bin/R

default: $(PROJECT).html $(PROJECT).pdf

.Rmd.html:
	@mkdir -p public
	@$(R) --quiet --slave --vanilla --file=make.R --args $< $@
	@mv $@ public/article.html

.Rmd.pdf:
	@mkdir -p public
	@$(R) --quiet --slave --vanilla --file=make.R --args $< $@
	@mv $@ public/

.PHONY: clean
clean:
	@$(RM) *.log
	@$(RM) -rf public/
