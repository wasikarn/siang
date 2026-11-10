---
type: regex
pattern: '^(?=[\s\S]*WireGuard)(?=[\s\S]*90 วัน)(?=[\s\S]*(เฉพาะ(ผ่าน|ทาง|ใน)?[^\n]{0,12}VPN|(?<!ไม่)ต้อง(ต่อ|ใช้|เข้า|ผ่าน)[^\n]{0,8}VPN|VPN[^\n]{0,15}เท่านั้น))(?=[\s\S]*(ไม่(ได้)?(มีการ)?(แจ้ง)?เตือน))'
match: contains
target: last_message
---
The specifics survive with their polarity (A10): WireGuard, the 90-day expiry, staging reachable
only through the VPN (`ไม่ต้องใช้ VPN` fails), and no advance warning (`ระบบจะแจ้งเตือน` fails).
