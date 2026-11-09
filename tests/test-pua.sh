#!/usr/bin/env bash
# skills/thai-pua-repair/scripts/pua_fix.py maps every known Windows Thai private-use glyph, reports
# the ones it cannot map instead of guessing, and keeps ordinary Thai text byte-identical.
# Run from anywhere: bash tests/test-pua.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
fix="$root/skills/thai-pua-repair/scripts/pua_fix.py"
fail=0
ok()  { echo "PASS $1"; }
bad() { echo "FAIL $1"; fail=1; }

# Words from real Thai PDFs: PUA tone mark after the consonant must come back as the standard mark.
got=$(printf 'ไม\xef\x9c\x8a ให\xef\x9c\x8b ปัจจัย' | python3 "$fix" 2>/dev/null)
[ "$got" = "$(printf 'ไม\xe0\xb9\x88 ให\xe0\xb9\x89 ปัจจัย')" ] && ok "tone marks F70A/F70B become ่ ้" || bad "tone marks F70A/F70B become ่ ้ (got: $got)"

# All 27 mapped rows, checked against the HarfBuzz/OpenJDK table values.
python3 - "$fix" <<'PY' || fail=1
import importlib.util, sys
spec = importlib.util.spec_from_file_location("pua_fix", sys.argv[1]); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
expect = {0xF700:0x0E10,0xF701:0x0E34,0xF702:0x0E35,0xF703:0x0E36,0xF704:0x0E37,0xF705:0x0E48,0xF706:0x0E49,0xF707:0x0E4A,
 0xF708:0x0E4B,0xF709:0x0E4C,0xF70A:0x0E48,0xF70B:0x0E49,0xF70C:0x0E4A,0xF70D:0x0E4B,0xF70E:0x0E4C,0xF70F:0x0E0D,0xF710:0x0E31,
 0xF711:0x0E4D,0xF712:0x0E47,0xF713:0x0E48,0xF714:0x0E49,0xF715:0x0E4A,0xF716:0x0E4B,0xF717:0x0E4C,0xF718:0x0E38,0xF719:0x0E39,0xF71A:0x0E3A}
bad = [hex(k) for k, v in expect.items() if m.fix(chr(k)) != chr(v)]
print("PASS all 27 rows map" if not bad and len(m.MAP) == 27 else "FAIL rows: %s, table size %d" % (bad, len(m.MAP)))
sys.exit(1 if bad or len(m.MAP) != 27 else 0)
PY

# U+F71B has no known mapping: stays in the text, is reported, exit 2.
set +e
printf 'a\xef\x9c\x9bb' | python3 "$fix" >/dev/null 2>"${TMPDIR:-/tmp}/pua-err.$$"; code=$?
set -e
[ "$code" = 2 ] && grep -q 'U+F71B x1' "${TMPDIR:-/tmp}/pua-err.$$" && ok "unmapped U+F71B reported, exit 2" || bad "unmapped U+F71B reported, exit 2 (exit $code)"
python3 -c "import os,sys; os.remove(sys.argv[1])" "${TMPDIR:-/tmp}/pua-err.$$"

# Ordinary Thai passes through untouched; --check exits 0 clean and 1 when the bug is present.
plain=$(printf 'สวัสดีครับ' | python3 "$fix" 2>/dev/null)
[ "$plain" = "สวัสดีครับ" ] && ok "plain Thai unchanged" || bad "plain Thai unchanged"
printf 'สวัสดี' | python3 "$fix" --check 2>/dev/null && ok "--check clean exits 0" || bad "--check clean exits 0"
set +e; printf 'ไม\xef\x9c\x8a' | python3 "$fix" --check >/dev/null 2>&1; code=$?; set -e
[ "$code" = 1 ] && ok "--check finds the bug, exit 1" || bad "--check finds the bug, exit 1 (exit $code)"
set +e; printf 'ไม\xef\x9c\x8a หมาย\xef\x9c\x9b' | python3 "$fix" --check >/dev/null 2>&1; code=$?; set -e
[ "$code" = 2 ] && ok "--check with mapped and unmapped glyphs, exit 2" || bad "--check with mapped and unmapped glyphs, exit 2 (exit $code)"

# ToUnicode rewriting (pua_pdf.py fix_cmap is pure text, so it needs no pikepdf or PDF).
python3 - "$root/skills/thai-pua-repair/scripts/pua_pdf.py" <<'PY' || fail=1
import importlib.util, sys
spec = importlib.util.spec_from_file_location("pua_pdf", sys.argv[1]); m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
cm = """1 begincodespacerange <0000> <00ff> endcodespacerange
2 beginbfchar
<0072> <F70E>
<0073> <F71B>
endbfchar
3 beginbfrange
<006e> <006f> <F70A>
<0010> <0012> <F70F>
<0020> <0021> <0E01>
endbfrange
endcmap"""
out, n = m.fix_cmap(cm)
checks = {
    "bfchar F70E becomes U+0E4C": "<0072> <0E4C>" in out,
    "unmapped F71B stays": "<0073> <F71B>" in out,
    "consecutive range F70A..F70B stays one range at 0E48": "<006e> <006f> <0E48>" in out,
    "non-consecutive range becomes bfchar entries": all(x in out for x in ("<0010> <0E0D>", "<0011> <0E31>", "<0012> <0E4D>")) and "<0010> <0012>" not in out,
    "plain Thai range untouched": "<0020> <0021> <0E01>" in out,
    "section counts match entries": "2 beginbfrange" in out and "3 beginbfchar" in out,
    "no mapped PUA left": not any(c in out.upper() for c in ("<F70", "<F71A", "<F710", "<F711", "<F712")),
}
checks["reported count is the 6 mapped glyphs (1 bfchar, 2 + 3 in ranges)"] = n == 6
ws, nws = m.fix_cmap("2 beginbfchar\n<41> <0E 01>\n<42> <F70A>\nendbfchar\nendcmap")
checks["whitespace inside a hex string keeps the character"] = "<41> <0E01>" in ws and "<42> <0E48>" in ws and nws == 1
cmt, _ = m.fix_cmap("2 beginbfchar\n<41> <0E21>\n<42> <F70A>\n% obsolete <42> <F70B>\nendbfchar\nendcmap")
checks["a % comment adds no mapping"] = "<42> <0E48>" in cmt and "0E49" not in cmt and "<41> <0E21>" in cmt
hdr = "/CIDSystemInfo << /Registry (Adobe%Compat) /Ordering (UCS) /Supplement 0 >> def\n1 beginbfchar\n<41> <F70A>\nendbfchar\nendcmap"
hout, _ = m.fix_cmap(hdr)
checks["CMap header outside the mapping sections is untouched"] = "/CIDSystemInfo << /Registry (Adobe%Compat) /Ordering (UCS) /Supplement 0 >> def" in hout and "<41> <0E48>" in hout
_, nlow = m.fix_cmap("1 beginbfchar\n<41> <0e01>\nendbfchar\nendcmap")
checks["a hex-case change is not counted"] = nlow == 0
for k, v in checks.items():
    print(("PASS " if v else "FAIL ") + "ToUnicode: " + k)
sys.exit(0 if all(checks.values()) else 1)
PY

[ "$fail" -eq 0 ] || exit 1
