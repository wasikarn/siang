#!/usr/bin/env bash
python3 - <<'PY'
import zlib
N = 12
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
lines = b"".join(b"BT /F%d 14 Tf 10 %d Td (abacdefg) Tj ET\n" % (i, 20 + 14 * i) for i in range(1, N + 1))
objs = [b"<< /Type /Catalog /Pages 2 0 R >>", b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>"]
fonts = " ".join("/F%d %d 0 R" % (i, 5 + 2 * (i - 1)) for i in range(1, N + 1))
objs.append(("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 200 220] /Contents 4 0 R /Resources << /Font << %s >> >> >>" % fonts).encode())
c = zlib.compress(lines)
objs.append(b"<< /Length %d /Filter /FlateDecode >>\nstream\n" % len(c) + c + b"\nendstream")
z = zlib.compress(cmap)
for i in range(1, N + 1):
    objs.append(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /ToUnicode %d 0 R >>" % (6 + 2 * (i - 1)))
    objs.append(b"<< /Length %d /Filter /FlateDecode >>\nstream\n" % len(z) + z + b"\nendstream")
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
open("check.txt", "w", encoding="utf-8").write("มม\n" * N)
PY
