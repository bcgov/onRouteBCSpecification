Feature: CV Client create a New onRouteBC Profile
 As a CV Client Business BCeID user I want to log in to onRouteBC using my BCeID credentials so that I can create my onRouteBC Profile.

@orv2-369-1
Rule: If a BCeID user company GUID is not in onRouteBC CV Client can choose to create a new onRoute profile or claim an existing profile

 Scenario: First log in BCeID company GUID is not in onRoute
   Given they have valid BCeID credentials
    When they successfully sign in using their BCeID credentials
    Then they are directed to the "Welcome to onRouteBC" page 
     And they see their BCeID "Company Legal Name"
     And they see the option to create a new profile or claim an existing profile

@orv2-369-2
Rule: A CV Client can view and update their "Company Information" and "My Information"

 Scenario: Choose create new profile
     Given they are at the "Welcome to onRouteBC" Page
      When they choose to create a new onRouteBC Profile
      Then they are directed to the "Company Information" page in the workflow

 Scenario: Update "Company Information" and "My Information"
     Given they are at the "Company Information" in workflow
      When they input all required fields
      Then they can continue to the "My Information" page
       And they see an indication "Company Information" is complete on "My Information" page in the workflow
     
 Scenario: Complete Create new onRouteBC profile workflow
     Given they are at the "My Information" in workflow
       And they have inputted all mandatory fields
      When they choose to finish
      Then their "Company Information" and "My Information" details are saved
       And they are assigned the "Admin" role for the CV Client onRouteBC Profile 
       And they are directed to a success page
       And they get a unique onRouteBC Client Number

@orv2-369-9
Rule: Workflow "Company Information" or "My Information" is not saved until the workflow is finished

 Scenario: CV Client Business BCeID navigates away from create new onRouteBC profile workflow
     Given they are at "Company Information" or "My Information" in the workflow
     When they navigate away from the page
     Then the onRouteBC account is not created
      And no information is saved

 @orv2-369-12
  Scenario: CV Client Business BCeID user added to a company profile first time sign in accept add to onRouteBC profile
      Given the CV Client Business BCeID user is at the invitation welcome page
      When they accept the invitation
      Then they are directed to the "My Information" page in the workflow
      And they are removed from the "Pending User" list of the company that added them
      And they are designated as an "Active User" 

  @orv2-369-13
  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  @orv2-369-14
  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page


