Feature: Display permit header information
    As a CV Vlient I want to be able to view a unique application details so that I can refer to this application in progress 
 
  Scenario: Display application number
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see a uniqe permit application number

  Scenario: Display date created
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see the date and time the permit application was created

  Scenario: Display last updated
    Given the CV Client is at the "Permit Application" page
     When they save the permit application
     Then they see the date and time the permit application was last updated

