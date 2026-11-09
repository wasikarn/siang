#!/usr/bin/env bash
python3 - <<'PY'
cmap = b"""/CIDInit /ProcSet findresource begin 12 dict begin begincmap
/CMapName /T def /CMapType 2 def
1 begincodespacerange <00> <ff> endcodespacerange
2 beginbfchar
<61> <0E21>
<67> <F71B>
endbfchar
2 beginbfrange
<62> <63> <F70A>
<64> <66> <F70F>
endbfrange
endcmap CMapName currentdict /CMap defineresource pop end end"""
content = b"BT /F1 18 Tf 20 60 Td (abacdefg) Tj ET"
objs = [
    b"<< /Type /Catalog /Pages 2 0 R >>",
    b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
    b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 240 100] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >>",
    b"<< /Length %d >>\nstream\n" % len(content) + content + b"\nendstream",
    b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /ToUnicode 6 0 R >>",
    b"<< /Length %d >>\nstream\n" % len(cmap) + cmap + b"\nendstream",
]
out = b"%PDF-1.4\n"
offs = []
for i, o in enumerate(objs, 1):
    offs.append(len(out))
    out += b"%d 0 obj\n" % i + o + b"\nendobj\n"
x = len(out)
out += b"xref\n0 %d\n0000000000 65535 f \n" % (len(objs) + 1)
for o in offs:
    out += b"%010d 00000 n \n" % o
out += b"trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n" % (len(objs) + 1, x)
open("in.pdf", "wb").write(out)
open("check.txt", "w", encoding="utf-8").write("มม\n")
PY
