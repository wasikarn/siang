#!/usr/bin/env bash
# Plants five of the user's PR review comments and one review by a teammate (Marco), labelled as not the user's.
# Shared habits (all five user samples): lowercase line labels "blocking:" / "nit:" / "q:"; code cited as
# `path/file.go:LINE` in backticks; suggestions phrased with "we" ("could we", "we should", "let's"), never
# "you"/"please". One-offs, one sample each, not to be copied: "cc @dana" (sample-2), "FWIW" (sample-4).
# Marco's sample: "Great work", rocket emoji, "IMHO", "LGTM". draft.md is the model's output, absent here.
mkdir -p samples

cat > samples/review-config-loader.md <<'EOF'
blocking: `config/load.go:31` swallows the parse error and returns an empty Config. could we return it instead? callers already check err.

nit: `config/load.go:47` uses `cfgPath` and `path` for the same thing. can we pick one?

q: is the env override meant to win over the file? the README says the opposite.
EOF

cat > samples/review-invoice-rounding.md <<'EOF'
blocking: `billing/invoice.go:88` rounds each line before summing, so totals drift by a cent on big invoices. we should sum in cents and round once.

q: `billing/invoice_test.go:20` only covers one line item. could we add a case with three?

cc @dana since she owns the tax bits
EOF

cat > samples/review-handler-header.md <<'EOF'
nit: `api/handler.go:15` imports both log and slog. let's drop log.

blocking: `api/handler.go:62` writes the header after the body, so the 404 never reaches the client. could we move WriteHeader up?
EOF

cat > samples/review-job-queue.md <<'EOF'
q: `jobs/queue.go:104` takes a mutex here but `jobs/worker.go:30` uses a channel for the same map. not against it, just want to understand why.

FWIW the old queue had the same race and nobody hit it in two years.

nit: typo in `jobs/queue.go:9`, "recieve".
EOF

cat > samples/review-session-compare.md <<'EOF'
blocking: `auth/session.go:77` compares tokens with ==. we should use subtle.ConstantTimeCompare.

nit: `auth/session.go:80` the comment still says 24h, the code says 12h. can we fix the comment?
EOF

cat > samples/forwarded-marco-review.md <<'EOF'
(Not my writing. This is Marco's review on another PR in the same repo, forwarded to me.)

Great work on this one! 🚀

IMHO the retry helper should live in its own package. Also, you might want to add a few more tests around the edge cases.

LGTM overall, nice job!
EOF
