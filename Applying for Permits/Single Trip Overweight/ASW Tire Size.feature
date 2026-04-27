@orv2-5472 https://moti-imb.atlassian.net/browse/ORV2-5472
Feature: As a user I need the system to validate that the tire sizes I have selected are compliant with the policy and regulations for single trip overweight permits, so that I can ensure my permit application is compliant.

User = PC, SA, TRAIN, CTPO, CA, PA
Staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 7: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

# Overview:
Tire load capacity is determined by vehicle type with Crane - All Terrain, Mobile Crane, Rubber Tired Loaders) having unique exceptions, axle type (Steer, Drive), and tire size, with a base rate of 100 kg/cm for most vehicles and 110 kg/cm specifically for Rubber Tired Loaders, and maximum limits that vary by configuration

@orv2-5472
Rule: Steer axle units for all vehicles except Crane - All Terrain, Mobile Crane, Rubber Tired Loaders must have a tire load rate of 100 kg/cm

  Scenario Outline: Steer axle tire load rate is within the 100 kg/cm limit
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a steer axle unit with <numberOfTires> tires of <tireWidth> mm
    And the steer axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the steer axle unit

    Examples:
      | description                                 | tireWidth | numberOfTires | axleWeight | calculation              |
      | Boundary pass at exactly 100 kg/cm - 315 mm | 315       | 2             | 6300       | 31.5 x 100 x 2 = 6,300   |
      | Pass below 100 kg/cm threshold - 315 mm     | 315       | 2             | 6000       | 31.5 x 100 x 2 = 6,300   |
      | Boundary pass at exactly 100 kg/cm - 385 mm | 385       | 2             | 7700       | 38.5 x 100 x 2 = 7,700   |
      | Boundary pass at exactly 100 kg/cm - 445 mm | 445       | 2             | 8900       | 44.5 x 100 x 2 = 8,900   |

  Scenario Outline: Steer axle tire load rate exceeds the 100 kg/cm limit
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a steer axle unit with <numberOfTires> tires of <tireWidth> mm
    And the steer axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                      | tireWidth | numberOfTires | axleWeight | calculation            |
      | Fail just above 100 kg/cm boundary - 315 mm      | 315       | 2             | 6301       | 31.5 x 100 x 2 = 6,300 |
      | Fail just above 100 kg/cm boundary - 385 mm      | 385       | 2             | 7701       | 38.5 x 100 x 2 = 7,700 |
      | Fail just above 100 kg/cm boundary - 445 mm      | 445       | 2             | 8901       | 44.5 x 100 x 2 = 8,900 |

@orv2-5472
Rule: Non-steering axle units for all vehicles except Crane - All Terrain, Mobile Crane, Rubber Tired Loaders must have a tire load rate of 100 kg/cm to a maximum of either 4,550 kg/tire for tires ≥445 or 3000 kg/tire for tires ≤444

  Scenario Outline: Non-steering axle tire load rate is within limit for tires ≥445 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the non-steering axle unit

    Examples:
      | description                          | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at rate limit - 445 mm | 445       | 4             | 17800      | 44.5 x 100 = 4,450/tire x 4 = 17,800 |
      | Boundary pass at cap limit - 457 mm  | 457       | 4             | 18200      | cap 4,550/tire x 4 = 18,200          |
      | Pass below limit - 445 mm            | 445       | 4             | 17000      | 44.5 x 100 = 4,450/tire x 4 = 17,800 |

  Scenario Outline: Non-steering axle tire load rate exceeds limit for tires ≥445 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                         | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above rate limit - 445 mm | 445       | 4             | 17801      | 44.5 x 100 = 4,450/tire x 4 = 17,800 |
      | Fail just above cap limit - 457 mm  | 457       | 4             | 18201      | cap 4,550/tire x 4 = 18,200          |

  Scenario Outline: Non-steering axle tire load rate is within limit for tires ≤444 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the non-steering axle unit

    Examples:
      | description                         | tireWidth | numberOfTires | axleWeight | calculation                 |
      | Boundary pass at cap limit - 385 mm | 385       | 4             | 12000      | cap 3,000/tire x 4 = 12,000 |
      | Boundary pass at cap limit - 431 mm | 431       | 4             | 12000      | cap 3,000/tire x 4 = 12,000 |
      | Pass below limit - 385 mm           | 385       | 4             | 11000      | cap 3,000/tire x 4 = 12,000 |

  Scenario Outline: Non-steering axle tire load rate exceeds limit for tires ≤444 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                        | tireWidth | numberOfTires | axleWeight | calculation                 |
      | Fail just above cap limit - 385 mm | 385       | 4             | 12001      | cap 3,000/tire x 4 = 12,000 |
      | Fail just above cap limit - 431 mm | 431       | 4             | 12001      | cap 3,000/tire x 4 = 12,000 |

