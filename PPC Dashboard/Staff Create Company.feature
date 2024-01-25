Feature: Staff create company
   As a PPC SA or PC I need to create a new onRouteBC profile for a CV Client so that I can purchase permits on their behalf or they can claim their account and purchase on their own.

Background: @orv2-1362-16

@orv2-1521-1
Rule: All fields are empty
@orv2-1521-2
Rule: All fields are updatable
 #see orv2-1587-2

@orv2-1521-3
Rule: There are mandatory fields
 #see orv2-1587-3

@orv2-1521-4
Rule: Staff can cancel create company

 Scenario: Cancel create "Company Information"
     Given Staff is editing "Company Information"
     When they select "Cancel"
     Then the changes are not saved 
     And they are directed to the welcome to onRouteBC page

@orv2-1521-5
Rule: Show success page when save is successful

  Scenario: Completed mandatory fields
    Given staff have completed the "Create Company" page
     When they continue
     Then they are directed to the success page
      And they see the onRouteBC Client Number
      And they see options to apply for a permit and view the profile

@orv2-1521-6
Rule: Generate a unique client ID when save is successful
@orv2-1521-7
Rule: Send onRouteBC profile creation notification to CV Client
@orv2-1521-8
Rule: Staff can optionally apply for a permit at success page
@orv2-1521-9
Rule: Staff can optionally view the CV Client profile at success page
@orv2-1521-10
Rule: Staff can create a new onRouteBC profile

  Scenario: New company 
    Given Staff have not found the company in onRouteBC
     When they choose to create a new profile
     Then they are directed to "Create Company"

@orv2-1521-11
Rule: Staff must complete a TPS migrated company profile  that has not been claimed or completed by staff

  Scenario: TPS migrated CV Client profile not yet claimed by CV Client or completed by staff
    Given staff find a company at search for company
     When they choose to view its profile
     Then they are directed to "Company Information" 







