Feature Common staff search features

Staff = SA, PC

@orv2-2216-1
Rule: Release staff user from current acting as company on initiation of new search

  Scenario: Search for permit
    Given staff are acting at company ABC
     When they choose to search for a permit
     Then they are not acting as a company
      And the header does not display company ABC

  Scenario: Search for company
    Given staff are acting as company ABC 
     When they choose to search for a company
     Then they are not acting as a company
      And the header does not display company ABC

@orv2-3411-4
Rule: The search value is cleared when the search entity is changed

@orv2-3411-5
Rule: The search value is cleared the search filter is changed
