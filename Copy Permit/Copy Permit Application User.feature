Feature: Copy Permit Application - Common Copy Permit Application

user = PC, SA, TRAIN, CTPO, CA, PA
cv client = CA, PA

@orv2-4969-1
Rule: a user cannot copy a rejected permit application

  Scenario: rejected permit application
    Given permit application A is rejected
     When a user attempts to copy permit application A
     Then copy is not available

@orv2-4969-3
Rule: users are directed to the new application after copying

  Scenario: copy permit application
    Given permit application A is eligible for copying
     When a user copies permit application A
     Then the user is directed to the new application B
      And permit application B contains the copied information from permit application A