@orv2-5472
Rule: Single steering axle units for all vehicles except Crane - All Terrain, Mobile Crane, Rubber Tired Loaders must have a tire load rate of 100 kg/cm to a maximum of 9,100 kg/axle for tires ≥445

  Scenario Outline: Single steering axle tire load rate is within the 9,100 kg/axle limit for tires ≥445 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a single steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the single steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the single steering axle unit

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at cap limit - 445 mm          | 445       | 2             | 9100       | cap 9,100 kg/axle                    |
      | Boundary pass at rate limit - 457 mm         | 457       | 2             | 9100       | cap 9,100 kg/axle                    |
      | Pass below limit - 508 mm                    | 508       | 2             | 9000       | cap 9,100 kg/axle                    |

  Scenario Outline: Single steering axle tire load rate exceeds the 9,100 kg/axle limit for tires ≥445 mm
    Given the vehicle is not a Crane - All Terrain, Mobile Crane, or Rubber Tired Loader
    And the vehicle has a single steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the single steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above cap limit - 445 mm           | 445       | 2             | 9101       | cap 9,100 kg/axle                    |
      | Fail just above cap limit - 457 mm           | 457       | 2             | 9101       | cap 9,100 kg/axle                    |
      | Fail just above cap limit - 508 mm           | 508       | 2             | 9101       | cap 9,100 kg/axle                    |

@orv2-5472
Rule: All axle units for Crane - All Terrain must have a tire load rate of 100 kg/cm to a maximum of 11,000 kg/axle for tires ≥520 

  Scenario Outline: Crane - All Terrain axle tire load rate is within the 11,000 kg/axle limit for tires ≥520 mm
    Given the vehicle is a Crane - All Terrain
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the axle unit

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at cap limit - 520 mm          | 520       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Boundary pass at cap limit - 550 mm          | 550       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Pass below limit - 609 mm                    | 609       | 2             | 10000      | cap 11,000 kg/axle                   |

  Scenario Outline: Crane - All Terrain axle tire load rate exceeds the 11,000 kg/axle limit for tires ≥520 mm
    Given the vehicle is a Crane - All Terrain
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above cap limit - 520 mm           | 520       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 550 mm           | 550       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 609 mm           | 609       | 2             | 11001      | cap 11,000 kg/axle                   |

@orv2-5472
Rule: Non-steering axle units for Mobile Crane must have a tire load rate of 100 kg/cm to a maximum of 11,000 kg/axle for tires ≥520

  Scenario Outline: Mobile Crane non-steering axle tire load rate is within the 11,000 kg/axle limit for tires ≥520 mm
    Given the vehicle is a Mobile Crane
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the non-steering axle unit

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at cap limit - 520 mm          | 520       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Boundary pass at cap limit - 550 mm          | 550       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Pass below limit - 609 mm                    | 609       | 2             | 10000      | cap 11,000 kg/axle                   |

  Scenario Outline: Mobile Crane non-steering axle tire load rate exceeds the 11,000 kg/axle limit for tires ≥520 mm
    Given the vehicle is a Mobile Crane
    And the vehicle has a non-steering axle unit with <numberOfTires> tires of <tireWidth> mm
    And the non-steering axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above cap limit - 520 mm           | 520       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 550 mm           | 550       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 609 mm           | 609       | 2             | 11001      | cap 11,000 kg/axle                   |

@orv2-5472
Rule: All axle units for Rubber Tired Loaders must have a tire load rate of 110 kg/cm to a maximum of either 11,000 kg/axle for tires ≥520 or 12,000 kg/axle for tires ≥600 

  Scenario Outline: Rubber Tired Loader axle tire load rate is within the 11,000 kg/axle limit for tires ≥520 mm and <600 mm
    Given the vehicle is a Rubber Tired Loader
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the axle unit

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at cap limit - 520 mm          | 520       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Boundary pass at cap limit - 550 mm          | 550       | 2             | 11000      | cap 11,000 kg/axle                   |
      | Pass below limit - 525 mm                    | 525       | 2             | 10000      | cap 11,000 kg/axle                   |

  Scenario Outline: Rubber Tired Loader axle tire load rate exceeds the 11,000 kg/axle limit for tires ≥520 mm and <600 mm
    Given the vehicle is a Rubber Tired Loader
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above cap limit - 520 mm           | 520       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 550 mm           | 550       | 2             | 11001      | cap 11,000 kg/axle                   |
      | Fail just above cap limit - 525 mm           | 525       | 2             | 11001      | cap 11,000 kg/axle                   |

  Scenario Outline: Rubber Tired Loader axle tire load rate is within the 12,000 kg/axle limit for tires ≥600 mm
    Given the vehicle is a Rubber Tired Loader
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they do not see a tire load rate error for the axle unit

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Boundary pass at cap limit - 609 mm          | 609       | 2             | 12000      | cap 12,000 kg/axle                   |
      | Boundary pass at cap limit - 622 mm          | 622       | 2             | 12000      | cap 12,000 kg/axle                   |
      | Pass below limit - 711.2 mm                  | 711.2     | 2             | 11000      | cap 12,000 kg/axle                   |

  Scenario Outline: Rubber Tired Loader axle tire load rate exceeds the 12,000 kg/axle limit for tires ≥600 mm
    Given the vehicle is a Rubber Tired Loader
    And the vehicle has an axle unit with <numberOfTires> tires of <tireWidth> mm
    And the axle weight is <axleWeight> kg
    When the user calculates the ASW table or chooses to continue with the permit application
    Then they see "Tire Size for Axle Unit X exceeds its load capacity."

    Examples:
      | description                                  | tireWidth | numberOfTires | axleWeight | calculation                          |
      | Fail just above cap limit - 609 mm           | 609       | 2             | 12001      | cap 12,000 kg/axle                   |
      | Fail just above cap limit - 622 mm           | 622       | 2             | 12001      | cap 12,000 kg/axle                   |
      | Fail just above cap limit - 711.2 mm         | 711.2     | 2             | 12001      | cap 12,000 kg/axle                   |

