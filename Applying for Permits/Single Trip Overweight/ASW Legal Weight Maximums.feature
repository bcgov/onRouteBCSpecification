 
@orv2-5706 https://moti-imb.atlassian.net/browse/ORV2-5706
Feature: As a user I need the system to validate that the axle unit weights are within the legal limits for the selected vehicle type and configuration so that I can submit a valid STOW permit application.

User = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 3: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

# Overview:
 Establishing the legal allowable weight for a commercial vehicle is governed by the "Lesser Of" principle, which dictates that the weight limit is always the lowest value among multiple regulatory criteria. These allowances are determined by evaluating individual axle unit maximums, axle group-weight limits for spans under 8 metres, and configuration-specific standards found in the regulatory appendices.

See: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881EFCEC-9462-46D8-A908-1E7DF42F113A%7D&file=Over%20Weight%20Dimension%20Set.xlsx&action=default&mobileredirect=true
 
 1. The "Lesser Of" Calculation Logic
 To establish the legal allowable weight (the threshold before a vehicle is considered "overloaded"), the Ministry compares the following values for every axle unit and group:
 Actual Weight: The actual weight of the unit (axle unit, axle group or GCVW).
 Legal (regulatory) Unit Maximums: Fixed caps based on the type of axle unit (e.g., 17,000 kg for a tandem).
 Axle Group Table (CTR 7.17): A distance-based limit for any group of axles spanning 8 metres or less. See: Applying for Permits/Single Trip Overweight/ASW <=8m Axle Group Maximum Legal Weight Thresholds.feature
 Sub-summing Logic: If one unit in a group is underloaded and another is overloaded, the allowable total for that 8 m group is the sum of the actual weight of the underloaded unit and the legal maximum of the overloaded unit.
 
 2. Individual Axle Unit Maximums
 Legal weight limits are first established by the physical configuration of the axle unit:
 Single Axle: 9,100 kg (standard for axles with 4 tires).
 Tandem Axle: 17,000 kg (two or more axles spaced between 1.0 m and 1.85 m).
 Tridem Axle: Generally 24,000 kg, but specific variations exist:
 Liquid Loads: Restricted to 23,000 kg unless specific stability criteria are met. (ignored in onRouteBC)
 Logging Loads: Permitted up to 25,500 kg under specific seasonal and configuration rules. (ignored in onRouteBC)
 
 3. Steering Axle Weight Allowances
 Steering axle limits are established based on the vehicle type and the presence of Permanently Mounted Equipment (PME):
 Standard Truck Tractor: 6,000 kg.
 Truck or Vehicle with PME: 9,100 kg.
 With tridem Drive Power Units: 7,300 kg (without PME) or 9,100 kg (with PME).
 Stability Ratios: For heavy rear groups, the steer axle must maintain a percentage of the drive weight to ensure control (e.g., at least 27% of a tridem drive’s weight at all times). See: Applying for Permits/Single Trip Overweight/ASW Steer Axle Min 27% of Drive Axle.feature

@orv2-5706-1
Rule: Steering axle unit weight maximums are determined by steer axle type, drive axle type, power unit vehicle type, and PME status.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME

    Scenario Outline: steering axle legal maximum is determined from configuration inputs
        Given the steer axle type is <steerAxleType>
            And the drive axle type is <driveAxleType>
            And the power unit vehicle type is <powerUnitType>
            And PME status is <pmeStatus>
         When the system determines the steering axle legal maximum
         Then the steering axle legal maximum is <steerAxleLegalMax> kg

        Examples:
            | steerAxleType | driveAxleType | powerUnitType | pmeStatus | steerAxleLegalMax |
            | single        | tandem        | truck         | no PME    | 9100              |
            | single        | tandem        | truck tractor | no PME    | 6000              |
            | single        | tridem        | truck         | with PME  | 9100              |
            | tandem        | tandem        | truck tractor | no PME    | 17000             |
            | tandem        | tridem        | truck tractor | with PME  | 15200             |

@orv2-5706-2
Rule: For single steer axle with single or tandem drive axle, the steering axle unit maximum is 9,100 kg for truck, 6,000 kg for truck tractor, and 9,100 kg when PME is present.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME

    Scenario Outline: single steer with single or tandem drive axle legal maximum validation
        Given the vehicle has a single steer axle and a <driveAxleType> drive axle
            And the power unit vehicle type is <powerUnitType>
            And PME status is <pmeStatus>
            And the steering axle weight is <steerAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | driveAxleType | powerUnitType | pmeStatus | steerAxleWeight | expectedResult                                          |
            | single        | truck         | no PME    | 9100            | the steering axle weight is at or under legal threshold |
            | tandem        | truck tractor | no PME    | 6001            | the steering axle weight is above legal threshold       |
            | tandem        | truck tractor | with PME  | 9100            | the steering axle weight is at or under legal threshold |

@orv2-5706-3
Rule: For single steer axle with tridem drive axle, the steering axle unit maximum is 7,300 kg without PME and 9,100 kg with PME.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME

    Scenario Outline: single steer with tridem drive axle legal maximum validation
        Given the vehicle has a single steer axle and a tridem drive axle
            And PME status is <pmeStatus>
            And the steering axle weight is <steerAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | pmeStatus | steerAxleWeight | expectedResult                                          |
            | no PME    | 7300            | the steering axle weight is at or under legal threshold |
            | no PME    | 7301            | the steering axle weight is above legal threshold       |
            | with PME  | 9100            | the steering axle weight is at or under legal threshold |

