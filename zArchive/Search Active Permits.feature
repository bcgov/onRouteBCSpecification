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
         | Issued By      |
     Then the list is sorted by the selected column header
     And the sort order is the reverse of the previously selected order

 