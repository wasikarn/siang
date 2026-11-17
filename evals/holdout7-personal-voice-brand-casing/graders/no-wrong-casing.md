---
type: regex
pattern: '(?<![A-Za-z])(?:(?!iOS(?![A-Za-z]))[iI][oO][sS]|(?!GitHub(?![A-Za-z]))[gG][iI][tT][hH][uU][bB]|(?!PostgreSQL(?![A-Za-z]))[pP][oO][sS][tT][gG][rR][eE][sS](?:[qQ][lL])?|(?!Kubernetes(?![A-Za-z]))[kK][uU][bB][eE][rR][nN][eE][tT][eE][sS]|(?!Figma(?![A-Za-z]))[fF][iI][gG][mM][aA])(?![A-Za-z])'
match: not_contains
target: {source: file, path: draft.md}
# must-pass: iOS ขึ้น GitHub แล้ว PostgreSQL กับ Kubernetes ปกติ ดู Figma ด้วย
# must-pass: ปล่อย iOS 5.4.1 ได้เลย
# must-fail: ปล่อยบน ios ได้เลย
# must-fail: โค้ดอยู่บน github แล้ว
# must-fail: ฐานข้อมูล postgresql ปรับแล้ว
# must-fail: ใช้ Postgres ตัวเดิม
# must-fail: ดู kubernetes อีกรอบ
# must-fail: แบบอยู่ใน figma
# must-fail: โค้ดอยู่บน Github แล้ว
---
No product appears in a wrong casing (ios, github, postgresql, Postgres, kubernetes, figma, Github); the official form is the only accepted spelling.
