Feature: Copy Permit/Common Copy Issued, Active or Expired Permit

user = PC, SA, TRAIN, CTPO, CA, PA

@orv2-4978-1
Rule: users can copy permit at Active or Expired Permits

  Scenario: active permit
    Given permit A is active
     When a user attempts to copy permit A
     Then copy is available

  Scenario: expired permit
    Given permit A is expired
     When a user attempts to copy permit A
     Then copy is available

  Scenario: copy unavailable
    Given the following statuses are true for a permit
      | tps synced permit |
      | revoked permit    |
      | void permit       |
     When a user attempts to copy
     Then copy is not available

@orv2-4978-2
Rule: users are directed to the new application after copying

  Scenario: copy permit 
    Given permit A is eligible for copying
     When a user copies permit A
     Then the user is directed to the new application B
      And permit application B contains the copied information from permit A