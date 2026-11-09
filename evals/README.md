# Evals

Ten cases for `siang:humanize` in `claude plugin eval`'s native layout (tag `humanize`):
eight planted cases (English prose, English Slack update with only subtle tells §9/§28/§30/§59-§61,
Thai standup, Thai UI copy, Thai customer-chat reply, Thai maintenance notice for §56 dates and
numbers, Thai release note for §31 spelling, Thai blog post for §33/§45/§47/§49/§51 structure), a clean human-written control
that must survive lightly edited, and a file-input case that proves the prose-only constraint
(frontmatter and code block byte-identical, graded on the file's contents).

Five more Thai cases carry tag `v012` as regression guards: hidden characters (§58), calques, PR
grammar (§44/§46/§53), a support reply that echoes the customer back (§57/§59), and a clean LINE
chat control (§39.1). Plain Claude passes four of them too; their job is to catch siang losing to
it, as it did on the echo-back and grammar cases (0.67 and 0.93 against plain 0.83 and 1.00,
2026-11-09). With the §57/§59 rules and the scan.py §44 cue, siang scored 1.00 on both over 3 runs.
That is weak evidence: the rules were written from these two fixtures, and grammar moved from 1 miss
in 3 to 0 in 3, within run-to-run noise. Three held-out cases (tag `holdout`, written by an agent that
never saw the rules) then tested both fixes on other wording, 5 runs per arm. Echo-back held (siang
1.00, plain 1.00). Trailing conditions did not: siang 0.60 against plain 1.00, because SKILL.md loaded
the Thai structure rules only for long prose. After step 3 loaded them for any Thai text over one
sentence and step 6 added a read for trailing conditions, siang scored 1.00 on that case and on a third
blind case (an on-call handoff, three trailing conditions); plain Claude also reorders them there.

Each case is `prompt.md` (invokes the skill by `skill: "siang:humanize"`), `case.yaml` (a
`scaffold_script` that writes the fixture), and `graders/`. `skill-fired.md` is
`tool_used: Skill`. Each prompt also says what to do if the Skill tool reports the skill as unknown:
without that line the without arm got "Unknown skill" and, in humanize-clean, rewrote nothing, so
that case's Δ of 1.0 was an artifact. The regex graders assert a planted tell is absent (`not_contains`) or a source
specific is kept (`contains`). A `contains` grader marked `# fixture: absent` checks a corrected
form instead (`3 กุมภาพันธ์ 2570`, `ลิงก์`), so the self-test requires it to miss the fixture:
returning the source unchanged must fail it. The four newest cases use regex graders only, so
their scores don't move with the LLM judge.

Two cases cover `siang:technical-writing` (tag `technical-writing`). `technical-writing-stale-howto` hands
the skill a stale how-to next to the script it documents. Regex graders check that the removed `--force` flag
is gone, the dry-run command and its real output are present, the steps are numbered, the title names the
goal and `KEYSTORE_URL` survives. `technical-writing-unverified-claim` checks a how-to for `bin/rotate-key` where
the skill must flag what it could not verify (`TODO: verify`) instead of asserting it. Both prompts name
`siang:technical-writing`; the fifteen humanize cases name `siang:humanize`.

One case covers `siang:document-review` (tag `document-review`): `document-review-planted-sop` hands the skill an SOP
with five planted defects (broken cross-reference, a file used before it is created, a missing required section,
a unit mismatch, an unsourced retention claim) and a standard to review it against. Its first run scored 1.00 with
the skill and 0.57 without (Δ +0.43). A plain model finds all four checkable defects; the Δ comes from the skill's own
contract: marking the unsourced claim unverifiable, grading findings by consequence, and ending in a verdict.

One case covers `siang:personal-voice` (tag `personal-voice`): `personal-voice-terse-writer` gives the skill three
terse chat messages and a polished draft to rewrite in that voice, plus a `voice.md` for the profile. Its first run
scored 1.00 with the skill and 0.78 without (Δ +0.22). Both arms fix the draft; the Δ comes from the profile, where
only the skill reports measured features (a sentence-length median) and separates habits from one-offs by sample.

Two harder cases follow. `technical-writing-hidden-facts` asks for one doc for two readers (a first-time how-to and a flag
and exit-code reference) over a script with a hidden `jq` prerequisite, a lock that exits 3 and a stale draft claiming
encryption at rest; first run 1.00 with the skill, 0.86 without (Δ +0.14): a plain model keeps the unsourced claim.
`personal-voice-thai-oneoffs` gives three Thai chat samples where one has an emoji and another `!!!`; first run 0.89
with, 0.67 without (Δ +0.22): a plain model copies the one-off emoji. The skill's profile still omits a sentence-length
median on samples this short, which the `profile-measured` grader keeps visible.


Run from the repo root: `claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish` (add `--trust-plugin` outside an interactive terminal; without the tool grant the file case cannot write and scores 0.60) (each run is a paid API call).

Free check, no API call: `bash tests/test-graders.sh` proves every prompt invokes
the siang skill it names and every regex grader compiles as a JS RegExp and matches its scaffolded fixture
(so a `not_contains` grader can fail and a `contains` grader can pass).

## Known gap

- **Invented facts in rewrites.** The Grit Gate's fabrication boundary (no new fact, number,
  cause, name or result) has no grader. A one-word haiku judge could not check it in either
  phrasing: written "PASS unless", it passed every planted invention; written "Score 1 only if",
  it failed correct replies 3/3. Presence of the source's specifics is checked by regex instead.
