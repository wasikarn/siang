# Eval runs

The `claude plugin eval --json` results behind the humanize numbers in `README.md`, `README.en.md` and
`evals/README.md`, kept here because `evals/results/` is gitignored. Trace paths and local paths were
stripped; scores, costs, turns, grader verdicts and the LLM judges' quoted output remain. Each file
records the prompts and graders it ran with (`promptMarkdown`, `graders`), which may differ from the
current cases.

| File | What it backs |
|---|---|
| `2026-11-09-0.1.11-opus-baseline.json` | 10 cases, 3 runs per arm after the without-arm fix: mean Δ +0.05, $9.80 |
| `2026-11-09-0.1.13-v012-before.json` | the five v012 Thai cases before the §57/§59 rules |
| `2026-11-09-0.1.13-cs-echo-after.json`, `-grammar-after.json`, `-grammar-scan-cue.json` | the same cases after the rules and the scan.py §44 cue |
| `2026-11-09-0.1.14-holdout.json` | held-out echo-back and grammar, 5 runs per arm: siang 0.60 vs plain 1.00 on grammar |
| `2026-11-09-0.1.16-holdout-grammar.json`, `-holdout-order.json` | the same after 0.1.16; order-holdout plain scored 0.83 under the graders before they accepted spoken times and topic-first phrasing |
| `2026-11-09-0.1.16-opus-full.json` | 18 cases, 3 runs per arm on Opus 5.5: siang 54/54, mean Δ +0.037, $17.13, 2.1x cost |
| `2026-11-09-0.1.16-no-rescan-variant.json` | with-arm only, a variant without the step-6 rescan: no cost saving, reverted |
| `2026-11-09-0.1.19-sonnet-neutral-prompts.json` | 18 cases on Sonnet 5.5 with prompts that ask for a human-sounding rewrite and add "(use the `siang:humanize` skill if you have it)": mean Δ +0.043, 1.7x cost |
| `2026-11-10-0.1.24-thai-with-only.json` | the 14 Thai cases, with-arm only, 3 runs each, after the deep-audit fixes (structure rules scoped by genre, tightened graders): 42/42 at 1.00, $9.15 |
| `2026-11-09-0.1.20-trigger-five-skills.json` | the five `trigger-*` cases, 3 runs, all 1.00, $2.26 |
| `2026-11-10-0.1.33-holdout3-eight-cases.json` | second held-out round, 8 cases, 5 runs per arm, $12.45 (`technical-writing` −0.07 on `report-export`) |
| `2026-11-10-0.1.33-holdout3-report-export-diagnostic-1.json`, `-2.json` | the two `report-export` diagnostics: 3 of 3 pass with-skill, then the `--keep-temp` run that showed the grader rejects correct notes |
| `2026-11-10-0.1.33-holdout4-technical-writing.json` | third round, 2 cases, 5 runs per arm, $3.26 |
| `2026-11-10-0.1.33-holdout5-technical-writing.json` | fourth round, 2 cases, 5 runs per arm, 1.00 / 1.00, $2.93 |
| `2026-11-10-0.1.33-trigger-personal-voice.json` | `trigger-personal-voice` rerun on the 0.1.33 description, 3 of 3, $0.35 |
| `2026-11-12-0.1.34-personal-voice-four-blind.json` | `personal-voice` with `voice_stats.py`, `holdout2-*` and `holdout3-*`, 5 runs per arm, $6.25 |
| `2026-11-12-0.1.34-terse-lower-trace.json`, `2026-11-12-0.1.35-terse-lower-caps.json` | `terse-lower` kept-trace run (3 per arm, $0.81) and the 0.1.35 all-caps rerun (5 per arm, $1.51) |
| `2026-11-12-0.1.36-document-review-five.json` | `document-review` with `doc_check.py`, five cases, 5 runs per arm, $8.39 |
| `2026-11-12-0.1.36-fifth-round-interrupted.json` | partial first run of the fifth round, stopped when the session ended, $7.68; superseded by the next three files |
| `2026-11-12-0.1.36-fifth-round-holdout4.json`, `-holdout6.json`, `-humanize-en.json` | fifth round, eight hard blind cases (plus two older `holdout4-technical-writing-*` reruns), 5 runs per arm, $19.40 |
| `2026-11-12-0.1.36-personal-voice-trace.json` | kept-trace run of the two `holdout4-personal-voice-*` cases, 3 per arm, $2.18 |
| `2026-11-12-0.1.37-personal-voice-tuned.json` | 0.1.37 on the same two cases after tuning, 5 per arm, $3.82 (not blind) |
| `2026-11-12-0.1.37-personal-voice-fresh-blind.json` | fresh blind `holdout5-personal-voice-*` pair, 5 per arm, $3.30 |
