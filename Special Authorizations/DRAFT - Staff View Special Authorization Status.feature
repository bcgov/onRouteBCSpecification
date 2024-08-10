Feature: As Staff I need to view special authorizations

Staff = PC, CTPO, Trainee, EO

@orv2-2654
Rule: Staff can view the special authorizations tab when no apecial authorizations are active

  Scenario: no special auth
    Given ABC Co. has no special authorizations
     When staff choose to view special authorizations for ABC Co.
     Then they see...

@orv2-2654
Rule: Staff can view the special authorizations tab