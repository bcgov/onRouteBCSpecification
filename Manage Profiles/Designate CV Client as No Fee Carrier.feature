Feature: As PPC SA or HQ Admin I need to designate a CV Client with the free permit flag so that these clients can purchase permits without being charged any fees.

@orv2-1050-1
Rule: Only PPC SA or HQ Admin can designate a CV Client for no fee permits

  Scenario: Viewing CV Client profile information
    Given a PPC SA or HQ Admin chooses to view a CV Client profile 
     When they choose to view "Special Authorizations"
     Then they can designate "No Fee Permits" for the CV Client
      And they can assign a no fee permit client type
        | The government of Canada or any province or territory                 |
        | A municipality                                                        |
        | A school district outside of BC (S. 9 Commercial Transport Act)       |
        | The government of the United States of America                        |
        | The government of any state or county in the United States of America |

@orv2-1050-2
Rule: CV Client can view only no fee permit designation 

  Scenario: CV Client has a special authorization designation
    Given a CV Client is viewing their profile information
      And they have been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they see the designation is allowed
      And they see the no fee permit client type
      But they cannot change the no fee permit designation 
      And they cannot change the no fee permit client type 

  Scenario: CV Client does not have a special authorization designation
    Given a CV Client is viewing their profile information
      And they have not been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they do not see the no fee permits section

@orv2-1050-3
Rule: If a CV Client has no special authorizations then the special authorizations tab is not visible 

  Scenario: CV Client does not have any special authorization designations
    Given a CV Client is viewing their profile information
     When they have not been designated with any special authorizations
     Then they do not see the special authorizations tab