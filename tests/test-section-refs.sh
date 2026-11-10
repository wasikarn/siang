#!/usr/bin/env bash
# Every §N and "cue #N" cited in the skill, README, CLAUDE.md and eval files must name a section that
# exists, and no section number may be defined twice. Section numbers are never renumbered
# (CLAUDE.md), so a dangling reference means a typo or a deleted rule. Run: bash tests/test-section-refs.sh
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
python3 - "$root" <<'PY'
import glob, os, re, sys
root = sys.argv[1]; os.chdir(root)
skill = sorted(glob.glob('skills/humanize/*.md'))
defs, dup = {}, []
for f in skill:
    for m in re.finditer(r'(?m)^#{2,5} +§?(\d+(?:\.\d+)*)\.?\s', open(f).read()):
        n = m.group(1)
        if n in defs: dup.append(f"§{n} defined in {defs[n]} and {f}")
        defs.setdefault(n, f)
cues = set(re.findall(r'(?m)^\| *(\d+) *\|', open('skills/humanize/cue-sheet.md').read()))
files = skill + sorted(glob.glob('skills/humanize/scripts/*.py')) + ['README.md', 'README.en.md', 'CLAUDE.md'] + sorted(glob.glob('evals/*/prompt.md') + glob.glob('evals/*/graders/*.md'))
bad = list(dup)
for f in files:
    for i, line in enumerate(open(f), 1):
        if 'next free number' in line: continue  # CLAUDE.md names the next unused § on purpose
        for n in re.findall(r'§(\d+(?:\.\d+)*)', line):
            if n not in defs: bad.append(f"{f}:{i}: §{n} is not a section")
        for n in re.findall(r'cue #(\d+)', line, re.I):
            if n not in cues: bad.append(f"{f}:{i}: cue #{n} is not in cue-sheet.md")
for b in bad: print('FAIL', b)
if bad: sys.exit(1)
print(f"section refs: {len(defs)} sections, {len(cues)} cues, all references resolve")
PY
