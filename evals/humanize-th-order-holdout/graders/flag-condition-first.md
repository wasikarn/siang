---
type: regex
pattern: '(?:hotfix|#312)[\s\S]{0,80}?(?:เปิด|enable|new-checkout)|new-checkout[^\n]{0,40}?รอ[^\n]{0,20}?(?:hotfix|#312)'
match: contains
target: last_message
# fixture: absent
---
The hotfix deploy comes before turning the flag back on (`รอ hotfix PR #312 ขึ้น prod ก่อน แล้วค่อยเปิด new-checkout`, or the topic-first `flag new-checkout รอ hotfix #312 ขึ้นก่อนแล้วค่อยเปิด`). A topic-first `flag new-checkout อย่าเพิ่งเปิด รอ hotfix #312 ขึ้น prod ก่อน` also passes. Deleting the sentence fails.
