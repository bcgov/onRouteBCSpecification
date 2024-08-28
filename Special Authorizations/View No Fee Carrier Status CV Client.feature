Feature: As CV Client I need to view the designation of the free permit flag so that I can purchase permits without being charged any fees.

CV Client = CA, PA

@orv2-1050-5
Rule: CV Client can view no fee permit designation if active

  Scenario: CV Client has a special authorization designation
    Given a CV Client is viewing their profile information
      And they have been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they see the designation is active
      And they see the no fee permit client type
      But they cannot change the no fee permit designation 
      And they cannot change the no fee permit client type 

  Scenario: CV Client does not have a special authorization designation
    Given a CV Client is viewing their profile information
      And they have not been designated for "No Fee Permits"
     When they choose to view "Special Authorizations"
     Then they do not see the no fee permits section

@orv2-1050-6
Rule: CV Client cannot view the special authorizations tab if there are no active special authorizations

  Scenario: CV Client does not have any special authorization designations
    Given a CV Client is viewing their profile information
     When they have not been designated with any special authorizations
     Then they do not see the special authorizations tab