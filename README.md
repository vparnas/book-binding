# book-binding
Printing those books compactly.

## Description
The solution, orchestrated via a Makefile, the Latex typesetting system, and a handful of PDF processing utilities (namely `pdfjam` and `pdftk`), generates A6/quarter-sheet bindings from public-domain texts or otherwise anything which the user has a right to print. It embeds these bindings onto full sheets, appropriately collated and ready for immediate printing on a regular household printer. At present, the binding is held via staples or the less elegant solutions discussed below.

The idea is for the text to spread compactly across the pages, superfluous white space eliminated, margins reduced and font minimal but still comfortable for reading. Each binding is accompanied by a configuration file enabling the overriding of numerous sizing and formatting options, customizing the title page with an optional background graphic, and triggering the Table of Contents. Otherwise, very little space is wasted, the reader choosing what to include from the source material.

## Business case
Public domain texts, though subject to country-specific regulation, tend to constitute works over a certain age - a hundred years in the US. Without detailing the full implications of *public domain*, these texts, in short, can be downloaded and used as you will for non-commercial purposes, or with certain constraints commercially that I shall here not detail.

It is my assumption that paper book readers still span great numbers, and that a substantial portion of them reads books in the public domain. The solution enables this audience to compact their reading to a miniature binding weighing *between one and two ounces*, easily manageable in the palm of a hand and squeezable into the tightest of confines like a pants pocket or a belt pouch. Also, the ability to house a small library within a shoebox proves an asset under confined spacial considerations.

More generally, the solution caters to any text you want as a mini-booklet and not a  stack of full sheets.

Economy-wise, for texts sufficiently compact, the solution yields cost savings over acquiring the public domain text from commercial outlets, particularly when sold new.

Now given all the present constraints: the manual labor involved in the latex priming of the downloaded source text, the further labor for printing, cutting, folding and stapling - all that together is easily justified given the amount of time we spend with that book and the physical advantage gained in the compactness. Considering the time we otherwise spend acquiring that book from commercial outlets, the net incremental labor might not amount to all that much.

[^NOTE]: priming - anywhere from 10-30 minutes per my experience, once accustomed to the process

## Constraints

### Text Length

Provided these bindings are held together by regular staples and not an alternative mechanism such as paper-clips (described below) or untried methods: the texts lending to a single binding are on the compacter range of upwards to ~35000 words for prose - that's eight-nine physical sheets, or 64-72 mini (quarter) pages (a full sheet equates to eight booklet pages across both sides). That's because the full sheets are sliced in half, the two half-sheet stacks collated, folded, and stapled across what is now double the width. 

So using at least a regular hand stapler, I'm unable to join any quantity of pages beyond that. Now should you have access to a more industrial stapler, the page count *can* expand, but not by much, as a stack of only so many sheets can be folded before it becomes too ... what's the word ... ungainly?

That word count limitation further decreases for poetry and drama, those formats subject to sparser formatting (frequent line breaks, stanza groupings, labels and whatnot). Though ultimately the user, as an 'editor' and primer of texts, bears significant control over the process.

To provide a frame of reference, examples of texts suitable to these constraints, many of which I've either printed or prepared the PDFs, include:

- Three of Marcelle Schwob's story collections.
- Arthur Rimbaud's *Une Saison en Enfer* and *Illuminations*
- Edward Spenser's *Amoretti* (88 sonnets, with notes)
- Paul Verlaine's *Poemes Saturniens*
- Voltaire's *Candide* and *Zadig* (short novels)
- Borges' *Nueve Ensayos Dantescos*
- Edgar Poe's *Eureka* (71 mini pages, over 37000 words at minimal font)
- Thomas Nashe - *The Unfortunate Traveller*
- Guillaume Apollinaire - *Alcools*
- Dante's *Commedia*, all three books in six printings (original old-Italian, without commentary).

Much of Shakespearean or Molierean drama also reduces to the above constraints.

You get the idea. Shorter novels/novellas, poetry/story collections, drama, or whatever you can segment into the width constraints.

**Mitigation strategy**

