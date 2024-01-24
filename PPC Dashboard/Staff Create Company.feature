Feature: Staff create company
   As a PPC SA or PC I need to create a new onRouteBC profile for a CV Client so that I can purchase permits on their behalf or they can claim their account and purchase on their own.

Background: @orv2-1362-16

@orv2-1521-1
Rule: All fields are empty
@orv2-1521-2
Rule: All fields are updatable
@orv2-1521-3
Rule: There are mandatory fields
@orv2-1521-4
Rule: Staff can cancel create company

 Scenario: Cancel create "Company Information"
     Given Staff is editing "Company Information"
     When they select "Cancel"
     Then the changes are not saved 
     And they are directed to the welcome to onRouteBC page

@orv2-1521-5
Rule: Show success page when save is successful
@orv2-1521-6
Rule: Generate a unique client ID when save is successful
@orv2-1521-7
Rule: Send onRouteBC profile creation notification to CV Client
@orv2-1521-8
Rule: Staff can optionally apply for a permit at success page
@orv2-1521-9
Rule: Staff can optionally view the CV Client profile at success page

TPS migrated CV Client profile not yet claimed by CV Client or completed by staff need to suspend company

Search for Company
Choose company
Directed to company information to complete information







