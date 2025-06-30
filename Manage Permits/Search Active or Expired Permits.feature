Feature: Search or Sort Expired Permits

@orv2-1008-0 @orv2-1651-3 @orv2-952-0 @orv2-1650-1
Rule: Users can search for permits using unit # and plate

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

@orv2-4655-1
Rule: users can search for permit using 1 or more characters of the permit number with or without spaces or hyphens

  Scenario: hyphens used 
     When they search by the <permit number>
     Then they see permit <results> with the characters used in the search in the order entered
      And all permit <statuses> can be displayed if found

  Examples:
   | Permit number | Results             | statuses |
   | P1-82364275   | P1-82364275-175-A01 | Issued   |
   | P1-37982658   | P1-37982658-946-A01 | Expired  |
   | P1-37982658   | P1-37982658-946-A01 | Revoked  |
   | P1-37982658   | P1-37982658-946-A01 | Voided   |
  
  Scenario: hyphens and spaces not used 
     When they search by the <permit number>
     Then they see permit <results> with the characters used in the search in the order entered
      And all permit <statuses> can be displayed if found

  Examples:
   | Permit number | Results             | statuses |
   | P182364275    | P1-82364275-175-A01 | Issued   |
   | P137982658    | P1-37982658-946-A01 | Expired  |
   | P137982658    | P1-37982658-946-A01 | Revoked  |
   | P137982658    | P1-37982658-946-A01 | Voided   |

  Scenario: spaces used 
     When they search by the <permit number> using the characters of the permit
     Then they see permit <results> with the characters used in the search in the order entered
      And all permit <statuses> can be displayed if found

  Examples:
   | Permit number | Results             | statuses |
   | P18 2364275   | P1-82364275-175-A01 | Issued   |
   | P1 37982658   | P1-37982658-946-A01 | Expired  |
   | P137982658 9  | P1-37982658-946-A01 | Revoked  |
   | P137982658 94 | P1-37982658-946-A01 | Voided   |

@orv2-4655-2
Rule: users are shown placeholder text in the search field

  Scenario: placeholder text is shown
    Given the CV Client is on the Expired Permits page
     When they view the search field
     Then they see "Search by Unit No., Plate or Permit No." as the placeholder text

@orv2-1009 @orv2-1651-4 @orv2-953-0 @orv2-1650-2
Rule: Users can sort the list of permits

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