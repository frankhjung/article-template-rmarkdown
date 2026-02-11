#!/usr/bin/make

# Rmarkdown Articles - Root Makefile
# Delegates builds to individual article subfolders.

# Find all article directories (those with a Makefile)
ARTICLES := $(patsubst %/Makefile,%,$(wildcard */Makefile))
ARTICLE_TARGET ?= default
SHELL    := /bin/bash

.PHONY: help list clean new-article update-links \
        $(ARTICLES) $(ARTICLES:%=%-clean)

help:
	@echo "Rmarkdown Articles Pipeline"
	@echo ""
	@echo "Usage:"
	@echo "  make list                              - List available articles"
	@echo "  make <article>                         - Build HTML for a specific article"
	@echo "  make <article> ARTICLE_TARGET=pdf       - Build PDF for a specific article"
	@echo "  make <article>-clean                   - Clean a specific article"
	@echo "  make new-article article_name=<name>   - Create a new article"
	@echo "  make update-links                      - Re-link shared files for all articles"
	@echo "  make clean                             - Clean all articles"
	@echo ""
	@echo "Available articles:"
	@$(foreach art,$(ARTICLES),echo "  - $(art)";)

list:
	@echo "Available articles:"
	@$(foreach art,$(ARTICLES),echo "  $(art)";)

$(ARTICLES):
	@echo "Building article: $@"
	$(MAKE) -C $@ $(ARTICLE_TARGET)

new-article:
	@if [ -z "$(article_name)" ]; then \
		echo "ERROR: article_name is required."; \
		echo "Usage: make new-article article_name=<name>"; \
		exit 1; \
	fi
	@if [ -d "$(article_name)" ]; then \
		echo "Article '$(article_name)' already exists!"; \
		exit 1; \
	fi
	@mkdir -p "$(article_name)"
	@ln -f files/article.mk "$(article_name)/Makefile"
	@ln -f files/make.R "$(article_name)/make.R"
	@cp files/article.Rmd "$(article_name)/article.Rmd"
	@mkdir -p "$(article_name)/images"
	@cp images/banner.jpg "$(article_name)/images/banner.jpg"
	@mkdir -p "$(article_name)/files"
	@ln -f files/article.css "$(article_name)/files/article.css"
	@ln -f files/preamble.tex "$(article_name)/files/preamble.tex"
	@echo "Article '$(article_name)' created successfully:"
	@find "$(article_name)/" -type f

update-links:
	@for art in $(ARTICLES); do \
		echo "Linking Makefile for $$art..."; \
		ln -f files/article.mk "$$art/Makefile"; \
		echo "Linking make.R for $$art..."; \
		ln -f files/make.R "$$art/make.R"; \
		echo "Linking files for $$art..."; \
		mkdir -p "$$art/files"; \
		ln -f files/article.css "$$art/files/article.css"; \
		ln -f files/preamble.tex "$$art/files/preamble.tex"; \
	done

# Clean specific article
$(ARTICLES:%=%-clean):
	@echo "Cleaning article: $(@:%-clean=%)"
	$(MAKE) -C $(@:%-clean=%) clean

# Clean all articles
clean:
	@for art in $(ARTICLES); do \
		echo "Cleaning $$art..."; \
		$(MAKE) -C "$$art" clean; \
	done
