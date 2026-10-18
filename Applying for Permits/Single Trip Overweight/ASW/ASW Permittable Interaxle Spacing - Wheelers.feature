@orv2-6071 https://moti-imb.atlassian.net/browse/ORV2-6071
Feature:   As a commercial vehicle policy engine
  I want to evaluate inter-axle spacing measurements for standard and wide wheeler configurations
  So that major vehicle separations, tractor-to-wheeler gaps, and group weight rules are strictly enforced under B.C. CTPM policy.

User = PC, SA, TRAIN, CTPO, CA, PA

# Definitions
 Interaxle spacing is the longitudinal distance separating two axle units measured from the centers of the closest axles.
 Axle Group Spacing is the longitudinal distance separating two axle groups measured from the centers of the furthest axles within each group.

# Inter-axle Spacing
 Diagrams: 
  Single to Tandem: X---XO
  Tandem to Tandem: OX---XO
  Tandem to Tridem: OX---XOO
  Tridem to Tridem: OOX---XOO

# Standard Legal Interaxle Spacings (No Permit Required)
 For standard commercial vehicles operating at standard legal weights, the minimum interaxle spacing is determined by the types of adjacent axle groups:

 | Leading Axle Group | Trailing Axle Group | Minimum Legal Spacing |
 | Single Axle        | Single Axle         | 3.0 m                 |
 | Single Axle        | Tandem Axle         | 3.0 m                 |
 | Single Axle        | Tridem Axle         | 3.0 m                 |
 | Tandem Axle        | Tandem Axle         | 5.0 m                 |
 | Tandem Axle        | Tridem Axle         | 5.5 m                 |
 | Tridem Axle        | Tridem Axle         | 6.0 m                 |

 Note: If a vehicle satisfies these minimum distances, its axle units are allowed their full standard legal weight limits.

# Front-to-Back Major Separation for Wheelers 
 @orv2-6071-1
 Rule: Front-half to back-half major separation must be at least 7.00 m for wheeler combinations

     Scenario Outline: Evaluating major front-to-back wheeler separation distance
       Given a wheeler vehicle combination with a "<wheeler_type>" axle group in the trailer
       When evaluating the inter-axle spacing between the rearmost drive/jeep axle in the front half and the first trailer/dolly axle in the back half of "<actual_spacing>"
       Then the front-to-back separation status shall be "<separation_status>"
       And the Table 7.17 applicability flag shall be "<check_table_717>"
       And the permittable max group weight rule shall be "<permittable_max_rule>"

       Examples:
         | wheeler_type    | actual_spacing | separation_status | check_table_717 | permittable_max_rule                                      |
         | 16-Wheel Tandem | 7.50 m         | PASS              | False           | 31,000 kg (PAW85K / Standard Wheeler)                     |
         | 16-Wheel Tandem | 6.50 m         | REJECT_TOO_SHORT  | True            | Reverts to Table 7.17 / Standard Heavy Haul Cap           |
         | 24-Wheel Tridem | 8.20 m         | PASS              | False           | 40,000 kg (PAW85K / Standard Wheeler)                     |
         | 24-Wheel Tridem | 6.80 m         | REJECT_TOO_SHORT  | True            | Reverts to Table 7.17 / Standard Heavy Haul Cap           |
         | Wide 24-Wheeler | 7.10 m         | PASS              | False           | Wide Wheeler Matrix (40,000 kg to 52,000 kg by Clear Gap) |

  Scenario: invalid wheeler spacing
   Given the vehicle is a standard wheeler
    And the last drive or jeep axle is in the front half of the vehicle
    And the first trailer or dolly axle is in the back half of the vehicle
    When a user inputs interaxle spacing of 6.99 m between those axle groups
    Then they see the violation "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 7.0 m."
     And interaxle spacing is indicated with a red border

