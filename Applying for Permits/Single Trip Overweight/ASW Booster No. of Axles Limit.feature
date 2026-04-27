@orv2-5421 https://moti-imb.atlassian.net/browse/ORV2-5421
Feature: As a user, I need the system to validate that the number of axles in the booster axle unit does not exceed the number of axles on the trailer for single trip overweight permits, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 17: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5421
Rule: Number of axles in booster axle unit must not exceed the number of axles on the trailer for single trip overweight permits

  Scenario: Booster axle unit has more axles than the trailer
    Given the vehicle has a booster axle unit and is towing a trailer
    And the booster axle unit has 2 axles
    And the trailer has 1 axle
    When the user reviews the permit configuration
    Then they see "No. of Axles for Axle Unit X must be less than or equal to No. of Axles for Axle Unit Y."
    And the "No. of Axles" field for the booster axle unit is indicated with a red border
    And they cannot continue the permit application 

  Scenario: Booster axle unit has the same number of axles as the trailer
    Given the vehicle has a booster axle unit and is towing a trailer
    And the booster axle unit has 2 axles
    And the trailer has 2 axles    
    When the user reviews the permit configuration
    Then they do not see "No. of Axles for Axle Unit X must be less than or equal to No. of Axles for Axle Unit Y."
    And they can continue the permit application

# Notes:
 Number of axles in booster <= # of axles on trailer