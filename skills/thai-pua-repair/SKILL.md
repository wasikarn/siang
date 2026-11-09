---
name: thai-pua-repair
description: "Thai PDF text repair: text extracted from a Thai PDF shows private-use glyphs (U+F700..U+F71D), broken tone marks or vowels, so search, copy or RAG fails. Fixes the extracted text, or the PDF file itself when asked."
---

# Thai PDF text repair

Old Windows UPC fonts (DilleniaUPC, AngsanaUPC, BrowalliaUPC, CordiaUPC) draw a raised tone mark or a tail-less ญ/ฐ with a private-use glyph, so the page looks right while the extracted text is wrong. `scripts/pua_fix.py` maps each glyph back to its standard Thai character.

## The loop

1. **Detect.** Extract the text: `pdftotext -enc UTF-8 <pdf> <out.txt>`, then run `python3 "${CLAUDE_SKILL_DIR}/scripts/pua_fix.py" --check <out.txt>`.
   Done when: the report names how many characters are mapped (exit 1 means the bug is present, exit 0 means nothing to fix).
2. **Fix.** `python3 "${CLAUDE_SKILL_DIR}/scripts/pua_fix.py" <out.txt> > fixed.txt`.
   Done when: `fixed.txt` exists and the report line is read in full.
3. **Verify.** For each distinct codepoint the report counted, read three words from `fixed.txt` around it and confirm each is valid Thai; then run `--check` on `fixed.txt`.
   Done when: every mapped codepoint has three words read and `--check` exits 0. Exit 2 means private-use characters remain unmapped (U+F71B..U+F71D, or another font's set): list them, with a few contexts, as unverifiable and leave them in place.
4. **Repair the PDF** (only when the user wants the file fixed, not just its text). `python3 "${CLAUDE_SKILL_DIR}/scripts/pua_pdf.py" in.pdf out.pdf` rewrites each font's ToUnicode map; it needs `pip install pikepdf` (the script exits 3 without it). Page content and fonts are untouched, so the page renders the same.
   Done when: `pdftotext` on `out.pdf` equals the `pua_fix.py` output of the original, and a render of the pages (`pdftoppm -r 40`) is byte-identical to the original's.
5. **Report.** State the counts, any unmapped codepoints with contexts, and whether the PDF file was repaired (without step 4, its copy-paste and other tools still see the old glyphs).

The table comes from HarfBuzz and OpenJDK shaping code, which agree on all 27 rows U+F700..U+F71A, and 15 rows were also read from real PDFs.
