---
type: regex
pattern: 'ไอโอเอส|ไอโอเอ็ส|กิตฮับ|กิทฮับ|กิตฮับ|โพสต์เกรส|โพสเกรส|โพสต์เกรสคิวแอล|คูเบอร์เนทิส|คูเบอร์เนตีส|กูเบอร์เนทีส|คูเบอร์เนเตส|ฟิกม่า|ฟิกมา'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: iOS ขึ้น GitHub แล้ว ดู Figma ด้วย
# must-pass: Kubernetes กับ PostgreSQL เรียบร้อย
# must-fail: ปล่อยบนไอโอเอสได้เลย
# must-fail: โค้ดอยู่บนกิตฮับ
# must-fail: ระบบบนคูเบอร์เนทิสขยายแล้ว
# must-fail: แบบอยู่ใน ฟิกม่า
# must-fail: ฐานข้อมูลโพสต์เกรสปรับแล้ว
---
Mint never transliterates a product name into Thai script, so none of the draft's Thai spellings (ไอโอเอส, คูเบอร์เนทิส, ฟิกม่า) may survive.
