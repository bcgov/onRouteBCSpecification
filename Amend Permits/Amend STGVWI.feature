@orv2-5765-1 https://moti-imb.atlassian.net/browse/ORV2-5765 
Feature: As an authorized staff user, I want to be able to amend a Single Trip GVW Increase (STGVWI) permit so that I can update the permit details on behalf of the applicant.

Staff = PC, SA, TRAIN, CTPO

# Note
# See the following feature files for additional specs:
# - User Apply for STGVWI
# - Staff Apply for STGVWI
# - Common Amend Permit Rules
# - Permit start and duration Staff

# Contact Information
@orv2-5765-2
Rule: staff can change all contact information except company email

# Permit Details
 # see Permit start and duration Staff feature file for rules related to permit start and duration

@orv2-5765-3
Rule: staff can change the start date of an issued or active permit

@orv2-5765-4
Rule: staff can change the duration of an issued or active permit

@orv2-5765-5
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
@orv2-5765-6
Rule: staff can change power unit details and recall a new power unit with an allowable vehicle sub-type without impacting other application data

 #see power unit to permit mapping https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/doc2.aspx?sourcedoc=%7B61096924-A4AC-4CE8-8B38-209A2ED349C3%7D&file=Vehicle%20to%20Permit%20Mapping.xlsx&action=default&mobileredirect=true

  Scenario: licensed GVW increase
    Given the current permit has a licensed GVW of 40000kg
      And the current permit has an actual GVW of 46000kg
      And the current licensed GVW increase is 6000kg
     When staff amend the licensed GVW to 45000kg
     Then the licensed GVW is updated to 45000kg
      And the licensed GVW increase is 5000kg

  Scenario: licensed GVW decrease
    Given the current permit has a licensed GVW of 40000kg
      And the current permit has an actual GVW of 46000kg
      And the current licensed GVW increase is 6000kg
     When staff amend the licensed GVW to 35000kg
     Then the licensed GVW is updated to 35000kg
      And the licensed GVW increase is 4000kg

# Actual GVW (kg)
@orv2-5765-7
Rule: staff can change the actual GVW (kg) of an issued or active permit decreasing or increasing the actual GVW (kg)

 # see the following feature file for rules related to actual GVW (kg):
 # - User Apply for STGVWI
 # - Staff Apply for STGVWI

# Overload Calculation
 # see the following feature file for rules related to actual GVW (kg):
 # - User Apply for STGVWI
 # - Staff Apply for STGVWI

# Trip Details
 # see the following feature file for rules related to trip details:
 # - User Apply for STGVWI
 # - Staff Apply for STGVWI

@orv2-5765-8
Rule: staff can change the total distance of an issued or active permit decreasing or increasing the total distance
# Finish, Refund and Add to Cart Submission Rules
 #see fee calculation and fee summary rules in the following feature files:
 # - User Apply for STGVWI

@orv2-5765-9
Rule: if staff amend results in the NPV being equal to the CPV ($0) they can continue to finish amendment screen

  Scenario: $0 amend
    Given the CPV is $30
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0  |
      And they can continue to finish amendment screen

@orv2-5765-10
Rule: if staff amend results in the NPV being higher than the CPV they can add the permit to the cart and pay the difference at checkout

  Scenario: licensed GVW decrease (NPV < CPV)
    Given the CPV is $65
      And the current permit has 
       | a licensed GVW | 40000kg |
       | an actual GVW  | 46000kg |
       | a total distance | 350km |
     When staff decrease the licensed GVW to 35000kg
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $37  |
       | Total                | -$28 |
      And they can add the permit to the cart

  Scenario: distance increase
    Given the CPV is $65
      And the current permit has 
       | a licensed GVW | 40000kg |
       | an actual GVW  | 46000kg |
       | a total distance | 350km |
     When staff increase the total distance to 500km
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $93  |
       | Total                | $28  |
      And they can add the permit to the cart

  Scenario: actual GVW increase
    Given the CPV is $65
      And the current permit has 
       | a licensed GVW | 40000kg |
       | an actual GVW  | 46000kg |
       | a total distance | 350km |
     When staff increase the actual GVW to 50000kg
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $117 |
       | Total                | $52  |
      And they can add the permit to the cart

@orv2-5765-11
Rule: if staff amend results in the NPV being less than the CPV they can continue to refund 

  Scenario: licensed GVW increase (NPV > CPV)
    Given the CPV is $65
      And the current permit has 
       | a licensed GVW | 40000kg |
       | an actual GVW  | 46000kg |
       | a total distance | 350km |
     When staff decrease the licensed GVW to 42000kg
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $49  |
       | Total                | -$16 |
      And they can continue to refund

  Scenario: distance reduction
    Given the CPV is $65
      And the current permit has
       | a licensed GVW | 40000kg |
       | an actual GVW  | 46000kg |
       | a total distance | 350km |
     When staff decrease the total distance to 200km
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $37  |
       | Total                | -$28 |
      And they can continue to refund

  Scenario: actual GVW reduction
    Given the CPV is $65
      And the current permit has a licensed GVW of 40000kg
      And the current permit has an actual GVW of 46000kg
      And the current permit has a total distance of 350km
     When staff decrease the actual GVW to 41000kg
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $65  |
       | New Permit Value     | $33  |
       | Total                | -$32 |
      And they can continue to refund

# Review and Confirm
 #see common amend permit rules feature file for rules related to review and confirm

@orv2-5765-12
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

  Scenario: > CPV
    Given the CPV is $15
     When staff amend the return trip designation to return trip
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $15 |
       | New Permit Value     | $30 |
       | Total                | $15 |

  Scenario: < CPV
    Given the CPV is $30
     When staff amend the return trip designation to one way
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $15 |
       | Total                | -$15 |

  Scenario: = CPV ($0 amend)
    Given the CPV is $30
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $30 |
       | New Permit Value     | $30 |
       | Total                | $0  |
       

# Fee Calculation and Fee Summary
 #see fee calculation and fee summary rules in the following feature files:
 # - User Apply for STGVWI


# Notes:

