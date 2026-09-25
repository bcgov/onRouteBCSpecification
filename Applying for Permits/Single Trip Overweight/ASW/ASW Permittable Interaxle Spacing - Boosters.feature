@orv2-6030 https://moti-imb.atlassian.net/browse/ORV2-6030
Feature: As a user I need the system to validate interaxle spacing exceptions for boosters so that STOW applications comply with policy spacing exceptions.

User = PC, SA, TRAIN, CTPO, CA, PA

# Notes
 Under British Columbia regulations, interaxle spacing — defined as the longitudinal distance separating two axle units measured from the centers of the closest axles—is strictly controlled to protect highway infrastructure and distribute weights safely.

# Inter-axle Spacing
 Diagrams: 
  Single to Tandem: X---XO
  Tandem to Tandem: OX---XO
  Tandem to Tridem: OX---XOO
  Tridem to Tridem: OOX---XOO

# Overweight Dimension set

@orv2-6030-1 
Rule: A single-axle booster attached to the rear of a semi-trailer with spacing of 4.2 m or greater allows up to the axle unit permittable maximum of 11,000 kg, 7.17 or 7.16g axle group result or bridge formula result if applicable.

 See the overweight dimension set for specific interaxle spacing requirements filter on:
 | Trailer Type       | Trailer Axle Unit Type |
 | ------------------ | --------------------   |
 | Boosters           | Single                 |

  Scenario: axle unit wins
   Given a single-axle booster is attached to the rear of a semi-trailer
     And the interaxle spacing is 4.2 m or greater
     And the axle unit actual weight is 11,000 kg
     And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
     And the bridge formula result is higher allowable axle group weight
    Then the overload is the legal maximum amount (9100 kg) - the axle unit actual weight (11,000 kg)

  Scenario: axle group wins
   Given a single-axle booster is attached to the rear of a semi-trailer
     And the interaxle spacing is 4.2 m or greater
     And the calculated 7.17 or 7.16g axle group weight results in a lower legal allowable
     And the bridge formula result is higher allowable axle group weight
    Then the overload is the the axle group actual weight - calculated legal allowable axle group (7.17 or 7.16g)

  Scenario: bridge formula wins
   Given a single-axle booster is attached to the rear of a semi-trailer
     And the interaxle spacing is 4.2 m or greater
     And the bridge formula result is lower allowable axle group weight
    Then the overload is the axle group actual weight - the bridge formula result

@orv2-6030-2
Rule: A single-axle booster attached to the rear of a semi-trailer with spacing between 3.0 m and less than 4.2 m allows only up to the axle unit legal maximum of 9,100 kg, 7.17 or 7.16g axle group result or bridge formula result if applicable.

 See the overweight dimension set for specific interaxle spacing requirements filter on:
 | Trailer Type       | Trailer Axle Unit Type |
 | ------------------ | --------------------   |
 | Boosters           | Single                 |

  Scenario: axle unit wins
   Given a single-axle booster is attached to the rear of a semi-trailer
     And the interaxle spacing is between 3.0 m and less than 4.19 m
     And the axle unit actual weight is 9,101 kg
     And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
     And the bridge formula result is higher allowable axle group weight
    Then the user sees the violation: "Interaxle Spacing for Axle Group (Axle Unit X - Axle Unit Y) restricts Axle Group Weight to 9100 kg"

  Scenario: axle unit wins at legal maximum
    Given a single-axle booster is attached to the rear of a semi-trailer
      And the interaxle spacing is between 3.0 m and less than 4.19 m
      And the axle unit actual weight is 9,100 kg
      And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
      And the bridge formula result is higher allowable axle group weight
     Then then there is no overload or violation

  Scenario: axle group wins
    Given a single-axle booster is attached to the rear of a semi-trailer
      And the interaxle spacing is between 3.0 m and less than 4.19 m
      And the axle unit actual weight is 9,100 kg
      And the calculated axle group weight (7.17 or 7.16g) results in a lower legal allowable
      And the bridge formula result is higher allowable axle group weight
     Then the overload is the axle group actual weight - calculated legal allowable axle group (7.17 or 7.16g)

