@ORV2-5341 https://moti-imb.atlassian.net/browse/ORV2-5341
Feature: As a user I need the system to ensure I am only able to input the number of wheels per axle that is allowed for the axle type I have selected.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 6: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5695-1
Rule: Axle unit 1 is always steer and axle unit 2 is always drive.

@orv2-5695-2
Rule: Steering axle can have 2 wheels for single axle unit, 4 wheels for tandem axle unit and 6 wheels for tridem axle unit

  Scenario: invalid number of wheels
    Given the axle unit is 1
      And the number of axles is 1
     When the user enters 4 for number of wheels per axle
     Then they see "No. of Wheels for Axle Unit 1 is not permittable."
      And the "No. of Wheels" field is indicated with a red border
      And they cannot continue the application

@orv2-5695-3
Rule: Drive axle can have 2 or 4 wheels for single axle unit, 4 or 8 wheels for tandem axle unit and 6 or 12 wheels for tridem axle unit

  Scenario: invalid number of wheels
    Given the axle unit is 2
      And the number of axles is 1
     When the user enters 8 for number of wheels per axle
     Then they see "No. of Wheels for Axle Unit 2 is not permittable."
      And the "No. of Wheels" field is indicated with a red border
      And they cannot continue the application

@ORV2-5341-1 @orv2-5695-4
Rule: Axle unit = > 3 single axle unit can have 2, 4 or 8 wheels per axle 

  Scenario Outline: Single axle unit accepts valid wheel counts
    Given the axle unit type is "single"
     And the number of axles is 1
    When the user enters <wheels> for number of wheels per axle
    Then the value is accepted

    Examples:
      | description              | wheels |
      | Valid single minimum     | 2      |
      | Valid single mid value   | 4      |
      | Valid single maximum     | 8      |

@ORV2-5341-2 @orv2-5695-5
Rule: Axle unit = > 3 tandem axle unit can have 4, 8 or 16 wheels per axle

  Scenario Outline: Tandem axle unit accepts valid wheel counts
    Given the axle unit type is "tandem"
      And the number of axles is 2
     When the user enters <wheels> for number of wheels per axle
     Then the value is accepted

    Examples:
      | description              | wheels |
      | Valid tandem minimum     | 4      |
      | Valid tandem mid value   | 8      |
      | Valid tandem maximum     | 16     |

@ORV2-5341-3 @orv2-5695-6
Rule: Axle unit = > 3 tridem axle unit can have 6, 12 or 24 wheels per axle

  Scenario Outline: Tridem axle unit accepts valid wheel counts
    Given the axle unit type is "tridem"
      And the number of axles is 3
     When the user enters <wheels> for number of wheels per axle
     Then the value is accepted

    Examples:
      | description              | wheels |
      | Valid tridem minimum     | 6      |
      | Valid tridem mid value   | 12     |
      | Valid tridem maximum     | 24     |

@ORV2-5341-4 @orv2-5695-7
Rule: Invalid wheel count for axle unit = > 3 is rejected

  Scenario Outline: Invalid wheel count shows not permittable message
    Given the axle unit type is <axleType>
    And axle unit identifier is <axleUnit>
    When the user enters <wheels> for number of wheels per axle
     And they choose to calculate or continue with the application
    Then they see "No. of Wheels for Axle Unit <axleUnit> is not permittable."
     And the invalid "No. of Wheels" field(s) are indicated with a red border
     And they cannot continue the application

    Examples:
      | description                    | axleType | axleUnit | wheels |
      | Invalid for single axle unit   | single   | 3        | 6      |
      | Invalid for tandem axle unit   | tandem   | 4        | 10     |
      | Invalid for tridem axle unit   | tridem   | 5        | 8      |

# Notes:
Axle unit 1 is always steer and axle unit 2 is always drive.
Steering axle allowable number of wheels
Single axle 2
Tandem 4
Tridem 6
Drive axle allowable number of wheels
Single 2, 4
Tandem 4, 8
Tridem 6, 12