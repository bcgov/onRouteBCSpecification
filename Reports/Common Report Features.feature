Feature: Common report features

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

@orv2-3072-3
Rule: Issued by is the user that adds the permit application to the cart

  Scenario: staff add to cart
     When staff view payment and refund reports
     Then issued by is the IDIR username

  Scenario: cv client add to cart
     When user view payment and refund reports
     Then issued by is Self Issued

Greyed out To date selection options based on the From date
Warning message if they select a From date that is too far away from the To date

@orv2-2856-1
Feature: Export reports to CSV

Payment and Refund Detail Sample: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B972CCEC0-F4DA-4CCA-8DA4-C75D689964A0%7D&file=Payment%20and%20Refund%20Detail.csv&action=default&mobileredirect=true

Payment and Refund Summary Sample: https://bcgov.sharepoint.com/:x:/r/teams/04314/_layouts/15/Doc.aspx?sourcedoc=%7B31B05184-528A-48A7-8694-1621576FE791%7D&file=Payment%20and%20Refund%20Summary.csv&action=default&mobileredirect=true

@orv2-2856-2
Rule: Users can choose to viw the report pdf or export to CSV field

  Scenario: export
    Given a user chooses to export as CSV
     When they choose to generate the report
     Then they see the option to save the report

@orv2-2856-3
Rule: View as PDF is the default 

  Scenario: arrive at reports
     When a user has been directed to reports
     Then they see "View as PDF" chosen

