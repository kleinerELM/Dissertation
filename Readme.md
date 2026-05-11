# Arbeitsdokument Dissertation Florian Kleiner

Dieses Dokument ist für XeLaTeX ausgelegt!

## Schriftarten ##

Im Unterordner `./font/` sollten folgende Dateien für die intendierte Schriftsetzung abgelegt sein:

 - LinotypeSyntaxCom-Bold.ttf
 - LinotypeSyntaxCom-BoldIt.ttf
 - LinotypeSyntaxCom-Italic.ttf
 - LinotypeSyntaxCom-Regular.ttf

Fehlen diese Fonts oder wird das Dokument mit PDFLaTeX gesetzt, wird lmodern als serifenlose Schriftart eingesetzt.

Außerdem sollte die Schriftart https://github.com/alerque/libertinus/releases auf dem System vorhanden sein, um das Kapitälchen-ß korrekt dazustellen.

Zum Bearbeiten einiger Vektorgrafiken werden die OTF-Schriftarten von Latin Modern erwartet:
https://www.gust.org.pl/projects/e-foundry/latin-modern/download

## Draft-Modus ##

Im Draft-Modus werden Wasserzeichen auf der Titelseite und in der Fußzeile jeder Seite hinzugefügt.
Um den Draft-Modus zu verlassen sollte die zweite Zeile in `./Dissertation.tex` auskommentiert werden:

`% \def\DRAFT{}`

Im vereinfachten Draft-Modus werden einige Seiten nicht eingebunden und der Anhang wird ohne Bilder gesetzt. Zum Deaktivieren des Modus muss folgende Zeile auskommntiert werden:

`% \def\DRAFTSIMPLIFY{}`

Alle anderen Designdefinitionen sind in `./additionals/a-latex_header.tex` eingepflegt.

## XeLaTeX Einstellungen ##

Um das Dokument vollständig außerhalb des Draftmodus zu setzen, muss die XeLaTeX Installation mehr Arbeitsspeicher zugewiesen werden. Ansonsten bricht das Setzen ab und es wird maximal ein Dokument mit unvollständiger Bibliographie erstellt. Ein Hinweis auf den Fehler ist, dass eine Datei Namens `Dissertation.bbl-SAVE-ERROR` erstellt wird.
Um das zu tun, muss ein Terminal geöffnet und folgender Befehl eingegeben werden:

`initexmf --edit-config-file=xelatex`

in dem geöffneten Dokument müssen folgende Zeilen eingegeben werden:

```
extra_mem_top = 10000000
main_memory = 10000000 
```
Abschließend müssen die Einstellungen durch XeLaTeX geladen werden:

`initexmf --dump=xelatex`

## VSCode Einstellungen ##

Das Dokument wurde mittels Visual Studio Code erstellt. Mit den Plugins LaTeX Workshop und LaTeX Utilities kann das Dokument innerhalb von VSCode in verschiedenen Versionen gesetzt werden:

 - *Fast Build Digital* (Setzt die digitale Version einmal)
 - *Clean & Build Print* (Setzt die Printversion als finales Dokument)
 - *Clean & Build Print* (Setzt die Digitalversion als finales Dokument)
 - *Print & Digital* (Setzt beide Versionen als finales Dokument)
 - *Parallel Print & Digital* (Setzt beide Versionen als finales Dokument in einem parallelen Prozess, nur unter Windows mit Powershell)

## Lizenz ##

CC-BY 4.0, Florian Kleiner, 2023-2026, 
https://creativecommons.org/licenses/by/4.0/