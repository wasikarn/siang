# Evals

Cases for `siang:humanize` (removed in 0.1.28), `siang:document-review` (removed in 0.1.26), `siang:technical-writing` (removed in 0.1.27) and `siang:personal-voice` (removed in 0.1.32) are described below as a record of what was measured. Their cases were removed with the skills and restored in 0.1.33, so they are in the tree again.

**0.1.33 (2026-11-10):** `humanize`, `document-review`, `technical-writing` and `personal-voice` were restored as skills under the revised rule. Measured text: `humanize` and `document-review` and `technical-writing` are the `SKILL.md` files from the commits before their removals (b20f58a, eb32e68, bf055b4); `personal-voice` is the 0.1.32 text (no cue-sheet step), whose frontmatter comes from the commit before 7fe87e7. Their eval cases were restored from the same commits. The restored text was then measured on new blind cases: see the second and third held-out rounds below.


Eighteen cases for `siang:humanize` in `claude plugin eval`'s native layout (tag `humanize`). Ten of them:
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
in 3 to 0 in 3, within run-to-run noise. Held-out cases (tag `holdout`, written by an agent that never saw
the rules) then tested both fixes on other wording, 5 runs per arm, two cases in one run and a third later. Echo-back held (siang
1.00, plain 1.00). Trailing conditions did not: siang 0.60 against plain 1.00, because SKILL.md loaded
the Thai structure rules only for long prose. After step 3 loaded them for any Thai text over one
sentence and step 6 added a read for trailing conditions, siang scored 1.00 on that case and on a third
blind case (an on-call handoff, three trailing conditions); plain Claude also reorders them there (it first
scored 0.83, until the graders accepted spoken times such as `10 โมง` and the topic-first `รอ hotfix…ก่อน`).

A neutral-prompt check (2026-11-09) reran all 18 humanize cases on Sonnet 5.5 with prompts that ask to rewrite the text so it reads like a person wrote it, with no genre letter or loop steps but still "(use the `siang:humanize` skill if you have it)", 3 runs per arm. The skill fired in all 54 with-arm runs; since the prompt named it, that is not trigger evidence (the `trigger-*` cases test that). Mean Δ was +0.04, the same as Opus with the original prompts. The gain sits in th-notice +0.33 (plain Claude writes western times), th-standup +0.22 (particles, the calque ดัน), th-chat-clean +0.13 (plain Claude over-polishes a clean chat) and en-subtle +0.11 (the strawman stays); th-grammar-planted is −0.07, and both arms fail the echo-back grader in th-cs-echo-planted (the pre-0.1.24 pattern, outputs never read) and the `VM 3 ใบ` grader. A with-arm run costs about 1.7x a plain one on Sonnet and 2.1x on Opus. Results are in `docs/eval-runs/`; the repo's prompts still name the skill. After the 0.1.24 deep-audit fixes, all 14 Thai cases reran with-arm only, 3 runs each: 42 of 42 at 1.00.

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
`siang:technical-writing`; the eighteen humanize cases name `siang:humanize`.

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

Five `trigger-*` cases at the time (all five are in the tree again since 0.1.33; tag `trigger`) test whether each skill fires from the task alone: the prompt never names the skill
(its expected name sits in the case `description`, because prompt frontmatter rejects unknown keys, and `tests/test-graders.sh`
reads it from there), and a `tool_used: Skill` grader checks the call. Run with `--ablation none`, 3 runs each: `humanize`,
`technical-writing`, `document-review`, `personal-voice` and `thai-pua-repair` all fired 3 of 3. The descriptions alone are
enough, so a SessionStart hook that injects skill text is not needed.

Four `holdout-document-review-*` and `holdout-personal-voice-*` cases were written by an agent that never saw the skills'
steps, and graded on outcomes (is each planted defect found; does the draft show the person's visible habits and keep the
facts) rather than on the skills' own vocabulary. 3 runs per arm: `holdout-document-review-calibration-sop` 1.00 vs 1.00 and
`holdout-document-review-change-record` 1.00 vs 1.00 (Δ 0.00 on both), `holdout-personal-voice-chatty` 1.00 vs 0.88 (+0.13),
`holdout-personal-voice-formal` 0.96 vs 0.88 (+0.08; the sign-off phrase is missed on some with-arm runs). So the +0.38 on
`document-review-planted-sop` came from grading the skill's own output format, not from finding more defects.
After 0.1.21 (step 5 now requires every profile habit, closers included, to be found in the draft as a quoted fragment),
the two `personal-voice` cases reran at 3 runs per arm: `holdout-personal-voice-formal` 1.00 vs 0.83 (+0.17, the sign-off
now survives in every with-arm run) and `holdout-personal-voice-chatty` 0.96 vs 0.88 (+0.08; one with-arm run copied the
bullet list that only one sample has, so the one-off exclusion still slips occasionally). Known
looseness in these graders: a bare number (14, 21, 12, 18, 45, 300) counts as a hit even in an unrelated finding, and
`review.md` starts with a "no issues found" line so a run that never writes it fails the all-clear grader.

