---
type: regex
pattern: 'let me know if|feel free to|hope (?:this|that) helps|happy to (?:help|answer|discuss)|reach out|in conclusion|in summary|to sum (?:it )?up|^(?:overall|ultimately|in short|all in all),'
flags: im
match: not_contains
target: {source: file, path: INCIDENT-2291.md}
# must-pass: - Load-test v3.18.3 at twice peak traffic before it ships.
# must-pass: Questions go to #payments-gateway.
# must-fail: Let me know if you have any questions or need further details!
# must-fail: Overall, the fix is in place.
---
The chat closer ("Let me know if you have any questions") and the "Overall," summary opener go, and the rewrite adds no other stock opener or closer (In summary, Feel free to, Hope this helps, reach out).
