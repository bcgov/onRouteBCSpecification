@ORV2-5350 https://moti-imb.atlassian.net/browse/ORV2-5350
Feature: As a user, I need the system to validate that the Drive Axle Unit and Jeep Axle Unit are load equalized within 1,000 kg when they have the same number of axles, so that I can ensure the permit configuration is compliant. 

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 11: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@ORV2-5350-1
Rule: Drive Axle Unit and Jeep Axle Unit with the same number of axles must be load equalized within 1000 kg

  Scenario Outline: Weight difference exceeds 1000 kg
    Given Axle Unit 2 and Axle Unit 3 have the same number of axles
    And Axle Unit 2 weight is <axleUnit2Weight> kg
    And Axle Unit 3 weight is <axleUnit3Weight> kg
    When the user chooses to calculate or continue with the permit application
    Then they see "Axle Unit 2 and Axle Unit 3 must be load equalized within 1000 kg."
     And axle unit 2 and axle unit 3 "Axle unit weight (kg)" fields are indicated with a red border
     And they cannot continue the permit application

    Examples:
      | axleUnit2Weight | axleUnit3Weight |
      | 12000           | 10999           |
      | 13500           | 12499           |
      | 15000           | 13900           |

  Scenario Outline: Weight difference is 1000 kg or less
    Given Axle Unit 2 and Axle Unit 3 have the same number of axles
    And Axle Unit 2 weight is <axleUnit2Weight> kg
    And Axle Unit 3 weight is <axleUnit3Weight> kg
    When the user chooses to calculate or continue with the permit application
    Then they do not see a load equalization error
     And they can continue the permit application

    Examples:
      | axleUnit2Weight | axleUnit3Weight |
      | 12000           | 11000           |
      | 13500           | 12501           |
      | 15000           | 15000           |

