#!/usr/bin/env python3
"""List the AI-writing tells a pattern can catch, with line number and section.

Usage: python3 scan.py [FILE]   (reads stdin when FILE is omitted or "-")

A first pass for step 3 and a recount for step 6 of SKILL.md, not the scan itself: a hit is a
candidate to judge (a technical sense such as "robust estimator" is fine), and most tells
(forced triads, structure, register) need a reader. Fenced code blocks and YAML frontmatter
are skipped, since the skill rewrites prose only. Always exits 0 unless the input can't be read.
"""
import re
import sys

# (section, label, pattern). Sections must exist in the skill; tests/test-section-refs.sh checks them.
RULES = [
    ("§14", "em dash", r"—"),
    ("§19", "curly quote", r"[“”‘’]"),
    ("§7", "AI vocabulary", r"(?i)\b(delv(e|es|ing)|tapestry|testament|underscor(e|es|ed|ing)|pivotal|intricate|interplay|meticulous(ly)?|showcas(e|es|ing)|bolster(s|ed|ing)?|garner(s|ed)?|foster(s|ed|ing)?|vibrant|crucial|seamless(ly)?|deep dive)\b"),
    ("§7", "AI vocabulary (abstract sense?)", r"(?i)\b(landscape|robust)\b"),
    ("§8", "copula avoidance", r"(?i)\b(serves|stands|functions) as\b"),
    ("§9", "negative parallelism", r"(?i)\bnot (just|only)\b|\bit'?s not [^.]{1,40}[.,;] it'?s\b"),
    ("§20", "chat artifact", r"(?i)\b(i hope this helps|let me know if|feel free to|certainly!|happy to help)"),
    ("§22", "sycophancy", r"(?i)\b(great (question|catch)|you'?re absolutely right)"),
    ("§23", "filler phrase", r"(?i)\b(in order to|due to the fact that|in the event that)\b"),
    ("§25", "generic conclusion", r"(?i)\b(in conclusion|the future looks bright)\b|โดยสรุปแล้ว|กล่าวโดยสรุป"),
    ("§27", "authority trope", r"(?i)\b(at its core|fundamentally)\b|เป็นที่ทราบกันดีว่า|ปฏิเสธไม่ได้ว่า"),
    ("§28", "signposting", r"(?i)\b(let'?s (dive|delve) in(to)?|here'?s the thing|here'?s what you need to know)\b"),
    ("§59", "re-explaining what the reader knows", r"(?i)\b(as you know|for context|to recap)\b|อย่างที่ทราบกันดี"),
    ("§61", "arguing with no one", r"(?i)\bsome (might|may|would) argue\b|บางคนอาจแย้งว่า"),
    ("§7", "Thai AI vocabulary", r"ภูมิทัศน์|เน้นย้ำ|อย่างมหาศาล|อย่างน่าทึ่ง"),
    ("§31", "non-standard spelling", r"อัพเดท|อัพเดต|แอพ|ลิงค์|อีเมล์|ดิจิตอล|เวอร์ชั่น|ฟีเชอร์|เซสชั่น"),
    ("§33", "connector cluster", r"อย่างไรก็ตาม|นอกจากนี้|ในขณะเดียวกัน|ทั้งนี้"),
    ("§36", "marketing calque", r"มุ่งมั่น|ประสบการณ์[^\n]{0,20}ที่ดีที่สุด|ก้าวสำคัญ"),
    ("§37", "nominalization", r"ทำการ|ได้ทำการ|การดำเนินการ"),
    ("§40", "leaked closer", r"หวังว่า[^\n]{0,30}เป็นประโยชน์|ยินดีให้ความช่วยเหลือ"),
    ("§32.8", "formal address (fine in legal/bank letters)", r"ท่านผู้อ่าน|ท่านลูกค้า|ของท่าน|ข้าพเจ้า|กระผม"),
    ("§51", "panorama opener", r"ในยุคปัจจุบัน|ในโลกยุคใหม่"),
    ("§56", "western date/time in Thai", r"\b\d{1,2}:\d{2}\s?(AM|PM|am|pm)?\b|\b\d{1,2}/\d{1,2}/\d{4}\b"),
    ("§57", "apology size", r"ขออภัยอย่างสูง"),
]
COMPILED = [(s, label, re.compile(p)) for s, label, p in RULES]


def prose_lines(text):
    """Yield (line_no, line) for prose only: skip YAML frontmatter and fenced code blocks."""
    lines = text.splitlines()
    i = 0
    if lines and lines[0].strip() == "---":
        for j in range(1, len(lines)):
            if lines[j].strip() == "---":
                i = j + 1
                break
    fence = None
    for n in range(i, len(lines)):
        line = lines[n]
        m = re.match(r"\s*(```|~~~)", line)
        if m:
            fence = None if fence == m.group(1) else (fence or m.group(1))
            continue
        if fence is None:
            yield n + 1, re.sub(r"`[^`\n]*`", "", line)  # inline code is not prose either


def scan(text):
    hits = []
    for no, line in prose_lines(text):
        for sec, label, rx in COMPILED:
            for m in rx.finditer(line):
                hits.append((no, sec, label, m.group(0)))
    return hits


def main():
    src = sys.argv[1] if len(sys.argv) > 1 else "-"
    text = sys.stdin.read() if src == "-" else open(src, encoding="utf-8").read()
    hits = scan(text)
    for no, sec, label, found in hits:
        print(f"L{no}: {sec} {label}: {found}")
    dashes = sum(1 for h in hits if h[1] == "§14")
    print(f"{len(hits)} candidate(s); em dashes: {dashes}")


if __name__ == "__main__":
    main()
