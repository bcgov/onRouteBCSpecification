Feature: Search for permits
   As a PPC Clerk I want to search for a CV Client permit so that I can amend it and reissue a revised legal permit.

@orv2-937-1
  Scenario: Search by permit number
    Given a PPC Clerk has chosen to search by permit number
     When they search by the <permit number> using the first 11 characters of the permit
     Then they see permit <results> with the first 11 characters used in the search

  Examples:
   | Permit number | Results             |
   | P1-82364275   | P1-82364275-175-A01 |
   | P1-37982658   | P1-37982658-946-A01 |
  
@orv2-937-2
  Scenario: Default to search by permit number
    Given the PPC Clerk is at the global search page
     When they choose to search 
     Then they see "Search By" defaulted to "Permit Number"

@orv2-937-3 
  Scenario: Permit search result data
    Given a PPC Clerk has chosen to search by permit number
     When they initiate the search
     Then they see the following <columns>
      And the they see data from the  <permit source>
      And permits that are expired are indicated
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

@orv2-937-4
  Scenario: Show truncated text on hover
    Given a PPC Clerk is at the search results
     When they hover over truncated text
     Then they see the entire text line

@orv2-937-5
  Scenario: Search for permit by plate number
    Given a PPC Clerk has chosen to search by plate number
     When they search by the <plate number> using first 10 characters or less
     Then they see permit <results> with the first 10 or less characters used in the search
      And hyphens or spaces are ignored

  Examples:
   | plate number | Results |
   | Bob24        | Bob24   |
   | Bob          | Bob24   |

@orv2-937-6
  Scenario: Show only active permits
    Given a PPC Clerk is at the search results
     When they choose to show only active permits
     Then only permits that have an end date and time on or before the current date and time are displayed

@orv2-937-7
  Scenario: View Permit PDF
    Given a PPC Clerk is at the search results
     When they chose to view the permit pdf
     Then the permit pdf is displayed in a new browser tab

@orv2-937-11
  Scenario: View Reciept PDF
    Given a PPC Clerk is at the search results
     When they chose to view the receipt pdf
     Then the receipt pdf is displayed in a new browser tab

@orv2-937-8
  Scenario: Show Actions
    Given a PPC Clerk is at the search results
      And the <actions> are:
      | Amend |
      | View Receipt |
      | Resend |
     When they chose to perform an action on a permit
     Then they see only valid <actions> for each permit <status>

  Examples:
    | actions      | status                   |
    | Amend        | active permit            |
    | View Receipt | active or expired permit |
    | Resend       | active or expired permit |
     
@orv2-937-9
  Scenario: Sort search results
    Given a PPC Clerk is at search results
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

@orv2-937-10
  Scenario: View resend active permit and receipt documents contact details
    Given a PPC Clerk is at search results
     When they chose to resend active permit and receipt documents
     Then they see the original permit application contact details:
        | email |
        | fax   |
      And they can update 

@orv2-937-12
   Scenario: Resend active permit and receipt documents
    Given a PPC Clerk is at "Resend Permit and Receipt"
     When they chose to resend
     Then they are directed to the "Search Results" page
      And they see "Successfully Sent"
