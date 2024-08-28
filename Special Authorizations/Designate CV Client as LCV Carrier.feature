Feature: As HQ Admin I need to designate a CV Client as Long Combination Vehicle (LCV) capable so that these CV Clients can apply for permits using these vehicle types.

Staff = SA, HQA
Non-auth Staff = PC, CTPO, Trainee, EO, FIN
CV Client = CA, PA

@orv2-1015-1
Rule: Staff can designate a CV Client as an LCV capable company

  Scenario: no lcv staff
    Given CV Client does not have a LCV designation
     When Staff choose to designate the LCV
     Then they see the option to designate the CV Client as LCV capable

  Scenario: no lcv non authorized staff
    Given CV Client does not have a LCV designation
     When Non-auth Staff choose to designate the LCV
     Then they do not see the the option to designate the CV Client as LCV capable

  Scenario: no LCV CV Client
    Given CV Client does not have a LCV designation
     When CV Client choose to designate the LCV
     Then they do not see the the option to designate the CV Client as LCV capable

@orv2-1015-2
Rule: LCV designation never expires

@orv2-1015-3
Rule: CV Client can view the LCV designation if active

  Scenario: LCV active
    Given ABC Co. has the LCV flag active
     When ABC Co. chooses to view special authorizations 
     Then they see the LCV status

  Scenario: LCV not active
    Given XYZ Co. does not the LCV flag active
     When XYZ Co. chooses to view special authorizations 
     Then they do not see an LCV status