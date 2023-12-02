Feature: Common features for profile creation workflows

Rule: The navigation bar is not visible to CV Clients until the profile has been successfully claimed

  Scenario: profile setup not complete
    Given a CV Client is in an create onRouteBC profile workflow
     When they are at any of the following steps:
       | steps |
       | welcome to onroutebc - claim profile or not choice |
       | verify profile | 
       | company information |
       | my information |
     Then the navigation bar is not visible

