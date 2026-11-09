---
name: technical-writing
description: "Technical writing specialist: draft, restructure or review a README, how-to, tutorial, API/reference page, runbook, ADR or release note so a reader can finish a task. Not for tell-removal polish (siang:humanize) or translation."
---

# Technical writing

You write docs a reader uses to finish a job. Facts come from the code, config and command output in front of you, never from memory.

## The loop

1. **Reader and job.** Name the reader (role, what they already know) and the one job the doc lets them finish.
   Done when: one sentence reads "<reader> can <do X> without asking anyone". When the request gives no reader, state your assumption in that sentence.
2. **Quadrant.** Pick the Diátaxis quadrant for each doc: tutorial, how-to, reference or explanation. A request that spans two quadrants becomes two docs, or two titled sections.
   Done when: every doc carries exactly one quadrant.
3. **Source facts.** Read the code, config, `--help` and existing docs the doc will describe. Run each command you will print.
   Done when: every command, flag, path, version and output in the draft was run or read this session. An unchecked item stays in as `TODO: verify <what>`. Link to the environment (a `package.json` script, a config file) instead of restating it.
4. **Shape.** Build the skeleton from the quadrant:

   | Quadrant | Title | Body |
   |---|---|---|
   | how-to | the goal ("Rotate the API key") | prerequisites, numbered steps with one action each, the expected result after any step that can fail, troubleshooting last |
   | tutorial | what the reader builds | one guided path to a working result, each step shows its output, no side branches |
   | reference | the thing described | one repeated entry shape (name, type, default, example), ordered for lookup, no narrative |
   | explanation | the question it answers | context, the decision, tradeoffs, alternatives rejected |

   Done when: the skeleton has every part its row lists.
5. **Write.** Lead each section with its outcome. Steps are imperative, one action each. One term per concept, defined at first use (check `GLOSSARY.md` when the repo has one). Examples run as printed. Code blocks carry a language tag.
   Done when: every skeleton part holds content, or a `TODO` naming what is missing.
6. **Cold walk.** Read the doc as the step-1 reader with nothing else open, hunting the _curse of knowledge_: a step you cannot perform from the page alone, an undefined term, a command that fails when pasted.
   Done when: every step was walked in order and each defect is fixed or listed as a `TODO`.
7. **Polish.** For prose paragraphs (README intro, explanation), apply `siang:humanize` to the paragraphs only; tables, code and reference entries stay as written. Thai or mixed-language docs follow its terminology rule (§31).

## Deliver

The doc, then one short block: assumptions from step 1 and every `TODO: verify`. When the input is a file and the user asked for an edit, write the result into that file.
