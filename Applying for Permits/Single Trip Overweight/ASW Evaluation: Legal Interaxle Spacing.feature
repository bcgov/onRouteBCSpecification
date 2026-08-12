@orv2-5872 https://moti-imb.atlassian.net/browse/ORV2-5872
Feature: As a user I need the system to validate legal interaxle spacing so that STOW applications comply with Appendix A Table II and spacing exceptions.

Source table: Table II and spacing exceptions reference https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7BBC9D45A8-8095-48DB-8D4F-C7420A2CAA89%7D&file=Spreads_Spacings_Weight_Exceptions.xlsx&action=default&mobileredirect=true

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
      | description                         | axleGroup                                 | spacing | requiredStatement       |
      | jeep to semitrailer below min       | Jeep and Semi-Trailer                     | 6.99    | greater than 7.0 m      |
      | drive axle to jeep below min        | Drive Axle and Jeep tandem or tridem axle | 4.19    | greater than 4.2 m      |
      | drive axle to jeep single above max | Drive Axle and Jeep Single Axle           | 3.51    | between 1.2 m and 3.5 m |

@orv2-5872-5
Rule: Exceptions for Platform Trailer and Platform Trailer - Wheelers axle groups must meet spacing thresholds based on axle group type

  Scenario Outline: validate platform trailer spacing thresholds by axle group type
    Given a user has a platform trailer with a <axleGroupType> axle group
     When they input interaxle spacing of <spacing> m for that axle group
     Then the axle group <spacingResult>

    Examples:
      | description                          | axleGroupType | spacing | spacingResult                                  |
      | single axle group at minimum         | Single        | 1.5     | meets the minimum 1.5 m spacing requirement    |
      | single axle group below minimum      | Single        | 1.49    | is below the minimum 1.5 m spacing requirement |
      | tandem axle group at standard min    | Tandem        | 4.2     | meets the minimum 4.2 m spacing threshold      |
      | tandem axle group below standard min | Tandem        | 4.19    | is below the minimum 4.2 m spacing threshold   |
      | tandem axle group below 7.0          | Tandem        | 6.99    | is below the 7.0 m spacing threshold           |
      | tandem axle group at 7.0             | Tandem        | 7.0     | meets the 7.0 m spacing threshold              |
      | tridem axle group at standard min    | Tridem        | 4.2     | meets the minimum 4.2 m spacing threshold      |
      | tridem axle group below standard min | Tridem        | 4.19    | is below the minimum 4.2 m spacing threshold   |
      | tridem axle group below 7.0          | Tridem        | 6.99    | is below the 7.0 m spacing threshold           |
      | tridem axle group at 7.0             | Tridem        | 7.0     | meets the 7.0 m spacing threshold              |

@orv2-5872-6
Rule: Exceptions for wheelers and wide wheelers must have at least 7.0 m of interaxle spacing between the last drive or jeep axle in the front half and the first trailer or dolly axle in the back half

  Scenario Outline: validate the 7.0 m spacing rule for standard and wide wheelers
    Given a user has selected vehicle sub-type <vehicleSubType>
      And the spacing being measured is between the last <frontAxleGroup> axle in the front half and the first <backAxleGroup> axle in the back half
     When they input interaxle spacing of <spacing> m
     Then the interaxle spacing result is <result>

    Examples:
      | description                                     | vehicleSubType                          | frontAxleGroup | backAxleGroup | spacing | result  |
      | fixed equipment wheeler semitrailers at minimum | Fixed Equipment - Wheeler Semi-Trailers | drive          | trailer       | 7.0     | valid   |
      | fixed equipment wheeler semitrailers below min  | Fixed Equipment - Wheeler Semi-Trailers | drive          | trailer       | 6.99    | invalid |
      | platform trailer wheelers at minimum            | Platform Trailer - Wheelers             | drive          | trailer       | 7.0     | valid   |
      | semi-trailers wheelers below min                | Semi-Trailers - Wheelers                | drive          | trailer       | 6.99    | invalid |
      | semi-trailers wide wheelers at minimum          | Semi-Trailers - Wide Wheelers           | jeep           | dolly         | 7.0     | valid   |
      | semi-trailers wide wheelers below min           | Semi-Trailers - Wide Wheelers           | jeep           | dolly         | 6.99    | invalid |

@orv2-5872-7
Rule: Users are shown a violation statement when standard or wide wheelers do not meet the 7.0 m spacing rule

 #Note: will confirm the violation statement for this one
  Scenario Outline: wheeler spacing below 7.0 m shows required minimum distance
    Given a user has selected vehicle sub-type <vehicleSubType>
      And the spacing being measured is between the last <frontAxleGroup> axle in the front half and the first <backAxleGroup> axle in the back half
     When they input interaxle spacing of <spacing> m
     Then the interaxle spacing is invalid
      And they see "Interaxle Spacing between the last <frontAxleGroup> axle in the front half and the first <backAxleGroup> axle in the back half must be at least 7.0 m."

    Examples:
      | description                                    | vehicleSubType                          | frontAxleGroup | backAxleGroup | spacing |
      | fixed equipment wheeler semitrailers below min | Fixed Equipment - Wheeler Semi-Trailers | drive          | trailer       | 6.99    |
      | platform trailer wheelers below min            | Platform Trailer - Wheelers             | drive          | trailer       | 6.99    |
      | semi-trailers wheelers below min               | Semi-Trailers - Wheelers                | drive          | trailer       | 6.99    |
      | semi-trailers wide wheelers below min          | Semi-Trailers - Wide Wheelers           | jeep           | dolly         | 6.99    |

# Notes
 # Exceptions to Table II
 Tandem and Tridem Jeeps: To operate under permit, tandem and tridem jeeps require a minimum of 4.2 m of interaxle spacing to the adjacent trailer axle group

 Allowable trailer to booster: a non-articulating booster attached to the rear of a lowbed has a 4.2 m spacing threshold from the trailer's last axle, and spacing below 3.0 m is also allowed as an exception for a single-axle booster.

 The 7.0 m Spacing Rule: For both standard and wide wheelers, the interaxle spacing between the last drive (or jeep) axle in the front half of the vehicle to the first trailer/dolly axle in the back half must be at least 7.0 m

 Platform Trailers: These multi-axle configurations rely on specific spacing thresholds:
 Single axle groups must be a minimum of 1.5 m apart

 Tandem/Tridem axle groups require a minimum of 4.2 m and a 7.0 m threshold also applies
 # Deprecated

