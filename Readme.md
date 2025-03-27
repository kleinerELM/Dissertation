# Arbeitsdokument Dissertation Florian Kleiner

Dieses Dokument ist für XeLaTeX ausgelegt!

Im Unterordner `./font/` sollten folgende Dateien für die intendierte Schriftsetzung abgelegt sein:

 - LinotypeSyntaxCom-Bold.ttf
 - LinotypeSyntaxCom-BoldIt.ttf
 - LinotypeSyntaxCom-Italic.ttf
 - LinotypeSyntaxCom-Regular.ttf

Fehlen diese Fonts oder wird das Dokument mit PDFLaTeX gesetzt, wird lmodern als serifenlose Schriftart eingesetzt.

Außerdem sollte die Schriftart https://github.com/alerque/libertinus/releases auf dem System vorhanden sein.

Um den Draftmodus zu verlassen sollte die zweite Zeile in `./Dissertation.tex` auskommentiert werden:
`% \def\DRAFT{}`
Das deaktiviert auch die Verwendung von tikzexternalize. Dadurch funktioniert auch die Verwendung von Acronymen in tikz-Diagrammen.

Alle Designdefinitionen sind in `./additionals/a-latex_header.tex` eingepflegt.