Grader changes after these runs (0.1.25, deep-audit fixes): the `order`, `units` and unmarked-claim graders of
`document-review-planted-sop`, `technical-writing-hidden-facts` and `technical-writing-unverified-claim` were
tightened or loosened, grader step numbers in the technical-writing and document-review cases were updated, and the
`thai-pua-repair-extracted-text` fixture no longer doubles a standard sara-a next to U+F710. Every Δ and score
quoted for those cases in this file and in the READMEs was measured under the earlier graders and has not been
re-run, so treat it as measured before 0.1.25 and not comparable to a new run.

No-op pruning check (0.1.23): `technical-writing` and `document-review` dropped the steps plain Claude already does (the
Diátaxis table, the style-rule list, the claim and requirement ID inventory), keeping `TODO: verify`, running each printed
command, "unverifiable is never a pass", the ledger grades and the verdict. Six cases, with-arm only, 3 runs each, before and
after: every case scored 1.00 after (the five that scored 1.00 before stayed at 1.00; `document-review-planted-sop` moved
0.92 to 1.00, within noise), and cost did not fall: $3.20 before, $3.29 after for the six cases. A shorter SKILL.md did not
make a run cheaper; the cost sits in the work, not in the skill text. The pruned versions stay because they score the
same and are easier to maintain.


Run from the repo root: `claude plugin eval . --scaffold --tag personal-voice --allow-tools "Bash,Edit,Write" --runs 1 --no-publish` (add `--trust-plugin` outside an interactive terminal; without the tool grant the file case cannot write and scores 0.60) (each run is a paid API call).

Free check, no API call: `bash tests/test-graders.sh` proves every prompt invokes
the siang skill it names and every regex grader compiles as a JS RegExp and matches its scaffolded fixture
(so a `not_contains` grader can fail and a `contains` grader can pass).

## Acceptance rule (set before the run, graders frozen)

A skill stays a skill only if, on its held-out cases (written by an agent that never saw the skill), all hold:
the with-skill mean score is above 0.90; no case loses to the without arm by more than 0.05 (revised 2026-11-10: the
original rule also required a mean Δ against the without arm of at least +0.05, and the verdicts below were reached under it;
the Δ figures stay as a record, and four skills removed under that clause were restored in 0.1.33). Cost is reported, not gated. Runs: 5 per arm, spend capped at $40. A skill that
fails is deleted or converted (scripts and knowledge kept as plain tools or docs, `SKILL.md` removed); humanize is
owned by another session and gets the same rule only with that session's agreement (it was applied later, see the humanize verdict below).

Held-out cases: `holdout-document-review-*`, `holdout-personal-voice-*`, `holdout-technical-writing-*`,
`holdout-thai-pua-repair-*` (two each). Graders and fixtures are frozen at sha256 `d1cb35dbc7742f68` (first 16
hex of the hash of every file under those eight directories, sorted by path, as
`find <dirs> -type f | sort | xargs shasum -a 256 | shasum -a 256`, run from the repo root with each directory written with its `evals/` prefix; from inside `evals/` the paths differ and so does the hash). Changing any of those files, or the skill text under test, after the run
voids it and the run starts again. Known loose graders, left as they are: `no-dest-flag` fails a migration note
that names `--dest`, `no-email-claim` fails any use of "hourly", one branch of `output-dir-prereq` is loose.

## Result of the acceptance run (graders frozen at `d1cb35dbc7742f68`, commit 0de01c8)

