@orv2-5947 ttps://moti-imb.atlassian.net/browse/ORV2-5947
eature: As a user I want to apply for a Extra-Provincial Temporary Operating Permit (EPTOP) so that I can authorize commercial passenger vehicles originating from outside B.C. to transport passengers into the province on a temporary basis if they do not hold a permanent British Columbia Passenger Transportation Licence.

users = PC, SA, TRAIN, CTPO, CA, PA
cv client = CA, PA

Note: These rules cover the user experience for applying for a EPTOP. for all users and those true for any user. Other rules (e.g., contact details, date or duration) that are common to more than one permit application type can be found in the Applying for Permits folder. Rules specific to staff can be found in the Applying for Permits/EPTOP/Staff Apply for EPTOP.feature file.

# Start permit
 @orv2-5947-1
 Rule: the Extra-Provincial Temporary Operating Permit is a Non-Resident permit type

# Permit Details
 # see Permit Start and Duration Staff and Permit Start and Duration User feature files for rules related to permit start and duration

 @orv2-5947-2
 Rule: EPTOP permits do not have CVSE forms
  # they do have an embedded conditions document that is part of the permit template but treated as a separate document with its own pagination

# Vehicle Information               
 @orv2-5947-3
 Rule: Users may only input a power unit allowable for a EPTOP manually or chosen from inventory

  # see vehicle to permit mapping: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

   Scenario: recall non allowable
     Given power unit A vehicle sub-type is not allowed
      When they choose to recall power unit A
      Then they do not see power unit A

   Scenario: manually input new vehicle
     Given vehicle sub-type 1 is not allowed
      When they attempt to choose vehicle sub-type 1 
      Then they do not see vehicle sub-type 1

 @orv2-5947-4
 Rule: Power unit province / state is not available when Mexico is chosen as the country

   Scenario: Mexico chosen
      When a user chooses the country "Mexico"
      Then Province state is not available

 @orv2-5947-5
 Rule: a user can edit any power unit detail except vehicle type or recall a new power unit with allowable vehicle sub-type

   Scenario: edit power unit details
      Given a user has inputted or recalled a power unit
      When they choose to edit the power unit details
      Then they can edit any detail except vehicle type

   Scenario: recall new power unit with allowable vehicle sub-type
      Given a user has inputted or recalled a power unit with vehicle sub-type 1
       And vehicle sub-type 2 is allowed for this permit type
      When they choose to recall a new power unit with vehicle sub-type 2
      Then they can recall the new power unit with vehicle sub-type 2
       And vehicle sub-type 1 is removed from the application
       And the details for the new power unit are added to the application

 @orv2-5947-6
 Rule: bc plated vehicles cannot apply for an EPTOP

   Scenario: bc plated
    Given a user chooses "British Columbia" as Province / State
     When they choose to continue
     Then they see "BC plated vehicles don't require this permit."
      And they can not continue

# Trip Details
 @orv2-5947-7
 Rule: users must input a point of entry for the trip

   Scenario: input point of entry and point of exit
      When a user inputs a point of entry and point of exit
      Then they can continue to the next step

   Scenario: no input to mandatory fields 
      When they do not enter valid data into point of entry
       And they attempt to continue
      Then they see "This is a required field"
       And they can not continue

# Fee Calculation and Fee Summary

 @orv2-5947-8
 Rule: the permit fee is a flat fee of $25

   Scenario: review and confirm page
      Given a user has filled out the application form
       And they are on the review and confirm page
      Then the permit fee is shown as $25

 @orv2-5947-10
 Rule: EPTOP can be free if CV Clients have the free flag on their profile

   Scenario: review and confirm page
      Given a user has filled out the application form
       And they are on the review and confirm page
       And they are a CV Client with the free flag
      Then the permit fee is shown as $0

# Review and Confirm
 @orv2-5947-9
 Rule: Point of Entry is shown on the review and confirm page

   Scenario: review and confirm page
      Given a user has filled out the application form
       And they are on the review and confirm page
      Then they see the point of entry they inputted on the application form

# Notes:
 - need to confirm if LOA's can be used with EPTOP's #waitingfor Barry
 - under Non-Res in start permit menu
 - if BC then show error on province selection