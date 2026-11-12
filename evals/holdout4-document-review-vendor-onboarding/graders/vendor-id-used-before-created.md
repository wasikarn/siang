---
type: regex
pattern: '(?:vendor[ _-]?ID)[\s\S]{0,250}(?:(?:before (?:it is|it.s|its|being|step|section|the step|it exists|promotion|payment setup)|not yet|later step|later section|undefined|unset|empty|does not (?:yet )?exist|doesn.t (?:yet )?exist|not (?:been )?(?:set|defined|exported|created|assigned|generated|issued)|out of order|wrong order|order|used before|referenced before|precedes|ahead of|only (?:set|exported|assigned|created|generated) (?:in|at|by)))|(?:(?:before (?:it is|it.s|its|being|step|section|the step|it exists|promotion|payment setup)|not yet|later step|later section|undefined|unset|empty|does not (?:yet )?exist|doesn.t (?:yet )?exist|not (?:been )?(?:set|defined|exported|created|assigned|generated|issued)|out of order|wrong order|order|used before|referenced before|precedes|ahead of|only (?:set|exported|assigned|created|generated) (?:in|at|by)))[\s\S]{0,250}(?:vendor[ _-]?ID)'
flags: i
match: contains
target: {source: file, path: review.md}
# fixture: absent
# must-pass: 3.2 step 4 enters the vendor ID, but the ERP system only assigns it in 4.3 step 2, a later step.
# must-pass: | F6 | 3.2 | Uses `vendor ID` before it exists |
# must-fail: The ERP system assigns the vendor ID in 4.3 step 2.
# must-fail: Steps 3.2 and 4.3 are in the wrong order.
---
3.2 step 4 enters the vendor ID in the contract tracker; the ERP system assigns it in 4.3 step 2 (standard req 7).
