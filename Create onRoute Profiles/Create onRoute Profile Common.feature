Feature: Common features for profile creation workflows

User = CV Client

@orv2-3322
Rule: The navigation bar is not visible to users until the profile has been successfully claimed

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following steps:
       | steps |
       | welcome to onroutebc - claim profile or not choice |
       | verify profile | 
       | company information |
       | my information |
     Then the navigation bar is not visible

@orv2-481-11
Rule: A user can cancel or step backwards

  Scenario: Cancel
    Given they have chosen to claim a onRouteBC profile
     When they choose to cancel
     Then they are directed to welcome to onRouteBC

  Scenario: Previous
     When they choose to return to a previous page
     Then they are directed to the previous page in the workflow

@orv2-369-9, @orv2-3322
Rule: contact details are not saved until the workflow is finished

 Scenario: CV Client Business BCeID navigates away from create new onRouteBC profile workflow
     Given they are at "Company Information" or "My Information" in the workflow
     When they navigate away from the page
     Then the onRouteBC account is not created
      And no information is saved

  Scenario: CV Client Business BCeID user added to a company profile first time sign in accept add to onRouteBC profile
      Given the CV Client Business BCeID user is at the invitation welcome page
      When they accept the invitation
      Then they are directed to the "My Information" page in the workflow
      And they are removed from the "Pending User" list of the company that added them
      And they are designated as an "Active User" 

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page





@orv2-907-4, @orv2-3322
Rule: a new PA user can only view company profile information

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to view their profile
      Then they are directed to company information
       But they cannot edit company information

@orv2-907-5, @orv2-3322
Rule: a new user can apply for a permit

 Scenario: choose to apply for permit
     Given the user has completed their profile creation
      When they choose to apply for a permit
      Then they are directed to applications in progress