@orv2-5872 https://moti-imb.atlassian.net/browse/ORV2-5872
Feature: As a user I need the system to validate legal interaxle spacing so that STOW applications comply with Appendix A Table II and spacing exceptions.

Source table: Table II and spacing exceptions reference https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7BBC9D45A8-8095-48DB-8D4F-C7420A2CAA89%7D&file=Spreads_Spacings_Weight_Exceptions.xlsx&action=default&mobileredirect=true

@orv2-5872-1
Rule: Interaxle spacing between adjacent axle units must meet Table II minimum distances for vehicles to operate at standard legal weights ((9,100 kg single / 17,000 kg tandem / 24,000 kg tridem)).

 Table II Minimum Interaxle Spacing (m) for Standard Legal Weights:
 | Leading Axle Group | Trailing Axle Group | Minimum Legal Spacing |
 | Single Axle        | Single Axle         | 3.0 m                 |
 | Single Axle        | Tandem Axle         | 3.0 m                 |
 | Single Axle        | Tridem Axle         | 3.0 m                 |
 | Tandem Axle        | Tandem Axle         | 5.0 m                 |
 | Tandem Axle        | Tridem Axle         | 5.5 m                 |
 | Tridem Axle        | Tridem Axle         | 6.0 m                 |

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
      And they see "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least <minSpacing> m."

    Examples:
      | description            | axleUnitX | axleTypeA   | axleUnitY | axleTypeB   | spacing | minSpacing |
      | tandem to tridem below | 2         | Tandem Axle | 3         | Tridem Axle | 5.49    | 5.5        |
      | tridem to tridem below | 3         | Tridem Axle | 4         | Tridem Axle | 5.99    | 6.0        |

# Notes
Under British Columbia regulations, **interaxle spacing**—defined as the longitudinal distance separating two axle units measured from the centers of the closest axles—is strictly controlled to protect highway infrastructure and distribute weights safely. 

1. Standard Legal Interaxle Spacings (No Permit Required)
For standard commercial vehicles operating at standard legal weights, the minimum interaxle spacing is determined by the types of adjacent axle groups:

| Leading Axle Group | Trailing Axle Group | Minimum Legal Spacing |
| :--- | :--- | :--- |
| **Single Axle** | **Single Axle** | **3.0 m** |
| **Single Axle** | **Tandem Axle** | **3.0 m** |
| **Single Axle** | **Tridem Axle** | **3.0 m** |
| **Tandem Axle** | **Tandem Axle** | **5.0 m** |
| **Tandem Axle** | **Tridem Axle** | **5.5 m** |
| **Tridem Axle** | **Tridem Axle** | **6.0 m** |

# Deprecated
 @orv2-5872-3
 Rule: A truck tractor with a single-axle jeep and lowbed semi-trailer may use interaxle spacing between 1.2 m and 3.5 m without a permit under CTR Section 7.22 when the qualifying load conditions are met

   Scenario Outline: validate CTR Section 7.22 interaxle spacing exception for single-axle jeep with lowbed semi-trailer
     Given a truck tractor is in combination with a single-axle jeep and a lowbed semi-trailer
       And the load condition is <loadCondition>
      When a user inputs interaxle spacing of <spacing> m between the tractor drive axle group and the single-axle jeep
      Then the interaxle spacing exception result is <result>
       And the spacing is <legalStatus>
       And for <legalstatus> of invalid they see "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be between 1.2 and 3.5 m."

     Examples:
       | description         | loadCondition | spacing | result  | legalStatus |
       | unladen at minimum  | empty         | 1.2     | valid   | legal       |
       | empty at maximum    | empty         | 3.5     | valid   | legal       |
       | empty below minimum | empty         | 1.19    | invalid | invalid     |
       | empty above maximum | empty         | 3.51    | invalid | invalid     |
 
 Legal exception:
 1. Single-Axle Jeep with Lowbed Semi-Trailer (CTR Section 7.22)

 - The Standard Rule: Standard legal spacings require a minimum gap of 3.0 m between a tandem axle group (the tractor drive) and any adjacent single axle (such as a jeep).
 - The Exception: Under CTR Section 7.22, a truck tractor in combination with a single-axle jeep and a lowbed semi-trailer can legally operate with an interaxle spacing of between 1.2 m and 3.5 m without a permit.
 - The Conditions: This spacing reduction is only permitted if the combination is completely unladen, or is being used to haul a bundle of green, in their natural state, felled or bucked logs or poles.

