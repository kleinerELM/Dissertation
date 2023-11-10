# Arbeitsdokument Dissertation Florian Kleiner

Dieses Dokument ist für XeLaTeX ausgelegt!

Im Unterordner `./font/` sollten folgende Dateien für die intendierte Schriftsetzung abgelegt sein:

 - LinotypeSyntaxCom-Bold.ttf
 - LinotypeSyntaxCom-BoldIt.ttf
 - LinotypeSyntaxCom-Italic.ttf
 - LinotypeSyntaxCom-Regular.ttf

Fehlen diese Fonts oder wird das Dokument mit PDFLaTeX gesetzt, wird lmodern als serifenlose Schriftart eingesetzt.

Um den Draftmodus zu verlassen sollte die zweite Zeile in `./Dissertation.tex` auskommentiert werden:
`% \def\DRAFT{}`

Alle Designdefinitionen sind in `./additionals/a-latex_header.tex` eingepflegt.

## XeLaTeX Konfiguration in VSCode
shell escape muss in latexmk aktiv sein für svg package:
https://tex.stackexchange.com/questions/516604/how-to-enable-shell-escape-or-write18-visual-studio-code-latex-workshop