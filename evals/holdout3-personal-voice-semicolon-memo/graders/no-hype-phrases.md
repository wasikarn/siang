---
type: regex
pattern: 'hope this (?:email|message|note) finds you|hesitate to (?:reach out|contact)|thrilled|game.changer|keep the momentum|exciting update'
match: not_contains
target: {source: file, path: draft.md}
flags: i
# must-pass: If anyone has a question about the variance, please ask me directly.
# must-fail: Please don't hesitate to reach out.
---
The stock corporate phrases (hope this email finds you well, thrilled, game-changer, keep the momentum, don't hesitate to reach out) appear nowhere in Marta's notes and must be gone.
