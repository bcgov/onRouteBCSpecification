Feature: Staff search for company
   As a PPC SA or PC and EO I want to search for a CV Client so that I can access their profile.

@orv2-1362-1
Rule: The entered search parameter is displayed after initiating a search
@orv2-1362-2
Rule: Search by defaults to company name

  Scenario: Default to search by company name
    Given the PPC SA, PC, EO is at the global search page
     When they choose to search 
     Then they see "Search By" defaulted to "Company Name"

@orv2-1362-5
Rule: PPC SA or PC and EO can search for a company using a minimum 4 characters in company name

  Scenario: Company exists 
    Given a PPC SA, PC, EO has chosen to search by company name
     When they search by company name using 4 characters
      And they search for "Band"
     Then they see results that include "Band" in the first 4 characters of company name
      And the following related results are shown
        | Bander Transport |
        | Bandam Trucking  |
        | Band Inc.        |
      But the results do not include "Truck Band"

 @orv2-1362-15
Rule: PPC SA or PC and EO search by company name also searches doing business as 

  Scenario: Company has a doing business as name
    Given a PPC SA, PC, EO has chosen to search by company name
     When they search by company name using 4 characters
      And they search for "Juli"
     Then they see results that include "Juli" in the first 4 characters of doing business as
      And the following related results are shown
        | Juliette Transport |
        | Julily Trucking    |
        | Julies Inc.        |
      But the results do not include "Truck Julie"

@orv2-1362-16
Rule: Indicate if no records are found and provide option to create company only to PPC SA or PC

  Scenario: Company does not exist 
    Given a PPC SA, PC has chosen to search by company name
     When they search by the company name using 4 characters
      And they search for "Band"
     Then they see "No records found"
      And the option to create a company

@orv2-1362-1
Rule: PPC SA or PC and EO can search for a company using a minimum 9 characters in client number

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
Rule: PPC SA or PC and EO can search by client number also searches legacy number

  Scenario: Both onRouteBC client number and legacy client number exists
    Given a PPC SA, PC or EO has chosen to search by client number
     When they search by the using 9 characters of the <client number>
     Then they see company <results> that have the first 9 characters matching in legacy number

  Examples:
   | description                   | client number | results                      |
   | using onRouteBC client number | 818745927     | 81-874592-765 and 2018-24432 |
   | using legacy client number    | 201824432     | 81-874592-765 and 2018-24432 |


@orv2-1362-3 
Rule: PPC SA or PC and EO can view company profile summary information in results 

  Scenario: Company result includes all data elements possible to display in results
    Given a PPC SA, PC, EO has chosen to search for a company
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
     Then the "Dosing Business As (DBA)" header is not shown

  Scenario: Legacy client number does not exist
    Given search results include companies that do not have a legacy client number
     When the results are shown
     Then the "Legacy" header is not shown

  Scenario: Show truncated text on hover
    Given a PPC SA, PC, EO is at the search results
     When they hover over truncated text
     Then they see the entire text line

@orv2-1362-8
Rule: Only PPC SA or PC can optionally view company profile

  Scenario: PPC SA or PC choose to view company profile
    Given a PPC SA or PC has found a company of interest
     When they choose to view the company profile
     Then they are directed to the company permits page applications in progress tab

  Scenario: EO chooses to view company profile
    Given an EO has found a company of interest
     When they choose to view the company profile
     Then they are unable to 
      And the option is not available

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