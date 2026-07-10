@orv2-5514 https://moti-imb.atlassian.net/browse/ORV2-5514 
Feature: As a user I need the system to validate that the wheelbase derived from the axle unit spacing and spread for my single steer tandem drive truck tractor vehicle is compliant with policy and regulations for single trip overweight permits, so that I can ensure my permit application is compliant.

users = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 20: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5514-1
Rule: This rule applies to the following power unit vehicle sub-types:
  | powerUnitVehicleSubtype         |
  | Picker Truck Tractors           |
  | Truck Tractors                  |
  | Truck Tractors - Stinger Steered |
  | Truck Tractors with PME         |

@orv2-5514-2
Rule: For all applicable power unit vehicle sub-types, truck tractor wheelbase derived from axle unit spacing and spread must not exceed 7.2 m for single steer tandem drive configurations when a trailer vehicle sub-type is selected

  Scenario: derived wheelbase is at the maximum allowed value
    Given an applicable power unit vehicle sub-type is selected
      And a trailer vehicle sub-type is selected
     When the system derives wheelbase using axle unit 1 spacing + 50% of axle unit 2 spread
     Then the derived wheelbase is 7.2 m
      And the wheelbase validation passes
      And the permit application is not blocked by wheelbase validation

  Scenario: derived wheelbase exceeds the maximum allowed value
    Given an applicable power unit vehicle sub-type is selected
      And a trailer vehicle sub-type is selected
      And axle unit 2 interaxle spacing is 6.6 m
      And axle unit 2 spread is 1.4 m
     When the system derives wheelbase using axle unit 1 spacing + 50% of axle unit 2 spread
     Then the derived wheelbase is 7.3 m
      And the wheelbase validation fails
      And the permit application is blocked
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) field is indicated with a red border
      And the user sees "Wheelbase for Axle Unit X and Axle Unit Y is greater than 7.2m."

@orv2-5514-3
Rule: For all applicable power unit vehicle sub-types, if the wheelbase is less than 6.2 m then there are no restrictions regardless of the trailer vehicle sub-type selected

  Scenario: derived wheelbase is below the minimum allowed value
    Given an applicable power unit vehicle sub-type is selected
      And axle unit1 is a single steer axle
      And axle unit 2 interaxle spacing is 5.8 m
      And axle unit 2 spread is 0.4 m
     When the system derives wheelbase using axle unit 1 spacing + 50% of axle unit 2 spread
     Then the derived wheelbase is 6.0 m
      And the wheelbase validation passes
      And the permit application is not blocked by wheelbase validation

@orv2-5514-4
Rule: For all applicable power unit vehicle sub-types, if the wheelbase is between 6.2 m and 7.2 m then the only allowed trailer vehicle sub-types are semi-trailers

  Scenario: semi-trailer selection shows review compliance warning message
    Given an applicable power unit vehicle sub-type with a derived wheelbase between 6.2 m and 7.2 m
      And the selected trailer vehicle sub-type is semi-trailer
     Then the trailer selection is allowed
      And the permit application is not blocked by trailer type validation
      And no wheelbase-related fields are indicated with a red border
      And the user sees "Review Compliance Requirements Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. Semi-Trailer wheelbase must be within dimensions table found in CTPM 5.3.7 A."

  Scenario Outline: non-semi trailer selection shows CTPM blocked message
    Given an applicable power unit vehicle sub-type with a derived wheelbase between 6.2 m and 7.2 m
      And the selected trailer vehicle sub-type is <trailerType>
     Then the trailer selection is not allowed
      And the permit application is blocked by trailer type validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) field is indicated with a red border
      And the user sees "Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. See CTPM 5.3.7.A."

    Examples:
      | trailerType    |
      | jeep           |
      | booster        |
      | jeep + booster |

# Notes:
Evaluating: Truck tractor wheelbase is measured as the longitudinal distance from the centre of the front steering axle (Single only) to the geometric centre of the drive axle unit (Tandem only), we would derive this by using 50% of the drive axle unit spread + the steer axle to drive axle spacing. The wheelbase cannot be beyond 7.2 m. If the wheelbase of a single steer tandem drive truck tractor is 6.2m to 7.2 m then the only trailers allowed is semi-trailer no jeep or booster

Applicable power unit vehicle sub-types:
Picker Truck Tractors
Truck Tractors
Truck Tractors - Stinger Steered
Truck Tractors with PME

Triggers:
- Commodity (only for driving allowed power unit vehicle sub-types)
- Vehicle Sub-type
- Axle unit 1 type
- Axle unit 2 type
- Trailer vehicle sub-type 
- Wheelbase derived length

Logic:
IF (Axle Unit 1 Spacing + 50% of Axle Unit 2 Spread) > 7.2 m
  AND Trailer Vehicle Sub-type is selected THEN
  Output = "Wheelbase for Axle Unit X and Axle Unit Y is greater than 7.2m."
  Validation = Fail  // wheelbase validation fails and permit application is blocked
  UI = Interaxle Spacing (m) and Axle Spread (m) fields show red border

ELSE IF (Axle Unit 1 Spacing + 50% of Axle Unit 2 Spread) BETWEEN 6.2 m AND 7.2 m
  AND Trailer Vehicle Sub-type = "Semi-trailer" THEN
  Output = "Review Compliance Requirements Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. Semi-Trailer wheelbase must be within dimensions table found in CTPM 5.3.7 A."
  Validation = Pass  // trailer selection is allowed and permit application is not blocked by trailer type validation
  UI = No wheelbase-related fields show a red border

ELSE IF (Axle Unit 1 Spacing + 50% of Axle Unit 2 Spread) BETWEEN 6.2 m AND 7.2 m
  AND Trailer Vehicle Sub-type IN ("Jeep", "Booster", "Jeep + Booster") THEN
  Output = "Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. See CTPM 5.3.7.A."
  Validation = Fail  // trailer selection is not allowed and permit application is blocked by trailer type validation
  UI = Interaxle Spacing (m) and Axle Spread (m) fields show red border

ELSE
  Output = ""  // no wheelbase restriction message when derived wheelbase is less than 6.2 m
  Validation = Pass  // no trailer-type restrictions are applied
END IF