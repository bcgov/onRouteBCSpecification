Feature: As Staff I need to view special authorizations

Staff = PC, CTPO, Trainee, EO

@orv2-2654
Rule: Staff can view the special authorizations tab when no special authorizations are active

  Scenario: no LCV active
    Given ABC Co. has no LCV
     When staff choose to view special authorizations for ABC Co.
     Then they see 

@orv2-2654
Rule: Staff can view the special authorizations tab


LOa
  # Scenario: no active no expired LOA(s)
    Given there are no active LOA(s)
     When users choose to view LOA(s)
     Then they see the option to view expired LOA(S)
    Given 
     When 
     Then 

  # Scenario: no active but expired LOA(s)
    Given there are no active LOA(s)
     When users choose to view LOA(s)
     Then they see the option to view expired LOA(S)
    Given 
     When 
     Then 

  # Scenario: active and expired LOA(s) users
    Given there are no active LOA(s)
     When users choose to view LOA(s)
     Then they see the option to view expired LOA(S)
    Given 
     When 
     Then 

  # Scenario: active no expired LOA(s) users
    Given there are no active LOA(s)
     When users choose to view LOA(s)
     Then they see the option to view expired LOA(S)
    Given 
     When 
     Then 