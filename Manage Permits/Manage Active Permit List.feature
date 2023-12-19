Feature: Manage Active Permit List
   As a CV Client I need to be able to view a list of my Active permits so that I can complete actions on them and keep track of my issued and Active permits.

@orv2-950
Rule: CV Clients PA and SA can view Active permits if any exist and see relevant information about them, CV Client PA can only view permits they created
@orv2-950-1
  Scenario: Default Active permits listed
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
     And the default sort order is "Permit Start Date" in reverse chronological order
     And CV Client PA only see permits they created
     And "Applicant" is the first name and last name of the CV Client user that submitted the permit application
     And they see "Refunds and amendments can be requested over the phone by calling the Provincial Permit Centre at Toll-free: 1-800-559-9688. Please have your permit number ready."

@orv2-950-3
  Scenario: No active permits
    Given the CV Client is at the "Permits" page
      And there are no active permits 
     When they choose to view "Active Permits"
     Then they see "No records found."

@orv2-951
Rule: CV Clients PA and SA can view the permit and permit payment receipt pdf
@orv2-951-1
  Scenario: View receipt pdf
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view a receipt
     Then they see the choosen permit payment receipt pdf in a new browser tab

@orv2-951-2
Scenario: View permit pdf
    Given the CV Client is at the "Active Permits" tab
      And there are active permits 
     When they choose to view the permit
     Then they see the permit pdf in a new browser tab

@orv2-952
Rule: CV Clients PA and SA can search for active permits by unit # and plate
@orv2-952-1
  Scenario: Search by unit #
    Given the CV Client has active permits that have a vehicle with a unit number
     When they choose to search by <parameter>
     Then <displayed> permits are shown

   Examples:
     | parameter | displayed                          |
     | 12345     | all permits with Unit Number 12345 |
     | 123       | all permits with Unit Number 12345 |
     | 1         | all permits with Unit Number 12345 | 

@orv2-952-2
  Scenario: Search by unit # no unit #
    Given the CV Client has active permits that have a vehicle without unit number
     When they choose to search by unit #
     Then they see "No records found" 

@orv2-952-3
  Scenario: Search by plate
    Given the CV Client has active permits
     When they choose to search by <parameter>
     Then <displayed> permits are shown

   Examples:
     | parameter | displayed                     |
     | A12345    | all permits with plate A12345 |
     | A123      | all permits with plate A12345 |
     | A         | all permits with plate A12345 |

@orv2-953
Rule: CV Clients PA and SA can sort the list of active permits
 Scenario: Sort list of active permits
     Given the CV Client chooses to sort by a specific column
     When they select any of the following column headers:
         | Permit #          |
         | Permit Type       |
         | Unit #            |
         | Plate             |
         | Permit Start Date |
         | Permit End Date   |
         | Applicant         |
     Then the list is sorted by the selected column header
     And the sort order is the reverse of the previously selected order
        


