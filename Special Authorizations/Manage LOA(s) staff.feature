Feature: Staff manage LOA(s)
As staff I need to view update expired or active letter of authorizations (LOA) for a CV Client profile so that these CV Clients can apply for permits using the special authorizations granted by their LOA(s).

Staff = SA, HQA

@orv2-2230-2
Rule Staff can edit active or expired LOA(s)

  Scenario: active or expired LOA(s) exist
     When staff choose to edit an active or expired LOA
     Then they are directed to the start of the workflow 
      And all previously inputted information is shown

@orv2-2230-3
Rule Show LOA updated notification

  Scenario: edit expired LOA
    Given staff are activating an expired LOA
     When staff complete edits
     Then they are directed to special authorizations
      And they see "LOA Updated" notification
      And the LOA is shown in the active LOA list

@orv2-2230-4
Rule Staff can delete active LOA(s)

  Scenario: initiate delete
    Given there are active LOA(s)
     When staff choose to delete an LOA
     Then thy see the delete confirmation

  Scenario: cancel delete
    Given there are active LOA(s)
     When staff choose to cancel the delete an LOA
     Then they are directed to special authorizations
      And no changes are made to the list of LOA(s)

  Scenario: confirm delete
    Given there are active LOA(s)
     When staff choose to delete an LOA
     Then the LOA is removed from the list 
      But not deleted from onRouteBC

@orv2-2230-5
Rule Staff can download expired LOA(s)

  Scenario: expired LOA(s)
    Given there are expired LOA(s)
     When users choose to view an LOA letter
     Then the LOA is shown in a new browser tab