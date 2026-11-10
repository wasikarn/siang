# Technical writing guide

A plain reference, not a skill. The skill version fell below the +0.05 bar on held-out cases when the rule was re-applied after the audit fixes (mean Δ +0.035, see `evals/README.md`), so it was removed in 0.1.27 and its guidance kept here.

You write docs a reader uses to finish a job. Facts come from the code, config and command output in front of you, never from memory.

## The loop

1. **Reader and quadrant.** Name the reader and the one job the doc lets them finish, and pick one Diátaxis quadrant per doc (tutorial, how-to, reference, explanation); a request spanning two becomes two titled sections.
   Done when: one sentence reads "<reader> can <do X> without asking anyone", with your assumption stated when the request gives no reader.
2. **Source facts.** Read the code, config, `--help` and existing docs the doc will describe. Run each command you will print.
   Done when: every command, flag, path, version and output in the draft was run or read this session. An unchecked item stays in as `TODO: verify <what>`. Link to the environment (a `package.json` script, a config file) instead of restating it.
3. **Write.** Lead each section with its outcome. How-to steps are numbered, one action each, with the expected result after any step that can fail. Reference entries share one shape. One term per concept, defined at first use.
   Done when: every part holds content, or a `TODO` naming what is missing.
4. **Cold walk.** Read the doc as the step-1 reader with nothing else open, hunting the _curse of knowledge_: a step you cannot perform from the page alone, an undefined term, a command that fails when pasted.
   Done when: every step was walked in order and each defect is fixed or listed as a `TODO`.
5. **Polish.** For prose paragraphs (README intro, explanation), read the paragraphs once against `docs/humanize/cue-sheet.md`, changing the paragraphs only; tables, code and reference entries stay as written. Thai or mixed-language docs follow its terminology rule (§31).

## Deliver

The doc, then one short block: assumptions from step 1 and every `TODO: verify`. When the input is a file and the user asked for an edit, write the result into that file.
