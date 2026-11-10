#!/usr/bin/env bash
# Plants policy.md (a user access review policy) and control-standard.md (the internal control it must
# meet). Six planted defects: dormancy 45 days in §4 vs 45 hours in the §6 table (unit), the Reviewer
# Matrix used in step 2 but created in step 5 (step before it exists), "section 11" that does not exist
# (dangling reference), revocation within 48 hours in §5 vs 72 hours in step 6 (contradicted number), no
# Evidence retention section (required by the control), "no orphan accounts exist" with no evidence
# (unverifiable claim). Clean on purpose: privileged accounts reviewed monthly (stricter than the
# control's quarterly minimum, so compliant), and standard accounts reviewed quarterly.
cat > control-standard.md <<'EOF'
# ICS-AC-07: User access review control

A policy that implements this control must meet every point below.

AC-07.1 Sections required: Purpose, Scope, Roles, Review frequency, Dormant accounts, Revocation,
        Procedure, Exceptions, Evidence retention, Approval.
AC-07.2 Standard user access is reviewed at least quarterly; privileged access at least quarterly.
        A policy may set a shorter interval.
AC-07.3 Accounts with no login for 90 days or more must be disabled. A policy may set a shorter limit.
AC-07.4 Access found inappropriate in a review is revoked within 72 hours of reviewer sign-off.
        The policy states one revocation deadline and uses it everywhere.
AC-07.5 Every procedure step may only rely on a list, role or artefact that already exists when the
        step runs.
AC-07.6 Cross-references must resolve to a section of the same policy.
AC-07.7 Statements of coverage or completeness (for example "all systems", "no accounts") must cite
        the evidence that supports them.
AC-07.8 Review evidence (exports, sign-offs, revocation tickets) is retained for at least 24 months.
EOF
cat > policy.md <<'EOF'
# POL-SEC-021: User access review policy

Version 2.0 · Owner: Head of IT Security · Effective 2026-10-01

## 1. Purpose

Make sure every person keeps only the access their job needs, by reviewing user access on a fixed
schedule and removing access that is no longer justified.

## 2. Scope

All production applications, databases and cloud accounts listed in the system inventory (CMDB),
for employees, contractors and service accounts. All systems in scope are covered by automated SSO
deprovisioning, so no orphan accounts exist.

## 3. Roles

- Access owner: the system owner named in the CMDB. Signs off the review for their system.
- IT Security: runs the review cycle and tracks revocations.
- Service desk: carries out revocations.

## 4. Review frequency and dormant accounts

- Standard user access is reviewed quarterly.
- Privileged access (admin, root, DBA, cloud owner roles) is reviewed monthly.
- Accounts with no login for 45 days are disabled automatically.

## 5. Revocation

Access the reviewer marks as not needed is revoked within 48 hours of reviewer sign-off.

## 6. Thresholds at a glance

| Item | Value |
|---|---|
| Standard review | Quarterly |
| Privileged review | Monthly |
| Dormancy limit | 45 hours |

## 7. Procedure

Step 1. IT Security exports the current user list of each in-scope system from the CMDB connectors.
Step 2. IT Security sends each export to the reviewer assigned to that system in the Reviewer Matrix.
Step 3. The reviewer marks each account keep or remove and signs off in the review ticket.
Step 4. IT Security checks every export was signed off; unsigned exports are escalated to the CISO.
Step 5. IT Security creates the Reviewer Matrix for the cycle from the CMDB system owners.
Step 6. The service desk revokes every account marked remove within 72 hours of sign-off and links
        the revocation ticket to the review ticket.
Step 7. IT Security closes the cycle once all revocation tickets are done.

## 8. Exceptions

An access owner may keep access that the review flags, for at most 90 days, with written CISO
approval recorded in the review ticket. Escalation of disputed exceptions follows section 11.

## 9. Approval

Approved by the CISO on 2026-09-20.
EOF
