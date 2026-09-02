 
@orv2-5709 https://moti-imb.atlassian.net/browse/ORV2-5709
Feature: As a user I need the system to validate that the axle unit weights are within the permittable limits for the selected vehicle type and configuration so that I can submit a valid STOW permit application.

User = PC, SA, TRAIN, CTPO, CA, PA

Evaluation logic Eval No. 4: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

# Overview:
To establish the maximum permittable weight for a commercial vehicle, the Ministry uses a "Lesser Of" logic similar to legal weights, but substitutes the distance-based axle group limits (CTR 7.17) with the Bridge Formula and specific Heavy Haul Policy maximums.

See: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B881EFCEC-9462-46D8-A908-1E7DF42F113A%7D&file=Over%20Weight%20Dimension%20Set.xlsx&action=default&mobileredirect=true

The permit maximum is determined by comparing three primary maximums, with the lowest value becoming the binding limit:
1. Axle Unit Policy Maximums
The Ministry establishes fixed "maximums" for individual axle units operating under an overweight permit for non-reducible loads:
Steering Axle: Max 9,100 kg (provided the unit is at legal weights when empty).
Single Axle (other than steer): Max 11,000 kg.
Tandem Axle: Max 23,000 kg.
Tridem Axle: Max 28,000 kg or 29,000 kg, depending on the spread and whether a booster is used.
2. The Bridge Formula
While legal weights for groups under 8 metres use the CTR 7.17 table, permit weights are governed by the Bridge Formula for all axle groups.
The Calculation: Maximum Permittable Weight (kg)=(30×wheelbase in cm)+18,000.
The Wheelbase: In this context, wheelbase means the distance between the centers of the first axle and last axle of any group being measured.
Infrastructure Protection: If the Bridge Formula result for a group is lower than the policy maximum (e.g., it allows only 21,000 kg for a tandem), the Bridge Formula limit prevails. See: Applying for Permits/Single Trip Overweight/ASW Calculate Bridge Formula.feature
3. Manufacturer Ratings
A permit never authorizes a vehicle to exceed its mechanical ratings. The established permit maximum is always restricted by the lowest of:
GAWR (Gross Axle Weight Rating): The manufacturer’s capacity for that specific axle. (not currently implemented in onRouteBC)
Tire Rating: Capped at 100 kg per 1 cm of tire width (or 110 kg/cm for municipal fire trucks). See Applying for Permits/Single Trip Overweight/ASW Tire Size.feature
4. Route-Specific Maximums (not currently implemented in onRouteBC)
The absolute maximum Gross Combination Vehicle Weight (GCVW) established by permit is also determined by the approved overload route:
64,000 kg: The standard maximum for term overweight permits.
72-Tonne Routes: Specific routes in the Peace River Area pre-approved for up to 72,000 kg.
80-Tonne Routes: Designated highways in the Lower Mainland.
85-Tonne Routes: Pre-approved major provincial highways and secondary routes for compliant heavy-haul equipment.
5. Extraordinary Load Review See: Applying for Permits/Single Trip Overweight/Record & Use Overload Number.feature
If a configuration exceeds the Bridge Formula, the standard policy maximums, or the 85,000 kg route maximum, the maximum is not established by a chart but through an Extraordinary Load Approval. This involves a custom Structural Engineering review to determine if specific bridges on a proposed route can safely support the proposed weights.

@orv2-5709-1
Rule: Axle unit policy maximums establish the base permit-weight maximums for non-reducible loads before applying Bridge Formula and other lower limits.

    Scenario Outline: base policy maximum is established before lower-limit comparisons
        Given the load is non-reducible
            And the axle unit type is <axleUnitType>
         When the system determines the base axle unit policy maximum
         Then the base axle unit policy maximum is <policyMaximum> kg

        Examples:
            | axleUnitType        | policyMaximum |
            | steering axle       | 9100          |
            | single non-steering | 11000         |
            | tandem axle         | 23000         |
            | tridem axle         | 28000         |

@orv2-5709-2
Rule: Steering axle unit policy maximum is 9,100 kg, provided the steering axle is at legal weight when the vehicle is empty.

    Scenario Outline: steering axle policy maximum validation
        Given the axle unit type is steering axle
            And the steering axle is at legal weight when empty
            And the steering axle weight is <steerAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | steerAxleWeight | expectedResult                                           |
            | 9100            | the steering axle weight is at or under policy maximum |
            | 9101            | Axle Unit Weight for Axle Unit X must not exceed A.      |

