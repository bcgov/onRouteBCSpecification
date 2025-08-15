@orv2-4978
Feature: Copy Permit/Common Copy Issued, Active or Expired Permit

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO

@orv2-4978-1
Rule: Copy permit at Active or Expired Permits

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
Rule: Staff copy permit at global search permit search results

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