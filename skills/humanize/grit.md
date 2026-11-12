# Grit and voice

Read at step 2 of `SKILL.md`: what specifics and point of view the rewrite carries, and how to match a writing sample.

## The Grit Gate

**Removing the universal patterns gets you to "clean," not "human."** Clean-but-neutral text sits in the safe middle, itself an AI tell. To clear it, every rewrite also does both:

1. **Surface the grit.** Pull the concrete specifics a real author includes and an LLM rounds off: ticket and PR refs, file and module names, the actual cause (race condition, double-submit, null from an API), real numbers, the one weird detail. Grit is what reads human, not the absence of fluff.
2. **Commit to a point of view.** Say which part matters and what you would actually do; balanced neutral reporting is the AI default. POV only where the genre allows it: blog, standup, ADR yes; legal, spec, reference stays plain, and plain *is* the human voice there.

**Fabrication boundary.** Specifics come only from the source or context. A point of view (a plan, a recommendation, which part matters) belongs to the author: write one in only when the author gave it or asked you to take a position, and otherwise ask or offer it as a suggestion next to the rewrite. A fact, number, cause, or result is never added. On a thin source the boundary wins: less grit beats invented grit. Pure puffery with nothing to pull: say so or ask for specifics; a polished, confidently empty paragraph is still AI.

**One unverifiable claim inside an otherwise real draft** differs from a hollow source. Keep the claim, strip unbacked certainty intensifiers (`เรียบร้อยแล้ว`, "completely", "fully"), and ask what was checked where the genre allows (Tier 2 hedge, §32.1). The three tiers apply in any language: an unverifiable added fact → drop, heard but unconfirmed → hedge once, sourced → cite. An author fact is never dropped for being unverifiable.

Worked "soulless vs alive" example, same facts as neutral report and as a real voice: `examples.md`, Grit Gate section.

## Voice

Given a writing sample, match **their** voice: length, formality, paragraph openers, punctuation, recurring phrases. Replace AI patterns with the sample's own habits. Short sentences stay short; `ของ`/`อัน` stays, with no upgrade to `องค์ประกอบ`/`ส่วนประกอบ`.

No sample: the Grit Gate default. Opinionated where the genre allows, varied rhythm (a short sentence, then a longer one that arrives somewhere), and some mess let in; asides and half-formed thoughts read human, perfect symmetry reads algorithmic.
