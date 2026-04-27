@ORV2-5366 https://moti-imb.atlassian.net/browse/ORV2-5366
Feature: As a user, I need the system to ensure the Steer Axle is a minimum of 27% of the Tridem Drive Axle Weight, so that I can ensure the permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 14: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@ORV2-5366
Rule: Steer Axle must be a minimum of 27% of Tridem Drive Axle Weight

  Scenario Outline: Steer axle weight meets the minimum 27% requirement
    Given the vehicle has a steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Boundary pass at exactly 27% | 20000                 | 5400            |
      | Pass above 27% threshold     | 20000                 | 6000            |
      | Boundary pass at exactly 27% | 18000                 | 4860            |

  Scenario Outline: Steer axle weight is below the minimum 27% requirement
    Given the vehicle has a steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 27% of Axle Unit Y axle unit Weight."

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Fail just below 27% boundary | 20000                 | 5399            |
      | Fail just below 27% boundary | 18000                 | 4859            |
      | Fail well below 27%          | 15000                 | 4000            |

