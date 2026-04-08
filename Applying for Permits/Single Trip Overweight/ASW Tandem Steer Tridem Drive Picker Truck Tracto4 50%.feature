@orv2-5456 https://moti-imb.atlassian.net/browse/ORV2-5456
Feature: As a user, I need the system to validate that the axle unit types and configurations I have selected are compliant with the ASW rules for tandem steer tridem drive picker truck tractor vehicles, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 18: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5456-1
Rule:



IF vehicle configuration is Tandem Steer/Tridem Drive
AND the vehicle is a picker truck tractor
AND the vehicle exceeds CTR Appendix B legal truck or truck tractor definitions
THEN
IF TandemSteerAxleGroupWeight < (0.50 × TridemDriveAxleGroupWeight)
THEN
Output = Axle Unit X must be at least 50% of Axle Unit Y.
ELSE IF OperatingAtPermitAxleWeights = Yes AND IsTowingTrailer = Yes
THEN
Output = Cannot tow a trailer if Axle Unit X and Axle Unit Y are exceeding legal axle weights.
AND indicate all Axle Unit Actual Weight input fields
ELSE
Output = blank
ELSE
Output = blank (rule not applicable)