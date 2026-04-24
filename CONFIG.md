# Config

**In Progress**

| Variable name | Explanation | Example |
|---|---|---|
| AUTHOR | | Voltaire |
| PREAUTHOR | The prefix before the author, used historically; comment out if unused | By |
| TITLE | Can be multiline (\\n for display purposes) | CANDIDE, \\n ou \\n L’OPTIMISME |
| TITLEBODY| What follows the author, can be multiline (\\n for display purposes) | TRADUIT DE L’ALLEMAND \\nDE M. LE DOCTEUR RALPH,\\nAVEC LES ADDITIONS\\n QU’ON A TROUVÉES DANS LA POCHE DU DOCTEUR, LORSQU’IL MOURUT\\n À MINDEN, L’AN DE GRÂCE 1759 |
| DATE | | 1759 |
| ALTTT | If uncommented, use the latex ALTTT environment, ie, for poetry. Value doesn't matter. | |
| TOC | If uncommented, generate TOC. If value set, this becomes the contents title over the default Table of Contents. | Table des Matières |
| HEADERSIZE | The header margin height; see `common.tex` for default. | 0.5in |
| FOOTERSIZE | The footer margin height; see `common.tex` for default. | 0.3in |
| INNER | The inner margin width; see `common.tex` for default. | 0.2in |
| OUTER | The outer margin width; see `common.tex` for default. | 0.2in |
| FOOTERSIZE | The footer margin height; see `common.tex` for default. | 0.3in |
| WIDTH | The width of the single-page PDF \* | 142mm |
| HEIGHT | The height of the single-page PDF \* | 200mm |
| PAGESTYLE | The latex \\pagestyle is set to this, if uncommented | headings |
| PDFSUBJECT | If defined, populates the PDF metadata | |
| PDFKEYWORDS | If defined, populates the PDF metadata | |

## On virtual page dimensions (WIDTH and HEIGHT variables) \*

Rather than adjusting the font size for our mini-binding pages (let's call these *virtual* pages), which the default Latex implementation restricts to a minimum of `10pt`, we instead increase the dimensions appropriately to fit more text. The solution will eventually shrink these *virtual* pages to an actual quarter-sheet size once embedded within the full-sheet PDF, effectively reducing the font size in the end-result.

**Varying virtual page dimensions, for reference**

| Name | Dimension (mm) | Notes |
|---|---|---|
| Letter | 216 × 279 mm | 8.5 x 11 in |
| 1/2L | 140 x 216 mm | 5.5 x 8.5 in |
| 1/4L | 108 x 140 mm | 4.3 x 5.5 in |
| 1/4L*1.10 | 119 x 154 mm | |
| 1/4L*1.15 | 124 x 161 mm | |
| 1/4L*1.25 | 135 x 175 mm | |
| 1/4L*1.35 | 145 x 188 mm | |
| A4 | 210 x 297 mm | 8.3 x 11.7 in |
| A5 | 148 x 210 mm | 5.8 x 8.3 in |
| A6: | 105 x 148 mm | 4.1 x 5.8 in (297.638 x 419.528 pts) |
| A6*1.10 | 116 x 163 mm | To use less and the font size can appear too large for many. |
| A6*1.15 | 121 x 170 mm | |
| A6*1.25 | 131 x 185 mm | ideally the maximum (smallest sized text) for prose |
| A6*1.35 | 142 x 200 mm | text too small for some; use to reduce page count or squeeze two-column verse | |
| Lulu pocket book | 108 x 175 | |
