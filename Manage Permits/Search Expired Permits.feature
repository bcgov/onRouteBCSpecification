Feature: Search or Sort Expired Permits

@orv2-1008-0 @orv2-1651-3
Rule: Users can search for Expired permits using unit # and plate

  Scenario: Search using unit #
    Given the CV Client has Expired permits that have a vehicle with a unit number
     When they choose to search using <parameter>
     Then <displayed> expired permits are shown

   Examples:
     | parameter | displayed                          |
     | 12345     | all expired permits with Unit Number 12345 |
     | 123       | all expired permits with Unit Number 12345 |

  Scenario: Search using unit # no unit #
    Given the CV Client has Expired permits that have a vehicle without unit number
     When they choose to search using unit #
     Then they see "No records found" 

  Scenario: Search using plate
    Given the CV Client has Expired permits
     When they choose to search using <parameter>
     Then <displayed> expired permits are shown

   Examples:
     | parameter | displayed                     |
     | A12345    | all expired permits with plate A12345 |
     | A123      | all expired permits with plate A12345 |

  Scenario: Search using plate no plate exists
    Given the CV Client has Expired Permits
      And the plate does not exist in their inventory
     When they choose to search using plate
     Then they see "No records found" 

@orv2-1009 @orv2-1651-4
Rule: Users can sort the list of expired permits

 Scenario: Sort list of Expired permits
     Given the CV Client chooses to sort using a specific column
     When they select any of the following column headers:
         | Permit #          |
         | Permit Type       |
         | Unit #            |
         | Plate             |
         | Permit Start Date |
         | Permit End Date   |
         | Issued By       |
     Then the list is sorted using the selected column header
     And the sort order is the reverse of the previously selected order