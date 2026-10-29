@orv2- https://moti-imb.atlassian.net/browse/ORV2-
Feature: As a user I need the system to validate interaxle spacing exceptions for jeeps so that STOW applications comply with policy spacing exceptions.

User = PC, SA, TRAIN, CTPO, CA, PA

# Definitions
 Interaxle spacing is the longitudinal distance separating two axle units measured from the centers of the closest axles.
 Axle Group Spacing is the longitudinal distance separating two axle groups measured from the centers of the furthest axles within each axle unit.

# Standard Inter-axle Spacing
 Diagrams: 
  Single to Tandem: X---XO
  Tandem to Tandem: OX---XO
  Tandem to Tridem: OX---XOO
  Tridem to Tridem: OOX---XOO

# Standard Legal Interaxle Spacings
 For standard commercial vehicles operating at standard legal weights, the minimum interaxle spacing is determined by the types of adjacent axle groups:

 | Leading Axle Group | Trailing Axle Group | Minimum Legal Spacing |
 | Single Axle        | Single Axle         | 3.0 m                 |
 | Single Axle        | Tandem Axle         | 3.0 m                 |
 | Single Axle        | Tridem Axle         | 3.0 m                 |
 | Tandem Axle        | Tandem Axle         | 5.0 m                 |
 | Tandem Axle        | Tridem Axle         | 5.5 m                 |
 | Tridem Axle        | Tridem Axle         | 6.0 m                 |

 Note: If a vehicle satisfies these minimum distances, its axle units are allowed their full standard legal weight limits.

# Evaluation States
 1. UNPERMITTED_LEGAL Operating legally under standard regulations. No overload permit required.
 2. VALID_OVERLOAD Overload permit REQUIRED. The weight is valid for heavy-haul transport.
 3. OVERWEIGHT_VIOLATION Exceeds the maximum allowable permit ceiling. Permit REJECTED / UNPERMITTABLE without extraordinary load approval.

# Inter-axle and Axle Group Spacing Rules
 @orv2-6069-1
 Rule: Tandem drive with single axle jeep qualifies for axle group permittable maximum weight exceptions if the interaxle spacing falls within 1.2 m and 3.5 m limits; otherwise, the standard permit process applies or if the Bridge Formula must be checked and potentially governs the maximum allowable weight

  See the overweight dimension set for specific interaxle spacing requirements filter on:
  | Trailer Type       | Trailer Axle Unit Type | Power Unit/Trailer Category | Power Unit Drive/Trailer Axle Unit Type |
  | ------------------ | --------------------   | --------------------------  | ------------------------------------    |
  | Jeeps              | Single                 | Power Unit                  | Tandem                                  |

  Scenario Outline: Evaluating permittable max weight across axle group spacing tiers
    Given a tandem drive tractor paired with a single axle jeep
     When evaluating overweight permit allowances for an axle group spacing of "<group_spacing>" and an inter-axle spacing of "<interaxle_spacing>"
     Then the permittable max group weight is "<permittable_max>"
      And does the Bridge Formula override the permittable max group weight? "<check_bridge_formula_cap>"
      And the legal maximum group weight is "<legal_max>"

       Examples:
         | tier_description      | group_spacing | interaxle_spacing | permittable_max    | check_bridge_formula_cap | legal_max                                |
         | Below Minimum Spacing | < 2.40 m      | < 1.20 m          | 24000 kg           | No                      | 24000 kg (Greater of 24,000 or 7.17)     |
         | Permit Tier 1 Lookup  | 2.40 - 3.00 m | 1.20 - 3.00 m     | 28000 kg           | No                      | 24000 kg (Greater of 24,000 or 7.17)     |
         | Permit Tier 2 Lookup  | 3.01 - 3.70 m | 3.01 - 3.50 m     | 29000 kg           | No                      | 24000 kg (Greater of 24,000 or 7.17)     |
         | Extended Spacing      | > 3.70 m      | > 3.50 m          | Bridge Formula Cap | Yes                     | Governed by Table 7.17 (if <= 8 m) or BF |

  Scenario: interaxle spacing outside jeep exception limits
    Given the vehicle has a single axle jeep
      And interaxle spacing between axle unit <axleUnitX> and axle unit <axleUnitY> is outside 1.2 m to 3.5 m
     Then the interaxle spacing exception result is invalid
      And the violation message is "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be between <A> and <b> m."
      And the Interaxle Spacing field is indicated with a red border

 @orv2-6069-2
 Rule: Multi-axle jeeps (tandem and tridem) require minimum 4.2 m inter-axle spacing under permit

  See the overweight dimension set for specific interaxle spacing requirements filter on:
  | Trailer Type       | Trailer Axle Unit Type |
  | ------------------ | --------------------   |
  | Jeeps              | Tandem                 |
  | Jeeps              | Tridem                 |

  Scenario Outline: Inter-axle spacing requirements for tandem and tridem jeeps under permit
    Given a heavy haul vehicle combination equipped with a "<jeep_type>"
     When operating under an overweight permit
     Then the inter-axle spacing to adjacent axle groups must be at least "<min_interaxle_spacing>"
      And the permittable max unit weight for the jeep shall be "<permittable_unit_max>"

    Examples:
      | jeep_type   | min_interaxle_spacing | permittable_unit_max |
      | Tandem Jeep | 4.20 m                | 23000 kg             |
      | Tridem Jeep | 4.20 m                | 28000 kg             |

  Scenario: interaxle spacing below minimum for jeep
     Given the vehicle has a tandem jeep and an adjacent trailer axle group
       And the interaxle spacing is 4.19 m
      Then the interaxle spacing exception result is invalid
       And the violation message is "Interaxle Spacing between <axleUnitX> and <axleUnitY> must be at least <min_interaxle_spacing> m."

