---
status: accepted
---

# Drop only added facts, never author facts

siang's anti-fabrication rule once read "a fact you cannot verify right now is dropped", which, taken literally, deletes the author's own facts (`staging ผ่านแล้ว`, a ticket number, a time) whenever the model cannot check them. We decided the drop applies only to an **added fact** (one the rewrite would introduce); an **author fact** stays, and siang may only strip unbacked certainty words around it. A humanizer edits wording; it is not the author's fact-checker, and dropping author facts loses information the reader needs.

## Considered options

- Drop every unverifiable fact, the author's included (rejected: it contradicts the keep-the-claim rule and the th-standup `claim-kept` grader, and would gut standups and status updates).
- Keep all facts and drop nothing (rejected: the model would then be free to add plausible detail, the failure the tier system exists to stop).
