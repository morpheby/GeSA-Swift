#!/bin/sh

# Pandoc command to create pdf
PDF_COMMAND="pandoc --from=markdown --to=latex --pdf-engine=xelatex --toc"

GFM_COMMAND="pandoc --from=markdown --to=gfm"

# Full list of input chapters
LIST=(
"GeSA Introduction.md"
"GeSA Usage.md"
"GeSA Structure.md"
"GeSA Comparison.md"
"GeSA QnA.md"
"GeSA State.md"
"GeSA Patterns.md"
"GeSA Examples.md"
)

# Heading document for pdf
DOC_HEAD="GeSA Description.md.head"

# Tail document for separate chapters
DOC_TAIL="GeSA ToC.md.tail"

OUTPUT_DIR=".."
REVERSE_DIR="src"
DOC_OUTPUT="${OUTPUT_DIR}/GeSA Description.pdf"

# Create separate interlinked chapters for GitHub
for x in "${LIST[@]}" ; do
    cat "${x}" "${DOC_TAIL}" | $GFM_COMMAND -o "${OUTPUT_DIR}/${x}" -
done

# Link pictures
for inname in *.graffle ; do
    outname=${inname%.*}
    (cd ${OUTPUT_DIR} && ln -sf "${REVERSE_DIR}/${outname}" "${outname}")
done

# Create full documentation pdf
cat "${DOC_HEAD}" "${LIST[@]}" | $PDF_COMMAND -o "${DOC_OUTPUT}" -
