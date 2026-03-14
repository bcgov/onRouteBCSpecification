cv client = CA, PA

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
