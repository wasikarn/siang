#!/usr/bin/env python3
"""Replace Windows Thai private-use glyphs (U+F700..U+F71A) with standard Thai Unicode.

Old UPC fonts (DilleniaUPC, AngsanaUPC, ...) store raised or lowered tone marks and vowels as
private-use codepoints, so a PDF looks right but its extracted text is wrong.

Usage: pua_fix.py [--check] [FILE ...]   (stdin when no FILE)
  fixed text goes to stdout, a one-line report to stderr.
  --check   report only; exit 1 when mapped PUA characters are present.
Exit codes: 0 clean or fixed, 1 --check found PUA, 2 unmapped private-use characters remain.

Table: HarfBuzz hb-ot-shaper-thai.cc thai_pua_shape and OpenJDK ThaiShaping.cpp agree on every
row; 15 rows were also read from the words of two real PDFs. U+F71B..U+F71D (inside the UPC range)
have no known mapping and are reported, never guessed.
"""
import sys
from collections import Counter

MAP = {
    0xF700: 0x0E10, 0xF701: 0x0E34, 0xF702: 0x0E35, 0xF703: 0x0E36, 0xF704: 0x0E37,
    0xF705: 0x0E48, 0xF706: 0x0E49, 0xF707: 0x0E4A, 0xF708: 0x0E4B, 0xF709: 0x0E4C,
    0xF70A: 0x0E48, 0xF70B: 0x0E49, 0xF70C: 0x0E4A, 0xF70D: 0x0E4B, 0xF70E: 0x0E4C,
    0xF70F: 0x0E0D, 0xF710: 0x0E31, 0xF711: 0x0E4D, 0xF712: 0x0E47, 0xF713: 0x0E48,
    0xF714: 0x0E49, 0xF715: 0x0E4A, 0xF716: 0x0E4B, 0xF717: 0x0E4C, 0xF718: 0x0E38,
    0xF719: 0x0E39, 0xF71A: 0x0E3A,
}


def fix(text):
    return text.translate(MAP)


def leftover(text):
    """Private-use characters (BMP PUA) still in text, as a Counter of codepoints."""
    return Counter(ord(c) for c in text if 0xE000 <= ord(c) <= 0xF8FF)


def main(argv):
    check = "--check" in argv
    files = [a for a in argv if a != "--check"]
    text = "".join(open(f, encoding="utf-8").read() for f in files) if files else sys.stdin.read()
    mapped = sum(1 for c in text if ord(c) in MAP)
    out = fix(text)
    left = leftover(out)
    if not check:
        sys.stdout.write(out)
    note = "pua_fix: %d mapped" % mapped
    if left:
        note += "; unmapped: " + ", ".join("U+%04X x%d" % (cp, n) for cp, n in sorted(left.items()))
    print(note, file=sys.stderr)
    if left:
        return 2
    return 1 if check and mapped else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
