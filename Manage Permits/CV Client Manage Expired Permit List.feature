Feature: Manage Expired Permit List
   As a CV Client I need to be able to view a list of my Expired permits so that I can complete actions on them and keep track of my issued and Expired permits.

CV Client = CA, PA

@orv2-995-0 @orv2-1651-5 @orv2-3282-1
Rule: CV Client can view Expired permits if any exist and see relevant information about them

  Scenario: Default Expired permits listed
    Given the CV Client is at the "Permits" page
     When they choose to view "Expired Permits"
     Then they see issued permits that have have reached their expiry date 
      And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

  Scenario: Expired permit information displayed
    Given the CV Client is at the "Permits" page
     When they choose to view "Expired Permits"
     Then they see columns
        | Permit #          |
        | Permit Type       |
        | Unit #            |
        | Plate             |
        | Permit Start Date |
        | Permit End Date   |
        | Issued By         |
     And the default sort order is "Permit Start Date" newest at the top

  Scenario: No Expired permits
    Given the CV Client is at the "Permits" page
      And there are no Expired permits 
     When they choose to view "Expired Permits"
     Then they see "No records found."

@orv2-3282-3
Rule: CV Client can see staff issued expired permits 

@orv2-3072-3
Rule: Issued by is the user that adds the permit application to the cart

  Scenario: staff add to cart
     When cv client view expired permits list
     Then issued by is Provincial Permit Center

  Scenario: cv client add to cart
     When cv client view expired permits list
     Then issued by is logged in user first name last name

@orv2-1007-1
Rule: CV Client can view the permit and permit payment receipt pdf

  Scenario: View receipt pdf
    Given the CV Client is at the "Expired Permits" tab
      And there are Expired permits 
     When they choose to view a receipt
     Then they see the choosen permit payment receipt pdf in a new browser tab

 Scenario: View permit pdf
     Given the CV Client is at the "Expired Permits" tab
       And there are Expired permits 
      When they choose to view the permit
      Then they see the permit pdf in a new browser tab

@orv2-4992-2  
Rule: a void permit shows a void label

  Scenario: View void permit
    Given CV Client is at the "Expired Permits" tab
      And there are void permits 
     When they choose to view a void permit
     Then they see "V" (Void) label on the permit

@orv2-4992-3
Rule: a revoked permit shows a revoked label

  Scenario: View revoked permit
    Given CV Client is at the "Expired Permits" tab
      And there are revoked permits 
     When they choose to view a revoked permit
     Then they see "R" (Revoked) label on the permit