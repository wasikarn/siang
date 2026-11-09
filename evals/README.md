# Evals

Eight cases for `siang:humanize` in `claude plugin eval`'s native layout (tag `humanize`):
six planted cases (English prose, Thai standup, Thai UI copy, Thai customer-chat reply, Thai
maintenance notice for §56 dates and numbers, Thai release note for §31 spelling), a clean human-written control
that must survive lightly edited, and a file-input case that proves the prose-only constraint
(frontmatter and code block byte-identical, graded on the file's contents).

Each case is `prompt.md` (invokes the skill by `skill: "siang:humanize"`), `case.yaml` (a
`scaffold_script` that writes the fixture), and `graders/`. `skill-fired.md` is
`tool_used: Skill`; the regex graders assert a planted tell is absent (`not_contains`) or a source
specific is kept (`contains`). A `contains` grader marked `# fixture: absent` checks a corrected
form instead (`3 กุมภาพันธ์ 2570`, `ลิงก์`), so the self-test requires it to miss the fixture:
returning the source unchanged must fail it. The two newest cases use regex graders only, so their
scores don't move with the LLM judge.

Run from the repo root: `claude plugin eval . --scaffold --tag humanize --allow-tools "Bash,Edit,Write" --runs 1 --no-publish` (add `--trust-plugin` outside an interactive terminal; without the tool grant the file case cannot write and scores 0.60) (each run is a paid API call).

Free check, no API call: `bash tests/test-graders.sh` proves every prompt invokes
`siang:humanize` and every regex grader compiles as a JS RegExp and matches its scaffolded fixture
(so a `not_contains` grader can fail and a `contains` grader can pass).

## Known gap

- **Invented facts in rewrites.** The Grit Gate's fabrication boundary (no new fact, number,
  cause, name or result) has no grader. A one-word haiku judge could not check it in either
  phrasing: written "PASS unless", it passed every planted invention; written "Score 1 only if",
  it failed correct replies 3/3. Presence of the source's specifics is checked by regex instead.
