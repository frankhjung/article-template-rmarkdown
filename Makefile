#!/usr/bin/make

PROJECT:= project_name_here
R	= /usr/bin/R

.SUFFIXES:
.SUFFIXES: .Rmd .html .pdf

default: $(PROJECT).html $(PROJECT).pdf

.Rmd.html:
	@mkdir -p public
	@$(R) --quiet --slave --vanilla --file=make.R --args $< $@
	@mv $@ public/index.html

.Rmd.pdf:
	@mkdir -p public
	@$(R) --quiet --slave --vanilla --file=make.R --args $< $@
	@mv $@ public/

.PHONY: clean
clean:
	@$(RM) *.log
	@$(RM) -rf public/
