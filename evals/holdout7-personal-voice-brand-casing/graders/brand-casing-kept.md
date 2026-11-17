---
type: regex
pattern: '^(?=[\s\S]*iOS)(?=[\s\S]*GitHub)(?=[\s\S]*PostgreSQL)(?=[\s\S]*Kubernetes)[\s\S]*Figma'
match: contains
# fixture: absent
target: {source: file, path: draft.md}
# must-pass: iOS 5.4.1 ขึ้น GitHub แล้ว PostgreSQL migrate เสร็จ Kubernetes scale แล้ว ดีไซน์อยู่ใน Figma
# must-pass: Figma เสร็จ ส่วน Kubernetes กับ PostgreSQL ดูแล้ว GitHub merge แล้ว ปล่อย iOS ได้
# must-fail: ios 5.4.1 ขึ้น GitHub แล้ว PostgreSQL migrate เสร็จ Kubernetes scale แล้ว ดีไซน์อยู่ใน Figma
# must-fail: iOS ขึ้น github แล้ว PostgreSQL migrate เสร็จ Kubernetes scale แล้ว ดีไซน์อยู่ใน Figma
# must-fail: iOS ขึ้น GitHub แล้ว PostgreSQL migrate เสร็จ Kubernetes scale แล้ว
# must-fail: iOS ขึ้น GitHub แล้ว Postgresql migrate เสร็จ Kubernetes scale แล้ว ดีไซน์อยู่ใน Figma
---
All five products (iOS, GitHub, PostgreSQL, Kubernetes, Figma) appear in the exact casing every sample uses, checked case-sensitively.
