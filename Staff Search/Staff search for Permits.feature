Feature: Search for permits
   As a PPC SA and PC I want to search for a CV Client permit so that I can perform actions to permits to assist CV Clients.

Staff = SA, PC, EO

@orv2-937-1
  Scenario: Search by permit number
    Given staff has chosen to search by permit number
     When they search by the <permit number> using the first 11 characters of the permit
     Then they see permit <results> with the first 11 characters used in the search
      And all permit <statuses> can be displayed if found

  Examples:
   | Permit number | Results             | statuses |
   | P1-82364275   | P1-82364275-175-A01 | Issued   |
   | P1-37982658   | P1-37982658-946-A01 | Expired  |
   | P1-37982658   | P1-37982658-946-A01 | Revoked  |
   | P1-37982658   | P1-37982658-946-A01 | Voided   |
  
@orv2-937-13
  Scenario: No results found
    Given staff has chosen to search for a permit
     When they initiate a search 
      And there are no results found
     Then they see "No results found"

@orv2-937-2
  Scenario: Default to search by permit number
    Given a PC is at the global search page
     When they choose to search 
     Then they see "Search By" defaulted to "Permit Number"

@orv2-937-3 
  Scenario: Permit search result data
    Given a PC has chosen to search by permit number
     When they initiate the search
     Then they see the following <columns>
      And the they see data from the  <permit source>
      And permits that are expired are indicated
      And the default sort order is "Issue Date" newest at the top

  Examples:
    | Columns           | Permit source                                                                          |
    | Permit #          | The unique generated permit number at the time of issuance                             |
    | Permit Type       | The permit type name                                                                   |
    | Commodity         | For Term permits this would be NA, will be used with known commodity permits e.g. STOS |
    | Plate             | The plate of the vehicle permitted                                                     |
    | Company Name      | The company name the permit was issued to                                              |
    | Permit Start Date | The start date of the permit submitted at application                                  |
    | Permit End Date   | The calculated expiry date based on the term submitted at application                  |
    | Issue Date        | The date the permit was issued                                                         |

@orv2-937-4
  Scenario: Show truncated text on hover
    Given a PC is at the search results
     When they hover over truncated text
     Then they see the entire text line

@orv2-937-5
  Scenario: Search for permit by plate number
    Given a PC has chosen to search by plate number
     When they search by the <plate number> using the exact plate number
     Then they see permit <results> with only the exact characters used in the search
      And all permit <statuses> can be displayed if found

  Examples:
   | plate number | Results   | statuses | label details |
   | Bob24        | Bob24     | Issued   | not displayed |
   | Bob234567    | Bob234567 | Expired  | displayed     |
   | A-12345      | A-12345   | Revoked  | displayed     |
   | A-123-123    | A-123-123 | Voided   | displayed     |

@orv2-937-6
  Scenario: Show only active permits
    Given staff is at the search results
     When they choose to show only active permits
     Then only permits that have an end date and time on or before the current date and time are displayed

@orv2-937-7
  Scenario: View Permit PDF
    Given staff is at the search results
     When they chose to view the permit pdf
     Then the permit pdf is displayed in a new browser tab

@orv2-937-11
  Scenario: View Receipt PDF
    Given staff is at the search results
     When they chose to view the receipt pdf
     Then the receipt pdf is displayed in a new browser tab

@orv2-937-8
  Scenario: Show Actions
    Given a PC is at the search results
      And the <actions> are:
      | Amend |
      | View Receipt |
      | Resend |
     When they chose to perform an action on a permit
     Then they see only valid <actions> for each permit <status>

  Examples:
    | actions      | status                                      |
    | Amend        | active permit                               |
    | View Receipt | active, superseded, void and expired permit |
    | Resend       | active, superseded, void and expired permit |
    | Void/Revoke  | issued and active permit                    |
     
@orv2-937-9
  Scenario: Sort search results
    Given a PC is at search results
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

@orv2-937-15
Rule: permits results display status labels based on their current state

  Scenario Outline: Display permit status labels
    Given staff are as search for permit
     When they search for a permit 
     Then it shows the correct <permit status> based on the <permit state>

     Examples:
     | permit state | permit status |
     | Voided       | Voided        |
     | Expired      | Expired       |
     | Superseded   | Superseded    |
     | Issued       |               |
     | Active       |               |

@orv2-937-12
Rule: SA, PC can resend the permit and receipt pdf's

   Scenario: Resend active permit and receipt documents
    Given a SA or PC is at "Resend Permit and Receipt"
     When they chose to resend
     Then the permit pdf and permit receipt pdf are sent to the contact details submitted at resend permit and receipt
      And they are directed to the "Search Results" page
      And they see "Successfully Sent"

@orv2-937-10
Rule: SA, PC can see original permit application contact details when resending permit and receipt pdf

  Scenario: permit application email
    Given a permit applicant submitted abc@email.com in additional email
     When staff choose to resend a permit or permit payment receipt pdf 
     Then they see abc@email.com

@orv2-937-14
Rule: SA, PC can update resend contact details

  Scenario: no email 
    Given a valid email address is not entered
     When staff choose to resend
     Then they see "This is a required field"
      And and the required field is indicated

Rule: SA, PC  can choose to send either the permit pdf or permit payment pdf or both

  Scenario: choose none
    Given 
     When 
     Then 

  Scenario: choose permit
    Given 
     When 
     Then 

  Scenario: choose receipt
    Given 
     When 
     Then 

  Scenario: choose permit and reciept
    Given 
     When 
     Then 

