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
		And operating at permit axle weights is <operatingAtPer mitAxleWeights>
		When the user chooses to calculate or continue with the permit application
		Then they see "Axle Unit X must carry a minimum of 50% of Axle Unit Y axle unit weight."
		 And the axle unit 1 "Axle Unit Weight (kg)" field is indicated with a red border
		 And they cannot continue the permit application

		Examples:
			| description                   | tridemDriveAxleUnitWeight | tandemSteerAxleUnitWeight | operatingAtPermitAxleWeights |
			| Fail just below 50% boundary  | 20000                      | 9999                       | No                           |
			| Fail well below 50% threshold | 24000                      | 10000                      | Yes                          |
			| Fail below 50% threshold      | 18000                      | 8000                       | No                           |

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