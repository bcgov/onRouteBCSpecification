@orv2-4440 https://moti-imb.atlassian.net/browse/ORV2-4440
Feature: As an authorized staff user, I want to be able to amend a Single Trip Overweight (STOW) permit so that I can update the permit details on behalf of the applicant.

Staff = PC, SA, TRAIN, CTPO

# Note
# See the following feature files for additional specs:
# - User Apply for STOW
# - Staff Apply for STOW
# - Common Amend Permit Rules
# - Permit start and duration Staff

# Contact Information
 @orv2-4440-1
 Rule: staff can change all contact information except company email

# Permit Details
 # see Permit start and duration Staff feature file for rules related to permit start and duration
 # see common amend per rules feature file for rules related to permit details

 @orv2-4440-2
 Rule: staff can change the start date of an issued or active permit

 @orv2-4440-3
 Rule: staff can change the duration of an issued or active permit

 @orv2-4440-4
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

# Commodity Details
 # see the following feature file for rules related to commodity details:
 # - User Apply for STOW.feature
 # - Staff Apply for STOW.feature

# Vehicle Information
 # see the following feature file for rules related to axle spacings and weights:
 # - User Apply for STOW.feature
 # - Staff Apply for STOW.feature
# Axle Spacings and Weights
 # see the following feature file for rules related to axle spacings and weights:
 # - User Apply for STOW.feature
 # - Staff Apply for STOW.feature

# Extraordinary Load Requests
 # see the following feature file for rules related to axle spacings and weights:
 # - Record & Use Overload Number.feature

# Trip Details
 # see the following feature file for rules related to trip details:
 # - User Apply for STOW.feature
 # - Staff Apply for STOW.feature

 @orv2-4440-7
 Rule: staff can change the total distance of an issued or active permit decreasing or increasing the total distance

# Reason for Amendment
 # see common Amend Permit Rules feature file for rules related to reason for amendment

# Finish, Refund and Add to Cart Submission Rules
 #see fee calculation and fee summary rules in the following feature files:
 # - STOW Review and Confirm.feature

 @orv2-4440-8
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

 @orv2-4440-9
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

 @orv2-4440-10
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
 # see the following feature file for rules related to review and confirm:
 # - User Apply for STOW.feature
 # - Staff Apply for STOW.feature
 # - STOW Staff Review and Confirm.feature
 # - STOW User Review and Confirm.feature

 @orv2-4440-13
 Rule: staff are shown a warning modal when the amendment results in a violation and they choose to add the permit to the cart, refund, or finish the amendment

   Scenario: violations add to cart
     Given staff have have violations on the permit amendment
       And they have continued to review and confirm the application
      When staff choose to add the application to the cart
      Then staff see the following modal warning message:
       "Amendment has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit amendment and would like to continue." 
       And they have the option to "Cancel" or "Continue"

  Scenario: violations continue to refund
    Given staff have have violations on the permit amendment
      And they have continued to review and confirm the application
     When staff choose to continue to refund
     Then staff see the following modal warning message:
      "Amendment has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit amendment and would like to continue." 
      And they have the option to "Cancel" or "Continue"

  Scenario: violations continue to finish
    Given staff have have violations on the permit amendment
      And they have continued to review and confirm the application
     When staff choose to continue to finish
     Then staff see the following modal warning message:
      "Amendment has violation(s) and/or warning(s) I confirm that I have reviewed the violation(s) and/or warning(s) associated with this permit amendment and would like to continue." 
      And they have the option to "Cancel" or "Continue"

# Fee Calculation and Fee Summary
 #see fee calculation and fee summary rules in the following feature files:
 # - STOW Staff Review and Confirm.feature
 # - STOW User Review and Confirm.feature

 @orv2-4440-11
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

# Notes:
