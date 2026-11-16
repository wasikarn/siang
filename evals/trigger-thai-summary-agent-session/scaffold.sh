#!/usr/bin/env bash
# Plants SOURCE.md, the log of a user/assistant coding-agent session in Thai with English tool output.
# Files changed: src/auth/session.ts and src/auth/session.test.ts (src/auth/api.ts only read).
# Test result: vitest, 14 passed (14). User's decision: keep the token TTL at 15 minutes (the assistant offered
# 60 minutes; security requires 15) and only make refresh fire 60 seconds before expiry.
# Not verified by the assistant: did not run e2e (Playwright, needs staging credentials) and did not check refresh in
# a Safari background tab. Next step for the user: run `npm run e2e` on staging, then open the PR; no date given.
cat > SOURCE.md <<'EOF'
# Session log: แก้ปัญหา login หลุดใน web-app

**User:** login แล้วโดนเด้งออกทุก 15 นาทีทั้งที่ยังใช้งานอยู่ ช่วยดูให้หน่อย

**Assistant:** ขอดูโค้ดส่วน session ก่อนครับ

```
[tool] Read src/auth/session.ts (112 lines)
[tool] Read src/auth/api.ts (64 lines)
[tool] Grep "refreshToken" src/ -> 3 matches
```

**Assistant:** เจอสาเหตุแล้วครับ `scheduleRefresh()` ใน `src/auth/session.ts` ตั้ง timer ไว้ที่ `expiresAt` พอดี
token เลยหมดอายุก่อนที่ `refreshToken()` จะถูกเรียก request ถัดไปได้ 401 แล้ว interceptor ใน `api.ts` ก็ logout ทันที
แก้ได้สองทาง
1. ให้ refresh ก่อนหมดอายุ 60 วินาที
2. ขยาย token TTL จาก 15 นาทีเป็น 60 นาที ปัญหาจะเกิดน้อยลงแต่ไม่หายไป
จะเลือกทางไหนครับ

**User:** ไม่เอา 60 นาที ทีม security บังคับไว้ที่ 15 นาที คง TTL 15 นาทีไว้ แก้แค่ให้ refresh ก่อนหมดอายุพอ

**Assistant:** รับทราบครับ ทำทางที่ 1

```
[tool] Edit src/auth/session.ts
  - const delay = expiresAt - Date.now();
  + const REFRESH_LEAD_MS = 60_000;
  + const delay = Math.max(0, expiresAt - Date.now() - REFRESH_LEAD_MS);
[tool] Edit src/auth/session.test.ts
  + it("refreshes 60s before expiry", ...)
  + it("refreshes immediately when less than 60s remain", ...)
[tool] Bash npx vitest run src/auth

 ✓ src/auth/session.test.ts (14 tests) 41ms

 Test Files  1 passed (1)
      Tests  14 passed (14)
   Duration  612ms
```

**Assistant:** เสร็จแล้วครับ
- แก้ `src/auth/session.ts` ให้ refresh ก่อน token หมดอายุ 60 วินาที
- เพิ่ม test 2 ตัวใน `src/auth/session.test.ts` ตอนนี้ unit test ของ auth ผ่านครบ 14 ตัว
- TTL ยังเป็น 15 นาทีตามที่คุณเลือก

สิ่งที่ผมยังไม่ได้ตรวจ: ผมไม่ได้รัน e2e test (Playwright) เพราะต้องใช้ staging credentials ซึ่ง session นี้ไม่มี
และยังไม่รู้ว่าบน Safari ที่หน่วง timer ของ tab ที่อยู่เบื้องหลัง refresh จะยิงทันหรือไม่

ขั้นต่อไปสำหรับคุณ: รัน `npm run e2e` บน staging ถ้าผ่านค่อยเปิด PR

**User:** โอเค เดี๋ยวรันเอง ขอบคุณ
EOF
