Feature: Common report parameters

Rule: Default report type choosen on reports page

  Scenario: Arrive at reports page
    Given PPC staff are at the reports page
     When view the list of available reports 
     Then the Permit Payment and Refund Summary report is choosen
  
Rule: Choose report type

  Scenario: Choose a report to view
    Given PPC staff wants to view a report
     When they choose a report 
     Then the choosen report is indicated
      And the choosen report parameters are displayed

Rule View report

  Scenario: View report
    Given PPC staff chooses to view a report
     When they choose to view the report
     Then the report is displayed in a new browser window