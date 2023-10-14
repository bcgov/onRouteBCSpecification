Feature: As PPC SA or HQ Admin I need to designate a CV Client with the free permit flag so that these clients can purchase permits without being charged any fees.

@orv2-1050
Rule: Only PPC SA or HQ Admin can designate a CV Client for no fee permits

  Scenario: Viewing CV Client profile information
    Given a PPC SA or HQ Admin chooses to view a CV Client profile 
     When they choose to view "Special Authorizations"
     Then they can designate "No Fee Permits" for the CV Client
      And they can assign a no fee permit client type

@orv2-1050
Rule: CV Client can view only no fee permit designation 

  Scenario: CV Client is viewing their profile
    Given a CV Client is viewing their profile information
      And they have been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they see the designation is allowed
      And they see the no fee permit client type
      But they cannot change the no fee permit designation 
      And they cannot change the no fee permit client type 

  Scenario: CV Client is viewing their profile
    Given a CV Client is viewing their profile information
      And they have not been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they do not see the no fee permits section

@orv2-1050
Rule: If a CV Client has no special authorizations then the special authorizations tab is not visible 


