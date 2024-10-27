set quiet

# set aliases
self := justfile_directory()

[private]
default:
	just --list

[doc('generate an svg image with all predefined clues.')]
create-overview:
    typst compile gc-overview.typ gc-overview.svg

[doc('needs package svgcleaner installed.')]
minify-icons:
    ./minify-icons.sh


# create docs
create-docs:
    typst compile docs.typ
