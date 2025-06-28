Feature: Amend Motive Fuel Permit
Amend Motive Fuel Permit (MFP) feature contains rules and scenarios specific to amending a MFP. 

staff = PC, SA, TRAIN, CTPO

@orv2-4202-1
Rule: staff can amend all contact information except company email

@orv2-4202-8
Rule: staff can amend all vehicle information except vehicle type

@orv2-4202-9
Rule: staff can amend all trip details

@orv2-4202-10
Rule: staff can amend the number of km(s) in total distance

  Scenario: < rounding amount
    Given the CPV is $113
      And the total km is 1617 km
     When staff increase total distance to 1624 km
     Then the NPV is $113
      And the total is $0

  Scenario: < rounding amount
    Given the CPV is $113
      And the total km is 1617 km
     When staff decrease total distance to 1610 km
     Then the NPV is $113
      And the total is $0

  Scenario: maximum permit value reached
    Given the CPV is $113
      And the total km is 1617 km
     When staff increase total distance to 2117 km
     Then the NPV is $140 (max MFP fee)
      And the total is $27

@orv2-4202-11
Rule: if staff amend results in a debit (NPV is greater than CPV) they can add the APA to the shopping cart

  Scenario: not at maximum permit value
    Given MFP permit A has a CPV of $100
     When staff add 200 km to total distance
     Then permit A NPV is $114
     And they can add the APA to the shopping cart

  Scenario: at maximum permit value ($0 amend)
    Given MFP permit A has a CPV of $140 (max MFP fee)
     When staff add km to total distance
     Then permit A NPV remains at the maximum allowable fee of $140
     And they can continue to refund to multiple payment methods

@orv2-4202-12
Rule: if staff amend results in a credit (NPV is less than CPV) they can continue to refund to multiple payment methods

  Scenario: total distance reduced above max
    Given the CPV is $140 (max MFP fee)
      And the total km is 2800 km
     When staff reduce total distance to 2500 km
     Then the NPV is $140 ($0 amend)
      And they can continue to refund to multiple payment methods

  Scenario: total distance reduced above min
    Given the CPV is $100
      And the total km is 1429
     When staff reduce total distance to 1200 km
     Then the NPV is $84
      And they can continue to refund to multiple payment methods

  Scenario: total distance reduced below min
  Given the CPV is $100
      And the total km is 1429
     When staff reduce total distance to 130 km
     Then the NPV is $10 (min MFP fee)
      And they can continue to refund to multiple payment methods

@orv2-4202-13
Rule: if staff amend results in the NPV being equal to the CPV they can continue to refund to multiple payment methods
@orv2-4202-14
Rule: staff are shown the Current Permit Value (CPV), New Permit Value (NPV) and the Total debit or credit at review and confirm fee summary

  Scenario: > CPV
    Given the CPV is $100
     When staff add 200 km to total distance
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $114 |
       | Total                | $14  |

  Scenario: < CPV
    Given the CPV is $100
      And the total km is 1429
     When staff reduce total distance to 1200 km
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $84  |
       | Total                | -$16 |

  Scenario: = CPV ($0 amend)
    Given the CPV is $100
     When staff amend the vehicle plate
      And continue to review and confirm
     Then they see the following:
       | Current Permit Value | $100 |
       | New Permit Value     | $100 |
       | Total                | $0   |

# See Amend Permit Date and Duration Rules Staff:
@orv2-4202-5
Rule: staff can reduce the duration of an issued or active permit
@orv2-4202-6 
Rule: staff can forward start date to a maximum of 60 days from today (current date and time the amend is initiated)
@orv2-4202-7
Rule: staff are notified when start date an/or expiry date are in the past
@orv2-4202-4
Rule: staff are notified when start date an/or expiry date are in the past
@orv2-4202-3
Rule: staff can amend the start date of an issued or active permit

# Deprecated:

# @orv2-4202-2
# Rule: staff can extend the duration up to 7 days

  Scenario: issued with 3 days
    Given permit A has a start date of 05/02/2025
      And a duration of 3 days
     When staff amend permit A duration to 7 days
     Then the end date is 05/09/2025

  Scenario: issued with 7 days
    Given permit A have a 7 day duration
     When staff amend duration
     Then they cannot add additional days
      But they can reduce duration