@orv2- https://moti-imb.atlassian.net/browse/ORV2-
Feature: As a user I need the system to validate interaxle spacing exceptions for jeeps so that STOW applications comply with policy spacing exceptions.

User = PC, SA, TRAIN, CTPO, CA, PA

# Notes
Under British Columbia regulations, interaxle spacing — defined as the longitudinal distance separating two axle units measured from the centers of the closest axles—is strictly controlled to protect highway infrastructure and distribute weights safely.

# Inter-axle Spacing
 Diagrams: 
  Single to Tandem: X---XO
  Tandem to Tandem: OX---XO
  Tandem to Tridem: OX---XOO
  Tridem to Tridem: OOX---XOO

# Standard Legal Interaxle Spacings (No Permit Required)
For standard commercial vehicles operating at standard legal weights, the minimum interaxle spacing is determined by the types of adjacent axle groups:

| Leading Axle Group | Trailing Axle Group | Minimum Legal Spacing |
| Single Axle        | Single Axle         | 3.0 m                 |
| Single Axle        | Tandem Axle         | 3.0 m                 |
| Single Axle        | Tridem Axle         | 3.0 m                 |
| Tandem Axle        | Tandem Axle         | 5.0 m                 |
| Tandem Axle        | Tridem Axle         | 5.5 m                 |
| Tridem Axle        | Tridem Axle         | 6.0 m                 |

Note: If a vehicle satisfies these minimum distances, its axle units are allowed their full standard legal weight limits.

@orv2--1
Rule: Tandem and tridem jeeps must have at least 4.2 m of interaxle spacing to the adjacent trailer axle group when operating under permit

	Scenario Outline: validate minimum spacing between a jeep and the adjacent trailer axle group
		Given the vehicle has a <jeepType> jeep and an adjacent trailer axle group
		 When a user inputs interaxle spacing of <spacing> m between the jeep and trailer axle group
		 Then the interaxle spacing exception result is <result>

		Examples:
			| description            | jeepType | spacing | result  |
			| tandem jeep at minimum | tandem   | 4.2     | valid   |
			| tridem jeep at minimum | tridem   | 4.2     | valid   |
			| jeep below minimum     | tandem   | 4.19    | invalid |

 Scenario: interaxle spacing below minimum for jeep
    Given the vehicle has a tandem jeep and an adjacent trailer axle group
      And the interaxle spacing is 4.19 m
     Then the interaxle spacing exception result is invalid
      And the violation message is "Interaxle Spacing between Axle Unit X and Axle Unit Y must be at least 4.2 m."

Still run 7.17 and bridge formula


# Exception Notes
Tandem and Tridem Jeeps: To operate under permit, tandem and tridem jeeps require a minimum of 4.2 m of interaxle spacing to the adjacent trailer axle group.

 # Deprecated

