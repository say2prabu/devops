---
title: Deployment Approval Required if the requested resource is more than 10.
labels: deployment-requested
---

Deployment Approval requested from {{ payload.sender.login}}.
Comment "Approved" to kick the deployment off

```json target_payload
   {
        "runNumber": {{ env.RUNNUMBER }}
   }
```