@orv2-5514 https://moti-imb.atlassian.net/browse/ORV2-5514 
Feature: As a user I need the system to validate that the wheelbase derived from the axle unit spacing and spread for my single steer tandem drive truck tractor vehicle is compliant with policy and regulations for single trip overweight permits, so that I can ensure my permit application is compliant.

users = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 20: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5514
Rule: Truck tractor wheelbase derived from the axle unit spacing and spread must not exceed 7.2 m for single steer tandem drive truck tractors

  Scenario: 
    Given 
     When 
     Then

@orv2-5514
Rule: If the wheelbase is less than 6.2 m then there are no restrictions

  Scenario: 
    Given 
     When 
     Then

@orv2-5514
Rule: If the wheelbase is greater than 7.2 m then the permit application is blocked 

  Scenario: 
    Given 
     When 
     Then

@orv2-5514
Rule: If the wheelbase is between 6.2 m and 7.2 m then only semi-trailers are allowed

  Scenario: 
    Given 
     When 
     Then
     
@orv2-5514
Rule: If the wheelbase is between 6.2 m and 7.2 m then the user is informed to refer to CTPM 5.3.7.A for trailer restrictions

# Notes:
Evaluating: Truck tractor wheelbase is measured as the longitudinal distance from the centre of the front steering axle (Single only) to the geometric centre of the drive axle unit (Tandem only), we would derive this by using 50% of the drive axle unit spread + the steer axle to drive axle spacing. The wheelbase cannot be beyond 7.2 m. If the wheelbase of a single steer tandem drive truck tractor is 6.2m to 7.2 m then the only trailers allowed is semi-trailer no jeep or booster

Triggers:
- Vehicle Sub-type
- Axle unit 1 type
- Axle unit 2 type
- Wheelbase derived length

Logic:
IF (Axle Unit 1 Spacing + 50% of Axle Unit 2 Spread) > 7.2 m THEN
    Output = ""Wheelbase for Axle Unit X and Axle Unit Y is greater than 7.2m.""

ELSE IF (Axle Unit 1 Spacing + 50% of Axle Unit 2 Spread) BETWEEN 6.2 m AND 7.2 m THEN
    Output = ""Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. See CTPM 5.3.7.A.""

ELSE
    Output = """"   // blank if less than 6.2 m
END IF