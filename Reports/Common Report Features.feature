Feature: Common report parameters

Rule: Default report type choosen on reports page

  Scenario: Arrive at reports page
    Given PPC staff are at the reports page
     When they view the list of available reports 
     Then the Permit Payment and Refund Summary report is choosen
  
Rule: Choose report type

  Scenario: Choose a report to view
    Given PPC staff wants to view a report
     When they choose a report 
     Then the choosen report is indicated
      And the choosen report parameters are displayed

Rule: View report

  Scenario: View report
    Given PPC staff chooses to view a report
     When they choose to view the report
     Then the report pdf is displayed in a new browser window

Rule: Maximum date range is 30 days
# Temporary solution to solve the resource issues with running reports with too many records

  Scenario: From date greater than 30 days from TO date
    Given Staff attempt to choose a from date 
     When they choose a To date greater than 30 days from the current date
     Then dates greater than 30 days from the current date are greyed out
      And they see a warning message
      And they cannot continue

  Scenario: To date greater than 30 days from From date
    Given From date is current date
     When they choose a To date greater than 30 days from the current date
     Then dates greater than 30 days from the current date are greyed out
      And they see a warning message
      And they cannot continue



Greyed out To date selection options based on the From date
Warning message if they select a From date that is too far away from the To date