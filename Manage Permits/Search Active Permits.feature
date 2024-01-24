Feature Search for active permits

@orv2-952-0 @orv2-1650-1
Rule: Users can search for active permits by unit # and plate

 Scenario: Search by unit #
   Given the CV Client has active permits that have a vehicle with a unit number
    When they choose to search by <parameter>
    Then <displayed> permits are shown

  Examples:
    | parameter | displayed                          |
    | 12345     | all permits with Unit Number 12345 |
    | 123       | all permits with Unit Number 12345 |
    | 1         | all permits with Unit Number 12345 | 

 Scenario: Search by unit # no unit #
   Given the CV Client has active permits that have a vehicle without unit number
    When they choose to search by unit #
    Then they see "No records found" 

 Scenario: Search by plate
   Given the CV Client has active permits
    When they choose to search by <parameter>
    Then <displayed> permits are shown

   Examples:
     | parameter | displayed                     |
     | A12345    | all permits with plate A12345 |
     | A123      | all permits with plate A12345 |
     | A         | all permits with plate A12345 |

@orv2-953-0 @orv2-1650-2
Rule: Users can sort the list of active permits

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