#!/usr/bin/env bash

set -u

DOC_NAME="Dissertation"
ADDITIONALS_ONLY=0
CLEANUP=0

for argument in "$@"; do
    case "$argument" in
        --additionals)
            ADDITIONALS_ONLY=1
            ;;
        --cleanup)
            CLEANUP=1
            ;;
        --nocleanup)
            CLEANUP=0
            ;;
        --)
            ;;
        *)
            DOC_NAME="$argument"
            ;;
    esac
done

ROOT_DIR=$(pwd)
DIR_DIGITAL="$ROOT_DIR/build_digital"
DIR_PRINT="$ROOT_DIR/build_print"
DIR_ADDITIONAL="$ROOT_DIR/build_additionals"
DATE_PREFIX=$(date +%y%m%d)
WARNING_COUNT=0
ERROR_COUNT=0

ADDITIONAL_NAMES=(
    "summary_paper_EN:summary_paper"
    "summary_paper_DE:summary_paper"
    "curriculum_vitae_EN:curriculum_vitae"
    "curriculum_vitae_DE:curriculum_vitae"
    "thesis_overview_EN:presentations"
    "thesis_overview_DE:presentations"
)

cleanup_build_directories() {
    echo "Cleaning temporary files..."
    rm -rf "$DIR_DIGITAL" "$DIR_PRINT" "$DIR_ADDITIONAL"
}

if [[ "$CLEANUP" -eq 1 ]]; then
    cleanup_build_directories
fi

build_digital() {
    mkdir -p "$DIR_DIGITAL"
    echo "Building Digital Version..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error \
        -xelatex "-outdir=$DIR_DIGITAL" "-jobname=$DOC_NAME" "$DOC_NAME.tex"
}

build_print() {
    mkdir -p "$DIR_PRINT"
    echo "Building Print Version..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error \
        -xelatex "-outdir=$DIR_PRINT" "-jobname=${DOC_NAME}_print" \
        -e '$xelatex = "xelatex %O \def\PRINTABLE{} \input{%S}"' "$DOC_NAME.tex"
}

build_additional() {
    local document_name="$1"
    local source_dir="$2"
    mkdir -p "$DIR_ADDITIONAL"
    pushd "$ROOT_DIR/$source_dir" > /dev/null || return 1
    echo "Building $document_name..."
    latexmk -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error \
        -xelatex "-outdir=$DIR_ADDITIONAL" "-jobname=$document_name" "$document_name.tex"
    local result=$?
    popd > /dev/null || return 1
    return $result
}

pids=()
if [[ "$ADDITIONALS_ONLY" -eq 0 ]]; then
    build_digital & pids+=("$!")
    build_print & pids+=("$!")
fi

for additional in "${ADDITIONAL_NAMES[@]}"; do
    document_name="${additional%%:*}"
    source_dir="${additional#*:}"
    build_additional "$document_name" "$source_dir" & pids+=("$!")
done

for pid in "${pids[@]}"; do
    if ! wait "$pid"; then
        ERROR_COUNT=$((ERROR_COUNT + 1))
    fi
done

move_pdf() {
    local source_path="$1"
    local target_path="$2"
    if [[ ! -f "$source_path" ]]; then
        echo "WARNING: PDF not found, cannot move: $source_path" >&2
        WARNING_COUNT=$((WARNING_COUNT + 1))
        return 0
    fi
    mv -f "$source_path" "$target_path"
}

if [[ "$ADDITIONALS_ONLY" -eq 0 ]]; then
    move_pdf "$DIR_DIGITAL/$DOC_NAME.pdf" "$ROOT_DIR/${DATE_PREFIX}_${DOC_NAME}.pdf"
    move_pdf "$DIR_PRINT/${DOC_NAME}_print.pdf" "$ROOT_DIR/${DATE_PREFIX}_${DOC_NAME}_print.pdf"
fi

for additional in "${ADDITIONAL_NAMES[@]}"; do
    document_name="${additional%%:*}"
    pdf_path="$DIR_ADDITIONAL/$document_name.pdf"
    move_pdf "$pdf_path" "$ROOT_DIR/${DATE_PREFIX}_${document_name}.pdf"
done

if [[ "$CLEANUP" -eq 1 ]]; then
    cleanup_build_directories
fi

if [[ "$ERROR_COUNT" -gt 0 ]]; then
    echo "Build finished with errors ($ERROR_COUNT error(s), $WARNING_COUNT warning(s))." >&2
    exit 1
fi
if [[ "$WARNING_COUNT" -gt 0 ]]; then
    echo "Build finished with warnings ($WARNING_COUNT warning(s))."
    exit 0
fi
echo "Build finished successfully."
exit 0
