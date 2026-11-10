---
type: regex
pattern: '^(?=[\s\S]*(?<!\d)22(?!\d)[^\n\d]{0,8}(?:พ\.?\s?ย|พฤศจิกา|nov|/\s?11))(?=[\s\S]*(?:20[:.]00|2\s?ทุ่ม|สองทุ่ม|8\s?pm|20\s?น))[\s\S]*(?<!\d)15(?!\d)\s*(?:นาที|min|m\b)'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: fyi ศุกร์ 22 พ.ย. 2 ทุ่ม deploy ฮะ ระบบล่มประมาณ 15 นาที
# must-pass: fyi 22/11 20:00 ขึ้น prod ฮะ down ~15 min
# must-pass: fyi ศุกร์ที่ 22 พฤศจิกายน 2567 เวลา 20:00 น. deploy ฮะ ใช้ไม่ได้ราว 15 นาที
# must-fail: fyi ศุกร์นี้ 2 ทุ่ม deploy ฮะ ระบบล่มประมาณ 15 นาที
# must-fail: fyi ศุกร์ 22 พ.ย. 2 ทุ่ม deploy ฮะ ระบบล่มแป๊บนึง
# must-fail: fyi ศุกร์ 22 พ.ย. deploy ฮะ ระบบล่มประมาณ 15 นาที
---
Facts kept: the date (22 November), the 20:00 start (2 ทุ่ม and 8pm count) and the 15-minute outage.
