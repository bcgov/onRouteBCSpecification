@orv2-5541 https://moti-imb.atlassian.net/browse/ORV2-5541 
Feature: As a user, I need the system to validate wheelbase limits for supported power unit vehicle sub-types using the correct axle configuration rules, including the oil-field bed truck exception, so that my single trip overweight permit application follows policy and legal requirements.

users = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 9: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5541-1
Rule: This feature applies to the following power unit vehicle sub-types:
  | powerUnitVehicleSubtype |
  | Truck                   |
  | Truck Tractor           |
  | Truck with PME          |
  | Truck Tractor with PME  |
  | Picker Truck Tractor    |
  And includes the oil-field bed truck exception described in @orv2-5541-4.

@orv2-5541-2
Rule: For applicable power unit vehicle sub-types, wheelbase is determined as the sum of Axle Unit X Axle Spread / 2, Interaxle Spacing, and Axle Unit Y Axle Spread / 2

  Scenario: wheelbase is calculated from axle unit measurements
    Given the power unit vehicle sub-type is Truck
      And the vehicle configuration is single steering axle
      And the vehicle has Axle Unit X of 2.0 m
      And the Interaxle Spacing is 3.5 m
      And the vehicle has Axle Unit Y of 2.1 m
     When the wheelbase is calculated
     Then the wheelbase is 7.6 m

@orv2-5541-3
Rule: For applicable power unit vehicle sub-types where Axle Unit 1 is single steering axle, wheelbase limits are based on Axle Unit 2 drive axle type. Truck and Truck with PME with tridem drive axle must have a minimum wheelbase of 6.6 m. Truck Tractor, Truck Tractor with PME, and Picker Truck Tractor with single or tandem drive axle must have a wheelbase from 3.0 m to 6.2 m, and with tridem drive axle must have a wheelbase from 6.6 m to 6.8 m.

  Scenario: tridem drive axle wheelbase is below the minimum
    Given the power unit vehicle sub-type is Truck Tractor
      And the vehicle configuration is single steering axle
      And the vehicle type is a single steering axle truck tractor
      And Axle Unit 2 drive axle type is tridem drive axle
      And Interaxle Spacing is 4.4 m
      And Axle Unit 2 Axle Spread is 4.2 m
      And the derived wheelbase is 6.5 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 2 is less than 6.6 m."
      And the permit application is blocked by wheelbase validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) fields are indicated with a red border

  Scenario: tridem drive axle wheelbase is above the maximum
    Given the power unit vehicle sub-type is Truck Tractor with PME
      And the vehicle configuration is single steering axle
      And the vehicle type is a single steering axle truck tractor
      And Axle Unit 2 drive axle type is tridem drive axle
      And Interaxle Spacing is 4.6 m
      And Axle Unit 2 Axle Spread is 4.6 m
      And the derived wheelbase is 6.9 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 2 is greater than 6.8 m."
      And the permit application is blocked by wheelbase validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) fields are indicated with a red border

  Scenario: single or tandem drive axle wheelbase is below the minimum
    Given the power unit vehicle sub-type is Truck Tractor
      And the vehicle configuration is single steering axle
      And the vehicle type is a single steering axle truck tractor
      And Axle Unit 2 drive axle type is tandem drive axle
      And Interaxle Spacing is 2.0 m
      And Axle Unit 2 Axle Spread is 1.8 m
      And the derived wheelbase is 2.9 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 2 is less than 3.0 m."
      And the permit application is blocked by wheelbase validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) fields are indicated with a red border

  Scenario: single or tandem drive axle wheelbase is above the maximum
    Given the power unit vehicle sub-type is Truck Tractor with PME
      And the vehicle configuration is single steering axle
      And the vehicle type is a single steering axle truck tractor
      And Axle Unit 2 drive axle type is tandem drive axle
      And Interaxle Spacing is 5.0 m
      And Axle Unit 2 Axle Spread is 2.6 m
      And the derived wheelbase is 6.3 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 2 is greater than 6.2 m."
      And the permit application is blocked by wheelbase validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) fields are indicated with a red border

@orv2-5541-4
Rule: For applicable power unit vehicle sub-types with a tandem steering tridem drive axle configuration, a tridem drive axle spread from 2.4 m to less than 2.8 m requires a minimum wheelbase of 7.7 m.

  Scenario: wheelbase is below the 7.7 m minimum for tridem drive axle spread from 2.4 m to less than 2.8 m
    Given the power unit vehicle sub-type is Truck Tractor with PME
      And the vehicle configuration is tandem steering tridem drive axle
      And Axle Unit 1 Axle Spread is 2.0 m
      And Interaxle Spacing is 3.2 m
      And Axle Unit 2 Axle Spread is 2.4 m
      And the derived wheelbase is 7.6 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 1 is less than 7.7 m."
      And the permit application is blocked by wheelbase validation

  Scenario: wheelbase meets the 7.7 m minimum for tridem drive axle spread from 2.4 m to less than 2.8 m
    Given the power unit vehicle sub-type is Truck with PME
      And the vehicle configuration is tandem steering tridem drive axle
      And Axle Unit 1 Axle Spread is 2.0 m
      And Interaxle Spacing is 3.5 m
      And Axle Unit 2 Axle Spread is 2.2 m
      And the derived wheelbase is 7.7 m
     When the wheelbase is evaluated
     Then the result is blank
      And the permit application is not blocked by wheelbase validation

