# Setup

## Dependencies

The pipeline requires three categories of tools:

1. **Build orchestration** — GNU Make
2. **PDF processing** — `pdfjam`, `pdftk` and `pdfinfo`
3. **LaTeX typesetting** — a TeX distribution with a specific set of packages

## 1. GNU Make

Almost certainly already present on any Linux system. Verify with:

```sh
make --version
```

If absent, install via your distribution's package manager (package name is universally `make`).

## 2. PDF Utilities

### pdfjam

`pdfjam` is a shell wrapper around the LaTeX `pdfpages` package. On most distributions it ships as part of a TeX distribution bundle (see section 3), but it may also be available as a standalone package.

### pdftk

`pdftk` has a somewhat fragmented packaging history — the original C/GCJ build was abandoned, and distributions vary in what they ship. The two common implementations are **pdftk-java** (a maintained Java port) and the original **pdftk** binary where still packaged.

### pdfinfo

`pdfinfo` is part of the **Poppler** utilities — a simple, universally packaged library.

## 3. LaTeX

This is the most involved dependency. You need a TeX distribution plus a set of packages. The two main distribution approaches are covered below: a **full install** (simplest, largest) and a **minimal install** (smaller footprint, requires individual package management).

### Packages required

| Package | Purpose |
|---|---|
| `geometry` | Page dimensions and margins |
| `multicol` | Multi-column layout |
| `hyphenat` | Disable hyphenation |
| `alltt` | Verbatim-style environment with font commands |
| `amsmath` | Math typesetting |
| `tikz` + `calc` library | Cover page graphics and overlays |
| `xcolor` | Color support |
| `graphicx` | Image inclusion |
| `pdfpages` | Embedding external PDFs |
| `verse` | Poem typesetting macros; `texlive-humanities` package on Debian |
| `inputenc` | UTF-8 input encoding |
| `fontenc` | T1 (Latin) or T2B (Cyrillic) output encoding |
| `palatino` | Palatino font (Latin mode) |
| `alphabeta` | Occasional Greek character input |
| `hyperref` | PDF metadata and hyperlinks |
| `bookmark` | PDF bookmark control |
| `sectsty` | Section heading styles |
| `titlesec` | Section title spacing and formatting |
| `babel` | Language support (required for Cyrillic/non-Latin texts) |

For Cyrillic texts specifically (`\LANGUAGE` defined in the config), `texlive-lang-cyrillic` (or equivalent) and the T2B font encoding support are additionally required.

## Installation by Distribution

### Arch Linux

The AUR and official repositories provide granular TeX packages via `texlive`.

```sh
# Core LaTeX and the required package groups
sudo pacman -S texlive-basic texlive-latex texlive-latexrecommended \
               texlive-latexextra texlive-fontsrecommended \
               texlive-fontutils texlive-pictures

# For Cyrillic support (only needed for non-Latin texts)
sudo pacman -S texlive-langcyrillic

# pdfjam ships with texlive; pdftk
sudo pacman -S pdftk

# pdfinfo
sudo pacman -S poppler
```

Verify `pdfjam` and `pdfinfo` is available after the texlive install:

```sh
pdfjam --version
pdfinfo -v
```

### Debian / Ubuntu

TeX Live on Debian/Ubuntu is split into many `texlive-*` metapackages. The safest approach for this project:

```sh
sudo apt update
sudo apt install texlive-latex-base texlive-latex-recommended \
                 texlive-latex-extra texlive-fonts-recommended \
                 texlive-pictures texlive-science texlive-humanities

# For Cyrillic support
sudo apt install texlive-lang-cyrillic

# pdfjam is bundled with texlive-extra-utils
sudo apt install texlive-extra-utils

# pdftk — Debian/Ubuntu ship pdftk-java
sudo apt install pdftk
# On older releases where pdftk is absent, try:
# sudo apt install pdftk-java

# pdfinfo
sudo apt install poppler-utils
```

> **Note:** If `pdftk` is unavailable in your release's repositories (it was dropped from Ubuntu 18.04 for a period), install `pdftk-java` directly or via a PPA:
> ```sh
> sudo add-apt-repository ppa:malteworld/ppa
> sudo apt install pdftk
> ```

### Fedora / RHEL / CentOS

```sh
# Core texlive
sudo dnf install texlive-scheme-medium

# Additional packages not covered by medium scheme
sudo dnf install texlive-hyphenat texlive-verse texlive-titlesec \
                 texlive-sectsty texlive-palatino texlive-alphabeta \
                 texlive-bookmark

# For Cyrillic support
sudo dnf install texlive-babel-russian texlive-cyrillic

# pdfjam (part of texlive) and pdftk
sudo dnf install pdftk

# pdfinfo
sudo dnf install poppler-utils
```

### Distribution-Agnostic: Full TeX Live install

If you want to avoid package-hunting across distributions, install upstream TeX Live directly. This gives you everything — all packages, all fonts, all language support — at the cost of ~7 GB disk space.

```sh
# Download the installer
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*/

# Run the installer (interactive; choose 'full scheme' or accept defaults)
sudo ./install-tl

# Add the installed binaries to your PATH (adjust year as needed)
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
```

Add the `PATH` line to your `.bashrc` / `.zshrc` for persistence. After this, `pdfjam` is included and all required packages are present. Install `pdftk` separately via your distribution's package manager.

### Distribution-Agnostic: Minimal TeX Live + tlmgr

If you have a working TeX Live install (any source) but are missing specific packages, install them individually via `tlmgr`, the TeX Live package manager:

```sh
sudo tlmgr install geometry ifthen multicol hyphenat alltt amsmath \
    pgf xcolor graphicx pdfpages verse palatino alphabeta \
    hyperref bookmark sectsty titlesec pdfjam

# Cyrillic
sudo tlmgr install babel-russian cyrillic
```

Note that `tlmgr` is only available with a TeX Live install sourced from upstream (not from distribution packages, which disable it in favor of their own package managers).

## Verification

Once everything is installed, a quick sanity check:

```sh
pdflatex --version
pdfjam --version
pdftk --version   # or: pdftk --help | head -1
pdfinfo -v
make --version
```

If `pdflatex` reports missing packages, install them via `tlmgr` (upstream TeX Live) or your distribution's package manager using the package name from the table above.
