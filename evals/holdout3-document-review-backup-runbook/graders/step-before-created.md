---
type: regex
pattern: 'repo-cipher|5\.4[^\n]*5\.7|5\.7[^\n]*5\.4'
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: - Step 5.4 reads the cipher file that is only fetched in step 5.7.
# must-fail: - Step 5.4 is fine.
---
Step 5.4 reads /srv/restore/repo-cipher.txt, which step 5.7 creates three steps later (standard rule 3). The finding names the file or ties 5.4 to 5.7.
