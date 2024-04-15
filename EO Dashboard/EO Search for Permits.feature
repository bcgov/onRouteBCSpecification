Feature: Enforcement Officer search for permits
   As an Enforcement Officer I need to find and view issued permits so that I can verify information about CV Clients I engage with on a daily basis.

@orv2-1086-1
Rule: Staff can search for a permit using 
Scenario: Search by permit number
    Given a EO has chosen to search by permit number
     When they search by the <permit number> using the first 11 characters of the permit
     Then they see permit <results> with the first 11 characters used in the search
      And all permit <statuses> are displayed if found

  Examples:
   | Permit number | Results             | statuses |
   | P1-82364275   | P1-82364275-175-A01 | Issued   |
   | P1-37982658   | P1-37982658-946-A01 | Expired  |
   | P1-37982658   | P1-37982658-946-A01 | Revoked  |
   | P1-37982658   | P1-37982658-946-A01 | Voided   |

@orv2-1086-2
  Scenario: Default to search by permit number
    Given the EO is at the global search page
     When they choose to search 
     Then they see "Search By" defaulted to "Permit Number"

@orv2-1086-3 
  Scenario: Permit search result data
    Given a EO has chosen to search by permit number
     When they initiate the search
     Then they see the following <columns>
      And the they see data from the  <permit source>
      And the default sort order is "Issue Date" newest at the top

  Examples:
    | Columns           | Permit source                                                         |
    | Permit #          | The unique generated permit number at the time of issuance            |
    | Permit Type       | The permit type name                                                  |
    | Plate             | The plate of the vehicle permitted                                    |
    | Company Name      | The company name the permit was issued to                             |
    | Permit Start Date | The start date the permit submitted at application                    |
    | Permit End Date   | The calculated expiry date based on the term submitted at application |
    | Issue Date        | The date the permit was issued                                        |

@orv2-1086-4
  Scenario: Show truncated text on hover
    Given a EO is at the search results
     When they hover over truncated text
     Then they see the entire text line

@orv2-1086-5
  Scenario: Search for permit by plate number
    Given a EO has chosen to search by plate number
     When they search by the <plate number> using the exact plate number
     Then they see permit <results> with only the exact characters used in the search
      And all permit <statuses> can be displayed if found

  Examples:
   | plate number | Results   | statuses | label details |
   | Bob24        | Bob24     | Issued   | not displayed |
   | Bob234567    | Bob234567 | Expired  | displayed     |
   | A-12345      | A-12345   | Revoked  | displayed     |
   | A-123-123    | A-123-123 | Voided   | displayed     |

@orv2-1086-6
  Scenario: Show only active permits
    Given a EO is at the search results
     When they choose to show only active permits
     Then only permits that have an end date and time on or before the current date and time are displayed

@orv2-1086-7
  Scenario: View Permit PDF
    Given a EO is at the search results
     When they chose to view the permit pdf
     Then the permit pdf is displayed in a new browser tab

# @orv2-1086-11
  Scenario: View Reciept PDF
    Given a EO is at the search results
     When they choose to view the receipt pdf
     Then the receipt pdf is displayed in a new browser tab

# @orv2-1086-8
  Scenario: Show Actions
    Given a EO is at the search results
      And the <actions> are:
      | View Receipt |
     When they chose to perform an action on a permit
     Then they see only valid <actions> for each permit <status>

  Examples:
    | actions      | status                   |
    | View Receipt | active or expired permit |
     
@orv2-1086-9
  Scenario: Sort search results
    Given a EO is at search results
     When they select any of the following column headers:
      | Permit Type       |
      | Permit Number     |
      | Plate             |
      | Company Name      |
      | Permit Start Date |
      | Permit End Date   |
      | Issued Date       |
     Then the list is sorted by the selected column header
      And the sort order is the reverse of the previously selected order


