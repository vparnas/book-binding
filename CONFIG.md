# Config

**In Progress**

| Variable name | Explanation | Example |
|---|---|---|
| AUTHOR | **required** | Voltaire |
| PREAUTHOR | What precedes the author; more common historically. | By |
| TITLE | The book title to appear on the cover page, **required**, can be multiline | CANDIDE, <br> ou <br> L’OPTIMISME |
| TITLEBODY| The optional detail to follow the title, can be multiline | TRADUIT DE L’ALLEMAND <br>DE M. LE DOCTEUR RALPH,<br>AVEC LES ADDITIONS<br> QU’ON A TROUVÉES DANS LA POCHE DU DOCTEUR, LORSQU’IL MOURUT<br> À MINDEN, L’AN DE GRÂCE 1759 |
| DATE | Publishing date | 1759 |
| ALTTT | If uncommented, use the latex ALTTT environment, ie, for poetry. Value doesn't matter. | |
| TOC | If uncommented, generate TOC. If value set, overrides the default *Table of Contents*. | Table des Matières |
| HEADERSIZE | The header margin height; see `common.tex` for default. | 0.5in |
| FOOTERSIZE | The footer margin height; see `common.tex` for default. | 0.3in |
| INNER | The inner margin width; see `common.tex` for default. | 0.2in |
| OUTER | The outer margin width; see `common.tex` for default. | 0.2in |
| FOOTERSIZE | The footer margin height; see `common.tex` for default. | 0.3in |
| WIDTH | The [width](#virtual_page) of the single-page PDF | 142mm |
| HEIGHT | The [height](#virtual_page) of the single-page PDF | 200mm |
| PAGESTYLE | The latex \\pagestyle is set to this, if uncommented | headings |
| PDFSUBJECT | If defined, populates the PDF metadata | |
| PDFKEYWORDS | If defined, populates the PDF metadata | |

## On virtual page dimensions (WIDTH/HEIGHT) <a name='virtual_page'></a>

Rather than adjusting the text size, which the default Latex implementation restricts to a minimum of `10pt`, we instead increase the *virtual* page dimensions appropriately to fit more text. The solution will eventually shrink these *virtual* pages to an actual quarter-sheet size once embedded within the full-sheet PDF, effectively reducing the text size of the end-result.

With A4 printing, for instance, in order to decrease text size and fit more text, rather than setting the virtual (quarter) page dimensions each to half of the A6, we expand them by, say, ten percent (resulting in roughly a 21% area increase). Now once this 'enlarged' A6 PDF is collated onto the pages of a full A4 PDF, the mini-pages are each compacted to a quarter-size anyway, with effectively smaller text.

See the following table for dimensional references of both the international and US-based sizes.

**Table of Dimensions**

| Name | Dimension (mm) | Dimensions (in) | Comments \* |
|---|---|---|---|
| US Letter | 216 × 279 mm | 8.5 x 11 in ||
| 1/2L | 140 x 216 mm | 5.5 x 8.5 in ||
| 1/4L | 108 x 140 mm | 4.3 x 5.5 in ||
| 1/4L*1.10 | 119 x 154 mm | ||
| 1/4L*1.15 | 124 x 161 mm | ||
| 1/4L*1.25 | 135 x 175 mm | ||
| 1/4L*1.35 | 145 x 188 mm | ||
| A4 | 210 x 297 mm | 8.3 x 11.7 in ||
| A5 | 148 x 210 mm | 5.8 x 8.3 in ||
| A6: | 105 x 148 mm | 4.1 x 5.8 in (297.638 x 419.528 pts) | Text size too large and unnecessarily increases page count.|
| A6*1.10 | 116 x 163 mm | | Comfortable text size, almost too large. |
| A6*1.15 | 121 x 170 mm | | Comfortable text size. |
| A6*1.25 | 131 x 185 mm | | A small, but comfortably sized text. |
| A6*1.35 | 142 x 200 mm | | Text too small for some; use to reduce page count or squeeze two-column verse |
| Lulu pocket book | 108 x 175 | |

\* Of the writer's opinion.
