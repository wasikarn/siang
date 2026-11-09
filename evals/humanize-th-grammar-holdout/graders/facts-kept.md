---
type: regex
pattern: '^(?=[\s\S]*#412)(?=[\s\S]*RedisSessionStore)(?=[\s\S]*MemorySessionStore)(?=[\s\S]*8\s*ชั่วโมง)(?=[\s\S]*REDIS_URL)(?=[\s\S]*auth-api)(?=[\s\S]*23\s*(?:ใบ|ticket|tickets))(?=[\s\S]*2,?000\s*RPS)(?=[\s\S]*15\s*นาที)(?=[\s\S]*login\s*ใหม่)(?=[\s\S]*(?:ไม่มี[^\n]{0,20}หลุด|ไม่หลุด))'
match: contains
target: last_message
---
Every specific in the source survives: PR #412, both store class names, the 8-hour TTL,
`REDIS_URL`, `auth-api`, the 23 tickets, the 2,000 RPS / 15-minute load test, and the one-time
re-login. Polarity: the load test still had no dropped sessions.
