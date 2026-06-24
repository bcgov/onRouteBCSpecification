@orv2-5612 https://moti-imb.atlassian.net/browse/ORV2-5612 
Feature: As a user I need the system to validate whether the actual GCVW exceeds the licensed GVW for my single trip overweight permit application, so that I can determine the overweight amount that applies.

users = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 2: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5612-1
Rule: overweight is the amount by which actual GCVW exceeds licensed GVW

  Scenario Outline: actual GCVW exceeds licensed GVW
    Given the licensed GVW is <licensedGvw> kg
      And the actual GCVW is <actualGcvw> kg
     When the user chooses to calculate or continue with the permit application
     Then the overweight is <overweight> kg

    Examples:
      | description                    | licensedGvw | actualGcvw | overweight |
      | actual GCVW above licensed GVW | 63500       | 64000      | 500        |
      | larger overweight amount       | 50000       | 57500      | 7500       |

  Scenario Outline: actual GCVW does not exceed licensed GVW
    Given the licensed GVW is <licensedGvw> kg
      And the actual GCVW is <actualGcvw> kg
     When the user chooses to calculate or continue with the permit application
     Then the overweight is <overweight>

    Examples:
      | description                     | licensedGvw | actualGcvw | overweight |
      | actual GCVW equals licensed GVW | 63500       | 63500      | 0          |
      | actual GCVW below licensed GVW  | 63500       | 63000      | 0          |

@orv2-5612-2
Rule: if the overweight calculated from licensed GVW versus actual GCVW conflicts with another overweight value, the greater overweight value is used to determine what the user is charged

# See ASW Use greater overweight value.feature for scenarios covering how the system selects the highest overweight amount.

# Notes:
Licensed GVW - actual GCVW overweight = positive value if greater than actual GCVW

# Evaluation Parameters:
- Licensed GVW
- Actual GCVW
- Overweight = Actual GCVW - Licensed GVW

# Logic:

IF actual GCVW > licensed GVW, THEN the overweight = actual GCVW - licensed GVW.
ELSE, the overweight = 0 or blank.

