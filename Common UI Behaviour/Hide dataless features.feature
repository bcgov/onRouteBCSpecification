Feature Hide dataless features

Rule Hide user interaction for a feature when no data exists

  Scenario: DBA 
    Given there is no data saved in the DBA field of a profile
     When viewing company information in permit application
     Then the DBA field name is not shown

