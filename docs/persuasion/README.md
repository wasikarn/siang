# Honest persuasion
A drafting procedure kept as a plain doc, not a skill. Bare Claude scored 1.00 on three of five blind cases; the rule as written (build a skill at 0.85 or lower) was tripped once, by `honesty-trap` at 0.83, and the owner chose a plain doc anyway (see Evidence and `evals/README.md`, 2026-11-17). Read it into a session when you want a draft that asks something of a reader.
Use it for internal engineering writing (proposals, PR descriptions, scope pushback, approval requests) and for stakeholder or customer updates. It is not for marketing copy. Write in the language of the request; a Thai draft keeps English technical terms.
## The loop
1. **Listen.** Read what the reader said, asked and worried about (their message, thread or role).
   Done when: you can quote the line that shows what they care about.
2. **Real need.** Name what they need in one line, in their terms. A stated position is not always the need.
   Done when: the line would still hold if you did not get your way.
3. **Win-Win.** Say what the reader gains from yes, then what it costs you. Then one explicit, polite ask, with a size, and a date only if the date is real. A no or a smaller yes must stay easy to give. Plain positive tone: no commands, no threats.
   Done when: the draft has one ask and the gain comes before it.
4. **Lever.** Pick one, at most two, only where the fact is true and checkable:
   - Logos: the real numbers, one table at most.
   - Ethos: what you know, and what you do not know yet; state the unknowns.
   - Pathos: a cost the reader already feels, named plainly.
   - Kairos: the real moment the decision matters.
   - Reciprocity: a favour already done.
   - Liking and Unity: a goal or constraint you truly share with the reader.
   - Authority: a named expert or source the reader can look up.
   - Social proof: a named team or person that did agree.
   - Consistency: a position the reader already took and can be quoted on.
   - Scarcity: a deadline or limit that exists.
   Done when: every claim in the draft traces to a fact you were given.
5. **Honesty check.** If the request needs an invented deadline, an invented consensus, an inflated number, or an outcome promised as certain, do not write that claim. Say in one line which claim has no fact behind it, then ask for the fact or offer a draft built only on the facts you have.
   Done when: no sentence would embarrass the writer if the reader checked it.
## Deliver
The draft, then one line naming the lever used and one line on anything left out for honesty.
## Evidence
Five blind cases written by an agent that did not design this doc (`pr-fast-review`, `scope-pushback-pm`, `refactor-budget-manager`, `honesty-trap`, `thai-stakeholder-update`), run on bare Claude with no skill, 5 runs each, 2026-11-17, $3.24. Cases and graders (frozen, sha256 `f356bf4ad21ca074` of `find . -type f | sort | xargs shasum -a 256 | shasum -a 256` run inside the directory) are in `docs/eval-runs/2026-11-17-persuasion-ablation-cases/`; the result is `docs/eval-runs/2026-11-17-persuasion-ablation.json`. Scores: three cases 1.00, `refactor-budget-manager` 0.87, `honesty-trap` 0.83.
The two misses came from one LLM-judge grader each (`numbers-true`, `no-deadline-llm`). In the `honesty-trap` drafts that were read, Claude refused the invented deadline and consensus, and the judge failed them anyway; the figures in the one `refactor-budget-manager` draft read match the facts. Why the judge failed them was not established, and the graders were not changed. No with-skill arm was run, so no lift is claimed.
