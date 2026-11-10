# CLAUDE.md

- Validate before committing: `claude plugin validate .`, `bash tests/test-graders.sh`,
  `bash tests/test-section-refs.sh` (every §N and cue #N resolves), `bash tests/test-scan.sh`, `bash tests/test-pua.sh` and `bash tests/test-pua-pdf.sh` (skips without pikepdf and pdftotext).
- Bump `version` in `.claude-plugin/plugin.json` on any skill change: `claude plugin update` copies
  nothing while the version is unchanged.
  `git-hooks/pre-commit` refuses a `skills/` commit without a bump; enable it once per clone with
  `git config core.hooksPath git-hooks` (relative path). Its test: `bash tests/test-version-hook.sh`.
  `.github/workflows/check.yml` runs a looser version check (one bump per pushed range or PR; the hook wants one per
  commit) plus the six `tests/*.sh` scripts (listed by hand: add a new test there too) on every push and PR, so a clone without the hook is still caught
  (after the push, not before). Amending a skills/ fix into a commit that already bumped still
  needs a fresh bump, since the hook compares with HEAD.
- Skill files may contain Thai: Thai writing is the subject matter.
- New rules adapted from another project: paraphrase the rule, write a fresh example, never copy
  a source's examples or quoted third-party passages, and add the source to
  `docs/humanize/references.md` ("Sources adapted") and `THIRD_PARTY_NOTICES.md`.
- Section numbers: §1-§30 and §59-§61 universal (`patterns-universal.md`), §31-§42 and §53-§58 in
  `patterns-thai.md`, §43-§52 in `patterns-thai-structure.md`. The next free number is §62; take
  it in whichever file the rule belongs to, and never renumber.
