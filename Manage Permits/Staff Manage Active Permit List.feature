Feature: Manage Active Permit List
   As PPC SA or PC I need to be able to view a list of a CV Clients Active permits so that I can complete actions on them and keep track of issued and Active permits.

Staff = PC and SA

@orv2-1650-3
Rule: Staff can view all Active permits if any exist and see relevant information about them

 Scenario: Default Active permits listed
   Given staff is at the "Permits" page
    When they choose to view "Active Permits"
    Then they see issued permits that have been issued and have not reached their expiry date 
     And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

 Scenario: Active permit information displayed
   Given staff is at the "Permits" page
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

@orv2-3072-6
Rule: Issued by is the user that adds the permit application to the cart

  Scenario: staff add to cart
     When staff view active permits
     Then issued by is IDIR username

  Scenario: cv client add to cart
     When staff view active permits
     Then issued by is logged in user first name last name

@orv2-1650-4
Rule: Staff can view the permit and permit payment receipt pdf

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

@orv2-1650-5, @orv2-2175
Rule: PPC SA can see all actions

  Scenario: PPC SA actions
    Given PPC SA chooses to complete an action on an active permit
     When they choose an action
     Then they see the following actions:
       | Amend        |
       | View Receipt |
       | Resend       |
       | Void/Revoke  |

  Scenario: PPC PC actions
    Given PPC PC chooses to complete an action on an active permit
     When they choose an action
     Then they see the following actions:
       | View Receipt |
       | Resend       |


        


