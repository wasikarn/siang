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
| `2026-11-10-0.1.25-thai-with-only.json` | the 14 Thai cases, with-arm only, 3 runs each, after the deep-audit fixes (structure rules scoped by genre, tightened graders): 42/42 at 1.00, $9.15 |