@orv2-5709-3
Rule: Single axle unit policy maximum is 11,000 kg for non-steering single axle units.

    Scenario Outline: single non-steering axle policy maximum validation
        Given the axle unit type is single non-steering axle
            And the single non-steering axle weight is <singleAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | singleAxleWeight | expectedResult                                                      |
            | 11000            | the single non-steering axle weight is at or under policy maximum |
            | 11001            | Axle Unit Weight for Axle Unit X must not exceed A.                 |

@orv2-5709-4
Rule: Tandem axle unit policy maximum is 23,000 kg.

    Scenario Outline: tandem axle policy maximum validation
        Given the axle unit type is tandem axle
          And the tandem axle weight is <tandemAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | tandemAxleWeight | expectedResult                                         |
            | 23000            | the tandem axle weight is at or under policy maximum |
            | 23001            | Axle Unit Weight for Axle Unit X must not exceed A.    |

@orv2-5709-5
Rule: Tridem axle unit policy maximum is 28,000 kg by default.

    Scenario Outline: tridem axle default policy maximum validation
        Given the axle unit type is tridem axle
          And tridem 29,000 kg policy conditions are not satisfied
          And the tridem axle weight is <tridemAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | tridemAxleWeight | expectedResult                                         |
            | 28000            | the tridem axle weight is at or under policy maximum |
            | 28001            | Axle Unit Weight for Axle Unit X must not exceed A.    |

@orv2-5709-6
Rule: Tridem axle unit policy maximum is 29,000 kg only when tridem spread is not less than 2.4 m and not more than 3.7 m, and booster configuration is single-axle booster or no booster; otherwise, if tridem spread is outside 2.4 m to 3.7 m or booster configuration is tandem or tridem booster, the tridem axle unit policy maximum is 28,000 kg.

    Scenario Outline: tridem axle policy maximum by spread and booster configuration
        Given the axle unit type is tridem axle
          And the tridem spread is <tridemSpread> m
          And the booster configuration is <boosterConfiguration>
          And the tridem axle weight is <tridemAxleWeight> kg
         When the user reviews the permit configuration
         Then <expectedResult>

        Examples:
            | tridemSpread | boosterConfiguration | tridemAxleWeight | expectedResult                                       |
            | 2.4          | no booster           | 29000            | the tridem axle weight is at or under policy maximum |
            | 3.7          | single-axle booster  | 29000            | the tridem axle weight is at or under policy maximum |
            | 3.7          | single-axle booster  | 29001            | Axle Unit Weight for Axle Unit X must not exceed A.  |
            | 2.3          | no booster           | 29000            | Axle Unit Weight for Axle Unit X must not exceed A.  |
            | 3.8          | no booster           | 29000            | Axle Unit Weight for Axle Unit X must not exceed A.  |
            | 2.8          | tandem booster       | 28000            | the tridem axle weight is at or under policy maximum |
            | 2.8          | tandem booster       | 29000            | Axle Unit Weight for Axle Unit X must not exceed A.  |
            | 2.8          | tridem booster       | 29000            | Axle Unit Weight for Axle Unit X must not exceed A.  |

@orv2-5709-7
Rule: If a lower maximum is produced by Bridge Formula, tire load rating, or other applicable evaluations, the lower value becomes the permit maximum.

    Scenario Outline: lower limit becomes binding permit maximum
        Given the axle unit policy maximum is <policyMaximum> kg
          And the Bridge Formula maximum is <bridgeFormulaMax> kg
          And the tire-load maximum is <tireLoadMax> kg
          And the other applicable maximum is <otherMax> kg
         When the system determines the binding permit maximum
         Then the binding permit maximum is <permitMax> kg

        Examples:
            | policyMaximum | bridgeFormulaMax | tireLoadMax | otherMax | permitMax |
            | 23000         | 21000            | 23000       | 23000    | 21000      |
            | 23000         | 23000            | 20500       | 23000    | 20500      |
            | 23000         | 23000            | 23000       | 22000    | 22000      |