@orv2-5706-4
Rule: For tandem steer axle with tandem drive axle, the steering axle unit maximum is 17,000 kg with or without PME.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME

    Scenario Outline: tandem steer with tandem drive axle legal maximum validation
        Given the vehicle has a tandem steer axle and a tandem drive axle
            And PME status is <pmeStatus>
            And the tandem steer axle weight is <steerAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | pmeStatus | steerAxleWeight | expectedResult                                          |
            | no PME    | 17000           | the steering axle weight is at or under legal threshold |
            | with PME  | 17001           | the steering axle weight is above legal threshold       |

@orv2-5706-5
Rule: For tandem steer axle with tridem drive axle, the steering axle unit maximum is 13,600 kg without PME and 15,200 kg with PME.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME

    Scenario Outline: tandem steer with tridem drive axle legal maximum validation
        Given the vehicle has a tandem steer axle and a tridem drive axle
            And PME status is <pmeStatus>
            And the tandem steer axle weight is <steerAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | pmeStatus | steerAxleWeight | expectedResult                                          |
            | no PME    | 13600           | the steering axle weight is at or under legal threshold |
            | no PME    | 13601           | the steering axle weight is above legal threshold       |
            | with PME  | 15200           | the steering axle weight is at or under legal threshold |

@orv2-5706-6
Rule: For single or tandem steer axle with tridem drive axle, minimum steering-to-drive weight ratio checks are evaluated in dedicated features and do not change the steering axle legal maximum defined by this feature. See: Applying for Permits/Single Trip Overweight/ASW Steer Axle Min 27% of Drive Axle.feature and Applying for Permits/Single Trip Overweight/ASW Tandem Steer Axle Min 40% of Drive Axle.feature

@orv2-5706-7
Rule: Drive axle unit weight maximums apply with or without PME and are determined by drive axle type and load condition.

 # Note: PME status is determined by the vehicle sub-type chosen e.g., truck with PME, truck tractor with PME
 
    Scenario Outline: drive axle legal maximum is determined from configuration inputs
        Given the drive axle type is <driveAxleType>
            And the load condition is <loadCondition>
            And the power unit vehicle type is <powerUnitType>
            And PME status is <pmeStatus>
         When the system determines the drive axle legal maximum
         Then the drive axle legal maximum is <driveAxleLegalMax> kg

        Examples:
            | driveAxleType | loadCondition | powerUnitType | pmeStatus | driveAxleLegalMax |
            | single        | fixed load    | truck         | no PME    | 9100              |
            | tandem        | fixed load    | truck tractor | with PME  | 17000             |
            | tridem        | fixed load    | truck         | no PME    | 24000             |
            | tridem        | fixed load    | truck tractor | no PME    | 24000             |

@orv2-5706-8
Rule: For single drive axle, the drive axle unit maximum is 9,100 kg.

    Scenario Outline: single drive axle legal maximum validation
        Given the vehicle has a single drive axle
            And the drive axle weight is <driveAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | driveAxleWeight | expectedResult                                       |
            | 9100            | the drive axle weight is at or under legal threshold |
            | 9101            | the drive axle weight is above legal threshold       |

@orv2-5706-9
Rule: For tandem drive axle, the drive axle unit maximum is 17,000 kg.

    Scenario Outline: tandem drive axle legal maximum validation
        Given the vehicle has a tandem drive axle
            And the drive axle weight is <driveAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | driveAxleWeight | expectedResult                                       |
            | 17000           | the drive axle weight is at or under legal threshold |
            | 17001           | the drive axle weight is above legal threshold       |

@orv2-5706-10
Rule: For tridem drive axle with fixed load, the drive axle unit maximum is 24,000 kg.

    Scenario Outline: tridem drive axle fixed-load legal maximum validation
        Given the vehicle has a tridem drive axle
            And the load condition is fixed load
            And the drive axle weight is <driveAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | driveAxleWeight | expectedResult                                       |
            | 24000           | the drive axle weight is at or under legal threshold |
            | 24001           | the drive axle weight is above legal threshold       |

@orv2-5706-11
Rule: For tridem drive axle on truck tractor configurations, the drive axle unit maximum is 24,000 kg.

    Scenario Outline: tridem drive axle truck tractor legal maximum validation
        Given the vehicle has a tridem drive axle
            And the power unit vehicle type is truck tractor
            And the drive axle weight is <driveAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | driveAxleWeight | expectedResult                                       |
            | 24000           | the drive axle weight is at or under legal threshold |
            | 24001           | the drive axle weight is above legal threshold       |

@orv2-5706-12
Rule: Drive axle unit weight must be greater than 20% of GCVW. See: Applying for Permits/Single Trip Overweight/ASW Drive Axle Min 20% of GCVW.feature

# Deprecated:
 Rule: Steering axle unit weight is exempt from seasonal axle weight restrictions.

# Notes:
 - Confirm:
  Rule: For tridem drive axle with liquid load, the drive axle unit maximum is 23,000 kg.
  Rule: For tridem drive axle with liquid load and tank centre height less than or equal to 2.4 m, the drive axle unit maximum is 24,000 kg.
  Rule: For tridem drive axle carrying log loads only, the drive axle unit maximum is 25,500 kg.
  Rule: The 25,500 kg tridem drive value includes the maximum tridem axle weight and maximum additional allowances for transportation of logs and poles. See CTR s. 7.26.
  Rule: For truck tractor with installed crane only (single or tandem steer axle with tandem drive axle), total axle weight is subject to CTR s. 7.17 Table limits, tractor tare weight must be greater than 14,000 kg, and crane centre of gravity must be forward of the truck rear suspension centre.

 # Violation Statements:
 - A You may require a different permit type Refer to the Commercial Transport Procedures Manual, or contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca