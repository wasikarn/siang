#!/usr/bin/env python3
"""Measure a writer's habits from sample files, and check a draft against them.

Usage: voice_stats.py SAMPLE [SAMPLE ...] [--draft DRAFT]   (SAMPLE or DRAFT may be - for stdin)

One file is one sample. Prints JSON:
  samples   per-sample features (sentence and paragraph length, punctuation counts, openers, closer,
            Thai/Latin letter ratio, hedges, Thai particles, all-caps words)
  habits    features present in at least 2 samples (the SKILL.md habit rule)
  one_offs  features seen in exactly 1 sample, with that sample's name
  draft     with --draft: the draft's features, and every numeric feature outside the samples' range

It measures; it does not judge. Thai has no sentence punctuation, so a Thai sentence is a line or a
stretch ending in . ! ? (shortcut: no Thai word segmentation, so Thai recurring words are not counted;
upgrade when a segmenter such as pythainlp is acceptable as a dependency).
Exit: 0 ok, 2 bad arguments or unreadable file.
"""
import json
import re
import statistics
import sys
from collections import Counter

PUNCT = {"em dash": "—", "en dash": "–", "spaced hyphen": " - ", "paren": "(", "exclamation": "!",
         "question": "?", "ellipsis": "...", "ellipsis char": "…", "semicolon": ";", "colon": ":",
         "comma": ",", "emoji": None}
EMOJI = re.compile("[\U0001F300-\U0001FAFF☀-➿]")
HEDGES_EN = ["maybe", "probably", "i think", "kind of", "sort of", "just", "really", "very", "actually",
             "basically", "pretty much", "tbh", "imo"]
HEDGES_TH = ["น่าจะ", "อาจ", "ค่อนข้าง", "ประมาณ", "มาก ๆ", "จริง ๆ", "เหมือน"]
PARTICLES = ["ครับ", "ค่ะ", "คะ", "นะ", "เลย", "แล้ว", "ด้วย", "จ้า", "จ้ะ", "ละ", "หรอก", "สิ", "เนอะ"]
THAI = re.compile("[฀-๿]")
LATIN = re.compile("[A-Za-z]")


def sentences(text):
    parts = re.split(r"(?<=[.!?…])\s+|\n+", text.strip())
    return [p.strip() for p in parts if p.strip()]


def med(xs):
    return statistics.median(xs) if xs else 0


def features(text):
    sents = sentences(text)
    paras = [p for p in re.split(r"\n\s*\n", text.strip()) if p.strip()]
    lines = [ln for ln in text.strip().splitlines() if ln.strip()]
    low = text.lower()
    thai, latin = len(THAI.findall(text)), len(LATIN.findall(text))
    n = max(len(sents), 1)
    punct = {k: (len(EMOJI.findall(text)) if v is None else text.count(v)) for k, v in PUNCT.items()}
    return {
        "sentences": len(sents),
        "sentence_chars_median": med([len(re.sub(r"\s", "", s)) for s in sents]),
        "sentence_tokens_median": med([len(s.split()) for s in sents]),
        "paragraphs": len(paras),
        "paragraph_chars_median": med([len(re.sub(r"\s", "", p)) for p in paras]),
        "punct_per_100_sentences": {k: round(v * 100 / n, 1) for k, v in punct.items()},
        "punct_counts": punct,
        "opener": (sents[0].split() or [""])[0] if sents else "",
        "sentence_openers": dict(Counter(s.split()[0].lower() for s in sents if s.split())),
        "closer": lines[-1] if lines else "",
        "all_lowercase_start": bool(sents) and all(s[0].islower() for s in sents if s[0].isalpha()),
        "thai_ratio": round(thai / (thai + latin), 2) if thai + latin else 0.0,
        "hedges": {h: low.count(h) for h in HEDGES_EN + HEDGES_TH if low.count(h)},
        "particles": {p: text.count(p) for p in PARTICLES if text.count(p)},
        "caps_words": dict(Counter(re.findall(r"\b[A-Z]{2,}\b", text))),
        "latin_words": dict(Counter(w.lower() for w in re.findall(r"[A-Za-z][A-Za-z'-]{2,}", text))),
    }


def presence(f):
    """Set of named habits a sample shows, as 'kind: name' strings."""
    out = {f"punctuation: {k}" for k, v in f["punct_counts"].items() if v}
    out |= {f"hedge: {h}" for h in f["hedges"]} | {f"particle: {p}" for p in f["particles"]}
    out |= {f"caps: {w}" for w in f["caps_words"]}
    out |= {f"opener: {w}" for w in f["sentence_openers"]}
    if f["all_lowercase_start"]:
        out.add("style: lowercase sentence starts")
    return out


def read(path):
    try:
        return sys.stdin.read() if path == "-" else open(path, encoding="utf-8").read()
    except OSError as e:
        sys.exit(f"voice_stats.py: cannot read {path}: {e.strerror}")


def main(argv):
    draft = None
    if "--draft" in argv:
        i = argv.index("--draft")
        if i + 1 >= len(argv):
            sys.exit("voice_stats.py: --draft needs a file")
        draft = argv[i + 1]
        argv = argv[:i] + argv[i + 2:]
    if not argv:
        sys.exit(__doc__)
    feats = {p: features(read(p)) for p in argv}
    seen = {p: presence(f) for p, f in feats.items()}
    count = Counter(h for s in seen.values() for h in s)
    result = {
        "sample_count": len(feats),
        "provisional": len(feats) < 3,
        "samples": feats,
        "habits": {h: sorted(p for p, s in seen.items() if h in s) for h, c in count.items() if c >= 2},
        "one_offs": {h: next(p for p, s in seen.items() if h in s) for h, c in count.items() if c == 1},
    }
    if draft is not None:
        d = features(read(draft))
        miss = []
        for key in ("sentence_chars_median", "sentence_tokens_median", "paragraph_chars_median", "thai_ratio"):
            vals = [f[key] for f in feats.values()]
            if not min(vals) <= d[key] <= max(vals):
                miss.append({"feature": key, "draft": d[key], "range": [min(vals), max(vals)]})
        for k in PUNCT:
            vals = [f["punct_per_100_sentences"][k] for f in feats.values()]
            if not min(vals) <= d["punct_per_100_sentences"][k] <= max(vals):
                miss.append({"feature": f"punct_per_100_sentences: {k}", "draft": d["punct_per_100_sentences"][k],
                             "range": [min(vals), max(vals)]})
        absent = sorted(h for h in result["habits"] if h not in presence(d))
        # an all-caps word the draft uses that fewer than 2 samples use: copy of a one-off, or a new shout
        caps_bad = sorted(w for w in d["caps_words"] if f"caps: {w}" not in result["habits"])
        result["draft"] = {"features": d, "out_of_range": miss, "habits_absent": absent,
                           "caps_not_habit": caps_bad}
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
