Feature: As Staff I need to view special authorizations

Staff = PC, CTPO, Trainee, EO

@orv2-2654
Rule: Staff can view the special authorizations tab

  Scenario: no special auth
    Given the ABC Co. has no special auth
     When staff choose to view special authorizations for ABC Co.
     Then they see 

@orv2-2654
Rule: Staff can view the special authorizations tab