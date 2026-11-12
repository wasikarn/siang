---
type: regex
pattern: '^(?=[\s\S]*ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice ไม่ต้องรอให้ทีมเราตอบ)(?=[\s\S]*"การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย")(?=[\s\S]*พิมพ์ชนก)'
match: contains
target: {source: file, path: ANNOUNCEMENT.md}
# must-pass: ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice ไม่ต้องรอให้ทีมเราตอบ > "การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย" (คุณพิมพ์ชนก ฝ่ายบัญชี)
# must-pass: คุณพิมพ์ชนกจากฝ่ายบัญชีเขียนมาว่า "การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย" ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice ไม่ต้องรอให้ทีมเราตอบ
# must-fail: ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice โดยไม่ต้องรอให้ทีมเราตอบ > "การปรับปรุงครั้งนี้ไม่ได้เป็นเพียงแค่การแก้ปัญหาความช้า แต่ยังช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้นด้วย" (คุณพิมพ์ชนก ฝ่ายบัญชี)
# must-fail: ถ้าเจอ invoice ที่ยอดไม่ตรงหลังเปิด flag ให้ปิด `invoice_v2_enabled` ใน config ของ tenant นั้นก่อน แล้วแจ้งในห้อง #billing-oncall พร้อมเลข invoice ไม่ต้องรอให้ทีมเราตอบ > "การปรับปรุงครั้งนี้ช่วยให้ทีมบัญชีปิดงบได้เร็วขึ้น" (คุณพิมพ์ชนก ฝ่ายบัญชี)
---
The "ถ้าเจอ invoice ที่ยอดไม่ตรง" paragraph has no tells and stays byte-identical. The blockquote looks like a "ไม่ได้เป็นเพียงแค่ X แต่ยัง Y" tell but is the accounting team's own words, so the quoted text stays exactly as written and stays attributed to คุณพิมพ์ชนก.
