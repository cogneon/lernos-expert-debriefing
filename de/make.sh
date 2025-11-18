PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-expert-debriefing-Guide-de"
chapters="./src/index.md ./src/1-0-Grundlagen.md ./src/1-1-Geschichte-des-Expert-Debriefings.md ./src/1-2-Warum-ist-Wissensbewahrung-heute-wichtig.md ./src/1-3-Implizites-und-explizites-Wissen.md ./src/1-4-Erfolgsfaktoren-fuer-Expert-Debriefing.md ./src/1-5-0-Expert-Debriefing-Referenzprozess.md ./src/1-5-1-Vorgespraech-fuehren.md ./src/1-5-2-Wissenslandkarte-aufbauen.md ./src/1-5-3-Massnahmen-ableiten.md ./src/1-5-4-Feedback-einholen.md ./src/1-5-5-Massnahmen-begleiten.md ./src/1-5-6-Reflexion-moderieren.md ./src/1-6-0-Expert-Debriefing-Toolbox.md ./src/1-6-1-Checkliste.md ./src/1-6-2-Dokumentenbibliothek.md ./src/1-6-3-Lessons-Learned.md ./src/1-6-4-Erklaervideo.md ./src/1-6-5-FAQ.md ./src/1-6-6-Memex.md ./src/1-6-7-Podcast.md ./src/1-6-8-Soziales-Netzwerk-Diagramm.md ./src/1-6-9-Voice-over-PowerPoint.md ./src/1-6-10-Screencast.md ./src/2-0-Lernpfad.md ./src/3-Anhang.md"

# Delete Old Versions
echo Deleting old versions ...
rm -rf $filename.*
rm -rf ../docs/de/*

# Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

# Create Markdown Version (md, one file)
echo Creating Markdown version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.md $chapters

# Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernos --number-sections --toc -V lang=de-de -o $filename.tex $chapters
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernos --number-sections --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Version (epub)
echo Creating eBook versions ...
magick -density 300 $filename.pdf[0] src/images/ebook-cover.jpg
mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o $filename.epub $chapters