Held-out cases, 5 runs per arm, 2026-11-10, $12.58 in all. With-skill score, without score, Δ:
`holdout-document-review-calibration-sop` 0.97 / 1.00 / −0.03, `holdout-document-review-change-record` 1.00 / 1.00 / 0.00,
`holdout-personal-voice-chatty` 0.93 / 0.88 / +0.05, `holdout-personal-voice-formal` 0.97 / 0.88 / +0.10,
`holdout-technical-writing-cli-stale-readme` 1.00 / 0.83 / +0.17, `holdout-technical-writing-config-default-prereq`
0.97 / 0.97 / 0.00, `holdout-thai-pua-repair-regulation` 1.00 / 0.87 / +0.13, `holdout-thai-pua-repair-rag-chunks`
1.00 / 0.89 / +0.11. Against the rule above: `personal-voice` (0.95, mean Δ +0.075), `technical-writing` (0.985, +0.085)
and `thai-pua-repair` (1.00, +0.12) pass, the first two narrowly and inside run-to-run noise; `document-review`
(0.985, −0.015) fails on Δ. It was converted in 0.1.26: `skills/document-review/` and its four eval cases
(`document-review-planted-sop`, the two `holdout-document-review-*`, `trigger-document-review`) were removed, and the
checklist kept as `docs/document-review-checklist.md`. The frozen hash covers the files as they were at the run; the
removed directories are in git history at 0de01c8. The cases and numbers for the removed skill above in this file are
a record of what was measured (the cases were restored in 0.1.33). humanize (mean Δ +0.04 over its 18 cases, measured by its
own session) would fail the same Δ bar; that is for its owner to decide and nothing was changed.

## Re-check after the second deep-audit (0.1.27)

