@orv2-5456 https://moti-imb.atlassian.net/browse/ORV2-5456
Feature: As a user, I need the system to validate that the axle unit types and configurations I have selected are compliant with the ASW rules for tandem steer tridem drive picker truck tractor vehicles, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 18: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5456-1
Rule: Tandem steer axle group must be at least 50% of tridem drive axle group for tandem steer/tridem drive picker truck tractor vehicles that exceed legal definitions

	Scenario Outline: Tandem steer axle group weight is below the 50% threshold
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the vehicle exceeds CTR Appendix B legal truck or truck tractor definitions
		And the tridem drive axle group weight is <tridemDriveAxleGroupWeight> kg
		And the tandem steer axle group weight is <tandemSteerAxleGroupWeight> kg
		And operating at permit axle weights is <operatingAtPermitAxleWeights>
		And towing trailer is <isTowingTrailer>
		When the user chooses to calculate or continue with the permit application
		Then they see "Axle Unit X must be at least 50% of Axle Unit Y."
		 And they cannot continue the permit application

		Examples:
			| description                         | tridemDriveAxleGroupWeight | tandemSteerAxleGroupWeight | operatingAtPermitAxleWeights | isTowingTrailer |
			| Fail just below 50% boundary        | 20000                      | 9999                        | No                           | No              |
			| Fail well below 50% threshold       | 24000                      | 10000                       | Yes                          | Yes             |
			| Fail below 50% while towing allowed | 18000                      | 8000                        | No                           | Yes             |

	Scenario Outline: Tandem steer axle group weight meets the 50% threshold and no towing restriction applies
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the vehicle exceeds CTR Appendix B legal truck or truck tractor definitions
		And the tridem drive axle group weight is <tridemDriveAxleGroupWeight> kg
		And the tandem steer axle group weight is <tandemSteerAxleGroupWeight> kg
		And operating at permit axle weights is <operatingAtPermitAxleWeights>
		And towing trailer is <isTowingTrailer>
		When the user chooses to calculate or continue with the permit application
		Then they do not see "Axle Unit X must be at least 50% of Axle Unit Y."
		 And they do not see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And they can continue the permit application

		Examples:
			| description                              | tridemDriveAxleGroupWeight | tandemSteerAxleGroupWeight | operatingAtPermitAxleWeights | isTowingTrailer |
			| Boundary pass at exactly 50%             | 20000                      | 10000                       | No                           | No              |
			| Pass above 50% at permit axle weights    | 20000                      | 11000                       | Yes                          | No              |
			| Pass above 50% while towing not at permit| 22000                      | 12000                       | No                           | Yes             |

	Scenario Outline: Towing a trailer is blocked when operating at permit axle weights
		Given the vehicle configuration is Tandem Steer/Tridem Drive
		And the vehicle is a picker truck tractor
		And the vehicle exceeds CTR Appendix B legal truck or truck tractor definitions
		And the tridem drive axle group weight is <tridemDriveAxleGroupWeight> kg
		And the tandem steer axle group weight is <tandemSteerAxleGroupWeight> kg
		And operating at permit axle weights is Yes
		And towing trailer is Yes
		When the user chooses to calculate or continue with the permit application
		Then they see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And all "Axle Unit Actual Weight (kg)" input fields are indicated with a red border
		 And they cannot continue the permit application

		Examples:
			| description                           | tridemDriveAxleGroupWeight | tandemSteerAxleGroupWeight |
			| Boundary pass for 50% but towing fail | 20000                      | 10000                       |
			| Above 50% but towing fail             | 22000                      | 12000                       |

	Scenario Outline: Rule is not applicable when prerequisite conditions are not met
		Given the vehicle configuration is <vehicleConfiguration>
		And the vehicle type is <vehicleType>
		And the vehicle exceeds CTR Appendix B legal truck or truck tractor definitions is <exceedsLegalDefinition>
		When the user chooses to calculate or continue with the permit application
		Then they do not see "Axle Unit X must be at least 50% of Axle Unit Y."
		 And they do not see "Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights."
		 And they can continue the permit application

		Examples:
			| description                              | vehicleConfiguration         | vehicleType           | exceedsLegalDefinition |
			| Not applicable for non-target configuration | Single Steer/Tridem Drive | picker truck tractor  | Yes                    |
			| Not applicable for non-picker vehicle    | Tandem Steer/Tridem Drive    | truck tractor         | Yes                    |
			| Not applicable when not exceeding legal  | Tandem Steer/Tridem Drive    | picker truck tractor  | No                     |