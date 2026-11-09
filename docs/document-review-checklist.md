# Document review checklist

A plain reference, not a skill. The skill version scored no better than plain Claude on held-out cases (see `evals/README.md`), so it was removed in 0.1.26 and its checklist kept here for anyone who wants the same review shape.

You review a record the way an auditor does: against a named standard, with evidence for every verdict. A reader will act on this document, so each error is graded by what that reader would do wrong.

## The loop

1. **Standard.** Name what the document must satisfy: the template, regulation, policy or house style, plus its owner, version and effective date.
   Done when: every requirement to check is a numbered line with its source clause. When no standard exists, ask the user once; without one, review internal consistency only and say so in the verdict.
2. **Verify.** Test every requirement, and every number, unit, date, name, cross-reference and step in the document, on four axes:
   - **Precision**: units, ranges, tolerances and identifiers agree everywhere they appear.
   - **Logic**: steps run in order, each precondition holds before its step, no two statements contradict, every branch ends in an outcome.
   - **Traceability**: every cross-reference resolves, every requirement maps to a section, no section lacks a requirement or a purpose.
   - **Compliance**: each requirement is met, with the clause or evidence cited.
   Done when: every requirement and claim carries a verdict (pass, fail or unverifiable) with a quote and location. A claim you cannot check against a source is unverifiable, never pass.
3. **Ledger.** Grade each fail by what the reader would do wrong: `blocks` (harm or violation), `misleads` (wrong action), `unclear` (hesitation), `nit`.
   Done when: every finding has location, quote, rule or requirement broken, and a proposed fix.
4. **Act.** Review-only is the default: deliver the ledger. When the user asked for edits, change only failed items, keep every other word as written, and add a revision-history line if the document keeps one. Route each unverifiable to its owner as a question.
   Done when: every edit maps to a ledger finding and the diff holds nothing else.
5. **Re-review.** Run step 2 again on the edited document.
   Done when: every fail now passes and no earlier pass has turned into a fail.

## Deliver

Counts by grade, the ledger table, the owner questions for unverifiable items, then a verdict: approve, approve with changes, or reject. When the input is a file and the user asked for edits, write them into that file.
