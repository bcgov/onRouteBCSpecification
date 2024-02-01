Feature: Manage Active Permit List
   As a CV Client I need to be able to view a list of my Active permits so that I can complete actions on them and keep track of my issued and Active permits.


@orv2-950-0 @orv2-1650-0
Rule: CV Clients PA and CA can view Active permits if any exist and see relevant information about them, CV Client PA can only view permits they created view permit pdfs

  Scenario: Default Active permits listed
    Given the CV Client is at the "Permits" page
     When they choose to view "Active Permits"
     Then they see issued permits that have been issued and have not reached their expiry date 
      And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

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
     And the default sort order is "Permit Start Date" in reverse chronological order
     And CV Client PA only see permits they created
     And Applicant is the first name and last name of the CV Client user that issued the permit or Provincial Permit Center if issued by the PPC
     And they see "Refunds and amendments can be requested over the phone by calling the Provincial Permit Centre at Toll-free: 1-800-559-9688. Please have your permit number ready."

  Scenario: No active permits
    Given the CV Client is at the "Permits" page
      And there are no active permits 
     When they choose to view "Active Permits"
     Then they see "No records found."

@orv2-951-0
Rule: CV Clients PA and SA can view the permit and permit payment receipt pdf

 Scenario: View receipt pdf
   Given the CV Client is at the "Active Permits" tab
     And there are active permits 
    When they choose to view a receipt
    Then they see the choosen permit payment receipt pdf in a new browser tab

 Scenario: View permit pdf
     Given the CV Client is at the "Active Permits" tab
       And there are active permits 
      When they choose to view the permit
      Then they see the permit pdf in a new browser tab


        


