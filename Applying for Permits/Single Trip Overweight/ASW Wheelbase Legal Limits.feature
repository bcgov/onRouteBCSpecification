@orv2-5541 https://moti-imb.atlassian.net/browse/ORV2-5541 
Feature: As a user I need the system to validate that the wheelbase limits are compliant with policy and regulations for single trip overweight permits, so that I can ensure my permit application is compliant.

users = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 9: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5541-1
Rule: wheelbase is determined as the sum of Axle Unit X, Interaxle Spacing, and Axle Unit Y

  Scenario: wheelbase is calculated from axle unit measurements
      Given the vehicle has Axle Unit X of 2.0 m
        And the Interaxle Spacing is 3.5 m
        And the vehicle has Axle Unit Y of 2.1 m
       When the wheelbase is calculated
       Then the wheelbase is 7.6 m

@orv2-5541-2
Rule: Tridem drive truck or truck tractor wheelbase must be between 6.6 m and 6.8 m

  Scenario: wheelbase is below the minimum
      Given the vehicle type is a tridem drive truck or truck tractor
        And Axle Unit 1 is 2.0 m
        And Interaxle Spacing is 2.4 m
        And Axle Unit 2 is 2.1 m
        And the derived wheelbase is 6.5 m
       When the wheelbase is evaluated
       Then the result is "Wheelbase for Axle Unit 1 is less than 6.6 m."
        And the permit application is blocked by wheelbase validation
        And the Interaxle Spacing (m) field is indicated with a red border
        And the Axle Spread (m) fields are indicated with a red border

  Scenario: wheelbase is above the maximum
      Given the vehicle type is a tridem drive truck or truck tractor
        And Axle Unit 1 is 2.0 m
        And Interaxle Spacing is 2.6 m
        And Axle Unit 2 is 2.3 m
        And the derived wheelbase is 6.9 m
       When the wheelbase is evaluated
       Then the result is "Wheelbase for Axle Unit 1 is greater than 6.8 m."
        And the permit application is blocked by wheelbase validation
        And the Interaxle Spacing (m) field is indicated with a red border
        And the Axle Spread (m) fields are indicated with a red border

@orv2-5541-3
Rule: Oilfield bed trucks can have a wheelbase of up to 10.0 m and a minimum dimensional wheelbase based on tridem drive axle spread of 2.4 m to 3.1 m

  Scenario: oilfield bed truck wheelbase is within the maximum
      Given the vehicle type is an oilfield bed truck (tridem drive)
        And Axle Unit 1 is 3.0 m
        And Interaxle Spacing is 4.0 m
        And Axle Unit 2 is 3.0 m
        And the tridem drive axle spread is 2.5 m
        And the derived wheelbase is 10.0 m
       When the wheelbase is evaluated
       Then the result is blank
        And the permit application is not blocked by wheelbase validation

  Scenario: oilfield bed truck wheelbase exceeds the maximum
      Given the vehicle type is an oilfield bed truck (tridem drive)
        And Axle Unit 1 is 3.0 m
        And Interaxle Spacing is 4.0 m
        And Axle Unit 2 is 3.1 m
        And the tridem drive axle spread is 2.5 m
        And the derived wheelbase is 10.1 m
       When the wheelbase is evaluated
       Then the result is "Wheelbase for Axle Unit 1 is greater than 10.0 m."
        And the permit application is blocked by wheelbase validation
        And the Interaxle Spacing (m) field is indicated with a red border
        And the Axle Spread (m) fields are indicated with a red border

  Scenario Outline: oilfield bed truck minimum dimensional wheelbase by axle spread
      Given the vehicle type is an oilfield bed truck (tridem drive)
        And the tridem drive axle spread is <axle spread> m
        And Axle Unit 1 is <axle unit 1> m
        And Interaxle Spacing is <interaxle spacing> m
        And Axle Unit 2 is <axle unit 2> m
        And the derived wheelbase is <wheelbase> m
       When the wheelbase is evaluated
       Then the result is "<result>"

      Examples:
        | axle spread | axle unit 1 | interaxle spacing | axle unit 2 | wheelbase | result                                        |
        | 2.4         | 2.0         | 3.5               | 2.2         | 7.7       | blank                                         |
        | 2.8         | 2.0         | 3.6               | 2.2         | 7.8       | blank                                         |
        | 3.0         | 2.0         | 3.7               | 2.2         | 7.9       | blank                                         |
        | 2.4         | 2.0         | 3.4               | 2.2         | 7.6       | Wheelbase for Axle Unit 1 is less than 7.7 m. |
        | 2.8         | 2.0         | 3.5               | 2.2         | 7.7       | Wheelbase for Axle Unit 1 is less than 7.8 m. |
        | 3.0         | 2.0         | 3.6               | 2.2         | 7.8       | Wheelbase for Axle Unit 1 is less than 7.9 m. |

# Notes:

Tridem Drive Trucks or Truck Tractors:
 - The minimum wheelbase for a tridem drive truck or truck tractor is 6.6 meters.
 - The maximum wheelbase for a tridem drive truck or truck tractor is 6.8 meters.
Exceptions for Oilfield Bed Trucks (Tridem Drive):
 - Oilfield bed trucks can have a wheelbase of up to 10.0 meters.
 - More specifically, for oilfield bed trucks, the minimum dimensional wheelbase varies based on the tridem drive axle spread:
   - If the tridem drive axle spread is between 2.4 meters and less than 2.8 meters, the minimum dimensional wheelbase is 7.7 meters.
   - If the tridem drive axle spread is between 2.8 meters and less than 3.0 meters, the minimum dimensional wheelbase is 7.8 meters.
   - If the tridem drive axle spread is between 3.0 meters and 3.1 meters, the minimum dimensional wheelbase is 7.9 meters.

# Evaluation Parameters:
- Vehicle Type
- Axle Unit 1
- Interaxle Spacing
- Axle Unit 2
- Wheelbase = Axle Unit 1 + Interaxle Spacing + Axle Unit 2
- Tridem Axle Spread (required for oilfield bed truck evaluations)

# Logic:
Wheelbase = Axle_Unit_1 + Interaxle_Spacing + Axle_Unit_2

IF Vehicle Type = ""General Tridem Drive Truck/Truck Tractor"" THEN
    IF Wheelbase < 6.6 m THEN
        Output = ""Wheelbase for Axle Unit X is less than 6.6 m.""
    ELSE IF Wheelbase > 6.8 m THEN
        Output = ""Wheelbase for Axle Unit X is greater than 6.8 m.""
    ELSE
        Output = """"   // blank if compliant
    END IF

ELSE IF Vehicle Type = ""Oilfield Bed Truck (Tridem Drive)"" THEN
    IF Tridem Axle Spread >= 2.4 m AND Tridem Axle Spread < 2.8 m THEN
        Min_Wheelbase = 7.7 m
    ELSE IF Tridem Axle Spread >= 2.8 m AND Tridem Axle Spread < 3.0 m THEN
        Min_Wheelbase = 7.8 m
    ELSE IF Tridem Axle Spread >= 3.0 m AND Tridem Axle Spread <= 3.1 m THEN
        Min_Wheelbase = 7.9 m
    ELSE
        Min_Wheelbase = 6.6 m   // fallback if spread not in exception ranges
    END IF

    IF Wheelbase < Min_Wheelbase THEN
        Output = ""Wheelbase for Axle Unit X is less than "" + Min_Wheelbase & "" m.""
    ELSE IF Wheelbase > 10.0 m THEN
        Output = ""Wheelbase for Axle Unit X is greater than 10.0 m.""
    ELSE
        Output = """"   // blank if compliant
    END IF
END IF