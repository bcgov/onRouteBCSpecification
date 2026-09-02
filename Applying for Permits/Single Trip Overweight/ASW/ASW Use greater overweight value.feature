@orv2-5692 https://moti-imb.atlassian.net/browse/ORV2-5692
Feature: As a user, I need the system to validate that the number of axles in the booster axle unit does not exceed the number of axles on the trailer for single trip overweight permits, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 12: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5692-1
Rule: when there is a conflict between the overweight value calculated for the axle group and the overweight value calculated for an axle unit, or the Licensed GVW vs the Actual GCVW the greater overweight value is used.

  Scenario: Axle unit overload amount is greater than the Licensed GVW vs Actual GCVW overload amount
    Given the number of axle units is 3
      And the user has input the following weights for each axle unit:
       | Axle Unit | Axle Unit Weight (kg) | Legal Max. (kg) |
       | 1         | 6,000                 | 6,000           |
       | 2         | 23,000                | 22,000          |
       | 3         | 23,000                | 22,000          |
      And the users power unit has a LGVW of 35,000 kg
     When overload amount is calculated based on LGVW and Total GCVW
     Then the overload amount that onRouteBC will use to calculate the permit fee is 17,000 kg
