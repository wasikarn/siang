---
type: regex
pattern: '^(?=[\s\S]*ปัจจุบัน)(?=[\s\S]*ปีละไม่น้อยกว่า)(?=[\s\S]*ฝึกอบรม)(?=[\s\S]*ฟื้นฟูข้อมูล)(?=[\s\S]*ป้องกัน)(?=[\s\S]*ฟ้องร้อง)(?=[\s\S]*ฝ่าฝืน)(?=[\s\S]*เป็นสิบปี)(?=[\s\S]*ฝ่ายบริการข้อมูลมีหน้าที่)'
match: contains
target: {source: file, path: regulation-clean.txt}
# fixture: absent
---
Vowels and tones shifted left after ป ฝ ฟ (U+F701..U+F704, U+F710, U+F712, U+F705, U+F706, U+F714) map back to the standard vowel or tone, giving ปัจจุบัน, ปีละ, ฝึกอบรม, ฟื้นฟู, ป้องกัน, ฟ้องร้อง, ฝ่าฝืน, เป็น, ฝ่าย.
