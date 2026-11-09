---
status: accepted
---

# Drop only added facts, never author facts

siang's anti-fabrication rule once read "a fact you cannot verify right now is dropped", which, taken literally, deletes the author's own facts (`staging ผ่านแล้ว`, a ticket number, a time) whenever the model cannot check them. We decided the drop applies only to an **added fact** (one the rewrite would introduce); an **author fact** stays, and siang may only strip unbacked certainty words around it. A humanizer edits wording; it is not the author's fact-checker, and dropping author facts loses information the reader needs.

## Considered options

- Drop every unverifiable fact, the author's included (rejected: it contradicts the keep-the-claim rule and the th-standup `claim-kept` grader, and would gut standups and status updates).
- Keep all facts and drop nothing (rejected: the model would then be free to add plausible detail, the failure the tier system exists to stop).

## Commitments are not facts

A promise in the author's text (a delivery time, a refund date) is a commitment, not a fact. When the context says the team cannot keep it (the courier gave no date), siang cuts the promise and keeps the status around it (`patterns-thai.md` §57). This is the one case where author text goes; the draft's facts (order number, where the parcel is) still stay. Added 2026-11-10.
