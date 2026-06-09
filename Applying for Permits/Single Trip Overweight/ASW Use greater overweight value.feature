@orv2-5692 https://moti-imb.atlassian.net/browse/ORV2-5692
Feature: As a user, I need the system to validate that the number of axles in the booster axle unit does not exceed the number of axles on the trailer for single trip overweight permits, so that I can ensure my permit application is compliant.

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

Evaluation logic Eval No. 12: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B75470B66-E982-4B22-AFE0-9ED4D69E3E27%7D&file=STOW%20Evaluations.xlsx&action=default&mobileredirect=true

@orv2-5692-1
Rule: when there is a conflict between the overweight value calculated for the axle group and the overweight value calculated for an axle unit, the greater overweight value is used.

