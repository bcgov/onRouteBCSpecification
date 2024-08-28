Feature: As Staff I need to view active letter of authorizations (LOA) for a CV Client profile so that I can reference the special authorizations granted by their LOA(s).

Staff = SA, HQA

@orv2-2231-1, @orv2-2232-1
Rule: Staff can see a list of active LOA(s)

  Scenario: active LOA(s) exist
     When Staff view LOA(s)
     Then they see the following information in the list:
      | information     | description                                     |
      | LOA Number      | onRouteBC generated unique ID                   |
      | Start Date      | inputted by staff when adding or editing an LOA |
      | Expiry Date     | inputted by staff when adding or editing an LOA |
      | Download Letter | link to download the uploaded LOA    

  Scenario: default sort
    Given there are active LOA(s)
     When Staff view LOA(s)
     Then the list is sorted by start date newest at the top in descending order      

@orv2-2230-1
Rule  Staff can see a list of expired LOA(s)

  Scenario: expired LOA(s) exist
     When staff view expired LOA(s)
     Then they see the following information in the list:
      | information     | description                                     |
      | LOA Number      | onRouteBC generated unique ID                   |
      | Start Date      | inputted by staff when adding or editing an LOA |
      | Expiry Date     | inputted by staff when adding or editing an LOA |
      | Download Letter | link to download the uploaded LOA  

@orv2-2231-3, @orv2-2232-3
Rule: Staff can see the status of a CV Clients LOA(s)

  Scenario: no active LOA(s)
    Given there are no active LOA(s)
     When staff choose to view LOA(s)
     Then they see the option to add an LOA

  Scenario: active LOA(s) exist
    Given there are active LOA(s)
     When staff choose to view LOA(s)
     Then they see a list of LOA(s)

  Scenario: active LOA(s) and expired
     When Staff choose to view LOA(s)
     Then they see a list of LOA(s)
      And they see the option to view expired LOA(S)
      And they see instruction text "Download the letter to see the specific travel terms of the LOA."

  Scenario: active LOA(s) no expired
     When staff choose to view LOA(s)
     Then they see a list of LOA(s)
      And they see instruction text "Download the letter to see the specific travel terms of the LOA."

  Scenario: no active but expired LOA(s)
     When staff choose to view LOA(s)
     Then they see the option to view expired LOA(S)

@orv2-2231-2, @orv2-2232-2
Rule: Staff can download an LOA letter

  Scenario: active LOA(s)
    Given there are active LOA(s)
     When users choose to view an LOA letter
     Then the LOA is shown in a new browser tab
