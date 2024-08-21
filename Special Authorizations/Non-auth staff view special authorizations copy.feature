Feature: Non-auth staff view special authorizations

Non-auth Staff = PC, CTPO, Trainee, EO, FIN

Rule: 

@orv2-1015-4
Rule: Non-auth staff can view the LCV designation status

  Scenario: LCV active
    Given ABC Co. has the LCV flag active
     When Non-auth staff chooses to view ABC Co. special authorizations 
     Then they see the LCV status

  Scenario: LCV not active
    Given XYZ Co. does not the LCV flag active
     When Non-auth staff chooses to view special authorizations 
     Then they do not see an LCV status

