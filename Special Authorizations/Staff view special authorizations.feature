Feature: Staff view special authorizations

Staff = SA, HQA

Rule: 

@orv2-
Rule: Non-auth staff can view the LCV designation status

  Scenario: LCV active
    Given ABC Co. has the LCV flag active
     When Non-auth staff chooses to view ABC Co. special authorizations 
     Then they see the LCV status

  Scenario: LCV not active
    Given XYZ Co. does not the LCV flag active
     When Non-auth staff chooses to view special authorizations 
     Then they do not see an LCV status

