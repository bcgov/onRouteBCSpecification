Feature: As HQ Admin I need to designate a CV Client as Long Combination Vehicle (LCV) capable so that these CV Clients can apply for permits using these vehicle types.

Other Staff = PC, SA, CTPO, Trainee
CV Client = CA, PA

@orv2-1015-1
Rule: HQA can designate a CV Client as an LCV capable company

  Scenario: HQA
    Given CV Client does not have a LCV designation
     When HQA choose to designate the LCV
     Then they see the option to designate the CV Client as LCV capable

  Scenario: Other Staff
    Given CV Client does not have a LCV designation
     When PC choose to designate the LCV
     Then they do not see the the option to designate the CV Client as LCV capable

  Scenario: CV Client
    Given CV Client does not have a LCV designation
     When CV Client choose to designate the LCV
     Then they do not see the the option to designate the CV Client as LCV capable

@orv2-1015-2
Rule: LCV designation never expires