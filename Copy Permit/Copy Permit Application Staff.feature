staff = PC, SA, TRAIN, CTPO

@orv2-4978-3
Rule: staff act as company upon copying a permit from global search for permit results

  Scenario: permit 1 for company a
    Given staff found permit 1 
      And it was issued for company A
     When they copy permit 1
     Then they are directed to the copied permit application
      And they are acting as company A

@orv2-4978-4
Rule: staff are directed to the copied permit application when copying a permit from global search for permit results

  Scenario: permit 1 for company a
    Given staff found permit 1 
      And it was issued for company A
     When they copy permit 1
     Then they are directed to the copied permit application

@orv2-4978-5
Rule: staff can copy a permit application from global search for permit results when not acting as a company

  Scenario: active permit
    Given permit A is active
     When a staff attempts to copy permit A
     Then copy is available

  Scenario: expired permit
    Given permit A is expired
     When a staff attempts to copy permit A
     Then copy is available

  Scenario: copy unavailable
    Given the following statuses are true for a permit
      | tps synced permit |
      | revoked permit    |
      | void permit       |
     When a staff attempts to copy
     Then copy is not available

@orv2-4978-6
Rule: staff can copy any permit application but not rejected ones

  Scenario: started by staff
    Given permit application A was started by staff
     When a staff member attempts to copy permit application A
     Then copy is available

  Scenario: started by cv client
    Given permit application A was started by a cv client
     When a staff member attempts to copy permit application A
     Then copy is available