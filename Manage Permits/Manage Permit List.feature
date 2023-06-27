Feature: Manage Active Permit List
   As a CV Client I need to be able to view a list of my active permits so that I can complete actions on them and keep track of my issued and active permits.

@orv2-950
Rule: CV Clients PA and SA can view active permits if any exist and see relevant information about them

@orv2-950-1
  Scenario: Default active permits listed
    Given the CV Client is at the "Permits" page
     When they choose to view "Active Permits"
     Then they see issued permits that have been issued and have not reached their expiry date 
      And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

@orv2-950-2
  Scenario: Active permit information displayed
    Given the CV Client is at the "Permits" page
     When they choose to view "Active Permits"
     Then they see columns
        | Permit #          |
        | Permit Type       |
        | Unit #            |
        | Plate             |
        | Permit Start Date |
        | Permit End Date   |
        | Applicant         |
     And "Applicant" is the first name and last name of the CV Client user that submitted the permit application
     And they see "Refunds and amendments can be requested over the phone by calling the Provincial Permit Centre at Toll-free: 1-800-559-9688. Please have your permit number ready."

@orv2-950-3
  Scenario: No active permits
    Given the CV Client is at the "Permits" page
      And there are no active permits 
     When they choose to view "Active Permits"
     Then they see "No records found."

@orv2-951
Rule: CV Clients PA and SA can vie the permit and permit payment receipt pdf

@orv2-951-1
  Scenario: View receipt pdf
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view the receipt
     Then they see the permit payment receipt pdf in a new browser tab

@orv2-951-2
Scenario: View permit pdf
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view the permit
     Then they see the permit pdf in a new browser tab

@orv2-952
Rule: CV Clients PA and SA can search for active permits by unit # and plate number

@orv2-952-1
  Scenario: Search by unit #
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view receipt
     Then they see the permit payment receipt in a new browser tab

  Scenario: Search vehicle inventory by 
    Given a CV Client is at their vehicle inventory
    And they view either Power Units or Trailers
    When they choose to <search>
    And they enter a <parameter>
    Then <displayed> vehicles are shown

   Examples:
     | search       | parameter | displayed                                                |
     | Unit Number  | 12345     | all vehicles with Unit Number 12345                      |
     
@orv2-951-2
  Scenario: Search by unit #
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view receipt
     Then they see the permit payment receipt in a new browser tab



@orv2-953
Rule: CV Clients PA and SA can sort the list of actice permits

  Scenario: View receipt
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view receipt
     Then they see the permit payment receipt in a new browser tab
        


