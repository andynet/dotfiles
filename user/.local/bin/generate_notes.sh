#!/usr/bin/env bash

# use pandoc to convert vimwiki to static web pages

set -o errexit
set -o nounset
set -o pipefail

echo "Writing root site pages..."
(
  for src in *.md
  do
    out="${src%.*}.html"

    pandoc \
      --from markdown \
      --to html \
      --wrap preserve \
      --template=".template.html" \
      --email-obfuscation references \
      --output "${out}" \
      ${src}

    echo "+ ${out}"
  done
)

echo "Rendering notes..."
(
  declare -A notes

  for src in notes/*.md
  do
    # Doc title from filename
    title="$(basename "${src}" .md)"

    # Downcase and hyphenate output paths
    out="$(echo ${src,,} | tr " " - | sed 's/.md$/.html/')"

    # Rewrite wikilinks and forward to pandoc
    pandoc \
      --from "markdown-shortcut_reference_links" \
      --to html \
      --wrap preserve \
      --lua-filter="lib/wikilink.lua" \
      --lua-filter="lib/nowidths.lua" \
      --template=".template.html" \
      --mathjax="/lib/mathjax/tex-chtml.js" \
      --variable js="/lib/path.js" \
      --metadata title="${title}" \
      --metadata body-class="note" \
      --output "${out}" \
      "${src}"

    notes["${title}"]="/${out}"

    echo "+ ${out}"
  done

  echo "Creating notes index..."
  index_links=()
  for title in "${!notes[@]}"
  do
    link="${notes["${title}"]}"
    index_links+=("[${title}](${link})")
  done
  printf -- "- %s\n" "${index_links[@]}" | \
    pandoc \
      --from markdown \
      --to html \
      --wrap preserve \
      --template=".template.html" \
      --variable js="/lib/path.js" \
      --metadata pagetitle="Notes index" \
      --metadata body-class="index" \
      --metadata description="Index listing of all published open notes." \
      --output "notes/index.html"
)

echo "Done."
