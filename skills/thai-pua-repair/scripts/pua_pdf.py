#!/usr/bin/env python3
"""Rewrite the ToUnicode maps of a PDF so Windows Thai private-use glyphs read as standard Thai.

Usage: pua_pdf.py IN.pdf OUT.pdf        (needs: pip install pikepdf)

Only each font's /ToUnicode stream changes; page content, fonts and layout stay as they were, so the
page renders the same while copy-paste, search and text extraction return standard Thai. Targets
that the table in pua_fix.py cannot map (U+F71B..U+F71D, other private-use sets) are left as they are.
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from pua_fix import MAP  # noqa: E402

HEX = r"<([0-9A-Fa-f]+)>"
SECTION = re.compile(r"(\d+)\s+begin(bfchar|bfrange)(.*?)end\2", re.S)
RANGE = re.compile(HEX + r"\s*" + HEX + r"\s*(<[0-9A-Fa-f]+>|\[[^\]]*\])")
CHAR = re.compile(HEX + r"\s*" + HEX)


def _dst(h):
    """Map each UTF-16 unit of a destination hex string through the PUA table."""
    units = [h[i:i + 4] for i in range(0, len(h), 4)]
    return "".join("%04X" % MAP.get(int(u, 16), int(u, 16)) if len(u) == 4 else u for u in units)


def _nmap(h):
    """How many UTF-16 units of a destination hex string the PUA table changes."""
    return sum(1 for i in range(0, len(h) - 3, 4) if int(h[i:i + 4], 16) in MAP)


def _clean(text):
    """Drop % comments and whitespace inside <hex> strings of a mapping section body, both legal in a CMap."""
    text = re.sub(r"%[^\r\n]*", "", text)
    return re.sub(r"<([0-9A-Fa-f\s]*)>", lambda m: "<" + re.sub(r"\s+", "", m.group(1)) + ">", text)


def _step(h, i):
    return "%0*X" % (len(h), int(h, 16) + i)


def _fix_range(lo, hi, dst):
    """Return (kept_range_lines, bfchar_pairs) for one bfrange entry."""
    if dst.startswith("["):
        items = re.findall(HEX, dst)
        return ["<%s> <%s> [%s]" % (lo, hi, " ".join("<%s>" % _dst(h) for h in items))], []
    base = dst[1:-1]
    n = int(hi, 16) - int(lo, 16) + 1
    want = [_dst(_step(base, i)) for i in range(n)]
    if want == [_step(base, i) for i in range(n)]:
        return ["<%s> <%s> <%s>" % (lo, hi, base)], []
    if want == [_step(want[0], i) for i in range(n)]:
        return ["<%s> <%s> <%s>" % (lo, hi, want[0])], []
    return [], [(_step(lo, i), want[i]) for i in range(n)]


def fix_cmap(text):
    """Return (new_text, number of destination characters the PUA table remapped)."""
    extra = []
    changed = [0]

    def section(m):
        kind, body = m.group(2), _clean(m.group(3))
        if kind == "bfchar":
            pairs = [(s, _dst(d)) for s, d in CHAR.findall(body)]
            changed[0] += sum(_nmap(d) for _, d in CHAR.findall(body))
            return "%d beginbfchar\n%s\nendbfchar" % (len(pairs), "\n".join("<%s> <%s>" % p for p in pairs))
        lines = []
        for lo, hi, dst in RANGE.findall(body):
            n = int(hi, 16) - int(lo, 16) + 1
            changed[0] += sum(_nmap(h) for h in re.findall(HEX, dst)) if dst.startswith("[") else sum(_nmap(_step(dst[1:-1], i)) for i in range(n))
            kept, chars = _fix_range(lo, hi, dst)
            lines += kept
            extra.extend(chars)
        return "%d beginbfrange\n%s\nendbfrange" % (len(lines), "\n".join(lines)) if lines else ""

    out = SECTION.sub(section, text)
    for i in range(0, len(extra), 100):  # a bfchar block holds at most 100 entries
        chunk = extra[i:i + 100]
        out = out.replace("endcmap", "%d beginbfchar\n%s\nendbfchar\nendcmap" % (
            len(chunk), "\n".join("<%s> <%s>" % p for p in chunk)), 1)
    return out, changed[0]


def main(argv):
    if len(argv) != 2:
        print(__doc__, file=sys.stderr)
        return 64
    try:
        import pikepdf
    except ImportError:
        print("pua_pdf: needs pikepdf (pip install pikepdf)", file=sys.stderr)
        return 3
    pdf = pikepdf.open(argv[0])
    fonts = changed = 0
    for obj in pdf.objects:
        if isinstance(obj, pikepdf.Dictionary) and obj.get("/Type") == "/Font" and obj.get("/ToUnicode") is not None:
            old = obj.ToUnicode.read_bytes().decode("latin-1")
            new, n = fix_cmap(old)
            if n:
                obj.ToUnicode.write(new.encode("latin-1"))
                fonts += 1
                changed += n
    pdf.save(argv[1])
    print("pua_pdf: %d font map(s) rewritten, %d character(s) remapped -> %s" % (fonts, changed, argv[1]), file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
