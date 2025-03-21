Feature: Manage Active Permit List
   As a CV Client I need to be able to view a list of my Active permits so that I can complete actions on them and keep track of my issued and Active permits.

CV Client = CA, PA

@orv2-950-0 @orv2-1650-0 @orv2-3282-2
Rule: CV Clients can view the active permits list if any exist and see relevant information about them

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
        | Issued By         |
     And the default sort order is "Permit Start Date" in reverse chronological order
     And they see "Refunds and amendments can be requested over the phone by calling the Provincial Permit Centre at Toll-free: 1-800-559-9688. Please have your permit number ready."

  Scenario: No active permits
    Given the CV Client is at the "Permits" page
      And there are no active permits 
     When they choose to view "Active Permits"
     Then they see "No records found."

@orv2-3282-4
Rule: CV Client can see staff issued active permits 

@orv2-3072-5
Rule: Issued by is the user that adds the permit application to the cart

  Scenario: staff add to cart
     When cv client view active permits
     Then issued by is Provincial Permit Center

  Scenario: cv client add to cart
     When cv client view active permits
     Then issued by is logged in user first name last name

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





        


