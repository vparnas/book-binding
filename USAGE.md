# Usage

**In Progress**

## Prepare the public domain plain text

```
$ ẁget ... -O book.txt
```
## Prime text for Latex

1. Rename/copy the text above to  ...

1. Remove the boilerplate header and footer.

1. Remove the embedded cover text (we'll generate this separately)

1. Convert emphasis blocks to from `_ ... _` to `\emph{ ... }`.Some suggestions:

    - In VIM (doesn't address the multi-line italics, handle these manually):

        ```VIM
        :%s/_\(.\{-\}\)_/\\emph{\1}/gc
        ```
1. Prime footnotes. Some suggestions with VIM search/replace:

    - convert inline [1] index and (start-of-line) [1] footnote content format to `\footnotemark[idx]`, `\footnotetext[idx]{content}` Latex format:

        ```VIM
        :%s/\v[^^]\zs\[\d+\]/\\footnotemark\0/gc
        % The {[}idx{]} format conversion:
        :%s/\v\{\[\}(\d+)\{\]\}/\\footnotemark[\1]/gc
        :%s/\v^(\[\d+\])\s((.{1,}\n)+)/\\footnotetext\1{\2}/gc
        ```
    - convert inline \*\* and \* to \footnotemark[2] and \footnotemark[1], and same with the footnote text underneath:

        ```VIM
        :%s/\v[^\[]\zs\*\*/\\footnotemark[2]/gc
        :%s/\v[^\[\*]\zs\*/\\footnotemark[1]/gc
        :%s/\v^\[\*\*\s(.*)\]/\\footnotetext[2]{\1}/gc
        :%s/\v^\[\*\s(.*)\]/\\footnotetext[1]{\1}/gc
        ```
1. Convert all uppercase section titles to Latex `\section` and/or `\subsection` blocks.

1. Remove/rectify '-' (hyphens) in section titles - these cause problems.

## Config file

## Execute the binding

