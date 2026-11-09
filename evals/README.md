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

A neutral-prompt check (2026-11-09) reran all 18 humanize cases on Sonnet 5.5 with prompts that only ask to rewrite the text so it reads like a person wrote it (no genre letter, no loop steps), 3 runs per arm. The skill fired in all 54 with-arm runs. Mean Δ was +0.04, the same as Opus with the original prompts. The gain sits in th-notice +0.33 (plain Claude writes western times), th-standup +0.22 (particles, the calque ดัน), th-chat-clean +0.13 (plain Claude over-polishes a clean chat) and en-subtle +0.11 (the strawman stays); th-grammar-planted is −0.07, and both arms keep the echo-back in th-cs-echo-planted and `VM 3 ใบ`. A with-arm run costs about 1.7x a plain one on Sonnet and 2.1x on Opus. The neutral prompts lived in a scratch copy; the repo's prompts still name the skill.

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
with, 0.67 without (Δ +0.22): a plain model copies the one-off emoji. The first run showed the skill's profile omitting a
sentence-length median on samples this short (`profile-measured`); 0.1.17 made the step-2 criterion explicit and a rerun
scored 1.00 against 0.67 (Δ +0.33), one run, so it may be noise.

One case covers `siang:thai-pua-repair` (tag `thai-pua-repair`): `thai-pua-repair-extracted-text` gives the skill a short
extract with Windows Thai PUA glyphs (U+F70A, F70B, F70E, F710) plus one U+F71B that has no known mapping. Graders check the
words come back right and that U+F71B stays in the text, neither deleted nor guessed. First run: 1.00 with and without the
skill (Δ 0.00). Plain Claude repairs a short sample from context, so this case is a regression guard, not evidence of
uplift; the skill's value (a checked 27-row table, a report of what it could not map, a whole 143-page extract in one
pass) shows at a scale this fixture does not reach.

`thai-pua-repair-pdf-file` covers the PDF branch: a hand-built one-page PDF whose ToUnicode map holds a consecutive PUA range,
a range that must split once mapped, and the unmappable U+F71B; the task is to write a repaired `out.pdf` and re-extract
its text. First run: 1.00 with and without the skill (Δ 0.00). The fixture's stream is uncompressed, so a plain model edits
it by hand; real PDFs compress it, which this case does not test. `tests/test-pua-pdf.sh` is the stronger check for the script.

`thai-pua-repair-pdf-compressed` is the harder version: twelve fonts, each with its own FlateDecode-compressed ToUnicode
stream, so the PDF cannot be edited by hand and every font map must be found. First run (one run per arm): 1.00 with the
skill, 0.75 without (Δ +0.25). Both arms repaired the tone marks and the range that must split; the plain model lost the
unmappable U+F71B on some lines (deleted or replaced), which the skill leaves in place and reports.

Three-run check of the nine non-humanize cases (2026-11-09, 3 runs per arm, with vs without): `document-review-planted-sop`
1.00 vs 0.62 (Δ +0.38); `personal-voice-terse-writer` 1.00 vs 0.78 (+0.22); `personal-voice-thai-oneoffs` 0.96 vs 0.70
(+0.26); `technical-writing-hidden-facts` 1.00 vs 0.90 (+0.10); `thai-pua-repair-pdf-compressed` 1.00 vs 0.92 (+0.08);
`technical-writing-stale-howto`, `technical-writing-unverified-claim`, `thai-pua-repair-extracted-text` and
`thai-pua-repair-pdf-file` all 1.00 vs 1.00 (Δ 0.00). The single-run Δs above were noisy where they were small (the
`technical-writing-unverified-claim` guard shows no gap over three runs). The `profile-lists-oneoffs` grader failed on
some `personal-voice-thai-oneoffs` runs because the profile omitted the one-offs it excluded. 0.1.20 made step 3 require a
one-offs line, and a rerun of both `personal-voice` cases (3 runs per arm) scored 1.00 vs 0.78 (+0.22) and 1.00 vs 0.70 (+0.30).

Five `trigger-*` cases (tag `trigger`) test whether each skill fires from the task alone: the prompt never names the skill
(its expected name sits in the case `description`, because prompt frontmatter rejects unknown keys, and `tests/test-graders.sh`
reads it from there), and a `tool_used: Skill` grader checks the call. Run with `--ablation none`, 3 runs each: `humanize`,
`technical-writing`, `document-review`, `personal-voice` and `thai-pua-repair` all fired 3 of 3. The descriptions alone are
enough, so a SessionStart hook that injects skill text is not needed.

Four `holdout-document-review-*` and `holdout-personal-voice-*` cases were written by an agent that never saw the skills'
steps, and graded on outcomes (is each planted defect found; does the draft show the person's visible habits and keep the
facts) rather than on the skills' own vocabulary. 3 runs per arm: `holdout-document-review-calibration-sop` 1.00 vs 1.00 and
`holdout-document-review-change-record` 1.00 vs 1.00 (Δ 0.00 on both), `holdout-personal-voice-chatty` 1.00 vs 0.88 (+0.13),
`holdout-personal-voice-formal` 0.96 vs 0.88 (+0.08; the sign-off phrase is missed on some with-arm runs). So the +0.38 on
`document-review-planted-sop` came from grading the skill's own output format, not from finding more defects. Known
After 0.1.21 (step 5 now requires every profile habit, closers included, to be found in the draft as a quoted fragment),
the two `personal-voice` cases reran at 3 runs per arm: `holdout-personal-voice-formal` 1.00 vs 0.83 (+0.17, the sign-off
now survives in every with-arm run) and `holdout-personal-voice-chatty` 0.96 vs 0.88 (+0.08; one with-arm run copied the
bullet list that only one sample has, so the one-off exclusion still slips occasionally). Known
looseness in these graders: a bare number (14, 21, 12, 18, 45, 300) counts as a hit even in an unrelated finding, and
`review.md` starts with a "no issues found" line so a run that never writes it fails the all-clear grader.


Run from the repo root: `claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish` (add `--trust-plugin` outside an interactive terminal; without the tool grant the file case cannot write and scores 0.60) (each run is a paid API call).

Free check, no API call: `bash tests/test-graders.sh` proves every prompt invokes
the siang skill it names and every regex grader compiles as a JS RegExp and matches its scaffolded fixture
(so a `not_contains` grader can fail and a `contains` grader can pass).

## Known gap

- **Invented facts in rewrites.** The Grit Gate's fabrication boundary (no new fact, number,
  cause, name or result) has no grader. A one-word haiku judge could not check it in either
  phrasing: written "PASS unless", it passed every planted invention; written "Score 1 only if",
  it failed correct replies 3/3. Presence of the source's specifics is checked by regex instead.
