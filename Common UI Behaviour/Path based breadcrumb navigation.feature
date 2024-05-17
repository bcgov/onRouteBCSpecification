Feature Path based breadcrumb navigation

#NOTE: Path based breadcrumb has not been adopted universally across the application

Rule: Display the pages the user has visited before arriving on the current page

  Scenario: to pay for permit from AIP
    Given I am at AIP
     When I choose to pay for permit
     Then I am directed to pay for permit 
      And I see the following breadcrumb navigation in the following order:
        | 1. Applications in Progress |
        | 2. Pay for Permit           |


