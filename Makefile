CFG=.booklet_cfg

ifneq (,$(wildcard ./$(CFG)))
    include $(CFG)
endif

SHELL=/bin/bash # paramount for bash expanded arithmetic

A4_SUF?=booklet-A4
HALF_SHEET_SUF?=booklet-A5
LETTER_SUF?=booklet-letter
DEFS_SUFFIX?=defs.tex
COMMON_TEX?=~/work/book-binding-pub/common.tex
HALF_SHEET_DIM=--a5paper # should equate to half of full-sheet

BASE?=index

# .SECONDARY: with no prerequisites causes all targets to be treated as secondary (i.e., no target is removed because it is considered intermediate)
.SECONDARY:

default: a4

a4: $(BASE)-$(A4_SUF).pdf

letter: $(BASE)-$(LETTER_SUF).pdf

tex: $(BASE).pdf

# TODO:
# Issue: Presence of TOC content, \ref, \pageref elements, footnotes, etc, require two pdflatex invocations; presently must force manually via make <target> -B
# Resolution: dynamically detect these elements and then rerun pdflatex twice
# Nice-to-haves:
# - dynamically select between A4/letter quarter-page scaled dimension
# - tex extension for the latext primed texts instead of the .txt
# - more user friendly text-size management than the WIDTH/HEIGHT config variables
# - variables to include the occasionally used latex libraries in common.tex

# Basic, quarter-page version of book
%.pdf: %.txt %.$(DEFS_SUFFIX) $(COMMON_TEX)
	pdflatex -jobname $* "\def\MAINBODY{$<} \input{$*.$(DEFS_SUFFIX)} \input{$(COMMON_TEX)}"

# A5, booklet version with odd pages flipped 180
%-$(HALF_SHEET_SUF).pdf: %.pdf
	pdfjam $< --booklet true $(HALF_SHEET_DIM) --landscape --outfile $@

# A5, booklet version with odd pages rotated upright
%-$(HALF_SHEET_SUF)-rot.pdf: %-$(HALF_SHEET_SUF).pdf
	pdftk $< rotate 1-endoddsouth output $@

# if A5 booklet #pages % 4 != 0, insert two blank pages such that once split into A4/letter, even division.
# A5 with pages shuffled/collated to facilitate the final, 4 small pp/full page conversion
%-$(HALF_SHEET_SUF)-coll.pdf: %-$(HALF_SHEET_SUF)-rot.pdf
	PAGES=$(shell pdfinfo $< | sed -n 's/Pages:\s\+\(.*\)/\1/p'); \
	if ((( $$PAGES % 4 ) != 0 )); then \
		pdfjam $< '1-,{},{}' $(HALF_SHEET_DIM) --landscape --outfile $<.temp && \
		mv -f $<.temp $< && \
		PAGES=$$(( $$PAGES + 2 )); \
	fi; \
	MID_PG="$$(( $$PAGES / 2 ))"; \
	pdftk $< shuffle 1-"$$MID_PG" "$$(( $$MID_PG + 1 ))"-end output $@

# A4 final booklet
%-$(A4_SUF).pdf: %-$(HALF_SHEET_SUF)-coll.pdf
	pdfjam $< --nup 1x2  --a4paper -o $@

# Letter size final booklet
%-$(LETTER_SUF).pdf: HALF_SHEET_DIM=--papersize '{5.5in,8.5in}'
%-$(LETTER_SUF).pdf: %-$(HALF_SHEET_SUF)-coll.pdf
	pdfjam $< --nup 1x2 -o $@

clean:
	rm -i $(BASE)*.pdf

FORCE:

