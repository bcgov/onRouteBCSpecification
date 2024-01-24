Feature: Staff Manage Expired Permit List
   As a PPC SA or PC I need to be able to view a list of Expired permits so that I can complete actions on them and keep track of issued and Expired permits on behalf of CV Clients.

@orv2-1653
Rule: Staff can view all Expired permits

  Scenario: Default Expired permits listed
    Given the CV Client is at the "Permits" page
     When they choose to view "Expired Permits"
     Then they see issued permits that have have reached their expiry date 
      And the expiry date is at 11:59:59pm (based on the permit start date + duration (days) - 1)

@orv2-1653-2
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
        | Applicant         |
     And the default sort order is "Permit Start Date" newest at the top
     And CV Client PA only see permits they created
     And "Applicant" is the first name and last name of the CV Client user that submitted the permit application
     And they see "Refunds and amendments can be requested over the phone using calling the Provincial Permit Centre at Toll-free: 1-800-559-9688. Please have your permit number ready."

@orv2-1653-3
  Scenario: No Expired permits
    Given the CV Client is at the "Permits" page
      And there are no Expired permits 
     When they choose to view "Expired Permits"
     Then they see "No records found."

@orv2-1007
Rule: CV Clients PA and SA can view the permit and permit payment receipt pdf

@orv2-1007-1
  Scenario: View receipt pdf
    Given the CV Client is at the "Expired Permits" tab
      And there are Expired permits 
     When they choose to view a receipt
     Then they see the choosen permit payment receipt pdf in a new browser tab

@orv2-1007-2
Scenario: View permit pdf
    Given the CV Client is at the "Expired Permits" tab
      And there are Expired permits 
     When they choose to view the permit
     Then they see the permit pdf in a new browser tab

@orv2-1008
Rule: CV Clients PA and SA can search for Expired permits using unit # and plate

@orv2-1008-1
  Scenario: Search using unit #
    Given the CV Client has Expired permits that have a vehicle with a unit number
     When they choose to search using <parameter>
     Then <displayed> expired permits are shown

   Examples:
     | parameter | displayed                          |
     | 12345     | all expired permits with Unit Number 12345 |
     | 123       | all expired permits with Unit Number 12345 |

@orv2-1008-2
  Scenario: Search using unit # no unit #
    Given the CV Client has Expired permits that have a vehicle without unit number
     When they choose to search using unit #
     Then they see "No records found" 

@orv2-1008-3
  Scenario: Search using plate
    Given the CV Client has Expired permits
     When they choose to search using <parameter>
     Then <displayed> expired permits are shown

   Examples:
     | parameter | displayed                     |
     | A12345    | all expired permits with plate A12345 |
     | A123      | all expired permits with plate A12345 |

@orv2-1008-4
  Scenario: Search using plate no plate exists
    Given the CV Client has Expired Permits
      And the plate does not exist in their inventory
     When they choose to search using plate
     Then they see "No records found" 

@orv2-1009
Rule: CV Clients PA and SA can sort the list of expired permits

Scenario: Sort list of Expired permits
    Given the CV Client chooses to sort using a specific column
    When they select any of the following column headers:
        | Permit #          |
        | Permit Type       |
        | Unit #            |
        | Plate             |
        | Permit Start Date |
        | Permit End Date   |
        | Applicant         |
    Then the list is sorted using the selected column header
    And the sort order is the reverse of the previously selected order
        


