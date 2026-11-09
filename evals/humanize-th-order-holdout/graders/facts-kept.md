---
type: regex
pattern: '^(?=[\s\S]*@?ploy)(?=[\s\S]*payment-gateway)(?=[\s\S]*INC-4821)(?=[\s\S]*Redis)(?=[\s\S]*14[:.]20)(?=[\s\S]*25\s*นาที)(?=[\s\S]*p99)(?=[\s\S]*800\s*ms)(?=[\s\S]*(?<!\d)(?:5|ห้า)\s*นาที)(?=[\s\S]*พี่ต้น)(?=[\s\S]*/v2/charge)(?=[\s\S]*2\s*%)(?=[\s\S]*new-checkout)(?=[\s\S]*#312)(?=[\s\S]*(?:10[:.]00|10 โมง|สิบโมง))(?=[\s\S]*(?:postmortem|post-mortem|โพสต์มอร์?เท?ม))(?=[\s\S]*(?<!ไม่)ปกติ)(?![\s\S]*ไม่(?:ได้)?(?:กลับมา)?ปกติ)'
match: contains
target: last_message
---
Every specific survives (a spoken time such as `10 โมง` is fine in Slack): handover to @ploy, `payment-gateway`, `INC-4821`, Redis pool at 14:20, 25-minute timeout, p99 > 800ms for 5 minutes, พี่ต้น, `/v2/charge` > 2%, flag `new-checkout`, PR #312, postmortem at 10:00. Polarity: payment-gateway is still back to normal, not reversed to not normal.
