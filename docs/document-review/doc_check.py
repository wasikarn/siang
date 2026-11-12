#!/usr/bin/env python3
"""Mechanical checks on a Markdown record (SOP, runbook, policy, spec), as candidates for a reviewer.

Usage: doc_check.py DOC.md [--sections "Purpose,Prerequisites,Procedure"]   (DOC may be - for stdin; relative
links are then checked against the current folder, so pass the file path when the document has them)

Prints JSON {"file", "counts", "findings": [{"check", "line", "quote", "detail"}]}. Checks:
  xref             "section N", "§N" or "step N" that matches no numbered heading or list item; Markdown links
                   to a missing #anchor or a missing relative file
  heading-number   numbered headings that skip, repeat or go backwards among siblings
  list-number      a numbered list that skips, repeats, goes backwards or does not start at 1
  quantity-conflict  two time or size quantities that share a context word but differ in value
                   (30 minutes vs 30 s next to the word "wait")
  duration-no-unit  "wait 30" with no unit after the number
  acronym          an all-caps token never expanded in parentheses
  date             impossible ISO dates, and more than one date format in one document
  section          with --sections: a required heading that is missing or out of order

It finds candidates only; a reviewer decides which are real. Fenced code blocks and inline code are skipped.
Limits (shortcut: line-based, no real Markdown parse; upgrade to a parser if lists or code blocks get missed):
nesting is read from indentation; indented (4-space) code blocks are not skipped; lazy list numbering (every
item "1.") is accepted; a quantity pairs by shared neighbouring word, so unrelated numbers next to the same
word can pair up.
Exit: 0 ok, 1 bad arguments or unreadable file.
"""
import datetime
import json
import os
import re
import sys
from collections import Counter

TIME = {"ms": .001, "s": 1, "sec": 1, "secs": 1, "second": 1, "seconds": 1, "min": 60, "mins": 60, "minute": 60,
        "minutes": 60, "h": 3600, "hr": 3600, "hrs": 3600, "hour": 3600, "hours": 3600, "d": 86400, "day": 86400,
        "days": 86400}
SIZE = {"b": 1, "kb": 1e3, "mb": 1e6, "gb": 1e9, "tb": 1e12}
UNITS = {**{u: ("time", v) for u, v in TIME.items()}, **{u: ("size", v) for u, v in SIZE.items()}}
UNIT_RX = "|".join(sorted(UNITS, key=len, reverse=True))
QTY = re.compile(rf"(?<![\w.,-])(\d{{1,3}}(?:,\d{{3}})+(?:\.\d+)?|\d+(?:\.\d+)?)\s*({UNIT_RX})\b", re.I)  # 1,500 ms
STOP = set("the a an of to for and or in on at is are be then after before about every each up by with from "
           "this that it its into".split())
HEADING = re.compile(r"^(#{1,6})\s+(?:(\d{1,3}(?:\.\d+)*)\.?\s+)?(.*?)\s*#*\s*$")  # 4 digits: a year
ITEM = re.compile(r"^(\s*)(\d+)[.)]\s")
SECTION_REF = re.compile(r"(?:\bsections?|\bsec\.|§)\s*(\d+(?:\.\d+)*)", re.I)
STEP_REF = re.compile(r"\bsteps?\s+(\d+)\b", re.I)
LINK = re.compile(r"\]\(([^)\s]+)\)")
ACRO = re.compile(r"(?<![^\W\u0e00-\u0e7f])[A-Z]{2,6}(?![^\W\u0e00-\u0e7f])")  # a Thai letter is a boundary, É is not
# capitalised or all caps, whole word: "2 may fail", "3 decimals" are not dates
MONTHS = ("Jan(?:uary)?|Feb(?:ruary)?|Mar(?:ch)?|Apr(?:il)?|May|June?|July?|Aug(?:ust)?|Sep(?:t(?:ember)?)?|"
          "Oct(?:ober)?|Nov(?:ember)?|Dec(?:ember)?")
