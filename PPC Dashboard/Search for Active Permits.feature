Feature: Search for active permits
   As a PPC Clerk I want to search for a CV Client active permit so that I can amend it and reissue a revised legal permit.

@orv2-937-1
  Scenario: Search by permit number
    Given a PPC Clerk has chosen to search by permit number
     When they search by the <permit number> using 8 characters of the permit
     Then they see permit <results> with the 8 characters used in the search

  Examples:
   | Permit number | Results             |
   | 82364275      | P1-82364275-175-A01 |
   | 37982658      | P1-37982658-946-A01 |
   | P1-37982      | P1-37982658-946-A01 |
   | 5-175-A0      | P1-82364275-175-A01 |


@orv2-937-2
  Scenario: Default to search by permit number
    Given the PPC Clerk is at the global search page
     When they choose to search 
     Then they seach "Search By" defaulted to "Permit Number"

@orv2-937-3 
  Scenario: Active Permit search result data
    Given a PPC Clerk has chosen to search by permit number
     When they initiate the search
     Then they see the following <columns>
      And the they see data from the  <permit source>

  Examples:
        | Permit #          |
        | Permit Type       |
        | Plate             |
        | Company Name      |
        | Permit Start Date |
        | Permit End Date   |
        | Issue Date        |

@orv2-937-4
  Scenario: 
    Given 
     When 
     Then 

@orv2-937-5
  Scenario: 
    Given 
     When 
     Then 

@orv2-937-6
  Scenario: 
    Given 
     When 
     Then 

@orv2-937-7
  Scenario: 
    Given 
     When 
     Then 

@orv2-937-8
  Scenario: 
    Given 
     When 
     Then 
     
@orv2-937-9
  Scenario: 
    Given 
     When 
     Then 

@orv2-937-10
  Scenario: 
    Given 
     When 
     Then                                    