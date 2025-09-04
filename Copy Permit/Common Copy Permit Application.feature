Feature: Copy Permit Application - Common Copy Permit Application

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO
cv client = CA, PA

@orv2-4969-1
Rule: a user cannot copy a rejected permit application

  Scenario: rejected permit application
    Given permit application A is rejected
     When a user attempts to copy permit application A
     Then copy is not available

@orv2-4969-2
Rule: a cv client cannot copy a permit application started by staff

  Scenario: started by staff
    Given permit application A was started by staff
     When a cv client attempts to copy permit application A
     Then copy is not available

  Scenario: started by cv client
    Given permit application A was started by a cv client
     When a user attempts to copy permit application A
     Then copy is available

@orv2-4969-3
Rule: staff can copy any permit application but not rejected ones

  Scenario: started by staff
    Given permit application A was started by staff
     When a staff member attempts to copy permit application A
     Then copy is available

  Scenario: started by cv client
    Given permit application A was started by a cv client
     When a staff member attempts to copy permit application A
     Then copy is available