MONTHS_ANY = f"{MONTHS}|{MONTHS.upper()}"
MONTH_WORDS = re.compile(rf"(?:{MONTHS.upper()})")  # an all-caps month is not an acronym
DATE_KINDS = {"ISO": re.compile(r"\b\d{4}-\d{2}-\d{2}\b"), "slash": re.compile(r"\b\d{1,2}/\d{1,2}/\d{2,4}\b"),
              "month name": re.compile(rf"\b\d{{1,2}}\s+(?:{MONTHS_ANY})\.?(?!\w)|\b(?:{MONTHS_ANY})\.?\s+\d{{1,2}}\b"
                                       rf"|\b\d{{1,2}}\s+(?:{MONTHS.lower()})\s+\d{{4}}\b")}  # lowercase: only with a year
NO_UNIT = re.compile(r"\b(wait|timeout|within|every|delay|sleep)\s+(?:of\s+|for\s+)?(\d+(?:[.,]\d+)*)\s*(?:$|[.,;:)](?!\d))", re.I)


def slug(text):
    return re.sub(r"\s", "-", re.sub(r"[^\w\s\u0e00-\u0e7f-]", "", text.lower()).strip())  # keep Thai marks


def prose(text):
    """(line number, text) for every line outside fenced code, with inline code blanked."""
    out, fenced = [], False
    for no, line in enumerate(text.splitlines(), 1):
        if line.lstrip().startswith(("```", "~~~")):
            fenced = not fenced
        elif not fenced:
            out.append((no, re.sub(r"`[^`]*`", " ", line)))
    return out


