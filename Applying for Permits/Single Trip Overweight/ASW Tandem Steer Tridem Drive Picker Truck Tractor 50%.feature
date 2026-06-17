@orv2-5456 https://moti-imb.atlassian.net/browse/ORV2-5456
Feature: As a user, I need the system to validate that the axle unit types and configurations I have selected are compliant with the ASW rules for tandem steer tridem drive picker truck tractor vehicles, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 18: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5456-1
Rule: Tandem steer legal maximum is 15,200 kg for Picker Truck Tractors with PME

Rule: Tridem drive legal maximum is 24,000 kg for Picker Truck Tractors with PME (per CTR Appendix B)

Rule: Tandem steer permit maximum is 15,200 kg for Picker Truck Tractors with PME

Rule: Tridem drive permit maximum is 28,000 kg for Picker Truck Tractors with PME

Rule: A non-standard Picker Truck Tractor with PME is one with tandem steer and tridem drive axles that falls below minimum dimensional thresholds (wheelbase < 6.6 m, steer axle spread < 1.0 m, drive axle spread < 2.4 m, or front projection > 1.0 m)

Scenario Outline: Picker Truck Tractor classification by dimensional thresholds
        Given the vehicle is a Picker Truck Tractor
        And the wheelbase is <wheelbase> m
        And the steer axle spread is <steerAxleSpread> m
        And the drive axle spread is <driveAxleSpread> m
        When the system evaluates the non-standard picker truck tractor rule
        Then the vehicle is <expectedResult>

        Examples:
            | description                          | wheelbase | steerAxleSpread | driveAxleSpread | expectedResult              |
            | Below the wheelbase threshold        | 6.5       | 1.0             | 2.4             | considered non-standard     |
            | Meets minimum dimensional thresholds | 6.6       | 1.0             | 2.4             | not considered non-standard |

 # See Wheelbase and Axle Spread feature for more detailed scenarios on how the dimensional thresholds apply

Rule: Apply the 50% tandem steer to tridem drive weight distribution ratio when operating at "Permit Weights" (exceeding legal maximums) for non-standard tandem steer/tridem drive Picker Truck Tractors with PME

Scenario Outline: Picker Truck Tractor meets or fails the 50% weight distribution ratio at Permit Weights
    Given the vehicle is a non-standard tandem steer/tridem drive Picker Truck Tractor
    And the operating condition is operating at "Permit Weights"
    And the tandem steer axle weight is <tandemSteerAxleWeight> kg
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    When the system evaluates the 50% tandem steer to tridem drive weight distribution rule
    Then the vehicle is <expectedResult>

    Examples:
        | description                 | tandemSteerAxleWeight | tridemDriveAxleWeight | expectedResult                 |
        | Meets the 50% requirement   | 10000                 | 20000                 | considered compliant           |
        | Fails the 50% requirement   | 9000                  | 20000                 | not considered compliant       |

Rule: No trailer towing is allowed when operating at "Permit Weights" (exceeding legal maximums) for non-standard tandem steer/tridem drive Picker Truck Tractors with PME

Scenario: Trailer towing is rejected at Permit Weights for a non-standard Picker Truck Tractor
    Given the vehicle is a non-standard tandem steer/tridem drive Picker Truck Tractor
    And the operating condition is operating at "Permit Weights"
    And the vehicle is towing a trailer
    When the user chooses to calculate or continue with the permit application
    Then they see "Cannot tow a trailer if Axle Unit 1 and Axle Unit 2 are exceeding legal axle weights."

Rule: Apply the standard 40% tandem steer to tridem drive weight distribution ratio when operating at "Legal Weights" for tandem steer/tridem drive Picker Truck Tractors with PME 

 # See 40% rule feature for more details on the standard 40% distribution requirement that applies to all tandem steer/tridem drive vehicles at legal weights, including non-standard tandem steer/tridem drive picker truck tractors with PME.

