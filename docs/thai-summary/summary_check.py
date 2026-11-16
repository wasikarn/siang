#!/usr/bin/env python3
"""Checks that a Thai summary follows the fixed template in README.md.
Usage: summary_check.py SUMMARY.md   (- for stdin)
Prints JSON {"file", "findings": [{"check", "detail"}]}. Exit 0 when clean, 1 when there are findings, 2 on bad input.
Checks: missing / extra / out-of-order "##" headings, conclusion over 3 lines, key points not 2-4 bullets,
an action item not shaped "who — what — when", length over MAX_CHARS.
Limits (shortcut: line-based, no real Markdown parse; upgrade if fenced code in a summary matters):
length counts non-space characters, since Thai has no spaces between words.
"""
import json
import re
import sys

HEADINGS = ["ข้อสรุป", "ประเด็นหลัก", "การตัดสินใจ", "สิ่งที่ต้องทำต่อ", "ที่ยังค้าง"]
NONE = "ไม่มี"
MAX_CHARS = 1500  # about 500 English words


def sections(text):
    """Return ([H2 titles in order], {title: [non-empty body lines]})."""
    order, body, cur = [], {}, None
    for line in text.splitlines():
        m = re.match(r"##\s+(.+?)\s*$", line)
        if m:
            cur = m.group(1)
            order.append(cur)
            body.setdefault(cur, [])
        elif cur is not None and line.strip():
            body[cur].append(line.strip())
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
    known = [h for h in order if h in HEADINGS]
    if known != [h for h in HEADINGS if h in known]:
        add("heading-order", " > ".join(known))
    if len(body.get("ข้อสรุป", [])) > 3:
        add("conclusion-length", f"{len(body['ข้อสรุป'])} lines, max 3")
    if "ประเด็นหลัก" in body:
        bullets = [x for x in body["ประเด็นหลัก"] if x.startswith(("-", "*"))]
        if not 2 <= len(bullets) <= 4:
            add("key-points-count", f"{len(bullets)} bullets, need 2-4")
    for line in body.get("สิ่งที่ต้องทำต่อ", []):
        if line != NONE and line.count(" — ") != 2:
            add("action-shape", line)
    n = len(re.sub(r"\s", "", text))
    if n > MAX_CHARS:
        add("too-long", f"{n} chars, max {MAX_CHARS}")
    return f


def main():
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        return 2
    try:
        text = sys.stdin.read() if sys.argv[1] == "-" else open(sys.argv[1], encoding="utf-8").read()
    except OSError as e:
        print(e, file=sys.stderr)
        return 2
    findings = check(text)
    print(json.dumps({"file": sys.argv[1], "findings": findings}, ensure_ascii=False, indent=1))
    return 1 if findings else 0


if __name__ == "__main__":
    sys.exit(main())
