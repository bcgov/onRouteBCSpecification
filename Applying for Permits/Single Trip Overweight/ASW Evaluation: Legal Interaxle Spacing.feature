@orv2-5872 https://moti-imb.atlassian.net/browse/ORV2-5872
Feature: As a user I need the system to validate legal interaxle spacing so that STOW applications comply with Appendix A Table II and the Heavy Haul Quick Reference Chart.

Source table: Table II and Heavy Haul Quick Reference Chart https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7BBC9D45A8-8095-48DB-8D4F-C7420A2CAA89%7D&file=Spreads_Spacings_Weight_Exceptions.xlsx&action=default&mobileredirect=true

@orv2-5872-1
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

@orv2-5872-2
Rule: Users are shown a violation statement when interaxle spacing is below the Table II minimum distance

  Scenario Outline: interaxle spacing below minimum shows the required minimum distance between axle units
    Given axle unit <axleUnitX> is a <axleTypeA>
      And axle unit <axleUnitY> is a <axleTypeB>
     When a user inputs interaxle spacing of <spacing> m between axle unit <axleUnitX> and axle unit <axleUnitY>
     Then interaxle spacing between those axle units is invalid
      And they see "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be greater than <minSpacing> m."

    Examples:
      | description            | axleUnitX | axleTypeA   | axleUnitY | axleTypeB   | spacing | minSpacing |
      | tandem to tridem below | 2         | Tandem Axle | 3         | Tridem Axle | 5.49    | 5.5        |
      | tridem to tridem below | 3         | Tridem Axle | 4         | Tridem Axle | 5.99    | 6.0        |

@orv2-5872-3
Rule: Exception interaxle spacing limits apply for jeep, semi-trailer, drive axle, and booster combinations

  Scenario Outline: validate interaxle spacing exceptions for specific axle groups
    Given a user has a configuration with <axleGroup>
     When they input interaxle spacing of <spacing> m for that axle group
     Then interaxle spacing for that axle group is <result>

    Examples:
      | description                              | axleGroup                            | spacing | result  |
      | jeep to semitrailer at minimum           | Jeep and Semi-Trailer                | 7.0     | valid   |
      | jeep to semitrailer below minimum        | Jeep and Semi-Trailer                | 6.99    | invalid |
      | drive axle to jeep at minimum            | Drive Axle and Jeep                  | 4.2     | valid   |
      | drive axle to jeep below minimum         | Drive Axle and Jeep                  | 4.19    | invalid |
      | drive axle to jeep single axle at min    | Drive Axle and Jeep Single Axle      | 1.2     | valid   |
      | drive axle to jeep single axle at max    | Drive Axle and Jeep Single Axle      | 3.5     | valid   |
      | drive axle to jeep single axle below min | Drive Axle and Jeep Single Axle      | 1.19    | invalid |
      | drive axle to jeep single axle above max | Drive Axle and Jeep Single Axle      | 3.51    | invalid |
      | semitrailer to booster below 3.0         | Semi-Trailer and Booster Single Axle | 2.99    | valid   |
      | semitrailer to booster at 3.0            | Semi-Trailer and Booster Single Axle | 3.0     | valid   |
      | semitrailer to booster above 3.0         | Semi-Trailer and Booster Single Axle | 4.2     | valid   |

@orv2-5872-4
Rule: Users are shown a violation statement when exception interaxle spacing is outside the allowed limit

  Scenario Outline: invalid exception spacing shows required limit
    Given a user has a configuration with <axleGroup>
     When they input interaxle spacing of <spacing> m for that axle group
     Then interaxle spacing for that axle group is invalid
      And they see "Interaxle Spacing for <axleGroup> must be <requiredStatement>."

    Examples:
      | description                         | axleGroup                       | spacing | requiredStatement       |
      | jeep to semitrailer below min       | Jeep and Semi-Trailer           | 6.99    | greater than 7.0 m      |
      | drive axle to jeep below min        | Drive Axle and Jeep             | 4.19    | greater than 4.2 m      |
      | drive axle to jeep single above max | Drive Axle and Jeep Single Axle | 3.51    | between 1.2 m and 3.5 m |

