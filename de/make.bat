@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core Repository

REM Variables
set filename="lernOS-expert-debriefing-Guide-de"
set chapters=./src/index.md ./src/1-0-Grundlagen.md ./src/1-1-Geschichte-des-Expert-Debriefings.md ./src/1-2-Warum-ist-Wissensbewahrung-heute-wichtig.md ./src/1-3-Implizites-und-explizites-Wissen.md ./src/1-4-Erfolgsfaktoren-fuer-Expert-Debriefing.md ./src/1-5-0-Expert-Debriefing-Referenzprozess.md ./src/1-5-1-Vorgespraech-fuehren.md ./src/1-5-2-Wissenslandkarte-aufbauen.md ./src/1-5-3-Massnahmen-ableiten.md ./src/1-5-4-Feedback-einholen.md ./src/1-5-5-Massnahmen-begleiten.md ./src/1-5-6-Reflexion-moderieren.md ./src/1-6-0-Expert-Debriefing-Toolbox.md ./src/1-6-1-Checkliste.md ./src/1-6-2-Dokumentenbibliothek.md ./src/1-6-3-Lessons-Learned.md ./src/1-6-4-Erklaervideo.md ./src/1-6-5-FAQ.md ./src/1-6-6-Memex.md ./src/1-6-7-Podcast.md ./src/1-6-8-Soziales-Netzwerk-Diagramm.md ./src/1-6-9-Voice-over-PowerPoint.md ./src/1-6-10-Screencast.md ./src/2-0-Lernpfad.md ./src/3-Anhang.md

REM Delete Old Versions
echo Deleting old versions ...
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf

REM Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml -s --resource-path="./src" %chapters% -o %filename%.docx

REM Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml -s --resource-path="./src" --toc %chapters% -o %filename%.html

REM Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

REM Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown --resource-path="./src" --template lernOS --number-sections -V lang=de-de %chapters% -o %filename%.pdf 

REM Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 %filename%.pdf[0] src/images/ebook-cover.jpg
magick mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml -s --resource-path="./src" --epub-cover-image=src/images/ebook-cover.jpg %chapters% -o %filename%.epub
ebook-convert %filename%.epub %filename%.mobi


echo Done. Check for error messages or warnings above. 

pause
