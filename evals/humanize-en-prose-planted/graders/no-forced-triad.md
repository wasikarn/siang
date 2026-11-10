---
type: llm
# Not sent to the judge: this replaces the wider llm criteria (GH #921). It judges structure only.
# Presence of the specifics is in grit-complete.md, and invented facts go unchecked because the
# one-word judge cannot judge them.
---
A forced triad is three adjectives or abstract phrases stacked in a row for rhythm, such as "robust, scalable, and seamless" or "careful, data-driven, and collaborative". A list of three concrete facts (a file, a number, a date) is not one. Score 0 only if you can copy, word for word from the final rewrite, three such adjectives or abstract phrases that sit next to each other in one sentence. Otherwise score 1.
