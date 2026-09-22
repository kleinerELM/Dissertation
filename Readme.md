# Dissertation von Florian Kleiner

**Titel der Arbeit:** Advanced 2D and 3D characterisation of clinker phases and hydrated cementitious binders by combining a variety of modern imaging and analytical techniques

<img src="figures/titlepage/Titlepage.svg" width="250" alt="Titelbild">

## Abstract
Diese Dissertation befasst sich mit der erweiterten 2D- und 3D-Charakterisierung von Klinkerphasen und hydratisierten zementären Bindemitteln. Um die Nachteile einzelner Messmethoden zu umgehen, werden verschiedene moderne bildgebende und analytische Verfahren (u. a. REM, FIB-nT, LA-ICP-MS, ArBIB, LT-DSC und Nanoindentation) korrelativ miteinander kombiniert.
Das Hauptziel der Arbeit ist es, das Verständnis der Zementhydratation und der mikrostrukturellen Entwicklung durch die Etablierung robuster Auswertungsmethoden zu verbessern.

## Hauptschwerpunkte der Arbeit

Inhaltliche Schwerpunkte:

*   **ArBIB-Präparationstechniken:** Anwendung von Argon-Ionenstrahlpolitur (ArBIB) zur Herstellung artefaktfreier Oberflächen für hochauflösende REM-Bildgebung unter Erhaltung der nativen Porenstruktur.
*   **Korrelative Mikroskopie von Klinkerphasen:** Kombination von Nanoindentation, REM-EDX und LA-ICP-MS an ArBIB-präparierten Proben zur phasenspezifischen Bestimmung mechanischer Eigenschaften und der Verteilung von Spurenelementen.
*   **Erweiterte FIB-nT-Workflows:** Optimierte Lift-out-Techniken für zementäre Materialien, fs-Laser-Präparation zur Untersuchung größerer Volumina sowie automatisierte Post-Processing-Workflows (Registrierung, Entrauschen, 3D-Superpixel-Segmentierung).
*   **Automatisierte Messung von Hydratsaumdicken (HLT):** Entwicklung eines Algorithmus zur automatisierten 2D-Bildauswertung, inklusive einer statistischen Repräsentativitätsanalyse für C<sub>3</sub>S, C<sub>2</sub>S und deren Mischungen.
*   **Partikelabstandsmessungen:** Analyse der dispergierenden Wirkung von Fließmitteln und Hochleistungsultraschall in frischen Zementleimen mittels Kryo-FIB-REM.
*   **EBSD-HLT-Korrelation:** Untersuchung des Zusammenhangs zwischen der kristallographischen Orientierung des C<sub>3</sub>S-Korns und dem lokalen C-S-H-Wachstum.
*   **Porenstrukturanalyse:** Vergleichende Untersuchung der Gel- und Kapillarporosität an porösen Gläsern und hydratisierten Zementen mittels REM, FIB-nT, LT-DSC und MIP.


## Technische Hinweise zum Dokument

Dieses Dokument ist für XeLaTeX ausgelegt! Die Arbeit ist vorrangig in Britisch Englisch verfasst, wobei einige Abschnitte nur in Deutsch verfügbar sind.

### Ordnerstruktur

