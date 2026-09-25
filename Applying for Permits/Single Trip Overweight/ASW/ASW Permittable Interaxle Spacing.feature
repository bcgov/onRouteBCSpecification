@orv2-6030 https://moti-imb.atlassian.net/browse/ORV2-6030
Feature: As a user I need the system to validate interaxle spacing exceptions so that STOW applications comply with policy spacing exceptions.

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

@orv2-6030-1
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

Interaxle Spacing between Axle Unit X and Axle Unit Y must be at least A m.
Still run 7.17 and bridge formula

@orv2-6030-2
Rule: For a single-axle booster attached to the rear of a semi-trailer, interaxle spacing determines the maximum permittable booster weight: spacing of 4.2 m or greater allows up to the permittable maximum of 11,000 kg; spacing between 3.0 m and less than 4.2 m allows only up to the legal maximum of 9,100 kg; and spacing below 3.0 m also allows only up to the legal maximum of 9,100 kg.

	Scenario Outline: determine maximum permittable booster weight from trailer-to-booster spacing
		Given a single-axle booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the maximum permittable booster weight is <maximumallowedWeight> kg

		Examples:
			| description                        | spacing | maximumallowedWeight |
			| spacing at higher weight threshold | 4.2     | 11000                |
			| spacing above higher threshold     | 5.0     | 11000                |
			| spacing between legal and permit   | 3.0     | 9100                 |
			| spacing below permit threshold     | 4.19    | 9100                 |
			| spacing below legal threshold      | 2.99    | 9100                 |

@orv2-6030-3
Rule: For a tandem booster attached to the rear of a semi-trailer, the minimum interaxle spacing from the trailer's last axle to the booster is 4.2 m, and spacing of 4.2 m or greater allows up to the maximum permittable booster weight of 23,000 kg.

	Scenario Outline: determine maximum permittable tandem booster weight from trailer-to-booster spacing
		Given a tandem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the tandem booster maximum weight result is <result>

		Examples:
			| description                    | spacing | result                                      |
			| spacing at minimum             | 4.2     | maximum permittable weight is 23000 kg      |
			| spacing above minimum          | 5.0     | maximum permittable weight is 23000 kg      |
			| spacing below minimum          | 4.19    | 23000 kg maximum is not available           |

	Scenario Outline: determine maximum permittable tandem booster weight for spacing below minimum
		Given a tandem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the tandem booster maximum weight result is <result>

		Examples:
			| description                    | spacing | result                                      |
			| spacing below minimum          | 4.19    | 23000 kg maximum is not available           |
 
@orv2-6030-4
Rule: For a tridem booster attached to the rear of a semi-trailer, the minimum interaxle spacing from the trailer's last axle to the booster is 4.2 m, and spacing of 4.2 m or greater allows up to the maximum permittable booster weight of 28,000 kg.

	Scenario Outline: determine maximum permittable tridem booster weight from trailer-to-booster spacing
		Given a tridem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the tridem booster maximum weight result is <result>

		Examples:
			| description                    | spacing | result                                      |
			| spacing at minimum             | 4.2     | maximum permittable weight is 28000 kg      |
			| spacing above minimum          | 5.0     | maximum permittable weight is 28000 kg      |
			| spacing below minimum          | 4.19    | 28000 kg maximum is not available           |

@orv2-6030-5
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

@orv2-6030-6
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
Tandem and Tridem Jeeps: To operate under permit, tandem and tridem jeeps require a minimum of 4.2 m of interaxle spacing to the adjacent trailer axle group.

Allowable trailer to booster: A non-articulating booster attached to the rear of a lowbed has a 4.2 m spacing threshold from the trailer's last axle, and spacing below 3.0 m is also allowed as an exception for a single-axle booster.

The 7.0 m Spacing Rule: For both standard and wide wheelers, the interaxle spacing between the last drive or jeep axle in the front half of the vehicle and the first trailer or dolly axle in the back half must be at least 7.0 m.

Platform Trailers: These multi-axle configurations rely on specific spacing thresholds. Single axle groups must be a minimum of 1.5 m apart. Tandem and tridem axle groups require a minimum of 4.2 m, and a 7.0 m threshold also applies.

 # Deprecated