Two independent checkers (Sol and Opus) found that `technical-writing`'s pass came from one grader, `no-keep-30`, which
rejected a correct README line (`... --keep 30 ~/work`, a valid use of the script's flag): it failed all 5 without-arm
runs of `holdout-technical-writing-cli-stale-readme`, and with it the Δ was +0.17 on that case. Two more graders
(`no-encryption-claim`, `no-local-tz-claim`) rejected correct text, and `jsonl-shape` in
`holdout-thai-pua-repair-rag-chunks` rejected a valid key order. All four were loosened with sample lines taken
from the checkers' probes (the self-test is red on the old patterns, green on the new), and the three cases whose
graders changed were rerun, 5 runs per arm, $5.23. The cases whose graders did not change (`holdout-thai-pua-repair-regulation`
and the two `holdout-personal-voice-*`) were not rerun. That departs from the rule's wording (a changed frozen file voids the run and it starts again): only the affected cases were rerun, to bound the cost, and the verdicts above say so. No new hash was recorded for the loosened graders before the rerun, so the `technical-writing` verdict rests on weaker evidence than a frozen run. `jsonl-shape` still allows at most one space after a colon, a looser-than-needed limit left as it was.

| case | with | without | Δ |
|---|---|---|---|
| `holdout-technical-writing-cli-stale-readme` | 1.00 | 0.90 | +0.10 |
| `holdout-technical-writing-config-default-prereq` | 0.97 | 1.00 | −0.03 |
| `holdout-thai-pua-repair-rag-chunks` | 1.00 | 0.94 | +0.06 |

`technical-writing`: with-skill 0.985, mean Δ +0.035, below the +0.05 bar, so it fails and was converted in 0.1.27
(`skills/technical-writing/` and its six eval cases removed; guidance kept as `docs/technical-writing-guide.md`).
`thai-pua-repair`: 1.00, mean Δ +0.095 (regulation +0.13, rag-chunks +0.06), still passes. Total spend across both runs
$17.81 of the $40 cap. The one remaining swing in the config case is `no-email-claim`, a known loose grader that fails any
use of "hourly" and cost the with-skill arm 0.03 once; it was not touched, because rerunning after each grader fix until a
skill passes is the tuning the rule exists to prevent. The loosened graders were written after seeing the first result, so
this second verdict is weaker evidence than the first; it removes a false pass rather than adding a new one.

## Final run on fresh blind cases (graders frozen at `e13671ec9adff4e5`)

Two things were still open: `personal-voice`'s held-out cases were not blind, and the rerun above was partial. So an agent
that never saw the skill wrote two new personal-voice cases (`holdout2-personal-voice-terse-lower`,
`holdout2-personal-voice-thai-codeswitch`; each has one habit shared by every sample and one one-off quirk the draft must not
copy), the `jsonl-shape` whitespace limit was loosened, and all four cases below were frozen (sha256 first 16 hex
`e13671ec9adff4e5` over `holdout2-personal-voice-*` and `holdout-thai-pua-repair-*`, same command as above) and run together,
5 runs per arm, $6.14, total spend $23.95 of the $40 cap. The two older `holdout-personal-voice-*` cases stay in the tree as
ordinary regression cases and no longer count towards the verdict.

| case | with | without | Δ |
|---|---|---|---|
| `holdout2-personal-voice-terse-lower` | 0.97 | 0.82 | +0.15 |
| `holdout2-personal-voice-thai-codeswitch` | 1.00 | 1.00 | 0.00 |
| `holdout-thai-pua-repair-regulation` | 1.00 | 0.87 | +0.13 |
| `holdout-thai-pua-repair-rag-chunks` | 1.00 | 0.94 | +0.06 |

`personal-voice`: with-skill 0.985, mean Δ +0.075, no case loses: pass (measured on plugin 0.1.27; 0.1.28 shortened the description and reworded step 5 to read `docs/humanize/cue-sheet.md` instead of calling `siang:humanize`, and 0.1.29 made that path plugin-relative; only a with-arm run of one case, `terse-lower`, was repeated after the rewording, so the shipped file's pass rests on the 0.1.27 run). `thai-pua-repair`: 1.00, mean Δ +0.095: pass. The
personal-voice gain comes from one case; on the Thai code-switch case plain Claude scores the same. The terse-lower with-arm
misses were the `signoff` and `no-caps-emphasis` graders, strict by design (they check a habit every sample shares and a
quirk that must not be copied). Open: the two PDF cases only check that `out.pdf` exists (`%PDF-`), so `cp in.pdf out.pdf`
plus a hand-edited `check.txt` passes every grader; with regex-on-file, last-message and tool-use graders only, and the
repaired streams compressed, that cannot be closed here.

## Rerun on the shipped text (0.1.31, same frozen graders `e13671ec9adff4e5`)

The two `holdout2-personal-voice-*` cases were run again on plugin 0.1.31, the text that ships (step 5 reads the cue sheet
through `${CLAUDE_SKILL_DIR}`), 5 runs per arm, $2.30. The graders and fixtures hash was unchanged before the run.

| case | with | without | Δ |
|---|---|---|---|
| `holdout2-personal-voice-terse-lower` | 0.975 | 0.85 | +0.125 |
| `holdout2-personal-voice-thai-codeswitch` | 0.975 | 1.00 | −0.025 |

With-skill mean 0.975, mean Δ +0.05, no case loses by more than 0.05: `personal-voice` still passes, at the threshold
(+0.075 on 0.1.27). The gain is still one case (`terse-lower`, where `no-caps-emphasis` fails all 5 without-arm runs); on the
code-switch case the with arm missed `english-tech-terms` once. Recorded spend is $31.59 of the $40 cap. One traced run of
`terse-lower` (0.1.31, with arm, kept with `--keep-temp`) shows no Read of the cue sheet: the model loaded the skill, read the
samples, wrote and edited `draft.md`, and skipped the step-5 read. So the pass measures the skill without that read; the
read is not doing work in these cases, and one run does not show whether it ever happens.

## Humanize on blind held-out cases (0.1.28)

The humanize session was no longer running and the user confirmed that no other session worked on it, then told this session to apply the rule to it. An agent that never saw the skill wrote four
cases (`holdout2-humanize-en-pr`, `-en-adr`, `-th-chat`, `-th-release`; a model-sounding draft with concrete facts, rewritten
in place, 8 regex graders each). Graders were frozen at sha256 `81f74ee5e3c5a238` (first 16 hex over the four directories, same command
as above) and run once, 5 runs per arm, $5.34, total spend $29.29 of the $40 cap. This hash cannot be reproduced: the four directories were never committed and are no longer on disk, so it is a record, not a check.

| case | with | without | Δ |
|---|---|---|---|
| `holdout2-humanize-en-pr` | 1.00 | 1.00 | 0.00 |
| `holdout2-humanize-en-adr` | 0.97 | 1.00 | −0.03 |
| `holdout2-humanize-th-chat` | 0.90 | 0.88 | +0.03 |
| `holdout2-humanize-th-release` | 0.88 | 0.88 | 0.00 |

With-skill mean 0.9375 (above 0.90), mean Δ 0.00 against the +0.05 bar: fail. No case loses by more than 0.05. It agrees with the
session's own 18-case figure (mean Δ +0.04). Two graders failed in both arms alike (`krub-not-every-sentence` in `th-chat`,
`no-hype-closer` in `th-release`, which bans any ครับ); they were strict by design and were not changed after the result, so the
verdict stands as run. Converted in 0.1.28: `skills/humanize/` moved to `docs/humanize/` (the loop as `README.md`, the cue sheet,
patterns, examples and `scripts/scan.py`; the only edits are `SKILL.md` references that now say `README.md`), its 18 cases and `trigger-humanize` removed, and the four held-out cases
dropped from the tree with it (they are in the numbers above, not in git, since they were never committed). `tests/test-scan.sh` now
reads planted fixtures from `tests/fixtures/humanize/`.

## Personal-voice without the cue-sheet step (0.1.32): fail, converted

The traced run above showed the model skipping step 5's cue-sheet read, so the step was removed (the read-for-tells instruction stays,
with no file to open) and the same two blind cases were run again on 0.1.32, same frozen graders (`e13671ec9adff4e5`, hash checked before
the run), 5 runs per arm, $2.29.

