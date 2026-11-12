---
type: regex
pattern: 'some engineers have noted|(?:some|many) (?:engineers|experts|people|teams) (?:have )?(?:noted|observed|argued|believe|feel|agree)|experts agree|it is (?:widely|generally|often) (?:known|accepted|agreed)'
flags: i
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: Pool settings are easy to miss in a dependency upgrade, and we missed them here.
# must-pass: We did not check pool settings during the upgrade.
# must-fail: Some engineers have noted that pool settings are often overlooked during dependency upgrades.
# must-fail: Many teams believe pool settings get overlooked.
---
"Some engineers have noted" credits a claim to nobody. The rewrite states it as the team's own finding or drops it.
