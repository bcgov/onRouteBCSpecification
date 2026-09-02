@orv2-5617 https://moti-imb.atlassian.net/browse/ORV2-5514 
Feature: As a user I need the system to determine the maximum legal weight threshold for axle groups where the axle spacing is 8 m or less, so that I can ensure my single trip overweight permit application uses the correct legal weight limit as defined in CTR 7.16/7.17.

users = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 5: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5617-1
Rule: for standard axle groups with a spacing of 8 m or less, the maximum legal weight threshold is determined by the lower of the sum of the applicable individual axle-unit legal weight thresholds and the CTR 7.17 table value for the group's spread

  Scenario Outline: legal threshold is determined by the lower of the sum of the applicable individual axle-unit legal weight thresholds and the CTR 7.17 table value
    Given a standard axle group (excluding axle unit 1) with a spacing of <spacing> m
      And the sum of the applicable individual axle-unit legal weight thresholds is <individualLimitSum> kg
      And the CTR 7.17 table value for the group's spread is <ctr717Value> kg
     When the system determines the maximum legal weight threshold
     Then the maximum legal weight threshold is <threshold> kg

    Examples:
      | description                                   | spacing | individualLimitSum | ctr717Value | threshold |
      | table value below individual limit sum        | 3.15    | 26100              | 21000       | 21000     |
      | table value equals individual limit sum       | 4.2     | 26100              | 26100       | 26100     |
      | table value above individual limit sum        | 5.1     | 26100              | 30000       | 26100     |
      | axle spacing near upper boundary              | 7.9     | 26100              | 33000       | 26100     |

@orv2-5617-2
Rule: for the tandem-drive/single-jeep axle-group exception in Section 7.16(g), the maximum legal weight threshold is the greater of 24,000 kg and the CTR 7.17 table value for the group's spread

  Scenario Outline: legal threshold is determined by the greater of 24,000 kg and the CTR 7.17 table value for the tandem-drive/single-jeep axle-group exception
    Given a tandem-drive/single-jeep axle group with a spacing of <spacing> m
      And the CTR 7.17 table value for the group's spread is <ctr717Value> kg
     When the system determines the maximum legal weight threshold
     Then the maximum legal weight threshold is <threshold> kg

    Examples:
      | description                           | spacing | ctr717Value | threshold |
      | table value below 24,000 kg           | 4.2     | 21000       | 24000     |
      | table value equals 24,000 kg          | 5.0     | 24000       | 24000     |
      | table value above 24,000 kg           | 6.3     | 27000       | 27000     |

@orv2-5617-3
Rule: axle groups with a spacing greater than 8 m rely on the sum of the applicable individual axle-unit legal weight thresholds because the CTR 7.17 table and the CTR 7.16(g) threshold do not apply

  Scenario: axle spacing exceeds 8 m
    Given an axle group with a spacing of 8.1 m
     When the system determines the maximum legal weight threshold
     Then the system uses the sum of the applicable individual axle-unit legal weight thresholds for the axle group

@orv2-5617-4
Rule: the system evaluates all axle-group combinations for a vehicle configuration and applies this evaluation to each combination with a spacing of 8 m or less

  Scenario: all axle-group combinations are evaluated
    Given a vehicle configuration with multiple axle units
      And axle groups are combinations of 2 or more axle units
     When the system evaluates axle-group spacing for the vehicle configuration
     Then all axle-group combinations are evaluated

  Scenario: only axle-group combinations with spacing of 8 m or less are selected for threshold determination
    Given a vehicle configuration has the following axle-group combinations:
      | axle-group combination | spacing |
      | group A                | 7.8 m   |
      | group B                | 8.0 m   |
      | group C                | 8.1 m   |
     When the system evaluates axle-group spacing for the vehicle configuration
     Then group A and group B are selected for maximum legal weight threshold determination
      And group C is not selected for CTR 7.16(g) threshold determination