Das Projekt-Repository ist wie folgt strukturiert:
*   `additionals/`: Beinhaltet ergänzende Text- und Konfigurationsdateien, wie den globalen LaTeX-Header (`a-latex_header.tex`), das Abkürzungs- und Symbolverzeichnis (`g-symbols.tex`), die Danksagung sowie die ehrenwörtliche Erklärung.
*   `chapter/`: Enthält die inhaltlichen LaTeX-Quelldateien der einzelnen Kapitel (Einleitung, Literatur, Methoden, Ergebnisse, Zusammenfassung etc.).
*   `curriculum_vitae/`: Enthält den Lebenslauf mit Publikationsliste des Autors (DE/EN).
*   `font/`: Ablageort für die projektspezifischen Schriftarten, die für das korrekte Setzen via XeLaTeX lokal bereitgestellt werden müssen.
*   `figures/`: Beinhaltet alle im Text referenzierten Abbildungen, Animationen und CSV-Rohdaten (zur Erzeugung von Plots mit pgfplots).
*   `presentations/`: Enthält eine kurze Übersichtspräsentation der Dissertation (DE/EN).
*   `summary_paper/`: Enthält das "Thesenpapier" nach den [Anforderungen der Prüfungskommission](https://www.uni-weimar.de/fileadmin/user/fak/bauing/hauptseiten/bauing/forschung/Promotionsverfahren_Dokumente/Zusammenfassung_zur_Promotionsschrift_uea0525.pdf) (DE/EN).
*   `.github/workflows/`: Konfigurationsdateien für GitHub Actions (automatisches Kompilieren).
*   `.vscode/`: Enthält arbeitsbereichsspezifische Einstellungen für Visual Studio Code, wie beispielsweise die Konfigurationen und Build-Rezepte für die LaTeX Workshop Erweiterung.

### Schriftarten

Im Unterordner `./font/` sollten folgende Dateien für die intendierte Schriftsetzung abgelegt sein:

 - LinotypeSyntaxCom-Bold.ttf
 - LinotypeSyntaxCom-BoldIt.ttf
 - LinotypeSyntaxCom-Italic.ttf
 - LinotypeSyntaxCom-Regular.ttf

Fehlen diese Fonts oder wird das Dokument mit PDFLaTeX gesetzt, wird lmodern als Fallback-Schriftart eingesetzt.

Außerdem sollte die Schriftart https://github.com/alerque/libertinus/releases auf dem System vorhanden sein, um das Kapitälchen-ß korrekt darzustellen.

Zum Bearbeiten einiger Vektorgrafiken werden die OTF-Schriftarten von Latin Modern erwartet:
https://www.gust.org.pl/projects/e-foundry/latin-modern/download

### Draft-Modus

Im Draft-Modus werden Wasserzeichen auf der Titelseite und in der Fußzeile jeder Seite hinzugefügt.
Um den Draft-Modus zu verlassen, sollte die zweite Zeile in `./Dissertation.tex` auskommentiert werden:

`% \def\DRAFT{}`

Im vereinfachten Draft-Modus werden einige Seiten nicht eingebunden und der Anhang wird ohne Bilder gesetzt. Zum Deaktivieren des Modus muss folgende Zeile auskommentiert werden:

`% \def\DRAFTSIMPLIFY{}`

Alle anderen Design-Definitionen sind in `./additionals/a-latex_header.tex` eingepflegt.

### XeLaTeX-Einstellungen

Um das Dokument vollständig außerhalb des Draft-Modus zu setzen, muss der XeLaTeX-Installation mehr Arbeitsspeicher zugewiesen werden. Ansonsten bricht das Setzen ab und es wird maximal ein Dokument mit unvollständiger Bibliografie erstellt. Ein Hinweis auf den Fehler ist, dass eine Datei namens `Dissertation.bbl-SAVE-ERROR` erstellt wird.
Um das zu tun, muss ein Terminal geöffnet und folgender Befehl eingegeben werden:

`initexmf --edit-config-file=xelatex`

in dem geöffneten Dokument müssen folgende Zeilen eingegeben werden:

```
extra_mem_top = 10000000
main_memory = 10000000 
```
Abschließend müssen die Einstellungen durch XeLaTeX geladen werden:

`initexmf --dump=xelatex`

### VS-Code-Einstellungen

Das Dokument wurde mittels Visual Studio Code erstellt. Mit den Plugins LaTeX Workshop und LaTeX Utilities kann das Dokument innerhalb von VSCode in verschiedenen Versionen gesetzt werden:

 - *Fast Build Digital* (Setzt die digitale Version einmal)
 - *Clean & Build Print* (Setzt die Printversion als finales Dokument)
 - *Clean & Build Digital* (Setzt die Digitalversion als finales Dokument)
 - *Print & Digital* (Setzt beide Versionen als finales Dokument)
 - *Parallel Print & Digital (win)* (Setzt alle Dokumente in einem parallelen Prozess, Windows)
 - *Build Additionals (win)* (Setzt nur Zusatzdokumente, Windows)
 - *Parallel Print & Digital (linux)* (Setzt alle Dokumente in einem parallelen Prozess, Linux)
 - *Build Additionals (linux)* (Setzt nur Zusatzdokumente, Linux)

### Parallele Build-Skripte

Der parallele XeLaTeX basierte Buildprozess kann auch über das Terminal angestoßen werden mit `.\build_parallel.ps1` (Windows) bzw. `./build_parallel.sh` (Linux). Die temporären Dateien werden in `build_digital`, `build_print` und `build_additionals` abgelegt.

*Windows* (mit allen verfügbaren Optionen):

```powershell
.\build_parallel.ps1 Dissertation -Additionals -Cleanup
```

*Linux* (mit allen verfügbaren Optionen):

```bash
./build_parallel.sh Dissertation --additionals --cleanup
```

Verfügbare Optionen:

* **additionals**: Baut nur die Dokumente aus `summary_paper/`, `curriculum_vitae/` und `presentations/`.
* **cleanup**: Löscht die Build-Ordner vor dem Start und nach dem Verschieben der PDFs. Diese Option ist standardmäßig deaktiviert.
* Der Name des Hauptdokuments kann als erstes Argument angegeben werden, zum Beispiel `./build_parallel.sh Dissertation` oder `.\build_parallel.ps1 Dissertation`.

## Lizenz

CC-BY 4.0, Florian Kleiner, 2023-2026, 
https://creativecommons.org/licenses/by/4.0/