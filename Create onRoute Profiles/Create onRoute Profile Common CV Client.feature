Feature: CV Client common features for profile creation workflows
 These rules apply to all onRouteBC account creation workflows.

User = basic or business

@orv2-481-8, @orv2-3322-10, @orv2-3228-15
Rule: The navigation bar is not visible to users until the profile has been successfully created

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following places:
       | welcome to onroutebc - claim profile or not choice |
       | claim an existing profile                          |
       | create a new profile                               |
       | contact details                                    |
     Then the navigation bar is not visible

@orv2-369-9, @orv2-3322-12, @orv2-3228-16
Rule: a cv client must have valid BCeID credentials

  Scenario: CV Client Business BCeID attempts to login onRouteBC and BCeID is not working
      Given the CV Client Admin or User has valid BCeID credentials 
      When they attempt to sign in using their BCeID credentials
      Then they are directed to a BCeID error page

  Scenario: CV Client Business BCeID admin OR user attempts to sign into onRouteBC using invalid BCeID credentials
      Given the CV Client Admin or User has invalid BCeID credentials 
      When they attempt to sign in to onRouteBC
      Then they are directed to a BCeID error page

@orv2-907-4, @orv2-3322-13, @orv2-3228-17
Rule: a new PA user can only view company profile information

 Scenario: New CV Client Business BCeID user completed profile setup
     Given the CV Client Business BCeID user has completed their profile
      When they choose to view their profile
      Then they are directed to company information
       But they cannot edit company information

@orv2-481-10, @orv2-3322-14, @orv2-3228-18
Rule: upon creating a profile or joining an existing profile a user can view their profile or apply for a permit

 Scenario: choose to apply for permit
     Given the user has completed their profile creation
      When they choose to apply for a permit
      Then they are directed to applications in progress

  Scenario: pa choose to view profile
     When a pa has chosen to view their profile
     Then they are directed to their user details

  Scenario: sa choose to view profile
     When a sa has chosen to view their profile
     Then they are directed to their company information