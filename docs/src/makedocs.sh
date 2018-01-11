#!/bin/sh

# Pandoc command to create pdf
COMMAND="pandoc --from=markdown --to=latex --latex-engine=xelatex --toc"

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
DOC_OUTPUT="${OUTPUT_DIR}/GeSA Description.pdf"

# Create separate interlinked chapters for GitHub
for x in "${LIST[@]}" ; do
    cat "${x}" "${DOC_TAIL}" > "${OUTPUT_DIR}/${x}"
done

# Create full documentation pdf
cat "${DOC_HEAD}" "${LIST[@]}" | $COMMAND -o "${DOC_OUTPUT}" -
