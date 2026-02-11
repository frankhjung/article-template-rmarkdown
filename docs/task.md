# Rmarkdown Multi-Article Project Tasks

## Part 1: Custom Docker Image

- [x] Create `Dockerfile` for Rmarkdown build tools

## Part 2: RMarkdown Workflow

- [x] Fix `files/article.mk` — parameterise `PROJECT`,
      output `article.html` instead of `index.html`
- [x] Create root `Makefile` based on `article-markdown`
      reference
- [x] Verify `files/make.R` needs no changes
- [x] Ensure `files/article.Rmd` template references
      `banner.jpg`

## Part 2a: Migrate `base-rate` Article

- [x] Re-link `base-rate/Makefile` and `make.R` from
      updated `files/`
- [x] Verify `base-rate` structure matches new convention

## Part 3: GitHub Pipeline

- [x] Create `.github/workflows/publish.yml` with
      `workflow_dispatch` and Blogger publish step
- [x] Rename `pages.yml` to `publish.yml`

## Part 4: Documentation

- [x] Update `README.md` to document multi-article
      workflow
- [x] Update `.gitignore` with `public/` and `*.html`
