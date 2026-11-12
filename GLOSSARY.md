# siang

siang repairs Thai text extracted from PDFs, and ships writing skills (`skills/humanize/`, `skills/personal-voice/`, `skills/technical-writing/`) for removing AI writing tells, drafting in a user's own voice and writing docs, plus a document-review procedure kept as a plain doc (`docs/document-review/`), in English and Thai. These are the terms its rules, evals and reviews use.

## Writing

**Tell**:
A wording or structure pattern that marks text as model-written, catalogued as a numbered section (§N).
_Avoid_: AI pattern, smell, marker

**Author fact**:
A fact that is already in the source text the user gave siang.
_Avoid_: claim, source fact

**Added fact**:
A fact that is not in the source text and would enter only through siang's rewrite.
_Avoid_: invented detail, invented grit

## Evals

**With arm / without arm**:
The two runs of one eval case: one with the siang plugin loaded, one without it.
_Avoid_: baseline, control

**Δ**:
The with-arm score minus the without-arm score for one case: the share of the result that siang itself causes.
_Avoid_: uplift, gain score