# Notes:
 - Confirm:
  - Rule: Steering axle unit policy maximum is 9,100 kg, provided the steering axle is at legal weight when the vehicle is empty.

  # Violation Statements:
   - Axle Unit Weight for Axle Unit X must not exceed A.

 The Ministry distinguishes between the steering axle and "other" axle units when establishing permit maximums to ensure vehicle stability and infrastructure protection:,
 1. Single Axle (Other than Steer): 11,000 kg
 This limit is explicitly defined in the regulatory tables as applying to a single axle other than a steering axle.
 It includes single axles found on jeeps and boosters.,
 Steering Axle Contrast: By comparison, a single steering axle has a lower permit maximum of 9,100 kg.,
 2. Tandem Axle: 23,000 kg
 This permit maximum applies to tandem axle groups on semi-trailers, jeeps, and boosters.,
 It is categorized under "Other Axles – Semi-Trailers" and is distinct from the tandem drive unit of the power unit, though tandem drive units can also be permitted to this weight if they carry more than 20% of the GCVW.,
 3. Tridem Axle: 28,000 kg or 29,000 kg
 The variation in this limit depends on the specific non-steer configuration and the presence of a booster:,
 28,000 kg: This is the maximum for a tridem group on a trailer when it is paired with a tandem or tridem booster., It is also the maximum for a tridem jeep or a tridem drive unit.,
 29,000 kg: This higher maximum is allowed for a tridem group on a lowbed semi-trailer when used with a single booster or no booster at all.

 A single drive axle unit is governed by specific weight caps, wheelbase standards, and a significant restriction on the total weight of the combination it can pull.
 1. Weight Maximums
 The weight allowances for a single drive axle distinguish between standard operation and specialized overweight permits:
 Legal Maximum: The maximum legal allowable weight is 9,100 kg.
 Permit Maximum: When operating under an overweight permit for non-reducible loads, the maximum is increased to 11,000 kg.
 2. The 38,000 kg GCVW Cap
 A critical regulatory "hard stop" for single drive axle units is the maximum weight of the entire vehicle combination (GCVW):
 Combination Limit: A single drive axle power unit is strictly prohibited from operating in a combination of vehicles with a gross vehicle weight exceeding 38,000 kg.
 Requirement for More Axles: For any combination heavier than 38,000 kg, the towing vehicle must be equipped with either a tandem or tridem drive axle group.
 3. Wheelbase and Dimensions
 Standard Wheelbase: For a truck tractor with a single drive axle, the legal wheelbase range is 3.0 m to 6.2 m.
 Exclusion from the 7.2 m Rule: The specific wheelbase "run" policy (allowing up to 7.2 m in exchange for trailer reductions) is exclusive to tandem drive truck tractors. Single drive tractors remain limited to the standard 6.2 m maximum.
 Tractor-Truck Distinction: If the unit is a straight truck (not a tractor), the wheelbase is "Not Specified" in Appendix B, allowing for more flexibility in its physical length.
 4. Configuration Rules
 Drive Ratios: Like all drive units, it must carry more than 20% of the GCVW to maintain legal traction and stability.
 Towing Prohibitions: Single steering/single drive axle trucks are generally restricted in their ability to tow heavy multi-axle trailers. For example, the maximum weight allowed for a tridem pony trailer in combination with a single drive truck is restricted to 17,000 kg (rather than the usual 21,000 kg).
 Double-Trailer Restriction: Tandem-steer/single-drive configurations are not permitted in double-trailer combinations (A, B, or C Trains).

 To establish the 29,000 kg permit maximum for a tridem axle unit (typically on a semi-trailer or lowbed), specific rules regarding the axle spread and the type of booster used must be satisfied according to the heavy-haul policies.
 1. The Axle Spread Rule
 To qualify for the higher weight allowance, the tridem axle group must maintain a specific spread (the longitudinal distance between the centers of the first and last axles in the group):
 Permitted Spread: The spread must be not less than 2.4 metres and not more than 3.7 metres.
 If the spread falls outside this range, the group may be restricted to a lower legal maximum (typically 24,000 kg) or subject to different Bridge Formula calculations.
 2. The Booster Rules
 The maximum permittable weight of the tridem unit is directly influenced by the configuration of the booster assembly attached to the rear of the trailer:
 For 29,000 kg: This weight is only permitted if the tridem unit is used in combination with a single-axle booster or with no booster at all.
 The 28,000 kg Restriction: If the configuration utilizes a tandem or tridem booster, the maximum weight for the tridem trailer axle group is reduced to 28,000 kg.
 Tridem Booster Limitation: A tridem axle booster itself is only permitted in combination with a tridem lowbed.
 3. Additional Supporting Conditions
 Beyond the spread and booster configuration, several other requirements must be met to legally carry 29,000 kg on the tridem unit:
 Vehicle Type: This specific allowance is categorized under "Other Axles – Semi-Trailers" and applies specifically to heavy-haul lowbed semi-trailers.
 Bridge Formula: The group and its relation to other axle units must satisfy the Bridge Formula (30×wheelbase in cm+18,000). If the formula yields a lower value than 29,000 kg for that specific spacing, the lower weight is the binding limit.
 Interaxle Spacing: For heavy-haul configurations operating under an overweight permit, there is typically a mandatory minimum interaxle spacing of 4.2 metres between the tridem trailer group and adjacent units (like the drive group or a jeep).
 Tire Loading: The vehicle must have sufficient tire width to ensure the load does not exceed 100 kg per 1 cm of tire width.