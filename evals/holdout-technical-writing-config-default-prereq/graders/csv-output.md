---
type: regex
pattern: '\.csv\b|\bCSV\b'
flags: i
match: contains
target: {source: file, path: SETUP.md}
# fixture: absent
# must-pass: You should see out/sales-2026-11-10.csv.
# must-fail: Reports are emailed to the team every hour.
---
Fact a reader needs to confirm success: the run writes a CSV file (`sales-YYYY-MM-DD.csv`) into the output directory.
