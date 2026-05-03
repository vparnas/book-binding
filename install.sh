#!/usr/bin/env bash
# install.sh — Install book-binding dependencies
# Supports: Debian/Ubuntu, Arch Linux, Fedora/RHEL/CentOS

set -euo pipefail

# ── Colour output ─────────────────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'
info()    { echo -e "${GREEN}[info]${NC}  $*"; }
warn()    { echo -e "${YELLOW}[warn]${NC}  $*"; }
error()   { echo -e "${RED}[error]${NC} $*" >&2; exit 1; }

# ── Detect distribution ───────────────────────────────────────────────────────
detect_distro() {
    if [[ -f /etc/os-release ]]; then
        # shellcheck source=/dev/null
        source /etc/os-release
        echo "${ID}"
    else
        error "Cannot detect distribution: /etc/os-release not found."
    fi
}

# ── Installers ────────────────────────────────────────────────────────────────
install_debian() {
    info "Detected Debian/Ubuntu — using apt"
    sudo apt-get update -qq

    info "Installing LaTeX packages..."
    sudo apt-get install -y \
        texlive-latex-base \
        texlive-latex-recommended \
        texlive-latex-extra \
        texlive-fonts-recommended \
        texlive-pictures \
        texlive-science \
        texlive-humanities \
        texlive-extra-utils   # provides pdfjam

    info "Installing Cyrillic/language support..."
    sudo apt-get install -y texlive-lang-cyrillic

    info "Installing pdftk..."
    # pdftk was absent from Ubuntu 18.04 repos; try both names
    if apt-cache show pdftk &>/dev/null; then
        sudo apt-get install -y pdftk
    elif apt-cache show pdftk-java &>/dev/null; then
        sudo apt-get install -y pdftk-java
    else
        warn "pdftk not found in repositories. Install manually from:"
        warn "  https://gitlab.com/pdftk-java/pdftk"
    fi

    info "Installing Poppler utilities (pdfinfo)..."
    sudo apt-get install -y poppler-utils

    info "Installing Make..."
    sudo apt-get install -y make
}

install_arch() {
    info "Detected Arch Linux — using pacman"

    info "Installing LaTeX packages..."
    sudo pacman -S --needed --noconfirm \
        texlive-basic \
        texlive-latex \
        texlive-latexrecommended \
        texlive-latexextra \
        texlive-fontsrecommended \
        texlive-fontutils \
        texlive-pictures

    info "Installing Cyrillic/language support..."
    sudo pacman -S --needed --noconfirm texlive-langcyrillic

    info "Installing pdftk..."
    sudo pacman -S --needed --noconfirm pdftk

    info "Installing Poppler utilities (pdfinfo)..."
    sudo pacman -S --needed --noconfirm poppler

    info "Installing Make..."
    sudo pacman -S --needed --noconfirm make
}

install_fedora() {
    info "Detected Fedora/RHEL — using dnf"

    info "Installing LaTeX packages..."
    sudo dnf install -y \
        texlive-scheme-medium \
        texlive-hyphenat \
        texlive-verse \
        texlive-titlesec \
        texlive-sectsty \
        texlive-palatino \
        texlive-alphabeta \
        texlive-bookmark \
        texlive-pdfjam

    info "Installing Cyrillic/language support..."
    sudo dnf install -y texlive-babel-russian texlive-cyrillic

    info "Installing pdftk..."
    if dnf info pdftk &>/dev/null; then
        sudo dnf install -y pdftk
    else
        warn "pdftk not found in repositories. Install pdftk-java manually:"
        warn "  https://gitlab.com/pdftk-java/pdftk"
    fi

    info "Installing Poppler utilities (pdfinfo)..."
    sudo dnf install -y poppler-utils

    info "Installing Make..."
    sudo dnf install -y make
}

# ── Verify installation ───────────────────────────────────────────────────────
verify() {
    info "Verifying installation..."
    local failed=0

    check() {
        local cmd="$1" label="$2"
        if command -v "$cmd" &>/dev/null; then
            info "  ✓ $label ($cmd)"
        else
            warn "  ✗ $label ($cmd) — not found in PATH"
            failed=1
        fi
    }

    check pdflatex  "LaTeX"
    check pdfjam    "pdfjam"
    check pdftk     "pdftk"
    check pdfinfo   "pdfinfo (Poppler)"
    check make      "Make"

    if [[ $failed -eq 1 ]]; then
        warn "One or more tools were not found. Check the output above."
        warn "If using a fresh TeX Live install, ensure its bin/ directory is on your PATH."
    else
        info "All dependencies verified successfully."
    fi
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
    local distro
    distro=$(detect_distro)

    case "$distro" in
        debian|ubuntu|linuxmint|pop)
            install_debian ;;
        arch|manjaro|endeavouros)
            install_arch ;;
        fedora|rhel|centos|rocky|almalinux)
            install_fedora ;;
        *)
            error "Unsupported distribution: '${distro}'. Supported: Debian/Ubuntu, Arch, Fedora/RHEL."
            ;;
    esac

    verify
}

main "$@"
