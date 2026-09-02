@orv2-5390 https://moti-imb.atlassian.net/browse/ORV2-5382
Feature: As a user, I need the system to validate that the minimum and maximum number of axles is permittable, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 8: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5390-1
Rule: Minimum number of axles is 1

  Scenario: No axles added
    Given a user has added a truck tractor power unit
      And they change the number of axles for an axle unit 2 to 0
     When they choose to calculate or continue to the next step
     Then they see "No. of Axles for Axle Unit 2 cannot be 0." error message
      And the axle unit 2 number of axles input field is indicated

  Scenario: At least 1 axle added
    Given a user has added a truck tractor power unit
      And they change the number of axles for axle unit 2 to 3
     When they choose to calculate or continue to the next step
     Then they do not see the error message
      And the axle unit 2 number of axles input field is not indicated

@orv2-5390-2
Rule: Maximum number of axles is 3 

  Scenario: Exceed maximum number of axles
    Given a user has added a truck tractor power unit
      And they change the number of axles for an axle unit 2 to 5
     When they choose to calculate or continue to the next step
     Then they see "No. of Axles for Axle Unit 2 is not permittable." error message
      And the axle unit 2 number of axles input field is indicated

  Scenario: Does not exceed maximum number of axles
    Given a user has added a truck tractor power unit
      And they change the number of axles for axle unit 2 to 3
     When they choose to calculate or continue to the next step
     Then they do not see the error message
      And the axle unit 2 number of axles input field is not indicated