# Notes: 
1. Steer axle units all vehicles except special vehicle:
	1. Tire load rate is 100 kg/cm
2. Non steering axle units all vehicles except special vehicle:
	1. For tires ≥445 tire load rate = 100 kg/cm to a Maximum = 4,550 kg / tire  
	2. For tires ≤444 tire load rate = 100 kg/cm to a Maximum = 3000 kg / tire  
3. Single steering axle units all vehicles:
	1. For tires ≥445mm tire load rate = 100 kg/cm to a Maximum = 9,100 kg / axle
4. All axle units for special vehicle: Crane - All Terrain:
	1. For tires ≥520mm tire load rate = 100 kg/cm to a Maximum = 11,000 kg / axle
5. Non-steering axle units for special vehicle: Mobile Crane:
	1. For tires ≥520mm tire load rate = 100 kg/cm to a Maximum = 11,000 kg / axle
6. All axle units for special vehicle: Rubber Tired Loaders
	1. For tires ≥520mm tire load rate = 110 kg/cm to a Maximum = 11,000 kg / axle
	2. For tires ≥600mm tire load rate = 110 kg/cm to a Maximum = 12,000 kg / axle

	When maximums are exceeded show: Tire Size for Axle Unit X exceeds its load capacity.

# Tire Load Validation Logic:
IF vehicle is Rubber Tired Loader THEN
  IF tireWidth ≥ 600 mm THEN
    rate = 110 kg/cm
    maxLoad = 12,000 kg/axle
  ELSE IF tireWidth ≥ 520 mm THEN
    rate = 110 kg/cm
    maxLoad = 11,000 kg/axle
  END IF
  IF axleWeight > maxLoad THEN
    SHOW "Tire Size for Axle Unit X exceeds its load capacity."
  END IF
ELSE IF vehicle is Crane - All Terrain THEN
  IF tireWidth ≥ 520 mm THEN
    rate = 100 kg/cm
    maxLoad = 11,000 kg/axle
    IF axleWeight > maxLoad THEN
      SHOW "Tire Size for Axle Unit X exceeds its load capacity."
    END IF
  END IF
ELSE IF vehicle is Mobile Crane AND axle is non-steering THEN
  IF tireWidth ≥ 520 mm THEN
    rate = 100 kg/cm
    maxLoad = 11,000 kg/axle
    IF axleWeight > maxLoad THEN
      SHOW "Tire Size for Axle Unit X exceeds its load capacity."
    END IF
  END IF
ELSE
  IF axle is single steering THEN
    IF tireWidth ≥ 445 mm THEN
      rate = 100 kg/cm
      maxLoad = 9,100 kg/axle
      IF axleWeight > maxLoad THEN
        SHOW "Tire Size for Axle Unit X exceeds its load capacity."
      END IF
    END IF
  ELSE IF axle is steer THEN
    rate = 100 kg/cm
    IF (axleWeight / numberOfTires) / (tireWidth / 10) > rate THEN
      SHOW "Tire Size for Axle Unit X exceeds its load capacity."
    END IF
  ELSE
    # non-steering axle
    IF tireWidth ≥ 445 mm THEN
      rate = 100 kg/cm
      maxLoad = 4,550 kg/tire
    ELSE
      rate = 100 kg/cm
      maxLoad = 3,000 kg/tire
    END IF
    IF (axleWeight / numberOfTires) > maxLoad THEN
      SHOW "Tire Size for Axle Unit X exceeds its load capacity."
    END IF
  END IF
END IF

 The available list of tires is:
 254 (10"")
 279.4 (11"")
 304.8 (12"")
 315 (12.4"")
 325 (12.8"")
 330 (13"")
 355 (14"")
 365 (14.4"")
 368 (14.5"")
 381 (15"")
 385 (15.2"")
 393 (15.5"")
 406 (16"")
 425 (16.7"")
 431 (17"")
 445 (17.5"")
 457 (18"")
 502 (19.8"")
 508 (20"")
 520 (20.5"")
 525 (20.7"")
 550 (21.7"")
 609 (24"")
 622 (24.5"")
 636 (25"")
 711.2 (28"")