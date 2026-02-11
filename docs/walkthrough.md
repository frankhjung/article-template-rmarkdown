# Walkthrough: Rmarkdown Multi-Article Setup

## Changes Made

### Part 1 — Dockerfile

#### [NEW] [Dockerfile](file:///home/frank/documents/articles/rmarkdown/Dockerfile)

- Base image: `rocker/r-ver:4`
- System deps: `pandoc`, `libcurl`, `libssl`, `libxml2`,
  `make`
- 15 R packages installed from CRAN
- `WORKDIR /workspace`, `ENTRYPOINT ["make"]`

---

### Part 2 — Makefile Infrastructure

#### [MODIFY] [article.mk](file:///home/frank/documents/articles/rmarkdown/files/article.mk)

render_diffs(file:///home/frank/documents/articles/rmarkdown/files/article.mk)

#### [NEW] [Makefile](file:///home/frank/documents/articles/rmarkdown/Makefile)

Root Makefile with targets: `help`, `list`, `<article>`,
`<article>-clean`, `new-article`, `update-links`, `clean`.
Uses `article_name=<name>` parameter (non-interactive).

#### base-rate Re-linking

Hard-linked all 4 shared files — verified matching inodes:

| File | Inode |
| :--- | :---- |
| `article.mk` ↔ `base-rate/Makefile` | 5771456 |
| `make.R` ↔ `base-rate/make.R` | 5768018 |
| `article.css` | 5790164 |
| `preamble.tex` | 5790181 |

---

### Part 3 — GitHub Pipeline

#### [DELETE] [pages.yml](file:///home/frank/documents/articles/rmarkdown/.github/workflows/pages.yml)

Removed (replaced by `publish.yml`).

#### [NEW] [publish.yml](file:///home/frank/documents/articles/rmarkdown/.github/workflows/publish.yml)

`workflow_dispatch` with `article_name`,
`article_title`, `article_labels` inputs. Jobs:
`validate` → `build` (Docker) → `publish` (Blogger).

---

### Part 4 — Documentation

#### [MODIFY] [README.md](file:///home/frank/documents/articles/rmarkdown/README.md)

Rewritten with project structure, prerequisites, build
commands, Docker usage, and publishing instructions.

#### [MODIFY] [.gitignore](file:///home/frank/documents/articles/rmarkdown/.gitignore)

Added `public/` and `*.html`.

---

## Verification

| Check | Result |
| :---- | :----- |
| `make -n help` | ✅ Parses, lists `base-rate` |
| `make -n list` | ✅ Lists `base-rate` |
| Hard links (4 files) | ✅ Matching inodes confirmed |
| YAML lint (`publish.yml`) | ✅ Fixed |
