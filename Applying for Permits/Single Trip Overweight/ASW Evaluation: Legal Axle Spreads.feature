@orv2-5872 https://moti-imb.atlassian.net/browse/ORV2-5872
Feature: As a user I need the system to validate legal interaxle spacing so that STOW applications comply with Appendix A Table II.

@orv2-5872-4
Rule: Interaxle spacing between adjacent axle units must meet Table II minimum distances

  Scenario Outline: validate interaxle spacing minimum by adjacent axle type pair
    Given adjacent axle units are <axleTypeA> followed by <axleTypeB>
     When a user inputs interaxle spacing of <spacing> m between those axle units
     Then interaxle spacing between those axle units is <result>

    Examples:
      | description              | axleTypeA   | axleTypeB   | spacing | result  |
      | single to single min     | Single Axle | Single Axle | 3.0     | valid   |
      | single to tandem min     | Single Axle | Tandem Axle | 3.0     | valid   |
      | single to tridem min     | Single Axle | Tridem Axle | 3.0     | valid   |
      | tandem to single min     | Tandem Axle | Single Axle | 3.0     | valid   |
      | tandem to tandem min     | Tandem Axle | Tandem Axle | 5.0     | valid   |
      | tandem to tridem min     | Tandem Axle | Tridem Axle | 5.5     | valid   |
      | tridem to single min     | Tridem Axle | Single Axle | 3.0     | valid   |
      | tridem to tandem min     | Tridem Axle | Tandem Axle | 5.5     | valid   |
      | tridem to tridem min     | Tridem Axle | Tridem Axle | 6.0     | valid   |
      | tandem to tridem below   | Tandem Axle | Tridem Axle | 5.49    | invalid |
      | tridem to tridem below   | Tridem Axle | Tridem Axle | 5.99    | invalid |

@orv2-5872-5
Rule: If Table I marks an axle type as Not Applicable for a vehicle combination, users cannot input spread for that axle type

  Scenario Outline: spread input is unavailable for not applicable axle types
    Given a user has selected <vehicleCombination>
      And Table I marks <axleType> as Not Applicable
     When they view the axle spread field for that axle type
     Then the axle spread field is not available

    Examples:
      | vehicleCombination                     | axleType           |
      | A Train                                | Tridem Drive Axles |
      | C Train                                | Tridem Drive Axles |
      | Truck Tractor and Semi-Trailer - Spread Tandem | Tridem Drive Axles |

