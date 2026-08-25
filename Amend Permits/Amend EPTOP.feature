@orv2-5953 https://moti-imb.atlassian.net/browse/ORV2-5953
Feature: As an authorized staff user, I want to be able to amend a Extra-Provincial Temporary Operating Permit (EPTOP) so that I can update the permit details on behalf of the applicant.

Staff = PC, SA, TRAIN, CTPO

# Note
# See the following feature files for additional specs:
# - User Apply for EPTOP
# - Staff Apply for EPTOP
# - Common Amend Permit
# - Refund to Multiple Payment Methods
# - Permit start and duration Staff

# Contact Information
 @orv2-5953-1
 Rule: staff can change all contact information except company email

# Permit Details
 # see Permit start and duration Staff feature file for rules related to permit start and duration

 @orv2-5953-2
 Rule: staff can change the start date of an issued or active permit

 @orv2-5953-3
 Rule: staff can change the duration of an issued or active permit

 @orv2-5953-4
 Rule: staff are notified when start date and/or expiry date are in the past

    Scenario: on application form
      Given the current date is 05/02/2025
       When staff amend the start date to 05/01/25
       Then they see "Start date is in the past"
  
    Scenario: on review and confirm
      Given the current date is 05/02/2025
       When staff amend the start date to 05/01/25
        And continue to review and confirm
       Then they see "Start date and/or expiry date is in the past"

# Vehicle Information
 @orv2-5953-5
 Rule: staff can change power unit details and recall a new power unit with an allowable vehicle sub-type without impacting other application data

  # see vehicle to permit mapping: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/doc2.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

  # see the following feature file for rules related to trip details:
  # - User Apply for EPTOP
  # - Staff Apply for EPTOP

# Trip Details
 # see the following feature file for rules related to trip details:
 # - User Apply for EPTOP
 # - Staff Apply for EPTOP

 @orv2-5953-7
 Rule: staff can change the point of entry

 # Finish, Refund and Add to Cart Submission Rules
  #see fee calculation and fee summary rules in the following feature files:
  # - User Apply for EPTOP

 @orv2-5953-8
 Rule: if staff amend results in the NPV being equal to the CPV ($0) they can continue to finish amendment screen

   Scenario: $0 amend
     Given the CPV is $25
      When staff amend the vehicle plate
       And continue to review and confirm
      Then they see the following:
        | Current Permit Value | $25 |
        | New Permit Value     | $25 |
        | Total                | $0  |
       And they can continue to finish amendment screen



# Fee Calculation and Fee Summary
 # see fee calculation and fee summary rules in the following feature files:
 # - User Apply for EPTOP

  @orv2-5953-11
 Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

   Scenario: = CPV ($0 amend)
     Given the CPV is $25
      When staff amend the vehicle plate
       And continue to review and confirm
      Then they see the following:
        | Current Permit Value | $25 |
        | New Permit Value     | $25 |
        | Total                | $0  |

# Finish Amendment
 # see common amend permit rules and refund to multiple payment methods rules in the following feature files

# Notes:

