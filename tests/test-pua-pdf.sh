#!/usr/bin/env bash
# End to end: build a tiny PDF whose ToUnicode maps a code to a Windows Thai PUA glyph, run
# skills/thai-pua-repair/scripts/pua_pdf.py on it, and read the text back with pdftotext. Needs pikepdf
# and poppler's pdftotext; without either, the test says SKIP and exits 0 (CI installs both).
# Run from anywhere: bash tests/test-pua-pdf.sh   (PYTHON=/path/to/python to pick a venv)
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
py=${PYTHON:-python3}
if ! "$py" -c 'import pikepdf' 2>/dev/null; then echo "SKIP pikepdf not installed"; exit 0; fi
command -v pdftotext >/dev/null || { echo "SKIP pdftotext not installed"; exit 0; }
work=$(mktemp -d)
trap 'python3 -c "import shutil,sys; shutil.rmtree(sys.argv[1])" "$work"' EXIT

"$py" - "$work/in.pdf" <<'PY'
import sys, pikepdf
pdf = pikepdf.new()
cmap = b"""/CIDInit /ProcSet findresource begin 12 dict begin begincmap
/CMapName /T def /CMapType 2 def
1 begincodespacerange <00> <ff> endcodespacerange
2 beginbfchar
<41> <F70A>
<42> <F71B>
endbfchar
endcmap CMapName currentdict /CMap defineresource pop end end"""
font = pdf.make_indirect(pikepdf.Dictionary(Type=pikepdf.Name.Font, Subtype=pikepdf.Name.Type1,
    BaseFont=pikepdf.Name.Helvetica, ToUnicode=pdf.make_stream(cmap)))
page = pdf.add_blank_page(page_size=(200, 100))
page.Resources = pikepdf.Dictionary(Font=pikepdf.Dictionary(F1=font))
page.Contents = pdf.make_stream(b"BT /F1 24 Tf 20 40 Td (AB) Tj ET")
pdf.save(sys.argv[1])
PY

text() { pdftotext -enc UTF-8 "$1" - | tr -d '\n\f'; }
before=$(text "$work/in.pdf")
set +e; "$py" "$root/skills/thai-pua-repair/scripts/pua_pdf.py" "$work/in.pdf" "$work/out.pdf" 2>"$work/err"; code=$?; set -e
after=$(text "$work/out.pdf")
fail=0
[ "$before" = "$(printf '\xef\x9c\x8a\xef\x9c\x9b')" ] && echo "PASS fixture reads as PUA before (U+F70A U+F71B)" || { echo "FAIL fixture before: $before"; fail=1; }
[ "$code" = 0 ] && echo "PASS pua_pdf.py exits 0" || { echo "FAIL pua_pdf.py exit $code: $(cat "$work/err")"; fail=1; }
[ "$after" = "$(printf '\xe0\xb9\x88\xef\x9c\x9b')" ] && echo "PASS mapped glyph becomes ่, unmapped U+F71B stays" || { echo "FAIL after: $after"; fail=1; }
[ "$fail" -eq 0 ] || exit 1
