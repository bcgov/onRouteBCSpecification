@orv2-5506 https://moti-imb.atlassian.net/browse/ORV2-5506
Feature: As a user, I need the system to ensure the Tandem Steer Axle is a minimum of 40% of the Tandem or Tridem Drive Axle Weight, so that I can ensure the permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 23: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5506
Rule: Tandem Steer Axle must be a minimum of 40% of Tandem or Tridem Drive Axle Weight

  Scenario Outline: Tandem steer axle weight meets the minimum 40% requirement of tandem drive axle
    Given the vehicle has a tandem steer axle and a tandem drive axle
    And the tandem drive axle weight is <tandemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description                  | tandemDriveAxleWeight | steerAxleWeight |
      | Boundary pass at exactly 40% | 17000                 | 6800            |
      | Pass above 40% threshold     | 17000                 | 7000            |
      | Boundary pass at exactly 40% | 15000                 | 6000            |

  Scenario Outline: Tandem steer axle weight is below the minimum 40% requirement of tandem drive axle
    Given the vehicle has a tandem steer axle and a tandem drive axle
    And the tandem drive axle weight is <tandemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 40% of Axle Unit Y axle unit Weight."

    Examples:
      | description                  | tandemDriveAxleWeight | steerAxleWeight |
      | Fail just below 40% boundary | 17000                 | 6799            |
      | Fail just below 40% boundary | 15000                 | 5999            |
      | Fail well below 40%          | 17000                 | 5000            |

  Scenario Outline: Tandem steer axle weight meets the minimum 40% requirement of tridem drive axle
    Given the vehicle has a tandem steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they do not see a steer axle weight error

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Boundary pass at exactly 40% | 20000                 | 8000            |
      | Pass above 40% threshold     | 20000                 | 8500            |
      | Boundary pass at exactly 40% | 18000                 | 7200            |

  Scenario Outline: Tandem steer axle weight is below the minimum 40% requirement of tridem drive axle
    Given the vehicle has a tandem steer axle and a tridem drive axle
    And the tridem drive axle weight is <tridemDriveAxleWeight> kg
    And the tandem steer axle weight is <steerAxleWeight> kg
    When the user reviews the permit configuration
    Then they see "Axle Unit X must be a minimum of 40% of Axle Unit Y axle unit Weight."

    Examples:
      | description                  | tridemDriveAxleWeight | steerAxleWeight |
      | Fail just below 40% boundary | 20000                 | 7999            |
      | Fail just below 40% boundary | 18000                 | 7199            |
      | Fail well below 40%          | 15000                 | 5000            |
