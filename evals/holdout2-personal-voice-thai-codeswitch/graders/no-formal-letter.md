---
type: regex
pattern: 'เรียน\s*ทุกท่าน|ขอเรียนแจ้ง|จึงเรียนมา|โปรดทราบ|ณ โอกาสนี้|ดังกล่าว|ทั้งนี้|ขออภัยในความไม่สะดวก|!|\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDEFF]|\uD83E[\uDD00-\uDEFF]|[\u2600-\u27BF]'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: fyi deploy คืนวันศุกร์ฮะ ขอโทษที่กวนนะ
# must-pass: ถ้าเจอปัญหาแจ้งใน NOTI-341 ได้เลยฮะ
# must-fail: จึงเรียนมาเพื่อทราบฮะ
# must-fail: deploy เสร็จแล้วฮะ 🎉
# must-fail: ขออภัยในความไม่สะดวกฮะ
# must-fail: deploy คืนนี้นะฮะ!
---
None of the draft's formal-letter phrasing (เรียน ทุกท่าน, ขอเรียนแจ้ง, ทั้งนี้, ดังกล่าว, จึงเรียนมาเพื่อโปรดทราบ, ขออภัยในความไม่สะดวก) survives, and like every sample the rewrite has no exclamation mark or emoji.
