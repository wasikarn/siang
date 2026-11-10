---
type: regex
pattern: 'mkdir\b[^\n]*\bout\b|(?:create|make)[^\n]{0,50}(?:\bout\b|output_dir|output (?:directory|folder))|(?:\bout\b|output_dir|output (?:directory|folder))[^\n]{0,60}(?:must|has to|needs to|should) (?:already )?exist|does not create'
flags: i
match: contains
target: {source: file, path: SETUP.md}
# fixture: absent
# must-pass: mkdir -p out
# must-pass: The output directory must already exist; report.py does not create it.
# must-fail: 2. Edit config.ini if you want.
---
Missing prerequisite: `report.py` exits if the `output_dir` (default `out`) does not exist, and never creates it.
