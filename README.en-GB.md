# Dissertation by Florian Kleiner

#### (Choose your language / Wählen sie ihre Sprache)
[![Englisch](https://img.shields.io/badge/Language-English-blue)](README.en-GB.md)
[![Deutsch](https://img.shields.io/badge/Language-German-green)](README.md)

**Thesis title:** Advanced 2D and 3D characterisation of clinker phases and hydrated cementitious binders by combining a variety of modern imaging and analytical techniques

<img src="figures/titlepage/Titlepage.svg" width="250" alt="Title page">

## Abstract

This dissertation addresses the advanced 2D and 3D characterisation of clinker phases and hydrated cementitious binders. To overcome the limitations of individual measurement methods, various modern imaging and analytical techniques, including SEM, FIB-nT, LA-ICP-MS, ArBIB, LT-DSC and nanoindentation, are combined correlatively.

The main objective is to improve the understanding of cement hydration and microstructural development by establishing robust evaluation methods.

## Main Research Topics

The main areas of research are:

* **ArBIB preparation techniques:** Application of argon broad ion beam (ArBIB) polishing to produce artefact-reduced surfaces for high-resolution SEM imaging while preserving the native pore structure.
* **Correlative microscopy of clinker phases:** Combination of nanoindentation, SEM-EDX and LA-ICP-MS on ArBIB-prepared samples to determine phase-specific mechanical properties and trace-element distributions.
* **Advanced FIB-nT workflows:** Optimised lift-out techniques for cement-based materials, fs-laser preparation for investigating larger volumes, and automated post-processing workflows for registration, denoising and 3D superpixel segmentation.
* **Automated hydrate-layer measurements:** Development of an algorithm for automated 2D image analysis, including a statistical representativeness analysis for C<sub>3</sub>S, C<sub>2</sub>S and their mixtures.
* **Particle-distance measurements:** Analysis of the dispersing effect of superplasticisers and power ultrasound in fresh cement pastes using cryo-FIB-SEM.
* **EBSD-HLT correlation:** Investigation of the relationship between the crystallographic orientation of C<sub>3</sub>S particles and local C-S-H growth.
* **Pore-structure analysis:** Comparative investigation of gel and capillary porosity in porous glasses and hydrated cements using SEM, FIB-nT, LT-DSC and MIP.

## Technical Information

This project is configured for XeLaTeX. The thesis is primarily written in British English, although some sections are available only in German.

### Directory Structure

The project repository is organised as follows:

* `additionals/`: Supplementary text and configuration files, including the global LaTeX header (`a-latex_header.tex`), the abbreviations and symbols list, acknowledgements and the declaration.
* `chapter/`: LaTeX source files for the individual chapters, including the introduction, literature review, methods, results and summary.
* `curriculum_vitae/`: The author's curriculum vitae, including a publication list (German and English).
* `font/`: Project-specific fonts required for the intended XeLaTeX output.
* `figures/`: Figures, animations and CSV data referenced by the thesis, including data used to generate plots with pgfplots.
* `presentations/`: An overview presentation of the dissertation (German and English).
* `summary_paper/`: The summary paper, prepared according to the [requirements of the examination committee](https://www.uni-weimar.de/fileadmin/user/fak/bauing/hauptseiten/bauing/forschung/Promotionsverfahren_Dokumente/Zusammenfassung_zur_Promotionsschrift_uea0525.pdf) (German and English).
* `.github/workflows/`: GitHub Actions workflows for automated compilation.
* `.vscode/`: Workspace-specific settings, including build recipes for the LaTeX Workshop extension.

### Fonts

The following files should be placed in `./font/` for the intended font setup:

- `LinotypeSyntaxCom-Bold.ttf`
- `LinotypeSyntaxCom-BoldIt.ttf`
- `LinotypeSyntaxCom-Italic.ttf`
- `LinotypeSyntaxCom-Regular.ttf`

If these fonts are unavailable, a fallback font is used.

The Libertinus font family should also be installed on the system to support small caps containing the German letter sharp S (`ß`):

https://github.com/alerque/libertinus/releases

Some vector graphics require the OTF fonts from Latin Modern for editing:

https://www.gust.org.pl/projects/e-foundry/latin-modern/download

### Draft Mode

In draft mode, watermarks are added to the title page and to the footer of every page. To leave draft mode, comment out the second line in `./Dissertation.tex`:

```tex
% \def\DRAFT{}
```

In simplified draft mode, some pages are omitted and the appendix is compiled without images. To disable this mode, comment out the following line:

```tex
% \def\DRAFTSIMPLIFY{}
```

All other design definitions are maintained in `./additionals/a-latex_header.tex`.

### XeLaTeX Settings

Compiling the complete document outside draft mode requires additional memory for XeLaTeX. Otherwise, compilation may stop and produce a document with an incomplete bibliography. One indication of this problem is the creation of a file named `Dissertation.bbl-SAVE-ERROR`.

Open a terminal and run:

```text
initexmf --edit-config-file=xelatex
```

Add the following lines to the file that opens:

```text
extra_mem_top = 10000000
main_memory = 10000000
```

Finally, load the settings into XeLaTeX:

```text
initexmf --dump=xelatex
```

### VS Code Settings

The project was created using Visual Studio Code. With the LaTeX Workshop and LaTeX Utilities extensions, the documents can be compiled using the following recipes:

- *Fast Build Digital* (single digital build)
- *Clean & Build Print* (final print version)
- *Clean & Build Digital* (final digital version)
- *Print & Digital* (both versions)
- *Parallel Print & Digital (win)* (all documents in parallel on Windows)
- *Build Additionals (win)* (supplementary documents only on Windows)
- *Parallel Print & Digital (linux)* (all documents in parallel on Linux)
- *Build Additionals (linux)* (supplementary documents only on Linux)

### Parallel Build Scripts

The parallel XeLaTeX build can also be started from a terminal using `./build_parallel.ps1` on Windows or `./build_parallel.sh` on Linux. Temporary files are stored in `build_digital`, `build_print` and `build_additionals`.

**Windows** (all available options):

```powershell
.\build_parallel.ps1 Dissertation -Additionals -Cleanup
```

**Linux** (all available options):

```bash
./build_parallel.sh Dissertation --additionals --cleanup
```

Available options:

* **additionals**: Builds only the documents in `summary_paper/`, `curriculum_vitae/` and `presentations/`.
* **cleanup**: Deletes the build directories before the build and after the PDFs have been moved. This option is disabled by default.
* The name of the main document can be supplied as the first argument, for example `./build_parallel.sh Dissertation` or `.\build_parallel.ps1 Dissertation`.

At the end, both scripts report whether the build completed successfully, with warnings or with errors. Missing PDFs produce warnings; failed LaTeX builds, move operations or cleanup steps produce errors.

## Licence

CC BY 4.0, Florian Kleiner, 2023-2026

https://creativecommons.org/licenses/by/4.0/