@orv2-5541-5
Rule: For oilfield bed trucks with a tandem steering tridem drive axle configuration, a tridem drive axle spread from 2.8 m to less than 3.0 m requires a minimum wheelbase of 7.8 m, and a spread from 3.0 m to 3.1 m requires a minimum wheelbase of 7.9 m. Oilfield bed trucks can have a maximum wheelbase of 10.0 m.

  Scenario: oilfield bed truck wheelbase is within the maximum
    Given the power unit vehicle sub-type is Truck with PME
      And the vehicle configuration is tandem steering tridem drive axle
      And the vehicle type is an oilfield bed truck (tridem drive)
      And Axle Unit 1 Axle Spread is 3.0 m
      And Interaxle Spacing is 7.0 m
      And Axle Unit 2 Axle Spread is 3.0 m
      And the derived wheelbase is 10.0 m
     When the wheelbase is evaluated
     Then the result is blank
      And the permit application is not blocked by wheelbase validation

  Scenario: oilfield bed truck wheelbase exceeds the maximum
    Given the power unit vehicle sub-type is Truck with PME
      And the vehicle configuration is tandem steering tridem drive axle
      And the vehicle type is an oilfield bed truck (tridem drive)
      And Axle Unit 1 Axle Spread is 3.0 m
      And Interaxle Spacing is 7.0 m
      And Axle Unit 2 Axle Spread is 3.1 m
      And the derived wheelbase is 10.05 m
     When the wheelbase is evaluated
     Then the result is "Wheelbase for Axle Unit 1 is greater than 10.0 m."
      And the permit application is blocked by wheelbase validation
      And the Interaxle Spacing (m) field is indicated with a red border
      And the Axle Spread (m) fields are indicated with a red border

  Scenario Outline: oilfield bed truck minimum wheelbase by axle spread
    Given the power unit vehicle sub-type is <powerUnitVehicleSubtype>
      And the vehicle configuration is tandem steering tridem drive axle
      And the vehicle type is an oilfield bed truck (tridem drive)
      And the tridem drive axle spread is <axle spread> m
      And Axle Unit 1 Axle Spread is <axle unit 1> m
      And Interaxle Spacing is <interaxle spacing> m
      And Axle Unit 2 Axle Spread is <axle unit 2> m
      And the derived wheelbase is <wheelbase> m
     When the wheelbase is evaluated
     Then the result is "<result>"

      Examples:
        | powerUnitVehicleSubtype | axle spread | axle unit 1 | interaxle spacing | axle unit 2 | wheelbase | result                                        |
        | Truck with PME          | 2.8         | 2.0         | 3.6               | 2.2         | 7.8       | blank                                         |
        | Truck with PME          | 3.0         | 2.0         | 3.7               | 2.2         | 7.9       | blank                                         |
        | Truck with PME          | 2.8         | 2.0         | 3.5               | 2.2         | 7.7       | Wheelbase for Axle Unit 1 is less than 7.8 m. |
        | Truck Tractor with PME  | 3.0         | 2.0         | 3.6               | 2.2         | 7.8       | Wheelbase for Axle Unit 1 is less than 7.9 m. |

@orv2-5541-7
Rule: For applicable single steering axle configurations, derived wheelbase is calculated as: Wheelbase = Interaxle Spacing + (Axle Unit 2 Axle Spread / 2).

@orv2-5541-8
Rule: For applicable tandem/tridem steer configurations, derived wheelbase is calculated as: Wheelbase = (Axle Unit 1 Axle Spread / 2) + Interaxle Spacing + (Axle Unit 2 Axle Spread / 2).

# Notes:

Single Steering Axle Vehicle Wheelbase Limits:
 - Truck and Truck with PME must have a minimum wheelbase of 6.6 meters.
 - Truck Tractor, Truck Tractor with PME, and Picker Truck Tractor must have a minimum wheelbase of 6.6 meters.
 - Truck Tractor, Truck Tractor with PME, and Picker Truck Tractor must have a maximum wheelbase of 6.8 meters.
Tandem Steering Tridem Drive Axle Configuration Minimum Wheelbase:
 - If the tridem drive axle spread is between 2.4 meters and less than 2.8 meters, the minimum wheelbase is 7.7 meters.
