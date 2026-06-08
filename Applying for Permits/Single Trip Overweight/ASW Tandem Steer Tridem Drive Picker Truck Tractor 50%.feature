@orv2-5456 https://moti-imb.atlassian.net/browse/ORV2-5456
Feature: As a user, I need the system to validate that the axle unit types and configurations I have selected are compliant with the ASW rules for tandem steer tridem drive picker truck tractor vehicles, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 18: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5456-1
Rule: Tandem steer axle unit must be at least 50% of tridem drive axle unit for tandem steer/tridem drive picker truck tractors where the tridem drive axle unit exceeds the CTR Appendix B legal limit of 15200 kg and does not exceed the permit maximum of 28000 kg

	Scenario Outline: Tandem steer axle unit weight is below the 50% threshold
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg which exceeds the CTR Appendix B legal limit of 15200 kg and does not exceed the permit maximum of 28000 kg
		And the tandem steer axle unit weight is <tandemSteerAxleUnitWeight> kg
		And operating at permit axle weights is <operatingAtPermitAxleWeights>
		When the user chooses to calculate or continue with the permit application
		Then they see "Axle Unit X must carry a minimum of 50% of Axle Unit Y axle unit weight."
		 And the axle unit 1 "Axle Unit Weight (kg)" field is indicated with a red border
		 And they cannot continue the permit application

		Examples:
			| description                   | tridemDriveAxleUnitWeight | tandemSteerAxleUnitWeight | operatingAtPermitAxleWeights |
			| Fail just below 50% boundary  | 20000                     | 9999                      | No                           |
			| Fail well below 50% threshold | 24000                     | 10000                     | Yes                          |
			| Fail below 50% threshold      | 18000                     | 8000                      | No                           |

@orv2-5456-2
Rule: A trailer can only be towed when not operating at permit axle weights for tandem steer/tridem drive picker truck tractors where the tridem drive axle unit exceeds the CTR Appendix B legal limit of 15200 kg and does not exceed the permit maximum of 28000 kg

	Scenario Outline: Towing is allowed when not operating at permit axle weights
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg which exceeds the CTR Appendix B legal limit of 15200 kg and does not exceed the permit maximum of 28000 kg
		And the tandem steer axle unit weight is <tandemSteerAxleUnitWeight> kg
		And operating at permit axle weights is <operatingAtPermitAxleWeights>
		And towing trailer is <isTowingTrailer>
		When the user chooses to calculate or continue with the permit application
		Then they do not see "Axle Unit X must carry a minimum of 50% of Axle Unit Y axle unit weight."
		 And they do not see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And they can continue the permit application

		Examples:
			| description                             | tridemDriveAxleUnitWeight | tandemSteerAxleUnitWeight | operatingAtPermitAxleWeights | isTowingTrailer |
			| Not towing while at permit axle weights | 20000                     | 10000                     | Yes                          | No              |
			| Pass above 50% at permit axle weights   | 20000                     | 11000                     | Yes                          | No              |
			| Towing is allowed when not at permit    | 22000                     | 12000                     | No                           | Yes             |

	Scenario Outline: Towing a trailer is blocked when operating at permit axle weights
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg which exceeds the CTR Appendix B legal limit of 15200 kg and does not exceed the permit maximum of 28000 kg
		And the tandem steer axle unit weight is <tandemSteerAxleUnitWeight> kg
		And operating at permit axle weights is Yes
		And towing trailer is Yes
		When the user chooses to calculate or continue with the permit application
		Then they see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And all "Axle Unit Weight (kg)" input fields are indicated with a red border
		 And they cannot continue the permit application

		Examples:
			| description                           | tridemDriveAxleUnitWeight | tandemSteerAxleUnitWeight |
			| Boundary pass for 50% but towing fail | 20000                     | 10000                     |
			| Above 50% but towing fail             | 22000                     | 12000                     |

	Scenario Outline: Rule is not applicable when prerequisite conditions are not met
		Given the vehicle configuration is <vehicleConfiguration>
		And the vehicle type is <vehicleType>
		And the tridem drive axle unit weight is <tridemDriveAxleUnitWeight> kg
		When the user chooses to calculate or continue with the permit application
		Then they do not see "Axle Unit X must carry a minimum of 50% of Axle Unit Y axle unit weight."
		 And they do not see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And they can continue the permit application

		Examples:
			| description                                                          | vehicleConfiguration      | vehicleType          | tridemDriveAxleUnitWeight |
			| Not applicable - wrong configuration                                 | Single Steer/Tridem Drive | picker truck tractor | 20000                     |
			| Not applicable - not a picker truck tractor                          | Tandem Steer/Tridem Drive | truck tractor        | 20000                     |
			| Not applicable - tridem drive at CTR Appendix B legal limit 15200 kg | Tandem Steer/Tridem Drive | picker truck tractor | 15200                     |
			| Not applicable - tridem drive exceeds permit maximum of 28000 kg     | Tandem Steer/Tridem Drive | picker truck tractor | 28001                     |