def analyse(text, docdir, sections):
    lines = prose(text)
    found = []

    def add(check, no, quote, detail):
        found.append({"check": check, "line": no, "quote": quote.strip()[:120], "detail": detail})

    raw = text.splitlines()
    headings, item_nums, anchors, head_nums = [], set(), set(), set()
    for no, ln in lines:
        m = HEADING.match(ln)
        if m:
            num = m.group(2)
            if not num and (s := re.match(r"(?:section|sec\.|§)\s*(\d+(?:\.\d+)*)", m.group(3), re.I)):
                num = s.group(1)  # "## Section 3: Scope" is numbered 3
            headings.append((no, len(m.group(1)), num, m.group(3)))
            anchors.add(slug(raw[no - 1].strip().strip("#").strip()))  # raw: inline code is part of the anchor
            head_nums |= {num} if num else set()
        if (m := ITEM.match(ln)):
            item_nums.add(int(m.group(2)))

    last = {}  # parent prefix -> last sibling number
    for no, _, num, title in headings:
        if not num:
            continue
        parts = num.split(".")
        parent, n = ".".join(parts[:-1]), int(parts[-1])
        want = last.get(parent, 0) + 1
        if n != want:
            add("heading-number", no, f"{num} {title}", f"expected {(parent + '.' if parent else '') + str(want)}")
        last[parent] = n

    open_lists = {}  # indent -> last number of the list open at that indent
    for no, ln in lines:
        m = ITEM.match(ln)
        if HEADING.match(ln) or (ln.strip() and not m and not ln.startswith((" ", "\t"))):
            open_lists = {}
        if not m:
            continue
        indent, n = len(m.group(1)), int(m.group(2))
        open_lists = {i: v for i, v in open_lists.items() if i <= indent}  # deeper lists closed
        if indent not in open_lists:
            if n != 1:
                add("list-number", no, ln, f"list starts at {n}, not 1")
        elif n != open_lists[indent] + 1 and not (n == 1 and open_lists[indent] == 1):
            add("list-number", no, ln, f"item {n} follows {open_lists[indent]}")
        open_lists[indent] = n

    for no, ln in lines:
        for m in SECTION_REF.finditer(ln):
            if m.group(1) not in head_nums:
                add("xref", no, ln, f"section {m.group(1)} matches no numbered heading")
        for m in STEP_REF.finditer(ln):
            if int(m.group(1)) not in item_nums:
                add("xref", no, ln, f"step {m.group(1)} matches no numbered list item")
        for m in LINK.finditer(ln):
            tgt = m.group(1)
            if re.match(r"[a-z][a-z0-9+.-]*:", tgt, re.I):
                continue
            path, _, frag = tgt.partition("#")
            if not path and frag not in anchors:
                add("xref", no, ln, f"anchor #{frag} matches no heading")
            elif path and not os.path.exists(os.path.join(docdir, path)):
                add("xref", no, ln, f"file {path} does not exist")

    qtys = []
    for no, ln in lines:
        for m in QTY.finditer(ln):
            dim, mult = UNITS[m.group(2).lower()]
            before = re.findall(r"[A-Za-z]+", ln[:m.start()])[-1:]
            after = re.findall(r"[A-Za-z]+", ln[m.end():])[:1]
            ctx = {w.lower() for w in before + after} - STOP
            qtys.append((no, ln, dim, float(m.group(1).replace(",", "")) * mult, ctx, m.group(0)))
    for j, b in enumerate(qtys):
        for a in qtys[:j]:
            if a[2] == b[2] and a[4] & b[4] and abs(a[3] - b[3]) > 1e-9:
                add("quantity-conflict", b[0], b[1],
                    f"'{b[5]}' (line {b[0]}) vs '{a[5]}' (line {a[0]}) near '{sorted(a[4] & b[4])[0]}'")

    for no, ln in lines:
        if (m := NO_UNIT.search(ln)):
            add("duration-no-unit", no, ln, f"'{m.group(0).strip()}' has no unit")

    seen, expanded = {}, set(re.findall(r"\(([A-Z]{2,6})\)", text))
    for no, ln in lines:
        for m in ACRO.finditer(ln):
            if not MONTH_WORDS.fullmatch(m.group(0)):
                seen.setdefault(m.group(0), no)
            if re.match(r"\s*\(", ln[m.end():]):
                expanded.add(m.group(0))
    for a, no in seen.items():
        if a not in expanded:
            add("acronym", no, a, "used but never expanded in parentheses")

    kinds = Counter()
    for no, ln in lines:
        for kind, rx in DATE_KINDS.items():
            for m in rx.finditer(ln):
                kinds[kind] += 1
                if kind == "ISO":
                    try:
                        datetime.date.fromisoformat(m.group(0))
                    except ValueError:
                        add("date", no, ln, f"{m.group(0)} is not a real date")
    if len(kinds) > 1:
        add("date", 0, "", "more than one date format: " + ", ".join(f"{k} x{v}" for k, v in kinds.items()))

    if sections:
        pos = []
        for want in sections:
            hit = next((h[0] for h in headings if want.lower() in h[3].lower()), None)
            if hit is None:
                add("section", 0, want, "required section missing")
            else:
                pos.append((hit, want))
        order = [w for _, w in sorted(pos)]
        required = [w for w in sections if w in order]
        if order != required:
            add("section", 0, ", ".join(order), "sections out of the required order: " + ", ".join(required))
    return found


def main(argv):
    sections = None
    if "--sections" in argv:
        i = argv.index("--sections")
        if i + 1 >= len(argv):
            sys.exit("doc_check.py: --sections needs a comma-separated list")
        sections = [s.strip() for s in argv[i + 1].split(",") if s.strip()]
        argv = argv[:i] + argv[i + 2:]
    if len(argv) != 1:
        sys.exit(__doc__)
    path = argv[0]
    try:
        text = sys.stdin.read() if path == "-" else open(path, encoding="utf-8").read()
    except (OSError, UnicodeDecodeError) as e:
        sys.exit(f"doc_check.py: cannot read {path}: {getattr(e, 'strerror', None) or e}")
    found = analyse(text, "." if path == "-" else os.path.dirname(os.path.abspath(path)), sections)
    print(json.dumps({"file": path, "counts": dict(Counter(f["check"] for f in found)), "findings": found},
                     ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
