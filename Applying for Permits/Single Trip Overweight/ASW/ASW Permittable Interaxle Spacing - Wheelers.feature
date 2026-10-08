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

@orv2--5
Rule: For standard and wide wheelers, the interaxle spacing from the last drive or jeep axle in the front half of the vehicle to the first trailer or dolly axle in the back half must be at least 7.0 m

	Scenario Outline: validate 7.0 m spacing between the front and back halves of a wheeler
		Given the vehicle is a <wheelerType> wheeler
			And the last drive or jeep axle is in the front half of the vehicle
			And the first trailer or dolly axle is in the back half of the vehicle
		 When a user inputs interaxle spacing of <spacing> m between those axle groups
		 Then the interaxle spacing exception result is <result>

		Examples:
			| description              | wheelerType | spacing | result  |
			| standard wheeler minimum | standard    | 7.0     | valid   |
			| wide wheeler minimum     | wide        | 7.0     | valid   |
			| wheeler below minimum    | standard    | 6.99    | invalid |

	Scenario: invalid wheeler spacing
		Given the vehicle is a standard wheeler
			And the last drive or jeep axle is in the front half of the vehicle
			And the first trailer or dolly axle is in the back half of the vehicle
		 When a user inputs interaxle spacing of 6.99 m between those axle groups
		 Then they see the violation "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 7.0 m."

@orv2--6
Rule: Platform trailers must meet the applicable interaxle spacing thresholds for their axle groups

	Scenario Outline: validate platform trailer interaxle spacing
		Given the platform trailer has adjacent <axleGroupType> axle groups
		 When a user inputs interaxle spacing of <spacing> m between those axle groups
		 Then the interaxle spacing exception result is <result>

		Examples:
			| description                      | axleGroupType              | spacing | result  |
			| single axle groups at minimum    | single                     | 1.5     | valid   |
			| single axle groups below minimum | single                     | 1.49    | invalid |
			| tandem groups at minimum         | tandem                     | 4.2     | valid   |
			| tridem groups at minimum         | tridem                     | 4.2     | valid   |
			| tandem or tridem below minimum   | tandem                     | 4.19    | invalid |
			| platform trailer 7.0 m minimum   | applicable 7.0 m threshold | 7.0     | valid   |

# Exception Notes
The 7.0 m Spacing Rule: For both standard and wide wheelers, the interaxle spacing between the last drive or jeep axle in the front half of the vehicle and the first trailer or dolly axle in the back half must be at least 7.0 m.

Platform Trailers: These multi-axle configurations rely on specific spacing thresholds. Single axle groups must be a minimum of 1.5 m apart. Tandem and tridem axle groups require a minimum of 4.2 m, and a 7.0 m threshold also applies.

 # Deprecated

