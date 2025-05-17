Feature: Universal Unexpected Error Handling

# see individual features for scenarios that a user may encounter to arrive at the universal unexpected error page

User = All

@orv2-1610-1
Rule: All unexpected errors will direct a user to the universal unexpected error page

@orv2-1610-2
Rule: Users can optionally choose to visit the onRouteBC home page from the universal unexpected error page

@orv2-3088-1
Rule: Show version mismatch error page for version incompatibility issues

  Scenario: cv client CA, PA at permit application
    Given a cv client is at permit application
      And they have inputted information
      And they have version 1 of onRouteBC
      And onRouteBC is updated to version 2
      And version 2 contain a feature that prevents version 1 application continuation to review and confirm
     When they choose to proceed to review and confirm
     Then they see "onRouteBC has been updated, Click here to continue"
      And they can optionally choose to go to applications in progress

  Scenario: auth staff permit application
    Given PC, SA, TRAIN, CTPO is at permit application
      And they have inputted information
      And they have version 1 of onRouteBC
      And onRouteBC is updated to version 2
      And version 2 contain a feature that prevents version 1 application continuation to review and confirm
     When they choose to proceed to review and confirm
     Then they see "onRouteBC has been updated, Click here to continue"
      And they can optionally choose to go to the staff home page

  Scenario: non auth staff any page
    Given HQA, FIN, EO is on any page
      And they have version 1 of onRouteBC
      And onRouteBC is updated to version 2
      And version 2 contain a feature that version 1 does not have
     When they choose to view another page
     Then they see "onRouteBC has been updated, Click here to continue"
      And they can optionally choose to go to the staff home page



