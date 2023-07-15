Feature: Authentication

@orv2-698
  Scenario: Logout
    Given a user chooses to logout of onRouteBC
     When they initiate the logout
     Then they are directed to the onRouteBC Siteminder login page
      And they should be logged out of onRouteBC


