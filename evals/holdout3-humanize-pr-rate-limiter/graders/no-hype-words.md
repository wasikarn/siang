---
type: regex
pattern: 'game.chang|revolutioni[sz]e|seamless|world.class|instrumental|invaluable'
flags: i
match: not_contains
target: {source: file, path: pr-description.md}
# fixture: present
---
The planted hype words (game-changing, revolutionize, seamless, world-class, instrumental, invaluable) are gone.