@orv2-5617-5
Rule: the legal threshold is used to determine compliance first, and overload is assessed only when actual axle-group weight exceeds that threshold

  Scenario Outline: assess compliance and overload after legal threshold is established
    Given an eligible axle group has a legal threshold of <legalThreshold> kg
      And the actual axle-group weight is <actualWeight> kg
     When the system evaluates the axle group against the legal threshold
     Then the compliance result is <complianceResult>
      And the overload amount is <overloadAmount> kg

    Examples:
      | legalThreshold | actualWeight | complianceResult | overloadAmount |
      | 24000          | 23500        | compliant        | 0              |
      | 24000          | 24000        | compliant        | 0              |
      | 24000          | 25000        | non-compliant    | 1000           |

@orv2-5617-6
Rule: the 8-metre axle group rule is applied by measuring the distance between the first and last axle in each eligible axle-group combination and comparing standard axle groups to the CTR 7.17 table while applying the tandem-drive/single-jeep axle-group exception under CTR 7.16(g)

  Scenario Outline: axle-group spread is measured from the first to last axle and the resulting threshold branch depends on whether the group is standard or tandem-drive/single-jeep
    Given an eligible <axleGroupType> axle-group combination has a spread of <spread> m
     When the system determines the maximum legal weight threshold for that axle-group combination
     Then the maximum legal weight threshold is <threshold> kg

    Examples:
      | axleGroupType            | spread | threshold |
      | standard                 | 1.0    | 16500     |
      | standard                 | 4.2    | 24000     |
      | standard                 | 7.6    | 32000     |
      | standard                 | 8.0    | 34000     |
      | tandem-drive/single-jeep | 4.2    | 24000     |
      | tandem-drive/single-jeep | 6.3    | 27000     |

# Notes:
 - An axle group is 2 or more axle units
 - For standard axle groups, the system compares the sum of the applicable individual axle-unit legal weight thresholds against the 7.17 table value and uses the lower limit to determine overload
 - Tandem Drive/Single Jeep axle group is the Section 7.16(g) exception and uses the greater of 24,000 kg or the 7.17 table value
 - This evaluation determines the legal allowable weight threshold first, then calculates what is in excess of that legal threshold
 - Applies to axle groups with ≤ 8 m spans, excluding axle unit 1

 The 8-metre axle group rule, defined in Section 7.17 of the Commercial Transport Regulations (CTR), is a fundamental weight distribution requirement used to protect road infrastructure by limiting the concentration of weight over short spans of a vehicle’s wheelbase.
 Under this rule, any group of axles that falls within a longitudinal spacing of 8 metres or less must not exceed the maximum gross weight specified in the regulatory table.

 1. How the Rule is Applied
 The rule works by evaluating the spread—the distance between the centres of the first and last axle in any potential group of axles within that 8-metre span.
 The Spacing Check: Any combination of axles (e.g., steer to drive, drive to trailer, or individual trailer groups) that fits within an 8 m length is checked against the Section 7.17 table.

 Weight Graduation: The allowable weight increases as the distance between the axles in the group increases, ranging from 9,100 kg for a spread of less than 1.0 m up to 34,000 kg for a spread of 8.0 m or more.

 2. The "Lesser Of" Principle
 For most standard vehicles and overload calculations, the 8-metre rule acts as a "hard ceiling." The legal allowable weight for any group of axles within an 8 m span is determined by identifying the lowest value among the sum of the applicable individual axle-unit legal weight thresholds and the 7.17 table value:

  - The sum of the applicable individual axle-unit legal weight thresholds (e.g., 9,100 kg for a single + 17,000 kg for a tandem = 26,100 kg).
  - The maximum weight allowed by the 7.17 table for that group's spread.

 If the sum of the individual axle-unit legal weight thresholds is higher than the table's limit for that distance, the table limit prevails.

 3. Key Applications and Scenarios
 Logging Trucks: Loaded logging trucks must comply with the 8 m rule if any individual axle in the group exceeds 9,100 kg.
 Heavy Haul and Fixed Equipment: Mobile cranes and trucks with permanently mounted equipment (PME) that do not meet standard interaxle spacing requirements (usually <4.2 m) must use the 7.17 table to determine their limits.
 Seasonal Road Bans: During seasonal restrictions, the 8 m rule is often the primary mechanism for determining allowable weights for non-reducible loads if specific interaxle spacing requirements (like >3.0 m between a tandem and single axle) are not met.
 4. Regulatory Exceptions
 Exempt Configurations: The rule specifically does not apply to standard configurations described in Appendices C (Buses), D (Tractor Semi-Trailers), and G (A, B, and C Trains), which have their own established weight tables.
 The "Greater Of" Exception (Section 7.16g): For a tandem-drive tractor paired with a single-axle jeep, the group is uniquely allowed the greater of 24,000 kg or the weight allowed by the 7.17 table.
 Bridge Formula: For overweight permits, the 8 m rule is used in conjunction with the Bridge Formula (30×wheelbase+18,000), though the formula applies to all spreads and does not stop at 8 m.

 CTR 7.17 — Maximum Gross Weight for Axle Groups
 (distance between centres of first and last axle in group → max gross weight)
 | < 1.00 m                         |  9,100 kg |
 | 1.00 m up to < 1.20 m            | 16,500 kg |
 | 1.20 m up to < 1.90 m            | 17,000 kg |
 | 1.90 m up to < 2.30 m            | 18,000 kg |
 | 2.30 m up to < 2.60 m            | 19,000 kg |
 | 2.60 m up to < 3.00 m            | 20,000 kg |
 | 3.00 m up to < 3.40 m            | 21,000 kg |
 | 3.40 m up to < 3.80 m            | 22,000 kg |
 | 3.80 m up to < 4.20 m            | 23,000 kg |
 | 4.20 m up to < 4.60 m            | 24,000 kg |
 | 4.60 m up to < 5.00 m            | 25,000 kg |
 | 5.00 m up to < 5.30 m            | 26,000 kg |
 | 5.30 m up to < 5.70 m            | 27,000 kg |
 | 5.70 m up to < 6.10 m            | 28,000 kg |
 | 6.10 m up to < 6.50 m            | 29,000 kg |
 | 6.50 m up to < 6.90 m            | 30,000 kg |
 | 6.90 m up to < 7.20 m            | 31,000 kg |
 | 7.20 m up to < 7.60 m            | 32,000 kg |
 | 7.60 m up to < 8.00 m            | 33,000 kg |
 | 8.00 m or more                   | 34,000 kg |

