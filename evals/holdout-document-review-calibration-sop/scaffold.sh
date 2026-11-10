#!/usr/bin/env bash
cat > standard.md <<'FIXTURE_EOF'
# LAB-STD-02: Standard for calibration SOPs

Every calibration SOP in the lab follows this standard.

## Required sections, in this order

1. Purpose
2. Scope
3. Equipment and materials
4. Safety
5. Procedure
6. Acceptance criteria
7. Records

## Rules

- R1. Every measured or set quantity states its SI unit (or rpm for stirrer speed).
- R2. A cross-reference names a section that exists in the same SOP.
- R3. Every solution, standard or item a procedure step uses is prepared or listed before that step.
- R4. A number stated in two places has the same value in both.
- R5. A claim about accuracy or compliance cites its source (certificate, manufacturer manual or validation report).
FIXTURE_EOF
cat > sop-ph-meter.md <<'FIXTURE_EOF'
# SOP-CAL-114: Calibration of the bench pH meter (PH-3)

## 1. Purpose

This SOP describes the two-point calibration of bench pH meter PH-3 in lab room 2.04.

## 2. Scope

Applies to pH meter PH-3 only. The meter is calibrated every 14 days, and before any batch release test.

## 3. Equipment and materials

- pH meter PH-3 with combination electrode
- Certified pH 4.01 buffer (sealed bottle, lot recorded at use)
- Purified water for rinsing
- Magnetic stirrer and stir bar
- Two clean 50 mL beakers

## 5. Procedure

1. Switch on PH-3 and let it warm up for 15 min.
2. Rinse the electrode with purified water and blot dry.
3. Place the electrode in buffer B-7 and press CAL. Wait until the reading is stable.
4. Rinse the electrode, place it in the pH 4.01 buffer and press CAL again.
5. Run the stirrer at 300 during both readings.
6. Prepare buffer B-7: pour 40 mL of certified pH 7.00 buffer into a clean beaker and bring it to 25 °C.
7. Store the electrode in its storage cap. For disposal of used buffer, see section 8.

## 6. Acceptance criteria

The calibration slope must be between 95 % and 105 %. The offset must be within ±15 mV.

## 7. Records

Record the slope, offset, buffer lot numbers and date in the PH-3 logbook. The next calibration is due 21 days after this one.
FIXTURE_EOF
cat > review.md <<'FIXTURE_EOF'
Status: no issues found
FIXTURE_EOF
