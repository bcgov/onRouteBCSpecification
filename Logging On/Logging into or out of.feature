Feature: Log into or out of onRouteBC

#needs roles and more detail for each roles "dashboard"

@orv2-698
  Scenario: Logout
    Given a user chooses to logout of onRouteBC
     When they initiate the logout
     Then they are directed to the onRouteBC Home Page
      And they should be logged out of onRouteBC

Scenario: First sign into onRouteBC
    Given they have valid BCeID credentials
    And the CV Client onRouteBC Profile does not exist
    When they successfully sign in using their BCeID credentials
    Then they are directed to the "Welcome to onRouteBC" page
    And they see their BCeID "Company Legal Name"

@orv2-369-8 @orv-672-3
Scenario: CV Client Business BCeID login onRouteBC
    Given the CV Client onRouteBC Profile exists
    When they sign in successfully using their BCeID credentials 
    Then they are directed to the "Permits" page "Applications in Progress" tab