# Evaluation Parameters:
 - Axle Group Definition — 2 or more axle units
 - Axle Group Spacing (m) — the distance between the first and last axle of the group
 - Applicable Individual Axle-Unit Legal Weight Thresholds (kg) — for example, 9,100 kg single, 17,000 kg tandem, or 24,000 kg tridem
 - Sum of Applicable Individual Axle-Unit Legal Weight Thresholds (kg)
 - CTR 7.17 Table Value (kg) — the maximum weight permitted for the group's spread per CTR 7.17
 - Maximum Legal Weight Threshold = lower of the sum of the applicable individual axle-unit thresholds or CTR 7.17 table value for standard axle groups
 - Maximum Legal Weight Threshold = greater of 24,000 kg or CTR 7.17 table value for the tandem drive/single jeep axle-group exception
 - Actual Axle-Group Weight (kg)
 - Overload Amount (kg) = MAX(0, Actual Axle-Group Weight - Maximum Legal Weight Threshold)

# Logic:
 IF tandem drive/single jeep axle group spacing ≤ 8 m AND axle group is not axle unit 1 THEN
     Legal_Threshold = MAX(24000, CTR_7.17_Table_Value)
     IF Actual_Axle_Group_Weight > Legal_Threshold THEN
       Compliance = "non-compliant"
       Overload_Amount = Actual_Axle_Group_Weight - Legal_Threshold
     ELSE
       Compliance = "compliant"
       Overload_Amount = 0
     END IF
 ELSE IF axle group spacing ≤ 8 m AND axle group is not axle unit 1 THEN
     Legal_Threshold = MIN(Sum_of_Applicable_Individual_Axle_Unit_Legal_Weight_Thresholds, CTR_7.17_Table_Value)
     IF Actual_Axle_Group_Weight > Legal_Threshold THEN
       Compliance = "non-compliant"
       Overload_Amount = Actual_Axle_Group_Weight - Legal_Threshold
     ELSE
       Compliance = "compliant"
       Overload_Amount = 0
     END IF
 ELSE
     CTR 7.16(g) does not apply
 END IF

 