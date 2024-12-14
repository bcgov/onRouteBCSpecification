Feature: Staff Manage Expired Permit List
   As a PPC SA or PC I need to be able to view a list of Expired permits so that I can complete actions on them and keep track of issued and Expired permits on behalf of CV Clients.

@orv2-1651-1
Rule: Staff can view all Expired permits

  Scenario: Default Expired permits listed
    Given Staff is at the "Permits" page
     When they choose to view "Expired Permits"
     Then they see issued permits that have have reached their expiry date 
      And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

  Scenario: Expired permit information displayed
    Given Staff is at the "Permits" page
     When they choose to view "Expired Permits"
     Then they see columns
        | Permit #          |
        | Permit Type       |
        | Unit #            |
        | Plate             |
        | Permit Start Date |
        | Permit End Date   |
        | Issued By         |
     And the default sort order is "Permit Start Date" newest at the top ascending

  Scenario: No Expired permits
    Given Staff is at the "Permits" page
      And there are no Expired permits 
     When they choose to view "Expired Permits"
     Then they see "No records found."

@orv2-3072-4
Rule: Issued by is the user that adds the permit application to the cart

  Scenario: staff add to cart
     When staff view expired permits list
     Then issued by is IDIR username

  Scenario: cv client add to cart
     When staff view expired permits list
     Then issued by is logged in user first name last name

@orv2-1651-2
Rule: Staff can view the permit and permit payment receipt pdf

  Scenario: View receipt pdf
    Given Staff is at the "Expired Permits" tab
      And there are Expired permits 
     When they choose to view a receipt
     Then they see the chosen permit payment receipt pdf in a new browser tab

 Scenario: View permit pdf
     Given the CV Client is at the "Expired Permits" tab
       And there are Expired permits 
      When they choose to view the permit
      Then they see the permit pdf in a new browser tab