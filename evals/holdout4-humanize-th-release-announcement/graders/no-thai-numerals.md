---
type: regex
pattern: '[๐-๙]'
match: not_contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: คืนวันอังคารที่ 10 พ.ย. เวลา 22:00 น.
# must-pass: request อาจช้าลงประมาณ 5 นาที
# must-fail: คืนวันอังคารที่ ๑๐ พฤศจิกายน ๒๕๖๙ เวลา ๒๒.๐๐ น.
# must-fail: อาจช้าลงประมาณ ๕ นาที
---
Engineers write Arabic digits in a release note. The fixture writes the date, the time and "5 นาที" in Thai digits (with a Buddhist-era year); the rewrite has no Thai digit anywhere.
