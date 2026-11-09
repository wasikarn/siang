---
type: regex
pattern: '^(?=[\s\S]*^ว่าด้วยการจัดเก็บและเปิดเผยข้อมูลการวิจัย$)(?=[\s\S]*^ข้อ ๒ ระเบียบนี้ให้ใช้บังคับตั้งแต่วันถัดจากวันประกาศเป็นต้นไป$)(?=[\s\S]*^การเปิดเผยข้อมูลดังกล่าวต่อบุคคลภายนอกจะกระทำได้เฉพาะเมื่อได้รับความยินยอมเป็นหนังสือ$)(?=[\s\S]*^ในกรณีที่มีปัญหาในการตีความ ให้อธิการบดีเป็นผู้วินิจฉัยชี้ขาด$)(?=[\s\S]*^หมายเหตุ ระเบียบฉบับนี้แก้ไขเพิ่มเติมจากระเบียบเดิมที่ประกาศใช้เมื่อปี ๒๕๖๑ และยกเลิกแบบคำขอเดิมทั้งหมด$)'
flags: m
match: contains
target: {source: file, path: regulation-clean.txt}
---
Five lines came out of the PDF already in standard Thai (Thai digits included). Each must survive byte for byte as a whole line.
