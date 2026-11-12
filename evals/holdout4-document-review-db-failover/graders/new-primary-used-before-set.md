---
type: regex
pattern: '(?:NEW_PRIMARY)[\s\S]{0,250}(?:(?:before (?:it is|it.s|its|being|step|section|the step|it exists|promotion|payment setup)|not yet|later step|later section|undefined|unset|empty|does not (?:yet )?exist|doesn.t (?:yet )?exist|not (?:been )?(?:set|defined|exported|created|assigned|generated|issued)|out of order|wrong order|order|used before|referenced before|precedes|ahead of|only (?:set|exported|assigned|created|generated) (?:in|at|by)))|(?:(?:before (?:it is|it.s|its|being|step|section|the step|it exists|promotion|payment setup)|not yet|later step|later section|undefined|unset|empty|does not (?:yet )?exist|doesn.t (?:yet )?exist|not (?:been )?(?:set|defined|exported|created|assigned|generated|issued)|out of order|wrong order|order|used before|referenced before|precedes|ahead of|only (?:set|exported|assigned|created|generated) (?:in|at|by)))[\s\S]{0,250}(?:NEW_PRIMARY)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: 4.2 step 3 uses $NEW_PRIMARY, but it is only exported in 4.3 step 3, a later step.
# must-pass: | F6 | 4.2 | `NEW_PRIMARY` is not yet set when step 3 runs |
# must-fail: Step 4.3 exports NEW_PRIMARY for the remaining steps.
# must-fail: Steps 4.2 and 4.3 are in the wrong order.
---
4.2 step 3 passes $NEW_PRIMARY to pgb-all.sh; the variable is first exported in 4.3 step 3 (standard req 7).
