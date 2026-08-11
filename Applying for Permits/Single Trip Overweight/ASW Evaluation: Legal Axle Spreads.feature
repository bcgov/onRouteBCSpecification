@orv2-5872 https://moti-imb.atlassian.net/browse/ORV2-5874
Feature: As a user I need the system to validate legal axle spreads so that STOW applications comply with Appendix A Table I.

Sources: Table I (Axle Spread) https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7BBC9D45A8-8095-48DB-8D4F-C7420A2CAA89%7D&file=Spreads_Spacings_Weight_Exceptions.xlsx&action=default&mobileredirect=true


user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-5872-1
Rule: Users must input axle spreads within Table I limits for single and tandem axle units based on the selected vehicle combination

  Scenario Outline: validate single and tandem axle spread limits by vehicle combination
    Given a user has selected <vehicleCombination>
      And axle unit <axleUnitType> is present in the ASW table
     When they input an axle spread of <spread> m for that axle unit
     Then axle spread for that axle unit is <result>

    Examples:
      | description              | vehicleCombination                             | axleUnitType | spread | result  |
      | single axle at max       | Truck and Pony Trailer Combinations            | Single Axle  | 1.0    | valid   |
      | single axle above max    | Truck and Pony Trailer Combinations            | Single Axle  | 1.01   | invalid |
      | tandem axle at min       | Truck Tractor and Semi-Trailer Combinations    | Tandem Axle  | 1.0    | valid   |
      | tandem axle at max       | Truck Tractor and Semi-Trailer Combinations    | Tandem Axle  | 1.85   | valid   |
      | tandem axle below min    | Truck Tractor and Semi-Trailer Combinations    | Tandem Axle  | 0.99   | invalid |
      | spread tandem at min     | Truck Tractor and Semi-Trailer - Spread Tandem | Tandem Axle  | 1.86   | valid   |
      | spread tandem at max     | Truck Tractor and Semi-Trailer - Spread Tandem | Tandem Axle  | 3.07   | valid   |
      | spread tandem above max  | Truck Tractor and Semi-Trailer - Spread Tandem | Tandem Axle  | 3.08   | invalid |

@orv2-5872-2
Rule: Tridem drive axle spread must follow Table I limits and include the oilfield bed truck exception

  Scenario Outline: validate tridem drive axle spread limits
    Given a user has selected <vehicleCombination>
      And a tridem drive axle unit is present in the ASW table
      And the vehicle is <oilfieldCondition>
     When they input an axle spread of <spread> m for the tridem drive axle
     Then axle spread for the tridem drive axle is <result>

    Examples:
      | description                   | vehicleCombination                  | oilfieldCondition      | spread | result  |
      | non-oilfield at minimum       | Truck and Pony Trailer Combinations | not an oilfield truck  | 2.4    | valid   |
      | non-oilfield at maximum       | Truck and Pony Trailer Combinations | not an oilfield truck  | 2.8    | valid   |
      | non-oilfield above maximum    | Truck and Pony Trailer Combinations | not an oilfield truck  | 3.0    | invalid |
      | oilfield at exception maximum | Truck and Pony Trailer Combinations | an oilfield bed truck  | 3.1    | valid   |
      | oilfield above exception max  | Truck and Pony Trailer Combinations | an oilfield bed truck  | 3.11   | invalid |

@orv2-5872-3
Rule: Tridem axles in trailers must be validated using Table I limits for the selected vehicle combination

  Scenario Outline: validate tridem trailer spread limits by vehicle combination
    Given a user has selected <vehicleCombination>
      And a tridem axle in trailer is present in the ASW table
      And the drive configuration is <driveConfiguration>
     When they input an axle spread of <spread> m for the trailer tridem axle
     Then axle spread for the trailer tridem axle is <result>

    Examples:
      | description                  | vehicleCombination                                           | driveConfiguration | spread | result       |
      | pony trailer at minimum      | Truck and Pony Trailer Combinations                          | any                | 2.4    | valid        |
      | pony trailer at maximum      | Truck and Pony Trailer Combinations                          | any                | 2.5    | valid        |
      | pony trailer above maximum   | Truck and Pony Trailer Combinations                          | any                | 2.51   | invalid      |
      | semitrailer at maximum       | Truck Tractor and Semi-Trailer Combinations                  | any                | 3.7    | valid        |
      | pole trailer at maximum      | Tridem Truck Tractor with Tridem or Tandem Axle Pole Trailer | any                | 3.1    | valid        |

@orv2-5872-4
Rule: Users are shown a violation statement when axle spread is outside the permitted Table I range

  Scenario Outline: invalid axle spread shows the allowed range for the axle unit
    Given a user has selected <vehicleCombination>
      And axle unit <axleUnitNumber> is a <axleUnitType> in the ASW table
     When they input an axle spread of <spread> m for that axle unit
     Then axle spread for that axle unit is invalid
      And they see "Axle Spread for Axle Unit <axleUnitNumber> must be between <minSpread> m and <maxSpread> m."

    Examples:
      | description                | vehicleCombination                          | axleUnitNumber | axleUnitType       | spread | minSpread | maxSpread |
      | tandem axle below minimum  | Truck Tractor and Semi-Trailer Combinations | 2              | Tandem Axle        | 0.99   | 1.0       | 1.85      |
      | tridem drive above maximum | Truck and Pony Trailer Combinations         | 2              | Tridem Drive Axle  | 3.0    | 2.4       | 2.8       |
      | trailer tridem above max   | Truck and Pony Trailer Combinations         | 3              | Tridem Trailer Axle| 2.51   | 2.4       | 2.5       |

# Notes:

Rule: If Table I marks an axle type as Not Applicable for a vehicle combination, users cannot input spread for that axle type

  Scenario Outline: spread input is unavailable for not applicable axle types
    Given a user has selected <vehicleCombination>
      And Table I marks <axleType> as Not Applicable
     When they view the axle spread field for that axle type
     Then the axle spread field is not available

    Examples:
      | vehicleCombination                             | axleType           |
      | Truck Tractor and Semi-Trailer - Spread Tandem | Tridem Drive Axles |