# Notes:
 - Triggers for assessing for 50% rule:
  - Power unit axle unit types: tandem steer and tridem drive
  - Power Unit vehicle sub types:
   - Picker Truck Tractor
   - Truck Tractor with Heavy Front Projected Crane (don't have this vehicle sub-type)
  - When Exceed Legal Axle Weights = Yes for either tandem steer or tridem drive axles a trailer is not allowed:
   - Tridem drive axle unit weight exceeds the CTR Appendix B legal limit of 24000 kg
   - Tandem steer axle unit weight exceeds the CTR Appendix B legal limit of 15200 kg

 - For these specific non-standard picker truck tractors, the steering axle unit must carry a minimum of 50% of the actual weight of the tridem drive axle group when the vehicle is loaded
 - tridem drive are the only ones that have a min axle weight
 - Picker Truck Tractors (Heavy Front Projected Crane)
  - Tandem Steer, Tridem Drive
  - no trailers and 50% rule apply
  - single steer regardless of drive can get trailer and overweight
  - tandem and tridem drive can get overweight but no trailer, legal weight with trailer

  ## Logic:
 Pseudo-code logic statement designed to apply the **50% weight distribution rule** and the associated **towing prohibition** for non-standard tandem-steer/tridem-drive picker trucks.

 ### **Pseudo-Code Logic: 50% Rule Application**

 ```pseudo
 // Logic for Tandem Steer / Tridem Drive Picker Truck Tractors
 // References: CTR Appendix B and Non-Standard Configuration Policy

 IF power_unit.axle_configuration == "Tandem Steer / Tridem Drive" AND power_unit.has_PME == TRUE THEN

     // STEP 1: Determine if the power unit is "Non-Standard"
     // Triggers: Dimensions falling outside CTR Appendix B standard ranges
     is_non_standard = FALSE

     IF power_unit.wheelbase < 6.6 THEN 
         is_non_standard = TRUE // Wheelbase is "tighter than standard"
     ELSE IF power_unit.steer_axle_spread < 1.0 THEN
         is_non_standard = TRUE // Spread is tighter than standard (single axle territory)
     ELSE IF power_unit.drive_axle_spread < 2.4 THEN
         is_non_standard = TRUE // Spread is tighter than standard
     ELSE IF power_unit.front_projection_PME > 1.0 THEN
         is_non_standard = TRUE // Exceeds standard front projection limit
     END IF

     // STEP 2: Apply Restricted Rules if Non-Standard
     IF is_non_standard == TRUE THEN
         
         IF power_unit.operating_weight_mode == "Permit Weights" THEN
             
             // 1. Apply the 50% Weight Distribution Rule
             IF power_unit.axle_unit_1_weight < (0.50 * power_unit.axle_unit_2_weight) THEN
                 REJECT_PERMIT("Axle Unit 1 must carry a minimum 50% of Axle Unit 2 axle unit weight.") 
             END IF

             // 2. Enforce the Towing Prohibition
             IF power_unit.is_towing_trailer == TRUE THEN
                 REJECT_PERMIT("Cannot tow a trailer if Axle Unit 1 and Axle Unit 2 are exceeding legal axle weights.")
             END IF

         ELSE IF power_unit.operating_weight_mode == "Legal Weights" THEN
             
             // Standard 40% distribution for loaded tandem/tridem applies
             IF power_unit.steer_axle_group_weight < (0.40 * power_unit.tridem_drive_group_weight) THEN
                 REJECT_OPERATION("Minimum 40% weight distribution required for loaded unit.")
             END IF

         END IF

     ELSE // Standard Appendix B Compliant power_unit
         // Standard steering ratio applies
         IF power_unit.is_loaded AND power_unit.steer_axle_group_weight < (0.40 * power_unit.tridem_drive_group_weight) THEN
             REJECT_OPERATION("Standard 40% steering weight ratio not met.")
         END IF
     END IF

 END IF
 ```

 ### **Summary of Logic Components**
 *   **The Power Unit Trigger:** The logic first isolates vehicles with **tandem steering** and **tridem drive** axles equipped with **Permanently Mounted Equipment (PME)**.
 *   **The Dimension Trigger:** It identifies "non-standard" units by checking if they fall below the minimum dimensions allowed in Appendix B, such as a **wheelbase less than 6.6 m** or axle spreads tighter than standard.
 *   **The Weight Mode Condition:** The rule distinguishes between **legal weights** and **permit weights**. The 50% requirement and towing ban are specifically activated when the operator requests **permit (overload) weights**.
 *   **The Prohibitions:** If all triggers are met, the logic enforces a weight distribution ratio of **0.5:1** (steer to drive) and a complete **ban on towing trailers**.

 Permit Axle Weights:

 | Section                                                  | Steering/Drives  | Steering Max Weight By Permit | Axle Spread (steer/drive)  | Truck Tractor Wheelbase | Drive Max Weight By Permit |
 | ---                                                      | ---              | ---                           | ---                        | ---                     | ---                        |
 | Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 2.4 - 2.8 m | 7.2 m (Min)             | 28,000 kg                  |
 | Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 2.8 - 3.0 m | 7.3 m (Min)             | 28,000 kg                  |
 | Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 3.0 - 3.1 m | 7.4 m (Min)             | 28,000 kg                  |
 | Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 2.4 - 2.8 m | 7.2 m (Min)             | 28,000 kg                  |
 | Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 2.8 - 3.0 m | 7.3 m (Min)             | 28,000 kg                  |
 | Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 3.0 - 3.1 m | 7.4 m (Min)             | 28,000 kg                  |

 (a) PME as defined under the CTR
 (b) tractor exceeds 14,000 kg tare weight
 (c) For tandem steer/tridem drive vehicles only and exceeding CTR Appendix B legal truck or truck tractor definitions - the tandem steer axle group weight must be min. 50% of the tridem drive axle group weight. These tandem steer/tridem drive picker trucks may not tow a trailer when operating at permit axle weights, as opposed to legal axle weights.

 Note: Maximum wheelbase is limited by OAL.

 Legal Tridem Drive Axle Spreads and Minimum Dimensional Wheelbases for Tandem Steer/Tridem Drive:

 Table IV - Tandem Steering/Tridem Drive Axle Combination Only Wheelbase:

 | Tridem Drive Axle Spread   | Minimum Dimensional Wheelbase |
 | ---                        | ---                           |
 | 2.4 m - less than 2.8 m    | 7.7 m                         |
 | 2.8 m - less than 3.0 m[a] | 7.8 m                         |
 | 3.0 m - 3.1 m[a]           | 7.9 m                         |

 [a] Applies to oilfield bed trucks only.