@orv2-6030-3
Rule: A single-axle booster attached to the rear of a semi-trailer with spacing below 3.0 m allows only up to the axle unit legal maximum of 9,100 kg, 7.17 or 7.16g axle group result, bridge formula result is not applicable.

 See the overweight dimension set for specific interaxle spacing requirements filter on:
 | Trailer Type       | Trailer Axle Unit Type |
 | ------------------ | --------------------   |
 | Boosters           | Single                 |

  Scenario: axle unit greater than allowable maximum
    Given a single-axle booster is attached to the rear of a semi-trailer
      And the interaxle spacing is less than 3.0 m
      And the axle unit actual weight is 9,101 kg
      And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
      And the bridge formula result is higher allowable axle group weight
     Then the user sees the violation: "Interaxle Spacing for Axle Group (Axle Unit X - Axle Unit Y) restricts Axle Group Weight to 9100 kg"

  Scenario: axle unit at allowable maximum
    Given a single-axle booster is attached to the rear of a semi-trailer
      And the interaxle spacing is less than 3.0 m
      And the axle unit actual weight is 9,100 kg
      And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
      And the bridge formula result is higher allowable axle group weight
     Then there is no overload or violation

  Scenario: axle group greater than axle unit maximum
    Given a single-axle booster is attached to the rear of a semi-trailer
      And the interaxle spacing is less than 3.0 m
      And the axle unit actual weight is 9,100 kg
      And the calculated axle group weight (7.17 or 7.16g) results in a higher legal allowable
      And the bridge formula result is higher allowable axle group weight
     Then the user sees the violation: "Interaxle Spacing for Axle Group (Axle Unit X - Axle Unit Y) restricts Axle Group Weight to 9100 kg"

@orv2-6030-4
Rule: For a tandem booster attached to the rear of a semi-trailer, the minimum interaxle spacing from the trailer's last axle to the booster is 4.2 m, and spacing of 4.2 m or greater allows up to the maximum permittable booster weight of 23,000 kg.

 See the overweight dimension set for specific interaxle spacing requirements filter on:
 | Trailer Type       | Trailer Axle Unit Type |
 | ------------------ | --------------------   |
 | Boosters           | Tandem                 |

	Scenario Outline: determine maximum permittable tandem booster weight from trailer-to-booster spacing
		Given a tandem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the tandem booster maximum weight result is <result>

		Examples:
			| description                    | spacing | result                                      |
			| spacing at minimum             | 4.2     | maximum permittable weight is 23000 kg      |
			| spacing above minimum          | 5.0     | maximum permittable weight is 23000 kg      |
			| spacing below minimum          | 4.19    | 23000 kg maximum is not available           |

	Scenario: tandem booster weight for spacing below minimum
		Given a tandem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of 4.19 m from the trailer's last axle to the booster
    And an axle unit weight of 23,000 kg
		 Then the user sees the violation: "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 4.2 m."
    And interaxle spacing is indicated 
 
@orv2-6030-5
Rule: For a tridem booster attached to the rear of a semi-trailer, the minimum interaxle spacing from the trailer's last axle to the booster is 4.2 m, and spacing of 4.2 m or greater allows up to the maximum permittable booster weight of 28,000 kg.

 See the overweight dimension set for specific interaxle spacing requirements filter on:
 | Trailer Type       | Trailer Axle Unit Type |
 | ------------------ | --------------------   |
 | Boosters           | Tridem                 |
 
	Scenario Outline: determine maximum permittable tridem booster weight from trailer-to-booster spacing
		Given a tridem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of <spacing> m from the trailer's last axle to the booster
		 Then the tridem booster maximum weight result is <result>

		Examples:
			| description                    | spacing | result                                      |
			| spacing at minimum             | 4.2     | maximum permittable weight is 28000 kg      |
			| spacing above minimum          | 5.0     | maximum permittable weight is 28000 kg      |
			| spacing below minimum          | 4.19    | 28000 kg maximum is not available           |

 Scenario: tridem booster weight for spacing below minimum
		Given a tridem booster is attached to the rear of a semi-trailer
		 When a user inputs interaxle spacing of 4.19 m from the trailer's last axle to the booster
    And an axle unit weight of 28,000 kg
		 Then the user sees the violation: "Interaxle Spacing between Axle Unit <axleUnitX> and Axle Unit <axleUnitY> must be at least 4.2 m."
    And interaxle spacing is indicated 

# Exception Notes
Allowable trailer to booster: A non-articulating booster attached to the rear of a lowbed has a 4.2 m spacing threshold from the trailer's last axle, and spacing below 3.0 m is also allowed as an exception for a single-axle booster.


