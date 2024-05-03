Feature: As users or staff I need to view active letter of authorizations (LOA) for a CV Client profile so that I can reference the special authorizations granted by their LOA(s).

Users = PC, CTPO, Trainee, CA, PA 
Staff = SA, HQA

@orv2-2231-1, @orv2-2232-1
Rule: Users or staff staff can see a list of active LOA(s)

  Scenario: view LOA(s) list
    Given there are active LOA(s)
     When users or staff view LOA(s)
     Then they see the following information in the list:
      | information     | description                                     |
      | LOA Number      | onRouteBC generated unique ID                   |
      | Start Date      | inputted by staff when adding or editing an LOA |
      | Expiry Date     | inputted by staff when adding or editing an LOA |
      | Download Letter | link to download the uploaded LOA               |

  Scenario: no active LOA(s) users
    Given there are no active LOA(s)
     When users choose to view LOA(s)
     Then LOA(s) are not shown

  Scenario: no active LOA(s) staff
    Given there are no active LOA(s)
     When staff choose to view LOA(s)
     Then they see the option to add an LOA

  Scenario: active LOA(s) exist users
    Given there are active LOA(s)
     When users choose to view LOA(s)
     Then they see a list of LOA(s)
      And instruction text

  Scenario: active LOA(s) exist staff
    Given there are active LOA(s)
     When staff choose to view LOA(s)
     Then they see a list of LOA(s)

  Scenario: default sort
    Given there are active LOA(s)
     When users or staff view LOA(s)
     Then the list is sorted by start date newest at the top in descending order

@orv2-2231-2, @orv2-2232-2
Rule: A user or staff can download an LOA letter

  Scenario: active LOA(s)
    Given there are active LOA(s)
     When users choose to view an LOA letter
     Then the LOA is shown in a new browser tab
