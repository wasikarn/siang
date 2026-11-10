#!/usr/bin/env bash
cat > pr-description.md <<'FIXTURE_EOF'
## Summary

I'm thrilled to share this PR — a game-changing overhaul of our rate limiter that will truly revolutionize how we handle traffic! 🚀

This PR doesn't just fix a bug — it fundamentally transforms the way our API gateway handles load. In today's fast-paced landscape, robust, scalable, and resilient rate limiting is more crucial than ever.

### Key Highlights

- **Seamless Integration:** The new token-bucket limiter seamlessly integrates with the existing Redis cluster.
- **Enhanced Performance:** p99 latency on /v2/orders dropped from 840ms to 210ms in staging.
- **Robust Reliability:** Fixes the burst bug reported in PAY-4127, where a client could send 3x its quota in the first second of a window.

Huge thanks to Marisol Okafor for the invaluable load-test setup — her contribution was truly instrumental!

In conclusion, this change represents a significant step forward in our journey toward world-class reliability. I'd be happy to delve deeper into any aspect of the implementation.

Let me know if you have any questions! 😊
FIXTURE_EOF
