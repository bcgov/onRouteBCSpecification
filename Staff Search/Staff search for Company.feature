Feature: Staff search for company
   As a staff I want to search for a CV Client so that I can view details about their profile.

Staff = SA, PC, EO, CTPO, Trainee, FIN, HQA

@orv2-1362-1
Rule: The entered search parameter is displayed after initiating a search
@orv2-1362-2
Rule: Search by defaults to company name

  Scenario: Default to search by company name
    Given the PPC SA, PC, EO is at the global search page
     When they choose to search 
     Then they see "Search By" defaulted to "Company Name"

@orv2-1362-5
Rule: Staff can search for a company using a minimum 4 characters in company name

  Scenario: Company exists 
    Given Staff has chosen to search by company name
     When they search by company name using 4 characters
      And they search for "Band"
     Then they see results that include "Band" in the first 4 characters of company name
      And the following related results are shown
        | Bander Transport |
        | Bandam Trucking  |
        | Band Inc.        |
      But the results do not include "Truck Band"

@orv2-1362-15
Rule: Staff search by company name also searches doing business as 

  Scenario: Company has a doing business as name
    Given a PPC SA, PC, EO has chosen to search by company name
     When they search by company name using 4 characters
      And they search for "Juli"
     Then they see results that include "Juli" in the first 4 characters of doing business as
      And the following related results are shown
        | Juliette Transport |
        | Julily Trucking    |
        | Julies Inc.        |

@orv2-1362-16, @orv2-3835
Rule: Indicate if no records are found and provide option to create company only to PPC SA or PC

  Scenario: authorized staff
    Given a PPC SA, PC has chosen to search for a company
      And there are no matching records in onRouteBC
     Then they see "No records found"
      And the option to create a company

  Scenario: not authorized
    Given EO has chosen to search for a company
      And there are no matching records in onRouteBC
     Then they see "No records found"
      And they do not have the option to create a company      

@orv2-1362-1
Rule: Staff can search for a company using a minimum 9 characters in client number

  Scenario: Only onRouteBC client number exists
    Given a PPC SA, PC or EO has chosen to search by client number
     When they search by <client number> using 9 characters
     Then they see company <results> that have the first 9 characters matching in <client number>

  Examples:
   | description             | client number | results       |
   | onRouteBC client number | 818745927     | 81-874592-765 |
   | onRouteBC client number | 818745927     | 81-874592-712 |
   | onRouteBC client number | 818745927     | 81-874592-709 |

@orv2-1362-14  
Rule: Staff can search using the first 9 characters of the client number

  Scenario: onRouteBC client number exists
    Given a PPC SA, PC or EO has chosen to search by client number
     When they search by the using 9 characters of the <client number>
     Then they see company <results> that have the first 9 characters matching in legathe client number

  Examples:
   | description                   | client number | results       |
   | using onRouteBC client number | 818745927     | 81-874592-765 |

@orv2-1362-4
Rule: Staff can search using the exact legacy number

  Scenario: Legacy client number exists
    Given Staff has chosen to search by legacy number
     When they search by the using all characters of the <legacy number>
     Then they see company <results> that match the legacy number
      But they do not see <results> that are not an exact match

  Examples:
   | description                     | legacy number | results |
   | using exact legacy number       | 98046         | 98046   |
   | using part of the legacy number | 980           |         |


@orv2-1362-3 
Rule: Staff can view company profile summary information in results 

  Scenario: Company result includes all data elements possible to display in results
    Given Staff has chosen to search for a company
     When they initiate the search
     Then they see the following information about the company:
        | Company Name                   |
        | Doing Business As (DBA)        |
        | onRouteBC Client Number        |
        | Legacy Client Number           |
        | Company Address Line 1         |
        | Company Address Line 2         |
        | Company City                   |
        | Company Country                |
        | Company Postal Code            |
        | Primary Contact First Name     |
        | Primary Contact Last Name      |
        | Primary Contact Email          |
        | Primary Contact Phone Number 1 |
        | Primary Contact Phone Number 2 |
  
  Scenario: Doing business as does not exist
    Given search results include companies that do not have a doing business as name
     When the results are shown
     Then the "Doing Business As (DBA)" header is not shown

  Scenario: Legacy client number does not exist
    Given search results include companies that do not have a legacy client number
     When the results are shown
     Then the "Legacy" header is not shown

  Scenario: Show truncated text on hover
    Given Staff is at the search results
     When they hover over truncated text
     Then they see the entire text line

@orv2-1362-8 @orv2-3835
Rule: Staff can optionally view company profile

  Scenario: Staff choose to view company profile
    Given Staff has found a company
     When they choose to view the company profile
     Then they are directed to the company permits page applications in progress tab

@orv2-1362-9
Rule: Sort multiple search results

  Scenario: Sorting numbers and letters
    Given search results contain company names starting with both numbers or letters
     When they are shown 
     Then the list is sorted in ascending order
      And company names that begin with numbers come before company names that begin with letters 
        | 2345678 Inc.        |
        | 5634678 Ltd.        |
        | Abacus Inc.         |
        | Bandstra Inc.       |
        | Johns Trucking Ltd. |

@orv2-1362-11
Rule: Searching with no inputted parameter does not initiate search

@orv2-1885-1
Rule: Suspended companies are indicated in search results

  Scenario: abc co. suspended
     When staff search for abc co.
     Then they see "Suspended" label on abc co. search results

  Scenario: abc co. unsuspended
     When staff search for abc co.
     Then they see abc co. search results
      And there is no "Suspended" label on abc co.