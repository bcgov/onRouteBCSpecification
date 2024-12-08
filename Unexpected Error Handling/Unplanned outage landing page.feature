Feature: Unplanned outage page

User = All

@ORV2-2026
Rule: the unplanned outage page is shown when onRouteBC is unavailable due to an unplanned outage
  
  Scenario: openshift down
    Given openshift is not working
     When users choose to visit onRouteBC
     Then they see the openshift outage page

  Scenario: onRouteBC pod down
    Given openshift is working
      But onRouteBC is not available
     When users choose to visit onRouteBC
     Then they see the unplanned outage page