# Notes:
- Triggers for assessing for 50% rule:
 - Tandem Steer/Tridem Drive configuration
 - Power Unit vehicle sub types:
  - Picker Truck Tractor (assumed our only version is only with PME?)
  - Truck Tractor with Heavy Front Projected Crane (don't have this vehicle sub-type), Truck Tractor with PME?
 - Exceed Legal Weight:
  - Tridem drive axle unit weight exceeds the CTR Appendix B legal limit of 24000 kg
  - Tandem steer axle unit weight exceeds the CTR Appendix B legal limit of 15200 kg

- For these specific non-standard picker truck tractors, the steering axle unit must carry a minimum of 50% of the actual weight of the tridem drive axle group when the vehicle is loaded
- tridem drive are the only ones that have a min axle weight
- Picker Truck Tractors (Heavy Front Projected Crane)
	- Tandem Steer, Tridem Drive
	- no trailers and 50% rule apply
	- single steer regardless of drive can get trailer and overweight
	- tandem and tridem drive can get overweight but no trailer, legal weight with trailer

 ## Logic:
 IF vehicle configuration = Tandem Steer/Tridem Drive
AND vehicle type = picker truck tractor
AND tridem drive axle unit weight > 15200 kg
AND tridem drive axle unit weight <= 28000 kg
THEN
    IF tandem steer axle unit weight < (0.50 * tridem drive axle unit weight)
    THEN
        Output = "Axle Unit X must carry a minimum of 50% of Axle Unit Y axle unit weight."
        Prevent user from continuing
    ELSE
        IF operating at permit axle weights = Yes
        AND towing trailer = Yes
        THEN
            Output = "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
            Indicate all "Axle Unit Actual Weight (kg)" input fields
            Prevent user from continuing
        ELSE
            Output = no error
            Allow user to continue
ELSE
    Output = no error
    Rule is not applicable

Permit Axle Weights:

| Section                                                  | Steering/Drives  | Steering Max Weight By Permit | Axle Spread (steer/drive)  | Truck Tractor Wheelbase | Drive Max Weight By Permit |
| ---                                                      | ---              | ---                           | ---                        | ---                     | ---                        |
| Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 2.4 - 2.8 m | 7.2 m (Min)             | 28,000 kg                  |
| Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 2.8 - 3.0 m | 7.3 m (Min)             | 28,000 kg                  |
| Picker truck tractors only with PME (a)                  | Tandem/Tridem[c] | 15,200 kg                     | 1.0 - 1.85 m / 3.0 - 3.1 m | 7.4 m (Min)             | 28,000 kg                  |
| Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 2.4 - 2.8 m | 7.2 m (Min)             | 28,000 kg                  |
| Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 2.8 - 3.0 m | 7.3 m (Min)             | 28,000 kg                  |
| Truck tractors only with heavy front projected crane (b) | Tandem/Tridem[c] | 17,000 kg                     | 1.0 - 1.85 m / 3.0 - 3.1 m | 7.4 m (Min)             | 28,000 kg                  |

(a) PME as defined under the CTR
(b) tractor exceeds 14,000 kg tare weight
(c) For tandem steer/tridem drive vehicles only and exceeding CTR Appendix B legal truck or truck tractor definitions - the tandem steer axle group weight must be min. 50% of the tridem drive axle group weight. These tandem steer/tridem drive picker trucks may not tow a trailer when operating at permit axle weights, as opposed to legal axle weights.

Note: Maximum wheelbase is limited by OAL.

Legal Tridem Drive Axle Spreads and Minimum Dimensional Wheelbases for Tandem Steer/Tridem Drive:

Table IV - Tandem Steering/Tridem Drive Axle Combination Only Wheelbase:

| Tridem Drive Axle Spread   | Minimum Dimensional Wheelbase |
| ---                        | ---                           |
| 2.4 m - less than 2.8 m    | 7.7 m                         |
| 2.8 m - less than 3.0 m[a] | 7.8 m                         |
| 3.0 m - 3.1 m[a]           | 7.9 m                         |

[a] Applies to oilfield bed trucks only.