Exceptions for Oilfield Bed Trucks (Tandem Steering Tridem Drive Axle Configuration):
 - Oilfield bed trucks can have a wheelbase of up to 10.0 meters.
 - For oilfield bed trucks, if the tridem drive axle spread is between 2.8 meters and less than 3.0 meters, the minimum wheelbase is 7.8 meters.
 - For oilfield bed trucks, if the tridem drive axle spread is between 3.0 meters and 3.1 meters, the minimum wheelbase is 7.9 meters.

# Evaluation Parameters:
- Vehicle Type
- Axle Unit 1
- Interaxle Spacing
- Axle Unit 2
- Wheelbase = Axle Unit 1 + Interaxle Spacing + Axle Unit 2
- Tridem Axle Spread

# Logic:
Wheelbase = Axle_Unit_1 + Interaxle_Spacing + Axle_Unit_2

This logic applies only to the power unit vehicle sub-types listed in @orv2-5541-1.

1. Calculate wheelbase as:
   Wheelbase = Axle_Unit_1 + Interaxle_Spacing + Axle_Unit_2

2. Apply single steering axle (Axle Unit 1) wheelbase limits by power unit vehicle sub-type and Axle Unit 2 (drive axle) configuration:
  IF AxleUnit1SteeringAxleType IN (""Single Steering Axle"")
   AND PowerUnitVehicleSubtype IN (""Truck"", ""Truck with PME"")
   AND AxleUnit2DriveAxleType = ""Tridem Drive Axle""
   AND Wheelbase < 6.6 m
   THEN Output = ""Wheelbase for Axle Unit 2 is less than 6.6 m.""

  IF AxleUnit1SteeringAxleType IN (""Single Steering Axle"")
   AND PowerUnitVehicleSubtype IN (""Truck Tractor"", ""Truck Tractor with PME"", ""Picker Truck Tractor"")
   AND AxleUnit2DriveAxleType IN (""Single Drive Axle"", ""Tandem Drive Axle"")
   AND Wheelbase < 3.0 m
   THEN Output = ""Wheelbase for Axle Unit 2 is less than 3.0 m.""

  IF AxleUnit1SteeringAxleType IN (""Single Steering Axle"")
   AND PowerUnitVehicleSubtype IN (""Truck Tractor"", ""Truck Tractor with PME"", ""Picker Truck Tractor"")
   AND AxleUnit2DriveAxleType IN (""Single Drive Axle"", ""Tandem Drive Axle"")
   AND Wheelbase > 6.2 m
   THEN Output = ""Wheelbase for Axle Unit 2 is greater than 6.2 m.""

  IF AxleUnit1SteeringAxleType IN (""Single Steering Axle"")
   AND PowerUnitVehicleSubtype IN (""Truck Tractor"", ""Truck Tractor with PME"", ""Picker Truck Tractor"")
   AND AxleUnit2DriveAxleType = ""Tridem Drive Axle""
   AND Wheelbase < 6.6 m
   THEN Output = ""Wheelbase for Axle Unit 2 is less than 6.6 m.""

  IF AxleUnit1SteeringAxleType IN (""Single Steering Axle"")
   AND PowerUnitVehicleSubtype IN (""Truck Tractor"", ""Truck Tractor with PME"", ""Picker Truck Tractor"")
   AND AxleUnit2DriveAxleType = ""Tridem Drive Axle""
   AND Wheelbase > 6.8 m
   THEN Output = ""Wheelbase for Axle Unit 2 is greater than 6.8 m.""

3. Apply tandem steering tridem drive axle configuration minimum wheelbase rules:
   IF Tridem Axle Spread >= 2.4 m AND Tridem Axle Spread < 2.8 m AND Wheelbase < 7.7 m
   THEN Output = ""Wheelbase for Axle Unit X is less than 7.7 m.""

  IF VehicleType = ""Oilfield Bed Truck (Tridem Drive)"" AND Tridem Axle Spread >= 2.8 m AND Tridem Axle Spread < 3.0 m AND Wheelbase < 7.8 m
   THEN Output = ""Wheelbase for Axle Unit X is less than 7.8 m.""

  IF VehicleType = ""Oilfield Bed Truck (Tridem Drive)"" AND Tridem Axle Spread >= 3.0 m AND Tridem Axle Spread <= 3.1 m AND Wheelbase < 7.9 m
   THEN Output = ""Wheelbase for Axle Unit X is less than 7.9 m.""

4. Apply the oilfield bed truck maximum wheelbase rule:
  IF VehicleType = ""Oilfield Bed Truck (Tridem Drive)"" AND Wheelbase > 10.0 m
   THEN Output = ""Wheelbase for Axle Unit X is greater than 10.0 m.""

5. If none of the above conditions are met:
   Output = """"