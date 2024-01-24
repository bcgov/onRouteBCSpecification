Feature: Main Header Information

Rule: Header always displays the company name for CV Client

Rule: Header displays the company name for staff when viewing/editing their profile

  Scenario: Viewing company information
    Given Staff are at company search results
     When they choose to view a CV Client profile 
     Then they see the chosen CV Client company name in the main header

