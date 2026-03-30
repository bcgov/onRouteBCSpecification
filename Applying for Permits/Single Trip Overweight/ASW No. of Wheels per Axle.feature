@ORV2-5341 https://moti-imb.atlassian.net/browse/ORV2-5341
Feature: As a user I need the system to ensure I am only able to input the number of wheels per axle that is allowed for the axle type I have selected.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 6: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@ORV2-5341-1
Rule: A single axle unit can have 2, 4 or 8 wheels per axle 

  Scenario Outline: Single axle unit accepts valid wheel counts
    Given the axle unit type is "single"
    When the user enters <wheels> for number of wheels per axle
    Then the value is accepted

    Examples:
      | wheels |
      | 2      |
      | 4      |
      | 8      |

@ORV2-5341-2
Rule: A tandem axle unit can have 4, 8 or 16 wheels per axle

  Scenario Outline: Tandem axle unit accepts valid wheel counts
    Given the axle unit type is "tandem"
    When the user enters <wheels> for number of wheels per axle
    Then the value is accepted

    Examples:
      | wheels |
      | 4      |
      | 8      |
      | 16     |

@ORV2-5341-3
Rule: A tridem axle unit can have 6, 12 or 24 wheels per axle

  Scenario Outline: Tridem axle unit accepts valid wheel counts
    Given the axle unit type is "tridem"
    When the user enters <wheels> for number of wheels per axle
    Then the value is accepted

    Examples:
      | wheels |
      | 6      |
      | 12     |
      | 24     |

@ORV2-5341-4
Rule: Invalid wheel count for axle unit type is rejected

  Scenario Outline: Invalid wheel count shows not permittable message
    Given the axle unit type is <axleType>
    And axle unit identifier is <axleUnit>
    When the user enters <wheels> for number of wheels per axle
     And they choose to calculate or continue with the application
    Then they see "No. of Wheels for Axle Unit <axleUnit> is not permittable."
     And the invalid "No. of Wheels" field(s) are indicated with a red border
     And they cannot continue the application

    Examples:
      | axleType | axleUnit | wheels |
      | single   | 2        | 6      |
      | tandem   | 3        | 10     |
      | tridem   | 4        | 8      |

# Notes: