@orv2- https://moti-imb.atlassian.net/browse/ORV2-
Feature: As a user I need the system to validate legal interaxle spacing so that STOW applications comply with Appendix A Table II and spacing exceptions.

Source table: Table II and spacing exceptions reference https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7BBC9D45A8-8095-48DB-8D4F-C7420A2CAA89%7D&file=Spreads_Spacings_Weight_Exceptions.xlsx&action=default&mobileredirect=true

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

Rule: A non-articulating booster attached to the rear of a lowbed must have at least 4.2 m of interaxle spacing from the trailer's last axle, except that a single-axle booster may have spacing below 3.0 m

	Scenario Outline: validate lowbed trailer-to-booster spacing exception
		Given a non-articulating <boosterType> booster is attached to the rear of a lowbed
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the interaxle spacing exception result is <result>

		Examples:
			| description                     | boosterType | spacing | result  |
			| standard booster at threshold   | single-axle | 4.2     | valid   |
			| single-axle booster below 3.0 m | single-axle | 2.9     | valid   |
			| other booster below threshold   | tandem      | 4.19    | invalid |

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

Rule: Platform trailers must meet the applicable interaxle spacing thresholds for their axle groups

	Scenario Outline: validate platform trailer interaxle spacing
		Given the platform trailer has adjacent <axleGroupType> axle groups
		 When a user inputs interaxle spacing of <spacing> m between those axle groups
		 Then the interaxle spacing exception result is <result>

		Examples:
			| description                      | axleGroupType              | spacing | result  |
			| single axle groups at minimum    | single                    | 1.5     | valid   |
			| single axle groups below minimum | single                    | 1.49    | invalid |
			| tandem groups at minimum         | tandem                   | 4.2     | valid   |
			| tridem groups at minimum         | tridem                   | 4.2     | valid   |
			| tandem or tridem below minimum   | tandem                   | 4.19    | invalid |
			| platform trailer 7.0 m minimum   | applicable 7.0 m threshold | 7.0    | valid   |

# Exception Notes
Tandem and Tridem Jeeps: To operate under permit, tandem and tridem jeeps require a minimum of 4.2 m of interaxle spacing to the adjacent trailer axle group.

Allowable trailer to booster: A non-articulating booster attached to the rear of a lowbed has a 4.2 m spacing threshold from the trailer's last axle, and spacing below 3.0 m is also allowed as an exception for a single-axle booster.

The 7.0 m Spacing Rule: For both standard and wide wheelers, the interaxle spacing between the last drive or jeep axle in the front half of the vehicle and the first trailer or dolly axle in the back half must be at least 7.0 m.

Platform Trailers: These multi-axle configurations rely on specific spacing thresholds. Single axle groups must be a minimum of 1.5 m apart. Tandem and tridem axle groups require a minimum of 4.2 m, and a 7.0 m threshold also applies.

 # Deprecated

