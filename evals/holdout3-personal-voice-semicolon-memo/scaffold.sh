#!/usr/bin/env bash
# Plants three notes Marta wrote and a draft in generic corporate voice. Marta's shared habits: long
# sentences joined with semicolons, no contractions, and every note ends with the line "— Marta".
# The draft has none of them and carries four facts that must survive: Daniel Okafor, $48,250,
# FIN-2291 and March 14, 2026.
set -euo pipefail
mkdir -p samples

cat > samples/1.md <<'EOF'
The March close is finished; the only open item is the duplicate payment to Hartwell Freight, which the bank has agreed to reverse by Friday. I do not expect it to affect the quarter, although I would prefer that nobody approves a Hartwell invoice until the reversal posts. The reconciliation workbook is in the shared drive under the usual name; the tab marked "exceptions" lists the three entries I could not match, and each has a note explaining what I tried.

— Marta
EOF

cat > samples/2.md <<'EOF'
I reviewed the travel claims for February; most were in order, but four were submitted without receipts and two exceeded the hotel limit without a recorded approval. I have returned all six to their owners with a short explanation. It is not a large amount of money; it is, however, the third month in a row that the same pattern has appeared, and I think the policy needs one clear sentence about what happens to a claim that arrives incomplete.

— Marta
EOF

cat > samples/3.md <<'EOF'
The auditors will be on site from the 9th to the 11th; they have asked for the fixed asset register, the lease schedule and the board minutes for the year. I have prepared the first two, and I have asked the company secretary for the third. If anyone is contacted directly, please answer only what is asked and copy me on the reply; it is easier to keep the record consistent when one person holds it.

— Marta
EOF

cat > draft.md <<'EOF'
Subject: Exciting Update on the Q3 Vendor Reconciliation! 🎉

Hi team,

I hope this email finds you well! I'm thrilled to share that we've made great progress on the Q3 vendor reconciliation.

Here's a quick summary:
- Daniel Okafor has completed the review of all outstanding invoices.
- We've identified a variance of $48,250 that we'll need to address.
- The issue is being tracked in ticket FIN-2291.
- The corrected ledger is due on March 14, 2026.

This is a real game-changer for our month-end process, and we couldn't have done it without everyone's hard work. Let's keep the momentum going!

Please don't hesitate to reach out if you have any questions.

Best regards,
The Finance Team
EOF
