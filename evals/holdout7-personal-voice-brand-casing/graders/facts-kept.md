---
type: regex
pattern: '^(?=[\s\S]*วิชัย)(?=[\s\S]*dev-2087)(?=[\s\S]*5\.4\.1)[\s\S]*(?<!\d)14(?!\d)[^\n\d]{0,8}(?:ม\.?\s?ค|มกรา|jan|/\s?0?1(?!\d))'
flags: i
match: contains
target: {source: file, path: draft.md}
# must-pass: iOS 5.4.1 ปล่อย 14 ม.ค. คุณวิชัยเทสต์ มีปัญหาแจ้ง DEV-2087
# must-pass: 14/01 ปล่อย v5.4.1 พี่วิชัยดูให้ ticket dev-2087
# must-fail: iOS 5.4.1 ปล่อย 14 ม.ค. มีปัญหาแจ้ง DEV-2087
# must-fail: iOS 5.4.1 ปล่อย 14 ม.ค. คุณวิชัยเทสต์
# must-fail: iOS ปล่อย 14 ม.ค. คุณวิชัยเทสต์ แจ้ง DEV-2087
# must-fail: iOS 5.4.1 ปล่อยเดือนมกรา คุณวิชัยเทสต์ แจ้ง DEV-2087
---
Facts kept: the tester Wichai (วิชัย), the ticket DEV-2087, version 5.4.1 and the 14 January date.
