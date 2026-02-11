# Rmarkdown Articles

A reusable project for authoring, building, and publishing
[R Markdown](https://rmarkdown.rstudio.com/) articles to
[Blogger](https://www.blogger.com/).

Each article lives in its own subfolder and shares a common
build configuration. A single GitHub Actions workflow builds
any article on demand and publishes the resulting HTML to
Blogger.

## Project Structure

```text
rmarkdown/
├── Dockerfile              # Rmarkdown build image
├── Makefile                # Root delegating Makefile
├── files/
│   ├── article.mk          # Shared article Makefile
│   ├── make.R              # R rendering script
│   ├── article.Rmd         # Article template
│   ├── article.css         # HTML styling
│   └── preamble.tex        # LaTeX preamble for PDF
├── images/
│   └── banner.jpg          # Default banner image
├── <article_name>/         # One folder per article
│   ├── Makefile             # Hard link → files/article.mk
│   ├── make.R              # Hard link → files/make.R
│   ├── article.Rmd         # Article source
│   ├── files/
│   │   ├── article.css     # Hard link → files/article.css
│   │   └── preamble.tex    # Hard link → files/preamble.tex
│   └── images/
│       └── banner.jpg      # Article banner
└── .github/workflows/
    └── publish.yml         # Build & publish workflow
```

## Prerequisites

- [R](https://www.r-project.org/) (version 4.0+)
- R packages: `rmarkdown`, `knitr`, `ggplot2`, and others
  (see `Dockerfile` for the full list)
- [GNU Make](https://www.gnu.org/software/make/)
- [pandoc](https://pandoc.org/) (bundled with RStudio or
  install separately)
- [Docker](https://www.docker.com/) (optional, for
  containerised builds)

### Installing R Packages

```r
install.packages(c(
  "broom", "dplyr", "forcats", "ggplot2", "knitr",
  "lubridate", "magrittr", "purrr", "readr", "rlang",
  "rmarkdown", "scales", "stringr", "tibble", "tidyr"
))
```

## Creating a New Article

```bash
make new-article article_name=my-article
```

This scaffolds a new article folder with all required files
and links.

## Building Locally

```bash
# Build a specific article
make -B base-rate

# List available articles
make list

# Clean a specific article
make base-rate-clean

# Clean all articles
make clean
```

Build output is written to
`<article_name>/public/article.html`.

## Docker Build

```bash
# Build the Docker image
docker build -t rmarkdown .

# Build an article using the image
docker run --rm -v "$PWD":/workspace rmarkdown -B base-rate

# Build using GHCR image:
docker run --rm -v "$PWD":/workspace docker://ghcr.io/frankhjung/gnur:4.5.2 -B base-rate


```

## Publishing via GitHub Actions

The
[publish.yml](.github/workflows/publish.yml)
workflow is triggered manually via `workflow_dispatch` with
three inputs:

| Input | Description |
| :---- | :---------- |
| `article_name` | Article subfolder name (e.g. `base-rate`) |
| `article_title` | Post title as it appears on Blogger |
| `article_labels` | Comma-separated labels for the post |

The workflow validates inputs, builds the article in a
Docker container, and publishes the resulting HTML to
Blogger using the
[blogger](https://github.com/frankhjung/docker-blogger)
image.

### Required Secrets

| Secret | Description |
| :----- | :---------- |
| `BLOGGER_BLOG_ID` | Destination blog identifier |
| `BLOGGER_CLIENT_ID` | Google OAuth Client ID |
| `BLOGGER_CLIENT_SECRET` | Google OAuth Client Secret |
| `BLOGGER_REFRESH_TOKEN` | Long-term API access token |

## References

- [R Markdown](https://rmarkdown.rstudio.com/)
- [Blogger API](https://developers.google.com/blogger)
- [docker-blogger](https://github.com/frankhjung/docker-blogger)

## [MIT License](LICENSE)

© Frank H Jung 2026