# Notes

 Rule: Vehicle weights between Legal Max and Permittable Max constitute valid, permittable overloads

   Scenario Outline: Evaluating weight and permit status across the 4 axle group spacing rows
     Given a tandem drive tractor and single axle jeep combination
     When evaluating a group weight of "<actual_weight>" with axle group spacing of "<group_spacing>" and inter-axle spacing of "<interaxle_spacing>"
     Then the Legal Max group weight is "<legal_max>"
     And the Permittable Max group weight is "<permittable_max>"
     And the system compliance status is "<compliance_status>"
     And the overload permit requirement is "<permit_required>"
     And the permit decision is "<permit_approval>"

     Examples:
       | description                       | group_spacing | interaxle_spacing | actual_weight | legal_max | permittable_max | compliance_status    | permit_required | permit_approval      |
       | Below Min Spacing (Legal)         | < 2.40 m      | < 1.20 m          | 23000 kg      | 24000 kg  | 24000 kg        | UNPERMITTED_LEGAL    | False           | NOT_REQUIRED         |
       | Below Min Spacing (Exceeds Limit) | < 2.40 m      | < 1.20 m          | 26000 kg      | 24000 kg  | 24000 kg        | OVERWEIGHT_VIOLATION | True            | REJECTED_EXCEEDS_CAP |
       | Tier 1 (Unpermitted Legal)        | 2.40 - 3.00 m | 1.20 - 3.00 m     | 23500 kg      | 24000 kg  | 28000 kg        | UNPERMITTED_LEGAL    | False           | NOT_REQUIRED         |
       | Tier 1 (Valid Overload)           | 2.40 - 3.00 m | 1.20 - 3.00 m     | 27500 kg      | 24000 kg  | 28000 kg        | VALID_OVERLOAD       | True            | CAN SUBMIT           |
       | Tier 1 (Overweight Violation)     | 2.40 - 3.00 m | 1.20 - 3.00 m     | 29000 kg      | 24000 kg  | 28000 kg        | OVERWEIGHT_VIOLATION | True            | REJECTED_EXCEEDS_CAP |
       | Tier 2 (Unpermitted Legal)        | 3.01 - 3.70 m | 3.01 - 3.50 m     | 24000 kg      | 24000 kg  | 29000 kg        | UNPERMITTED_LEGAL    | False           | NOT_REQUIRED         |
       | Tier 2 (Valid Overload)           | 3.01 - 3.70 m | 3.01 - 3.50 m     | 28500 kg      | 24000 kg  | 29000 kg        | VALID_OVERLOAD       | True            | CAN SUBMIT           |
       | Tier 2 (Overweight Violation)     | 3.01 - 3.70 m | 3.01 - 3.50 m     | 30000 kg      | 24000 kg  | 29000 kg        | OVERWEIGHT_VIOLATION | True            | REJECTED_EXCEEDS_CAP |
       | Extended Spacing (Valid Overload) | > 3.70 m      | > 3.50 m          | 32000 kg      | 24000 kg  | 34000 kg (BF)   | VALID_OVERLOAD       | True            | CAN SUBMIT           |
       | Extended Spacing (Exceeds BF Cap) | > 3.70 m      | > 3.50 m          | 35000 kg      | 24000 kg  | 34000 kg (BF)   | OVERWEIGHT_VIOLATION | True            | REJECTED_EXCEEDS_CAP |