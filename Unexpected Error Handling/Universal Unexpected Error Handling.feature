Feature: Universal Unexpected Error Page

# see individual features for scenarios that a user may encounter to arrive at the universal unexpected error page

User = All

@orv2-1610-1
Rule: All unexpected errors will direct a user to the universal unexpected error page

@orv2-1610-2
Rule: Users can optionally choose to visit the onRouteBC home page from the universal unexpected error page

@orv2-3088-1
Rule: Show universal unexpected error for version incompatibility issues

  Scenario: permit application
    Given a user is at permit application
      And they have inputted information
      And they have version 1 of onRouteBC
      And onRouteBC is updated to version 2
      And version 2 contain a feature that prevents version 1 application continuation to review and confirm
     When they choose to proceed to review and confirm
     Then they see the universal error 



