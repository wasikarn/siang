#!/usr/bin/env python3
"""Checks that a Thai summary follows the fixed template in SKILL.md.
Usage: summary_check.py SUMMARY.md   (- for stdin)
Prints JSON {"file", "findings": [{"check", "detail"}]}. Exit 0 when clean, 1 when there are findings, 2 on bad input (unreadable or not UTF-8).
Checks: missing / extra (any heading level) / out-of-order headings, an empty section, text before the first
heading, a fenced code block, conclusion over 3 lines, key points not 2-4 top-level bullets or numbered items (a nested sub-bullet is not counted), an action item not shaped
"who — what — when" (the separator is the three-part split on " — ", so a spaced em dash inside a part fails), "ไม่มี" beside another entry in the decision, action or open-question section, length over MAX_CHARS.
Limits (shortcut: line-based, no real Markdown parse; upgrade if fenced code in a summary matters):
length counts non-space characters, since Thai has no spaces between words.
"""
import json
import re
import sys

HEADINGS = ["ข้อสรุป", "ประเด็นหลัก", "การตัดสินใจ", "สิ่งที่ต้องทำต่อ", "ที่ยังค้าง"]
NONE = "ไม่มี"
MAX_CHARS = 1500  # about 500 English words
MARKER = r"(?:[-*+]|\d+[.)])\s+"  # a Markdown list marker: -, *, + or 1. / 1)


def sections(text):
    """Return ([H2 titles in order], {title: [non-empty body lines]})."""
    order, body, cur = [], {}, None
    for line in text.splitlines():
        m = re.match(r"(#{1,6})\s+(.+?)\s*$", line)
        if m:  # only "##" is a section; any other level becomes an extra heading, shown with its hashes
            cur = m.group(2) if m.group(1) == "##" else f"{m.group(1)} {m.group(2)}"
            order.append(cur)
            body.setdefault(cur, [])
        elif cur is not None and line.strip():
            body[cur].append(line.rstrip())  # keep the indent: a nested bullet is not a key point
        elif cur is None and line.strip():
            body.setdefault(None, []).append(line.strip())
    return order, body


def check(text):
    f = []
    add = lambda c, d: f.append({"check": c, "detail": d})
    order, body = sections(text)
    for h in HEADINGS:
        if h not in order:
            add("missing-heading", h)
    for h in order:
        if h not in HEADINGS:
            add("extra-heading", h)
    for h in HEADINGS:
        if h in body and not body[h]:
            add("empty-section", h)
    if body.get(None):
        add("preamble", body[None][0])
    if re.search(r"^\s*(```|~~~)", text, re.M):
        add("code-fence", "fenced block; write the summary as plain Markdown")
    known = [h for h in order if h in HEADINGS]
    if known != [h for h in HEADINGS if h in known]:
        add("heading-order", " > ".join(known))
    if len(body.get("ข้อสรุป", [])) > 3:
        add("conclusion-length", f"{len(body['ข้อสรุป'])} lines, max 3")
    if "ประเด็นหลัก" in body:
        bullets = [x for x in body["ประเด็นหลัก"] if re.match(MARKER, x)]  # top-level only
        if not 2 <= len(bullets) <= 4:
            add("key-points-count", f"{len(bullets)} bullets, need 2-4")
    actions = body.get("สิ่งที่ต้องทำต่อ", [])
    for line in actions:
        line = line.strip()
        item = re.sub("^" + MARKER, "", line).strip('"“”')  # drop a list marker and the template's quotes
        if item == NONE:
            if len(actions) > 1:  # "ไม่มี" means the section is empty, so it cannot sit beside an action
                add("action-shape", line)
            continue
        parts = item.split(" — ")
        if len(parts) != 3 or not all(re.search(r"\w", x) for x in parts):  # each of who, what, when needs a word; "ไม่ระบุ" is one
            add("action-shape", line)
    for h in ("การตัดสินใจ", "ที่ยังค้าง"):  # "ไม่มี" means the section is empty, so it cannot sit beside an entry
        items = [re.sub("^" + MARKER, "", x.strip()).strip('"“”') for x in body.get(h, [])]
        if NONE in items and len(items) > 1:
            add("none-with-content", h)
    n = len(re.sub(r"\s", "", text))
    if n > MAX_CHARS:
        add("too-long", f"{n} chars, max {MAX_CHARS}")
    return f


def main():
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        return 2
    try:
        raw = sys.stdin.buffer.read() if sys.argv[1] == "-" else open(sys.argv[1], "rb").read()
        text = raw.decode("utf-8-sig")  # a byte order mark is not part of the heading
    except (OSError, UnicodeDecodeError) as e:
        print(e, file=sys.stderr)
        return 2
    findings = check(text)
    print(json.dumps({"file": sys.argv[1], "findings": findings}, ensure_ascii=False, indent=1))
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
