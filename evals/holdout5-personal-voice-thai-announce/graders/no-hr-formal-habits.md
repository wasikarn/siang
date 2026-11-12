---
type: regex
pattern: 'เรียน ?(?:พนักงาน|ทุกท่าน|ทีม|ทุกคน)|จึงเรียนมา|เพื่อโปรดทราบ|ขออภัยในความไม่สะดวก|มา ณ โอกาสนี้|ขอแสดงความนับถือ|^(?![\s\S])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: พฤ. 19 พ.ย. 14:00 จะ deploy payment-service ขึ้น production
# must-pass: ติดอะไรทักใน #infra ได้เลย
# must-fail: เรียน ทีมทุกท่าน ทางทีมจะ deploy payment-service
# must-fail: ขออภัยในความไม่สะดวกมา ณ โอกาสนี้
---
The forwarded HR notice is labelled not the user's: its formal letter habits (เรียน..., จึงเรียนมาเพื่อโปรดทราบ, ขออภัยในความไม่สะดวก) must not appear.