# Inter-Axle Gap Between Tractor Drive Unit and Front-Most Wheeler/Jeep
 @orv2-6071-2
 Rule: Inter-axle gap between tractor drive unit and front-most wheeler/jeep must be between 4.20 m and 7.20 m

   Scenario Outline: Evaluating tractor drive to front-most wheeler gap
     Given a tractor paired with a front-mounted wheeler jeep or wheeler unit
     When evaluating the inter-axle spacing between the tractor rearmost drive axle and the front-most wheeler axle of "<gap_distance>"
     Then the tractor-to-wheeler gap compliance status shall be "<gap_status>"
     And the permit approval decision shall be "<permit_decision>"

     Examples:
       | scenario_description      | gap_distance | gap_status         | permit_decision                   |
       | Compliant Mid-Range Gap   | 5.50 m       | PASS               | APPROVED                          |
       | Compliant Minimum Gap     | 4.20 m       | PASS               | APPROVED                          |
       | Compliant Maximum Gap     | 7.20 m       | PASS               | APPROVED                          |
       | Gap Below 4.20 m Minimum  | 3.80 m       | REJECT_TOO_SHORT   | REJECTED_INVALID_INTERAXLE_GAP    |
       | Gap Exceeds 7.20 m Maximum| 7.60 m       | REJECT_TOO_LONG    | REJECTED_INVALID_INTERAXLE_GAP    |

  Scenario: too short tractor-to-wheeler gap
    Given a tractor paired with a front-mounted wheeler jeep or wheeler unit
    When when a user inputs an inter-axle spacing of "3.80 m" between the tractor rearmost drive axle and the front-most wheeler axle
    Then they see the violation "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 4.20 m."
     And interaxle spacing is indicated with a red border

   Scenario: too long tractor-to-wheeler gap
     Given a tractor paired with a front-mounted wheeler jeep or wheeler unit
     When when a user inputs an inter-axle spacing of "7.60 m" between the tractor rearmost drive axle and the front-most wheeler axle
     Then they see the violation "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must not exceed 7.20 m."
      And interaxle spacing is indicated with a red border

# General clear inter-axle spacing between adjacent wheeler axle groups
 @orv2-6071-3
 Rule: General clear inter-axle spacing between adjacent wheeler axle groups must be at least 4.20 m

   Scenario Outline: Evaluating spacing between consecutive wheeler axle groups
     Given a multi-wheeler combination containing consecutive wheeler axle groups
     When evaluating the clear inter-axle spacing between adjacent wheeler groups of "<group_gap>"
     Then the group-to-group spacing status shall be "<group_spacing_status>"
     And the Bridge Formula check flag shall be "<check_bridge_formula>"

     Examples:
       | group_gap | group_spacing_status | check_bridge_formula                    |
       | 4.50 m    | PASS                 | True                                    |
       | 4.20 m    | PASS                 | True                                    |
       | 3.60 m    | REJECT_TOO_SHORT     | False (Reverts to CTR 7.17 Table limit) |

   Scenario: Invalid tractor-to-wheeler gap
     Given a tractor paired with a front-mounted wheeler jeep or wheeler unit
     When when a user inputs an inter-axle spacing of "3.80 m" between the tractor rearmost drive axle and the front-most wheeler axle
     Then they see the violation "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 4.20 m."
     And interaxle spacing is indicated with a red border

# Notes
 The 7.0 m Spacing Rule: For both standard and wide wheelers, the interaxle spacing between the last drive or jeep axle in the front half of the vehicle and the first trailer or dolly axle in the back half must be at least 7.0 m.

 Platform Trailers: These multi-axle configurations rely on specific spacing thresholds. Single axle groups must be a minimum of 1.5 m apart. Tandem and tridem axle groups require a minimum of 4.2 m, and a 7.0 m threshold also applies.

 ## Regulatory Context Summary

 1. Major Separation Requirement:
    * Rule: CTPM Section 5.3.16.B and Chapter 6.3.3.D mandate that the distance between the last axle in the front half (drive unit or jeep) and the first axle in the back half (trailer or dolly) must be at least 7.00 m.
    * Table 7.17 Exclusion: Because this gap expands the total distance between extreme axles past 8.00 m, CTR Table 7.17 does not apply. The group is evaluated directly against Wheeler permit tables (31,000 kg / 40,000 kg) and the B.C. Bridge Formula.

 2. Tractor to Front Wheeler Gap:
    * Rule: Per CTPM Section 5.3.16.B, when wheeler units/jeeps are positioned directly behind the truck tractor, the inter-axle gap must fall within 4.20 m to 7.20 m.
    * Drawbar Cap: The maximum drawbar length between the tractor and first wheeler unit is 6.00 m under Motor Vehicle Act Regulations.

 3. General Group Spacing:
    * Rule: Adjacent wheeler axle groups require a minimum clear inter-axle spacing of 4.20 m. If the gap drops below 4.20 m, the groups cannot receive wheeler weight allowances and revert to standard axle group calculations under CTR 7.17(2).