| case | with | without | Δ |
|---|---|---|---|
| `holdout2-personal-voice-terse-lower` | 0.95 | 0.875 | +0.075 |
| `holdout2-personal-voice-thai-codeswitch` | 1.00 | 1.00 | 0.00 |

With-skill mean 0.975 (above 0.90), mean Δ +0.0375 against the +0.05 bar: fail. No case loses. The 0.1.31 run scored +0.05 on the
same cases; the 0.0125 gap is within run-to-run noise, so the honest reading is that `personal-voice` sits at about +0.04 to +0.05,
at or just under the bar, with its gain in one case. By the rule it does not earn its place. Converted in 0.1.32:
`skills/personal-voice/SKILL.md` became `docs/personal-voice-guide.md` (frontmatter replaced by a not-a-skill note, the loop unchanged),
and its seven cases were removed (`personal-voice-terse-writer`, `personal-voice-thai-oneoffs`, `holdout-personal-voice-chatty`,
`holdout-personal-voice-formal`, `holdout2-personal-voice-terse-lower`, `holdout2-personal-voice-thai-codeswitch`,
`trigger-personal-voice`; they are in git history). Recorded spend is $34.01 of the $40 cap. `thai-pua-repair` was the only skill left until 0.1.33.

## Known gap

- **Invented facts in rewrites.** The Grit Gate's fabrication boundary (no new fact, number,
  cause, name or result) has no grader. A one-word haiku judge could not check it in either
  phrasing: written "PASS unless", it passed every planted invention; written "Score 1 only if",
  it failed correct replies 3/3. Presence of the source's specifics is checked by regex instead.

## Second held-out round (2026-11-10, before the run)

Eight new cases, `holdout3-*` (two each for `humanize`, `personal-voice`, `technical-writing`, `document-review`), written by agents that were told not to read `skills/` or any existing case for their skill. Graders and fixtures are frozen at sha256 `69b6e792354fd05d` (first 16 hex of `find evals/holdout3-* -type f | sort | xargs shasum -a 256 | shasum -a 256`, run from the repo root). Rule: with-skill mean above 0.90 and no case losing to the without arm by more than 0.05, 5 runs per arm. Nothing in these cases or the skills changes after the run starts; a miss is reported as it is.

### Result of the second held-out round (2026-11-10, graders frozen at `69b6e792354fd05d`, commit 7916cd9)

5 runs per arm, 8 cases, $12.45. With-skill / without / Δ: `holdout3-document-review-access-review-policy` 1.00 / 1.00 / 0.00, `holdout3-document-review-backup-runbook` 1.00 / 1.00 / 0.00, `holdout3-humanize-pr-rate-limiter` 1.00 / 1.00 / 0.00, `holdout3-humanize-th-incident-note` 1.00 / 1.00 / 0.00, `holdout3-personal-voice-semicolon-memo` 1.00 / 1.00 / 0.00, `holdout3-personal-voice-thai-chat` 1.00 / 1.00 / 0.00, `holdout3-technical-writing-snap-backup` 1.00 / 1.00 / 0.00, `holdout3-technical-writing-report-export` 0.90 / 0.97 / −0.07.

Against the rule (with-skill mean above 0.90, no case losing by more than 0.05): `document-review` (1.00), `humanize` (1.00) and `personal-voice` (1.00) pass. `technical-writing` has a mean of 0.95 but loses by 0.07 on `report-export`, so it fails on that case. The only failing grader was `no-range-flags-in-command` (4 of 5 with-skill runs, 1 of 5 without). Its pattern `report\.py[^\n]*--(?:until|from)\b` matches any line that mentions `report.py` and then `--from` or `--until`, so a correct migration note such as "report.py no longer accepts --from or --until" would also fail it. That is a likely cause but is not confirmed: no sandbox was kept. The grader is left as it is, because changing it after the result would void the run.

