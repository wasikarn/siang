# CLAUDE.md

- Validate before committing: `claude plugin validate .` and `bash tests/test-graders.sh`.
- Bump `version` in `.claude-plugin/plugin.json` on any skill change: `claude plugin update` copies
  nothing while the version is unchanged.
  `git-hooks/pre-commit` refuses a `skills/` commit without a bump; enable it once per clone with
  `git config core.hooksPath git-hooks` (relative path). Its test: `bash tests/test-version-hook.sh`.
- Skill files may contain Thai: Thai writing is the subject matter.
- New rules adapted from another project: paraphrase the rule, write a fresh example, never copy
  a source's examples or quoted third-party passages, and add the source to
  `skills/humanize/references.md` ("Sources adapted") and `THIRD_PARTY_NOTICES.md`.
- Section numbers: §1-§30 universal, §31-§42 and §53+ in `patterns-thai.md`, §43-§52 in
  `patterns-thai-structure.md`. Take the next free number; never renumber.
