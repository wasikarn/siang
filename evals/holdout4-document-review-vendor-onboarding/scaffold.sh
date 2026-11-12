#!/usr/bin/env bash
# Plants docs/procurement-doc-standard.md (8 requirements), a long docs/vendor-onboarding-procedure.md
# and an empty review.md. The procedure reads as finished but breaks the standard in 8 places, kept
# far apart: a reference to a section that does not exist, a numbered list that skips a step, one
# retention period given two values in different units, an impossible effective date, an acronym never
# spelled out, a vendor ID used before the step that creates it, no accountable owner in the header,
# and an unsourced risk statistic.
mkdir -p docs

cat > docs/procurement-doc-standard.md <<'EOF'
# Procurement Document Standard (PRC-STD-02)

Every procurement procedure must meet these requirements before the Procurement Steering
Committee publishes it. A reviewer checks each one and records every gap.

1. **Owner.** The header names one accountable owner for the document, as a role.
2. **Version and dates.** The header states a version and an effective date. Every date in the
   document is written as YYYY-MM-DD and is a real calendar date.
3. **Acronyms.** Every acronym is spelled out at its first use. Exempt: ID, PDF, VAT and currency codes such
   as USD.
4. **Cross-references.** Every reference to a section or step points to one that exists in the
   same document.
5. **Numbering.** Sections and numbered steps run in sequence with no gaps.
6. **Consistent values.** A retention period, threshold or amount has the same value and unit
   everywhere it appears.
7. **Order.** No step uses a record, number or approval that only a later step produces.
8. **Evidence.** Any statistic or claim about vendor risk cites its source. A claim without a
   source must be marked unverified.
EOF

cat > docs/vendor-onboarding-procedure.md <<'EOF'
# Vendor Onboarding Procedure

Version: 3.2
Effective date: 2026-07-01
Last reviewed: 2026-10-20
Applies to: every new supplier of goods or services with expected annual spend above 5,000 USD

## 1. Purpose

This procedure sets out how a new vendor is requested, assessed, approved and set up for payment.
It exists so that no vendor receives a purchase order (PO) or a payment before procurement,
security and finance have each checked it.

## 2. Roles and records

### 2.1 Roles

- **Requester:** the employee who needs the vendor. Starts the request and supplies the business
  case.
- **Procurement analyst:** runs the due-diligence checks and keeps the vendor file.
- **Security reviewer:** assesses vendors that will handle company data or connect to company
  systems.
- **Finance accounts payable (AP) clerk:** sets up the vendor for payment.

### 2.2 The vendor file

Each vendor has one vendor file in the procurement shared drive. It holds the request form, the
due-diligence results, the signed contract and every approval.

### 2.3 Risk tiers

- **Tier 1:** handles personal data or connects to company systems.
- **Tier 2:** has access to company premises but not to data or systems.
- **Tier 3:** neither of the above.

### 2.4 Retention

Keep the vendor file, including all due-diligence records, for 7 years after the contract ends.

## 3. Request and screening

Performed by: Requester and Procurement analyst.

### 3.1 Submit the request

1. The Requester fills in the vendor request form on the procurement portal.
2. The Requester attaches a quote and a one-paragraph business case.
3. The Requester picks the risk tier from section 2.3.
4. The Requester's manager approves the request in the portal.

### 3.2 Screen the vendor

1. The Procurement analyst checks the vendor against the sanctions list and records the result.
2. The analyst requests the last two years of financial statements.
3. The analyst sends the mutual non-disclosure agreement (NDA) for signature.
4. The analyst enters the vendor ID in the contract tracker and links it to the request.
5. For Tier 1 vendors, the analyst forwards the request to the Security reviewer.

### 3.3 Questionnaire

All Tier 1 and Tier 2 vendors complete the vendor security questionnaire. Tier 1 vendors must
also attach a current System and Organization Controls 2 (SOC 2) Type II report or an
equivalent audit. Vendors on the preferred list have 70% fewer security incidents than other
vendors, so Tier 2 vendors on that list may skip the questionnaire.

## 4. Approval and setup

Performed by: Security reviewer, Procurement analyst and Finance AP clerk.

### 4.1 Security review

1. The Security reviewer reads the questionnaire and the audit report.
2. The Security reviewer completes the VRA and stores it in the vendor file.
3. If the result is high risk, the Security reviewer rejects the vendor and the request closes.
4. If the vendor will process personal data, the Security reviewer sends the data processing
   agreement (DPA) for signature.

### 4.2 Contract approval

1. The Procurement analyst drafts the contract from the standard template.
2. Legal reviews any change to the template clauses.
3. The budget holder approves the contract value.
4. The vendor signs the contract.
6. The company signatory signs the contract.
7. The Procurement analyst stores the signed contract in the vendor file.

### 4.3 Payment setup

1. The Finance AP clerk checks the bank details by phone with a contact named in the contract.
2. The clerk creates the vendor record in the enterprise resource planning (ERP) system, which
   assigns the vendor ID.
3. The clerk sends the vendor ID back to the Procurement analyst.
4. The vendor can now receive a PO.

## 5. Changes to an existing vendor

Performed by: Procurement analyst.

1. Bank detail changes follow section 4.3, step 1, and are never accepted by email alone.
2. A change of risk tier repeats the checks in section 3.2 and, for Tier 1, section 4.1.
3. A vendor with no spend for 24 months is set to inactive in the ERP system. Reactivation
   follows section 8.2.

## 6. Offboarding

Performed by: Procurement analyst and Finance AP clerk.

### 6.1 End the relationship

1. The Procurement analyst confirms the contract end date with the budget holder.
2. The Finance AP clerk blocks new payments in the ERP system.
3. For Tier 1 vendors, the Security reviewer confirms that access has been removed and data
   returned or destroyed.

### 6.2 Close the file

1. The Procurement analyst marks the vendor file closed.
2. Due-diligence records are deleted 60 months after the contract ends.
3. The vendor record in the ERP system is archived, not deleted.

## 7. Transition

The revised questionnaire in section 3.3 applies to every vendor onboarded on or after
2027-02-29. Vendors onboarded before that date keep their existing assessment until their next
contract renewal.
EOF

: > review.md