Should you wish to print larger texts: split bindings into one, two, or however many segments of tractable width each. The space consumed by even four such booklets (not that there's a need to carry but one at a time) is still compacter than most of even the smallest commercial paperback bindings.

The entire Dante's *Commedia* without translations or commentary, I've primed into six booklets, each at only about 60-70% width capacity (per the said stapling constraints), hence two booklets for each of the three volumes. I've seen commercial bindings of this work (with substantial commentary, granted) sizeable enough to occupy a backpack.

### Manual Latex Priming

**Plain-text source**

I've chosen to work with the plain text versions of public-domain texts. The HTML counterparts I deemed too complex to convert to Latex, which would require substantial cutting/manipulating of HTML elements. And I wasn't satisfied with the output of the automated conversion tools for this purpose (Pandoc), though that's not to say there isn't opportunity. Meanwhile, the plain text versions are already 99% aligned with the final Latex output we want for these minimalist bindings.

That 1%, however, complicates automation effort. Though there's a narrow but real automation target in the middle, everything around still requires some manual labor and judgment:

1. Operations like stripping the boilerplate header/footer texts (from public-domain repositories as Gutenberg) are trivial.

1. Converting emphasized text blocks between formats, even manually, is a quick regex/search-replace procedure.

1. Plain text section dividers tend to comprise the usually isolated all-caps words and or numbers. These can be detected and automatically converted to latex `\section` and/or `\subsection` blocks, but requires human validation one way or another. Ultimately, numerous segmentation strategies exist across books, and a capitalized isolated line can contain a title, a subtitle, an epigraph, a dedication, or further elements not considered here.

1. The footnote structure varies too much per text and per era, and placement/formatting decisions affect page layout in ways only the human eye can judge.

1. Poetry - line wrap decisions, stanza grouping, whether a line continuation is intentional or a plain-text artifact - these complicate automation.

1. Drama - speaker labels, stage directions, verse vs. prose passages, act/scene hierarchy - same story.

1. Any text with unusual structure (epistolary novels, frame narratives, mixed prose/verse like *Une Saison en Enfer*) - formatting requires human judgement.

1. The source plain-text also includes its own TOC that must be stripped out in favor of the Latex-generated TOC with accurate page numbers computed during runtime.

That said, once accustomed to the process, the above can be handled in 10-30 minutes per text of largely prose; longer for non-uniform poetry and drama.

## The Current Pipeline

**(A) Public-Domain (project Gutenberg) text in the plain-text format**

**-->** (priming, manual labor, limited automation)

**(B) Latex formatted text**

- Section labels for parts/chapters and TOC generation
- Directives for footnotes and emphasized (italic) text
- occasional tinkering to accommodate compacter printing;

**Config file** (to accompany each text)

- book metadata, formatting options, mini-page size, font, optional TOC, etc ...

**-->**

**(C) Quarter-sheet pdf**
- Here you gage what the final output will look like, check formatting, verify the page count.

**-->**

**(D) Half-sheet pdf** - an intermediary output consisting of two quarter-sheets per page.

**-->**

**(E) Full-page pdf** - the final output containing four quarter-pages per each full page. Ready for printing.

### Alternative, shorter pipeline

Take any existing small-page pdf (not necessarily yet A6/quarter-page size), or even some larger-page text (of particularly large font) reducible to a quarter-sheet. Apply manual cutting (via pdfjam or similar) to further compact. This becomes your input **C** directly, to feed into stage **D**.

## Printing/binding process
- Print your final (stage **E**) full-page 'multiplexed' pdf, verifying the preview to mitigate any superfluous borders.

- Cut resulting full pages in half across the width via one of
    1. hand folding and tearing. *
    1. hand folding and scissor cut, this usually resulting in imperfections *
    1. Paper cutter if available

    \* Proceed in smaller batches to avoid mishaps
- Fold the resulting half-sheet stacks in half, length-wise.

- Combine all the above into a booklet, verifying page numbers. The lower stack should immediately proceed the upper.

- Two staples somewhere across the upper and lower parts of the 'spine' - challenging with a regular hand-stapler for lack of reach to the spine across the quarter-page width - but doable - requires crafty folding to accomodate.

- Alternative, sloppy, paper-clip solution: should the width surpass the 'stapalable' constraints, hold one side of the pages together by paper clips - one above, one below, close to the center on the side of the book obviously *not* read at the time. The bindings are small and light enough anyway that it's not much of a structural issue.

## Ideas/improvements
- Automate in whole or part the Latex priming of the Gutenberg plain text (or compatible) with predictable structure.
- Improve the printing/binding process.
- A longer/better/industrial stapler.
- An alternative binding method of comparable or improved efficiency to stapling, accessible via non-specialized and easily available tools, and removing or at least not further constricting the stapling-width limitation.
- A5/half-US-Letter-size printing to eliminate the sheet cutting process

## References

- [Project Gutenberg](https://www.gutenberg.org/) — primary source for public-domain texts
- [Standard Ebooks](https://standardebooks.org/) — carefully formatted, modernized public-domain editions
- [The LaTeX Project](https://www.latex-project.org/) — typesetting system used to format and compile texts
- [pdfjam](https://github.com/rrthomas/pdfjam) — PDF page layout and imposition utility
- [pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/) — PDF manipulation toolkit
- [Public Domain: Overview (Cornell)](https://copyright.cornell.edu/publicdomain) — clear reference on what constitutes public domain, with US-centric detail
- [Creative Commons — Public Domain](https://creativecommons.org/share-your-work/public-domain/) — accessible introduction to the concept
- [Copyright Term and the Public Domain (Cornell chart)](https://copyright.cornell.edu/sites/default/files/2024-09/Copyright_Term_and_the_Public_Domain.pdf) — authoritative year-by-year reference for US public domain eligibility