Seven of eight cases scored 1.00 in both arms, so these cases do not separate the skills from plain Claude; they show only that the skills do no harm there.

Diagnostic rerun (same day, after the verdict, does not change it): `holdout3-technical-writing-report-export`, with-skill arm only, 3 runs, `--keep-temp`, $0.55, scored 1.00 in all 3, with `no-range-flags-in-command` passing. The first round failed that grader in 4 of 5 with-skill runs, so the failure did not reproduce and the cause (a loose grader, or run-to-run variance) is still not confirmed: no failing document was kept. The first-round verdict for `technical-writing` stands as recorded; only a fresh blind case set can settle it.

## Third held-out round, `technical-writing` only (2026-11-10, before the run)

Two new cases, `holdout4-technical-writing-logtidy-readme` and `holdout4-technical-writing-assetsync-howto`, written by an agent that was told not to read `skills/` or any existing `technical-writing` case, and to make every grader accept a correct document (including a migration note that names a removed flag). Graders and fixtures are frozen at sha256 `b98cf10e97652006` (first 16 hex of `find evals/holdout4-* -type f | sort | xargs shasum -a 256 | shasum -a 256`, repo root). Rule: with-skill mean above 0.90 and no case losing by more than 0.05, 5 runs per arm. Nothing changes after the run starts.

### Result of the third round (2026-11-10, graders frozen at `b98cf10e97652006`, commit 1041917)

5 runs per arm, $3.26. With-skill / without / Δ: `holdout4-technical-writing-assetsync-howto` 1.00 / 0.97 / +0.03, `holdout4-technical-writing-logtidy-readme` 1.00 / 1.00 / 0.00. The with-skill mean is 1.00 and no case loses, so `technical-writing` passes the rule on this round. Its second-round result (`holdout3-technical-writing-report-export`, −0.07) stays on record, so the skill has a failing second round and a passing third round; by the rule's wording (a case losing by more than 0.05 fails) the second round failed on `report-export` (−0.07), and the later rounds are a rerun on a case set written after that failure, not a clean pass. The loose grader explains the miss (next paragraph), but it is an after-the-fact reading. The only failing grader was `delete-opt-in` (1 of 5 without-arm runs).

Cause confirmed (second diagnostic, same day, 5 runs per arm with `--keep-temp`, $1.79): `holdout3-technical-writing-report-export` scored 0.95 with-skill and 0.97 without (Δ −0.03), and `no-range-flags-in-command` failed 3 times (2 with-skill, 1 without). The traces show the failing documents contain correct notes such as "`report.py` has no `--until` option" or "has no `--until` or `--from` option", which match the grader's pattern `report\.py[^\n]*--(?:until|from)\b`. So the grader rejects correct text: the second-round −0.07 came from a loose grader, not from a worse document. The grader file is left unchanged, since it is part of the frozen set `69b6e792354fd05d`, and the round-2 table above stays as measured. The case is retired in favour of the two `holdout4-*` cases, whose graders were written to accept such notes; the third round (1.00 with-skill, no case losing) is a rerun on cases written after the second-round failure, so `technical-writing` stays a skill on a weaker footing than the other three (see the second paragraph of this section).

Note (deep-audit, 2026-11-10): `holdout3-technical-writing-report-export` is not deleted and still carries the tags `holdout` and `technical-writing`, so `--tag technical-writing` or `--tag holdout` still runs it with the loose grader. Select cases with `--case`, or read that case as unreliable. Editing its tags would change the frozen hash `69b6e792354fd05d`.

## Fourth held-out round, `technical-writing` only (2026-11-10, before the run)

Two new cases, `holdout5-technical-writing-key-rotation` and `holdout5-technical-writing-thumb-options`, written by an agent that was told not to read `skills/`, `docs/`, this file, `evals/results/` or any existing `technical-writing` case, and to make every grader accept a correct document. This round exists because the third round was written after the second-round failure (see above), so it is weaker evidence; this one was written without seeing any result of the skill, though by the same session that had seen the earlier failure and wrote the brief. Graders and fixtures are frozen at sha256 `5a17a92e3945e148` (first 16 hex of `find evals/holdout5-* -type f | sort | xargs shasum -a 256 | shasum -a 256`, repo root). Rule: with-skill mean above 0.90 and no case losing by more than 0.05, 5 runs per arm. Known weakness stated by the author before the run: `no-quality-85-default` and `no-jpeg-default` would wrongly fail a migration table whose last column is the old 2.x value. Nothing changes after the run starts.
