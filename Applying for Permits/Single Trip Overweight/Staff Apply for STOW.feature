Feature: Staff Apply for Single Trip Overweight Permit

staff = PC, SA, TRAIN, CTPO

@orv2-4467-1
Rule: staff must choose a start date to a maximum of 60 days from today (current date and time the application is initiated)

 see: Permit start and duration Staff.feature

@orv2-4467-2
Rule: staff must choose a permit length in increments of one day, with a maximum of 30 days

 See: Permit start and duration Staff.feature

@orv2-4467-3
Rule: staff can add a permit to the shopping cart with policy validation warnings

  Scenario: only validation warnings
    Given permit application has policy validation warnings
     When staff continue to review and confirm
     Then they see a warning message indicating the application has violations with the following information:
       | data                     | description                         |
       | Axle Spacing and Weights | warning title                       |
       | Overweight Calculation   | heading                             |
       | Total (GCVW)             | sum of actual axle unit weights     |
       | Overweight (kg)          | amount over the legal limit         |
       | Violations               | 1 or more violation warnings listed |
      And they can choose to continue or cancel and go back to edit the application 

  Scenario Outline: validation warnings and mandatory field warning
    Given permit application has policy validation warnings
      And permit application has <mandatory field warnings>
     When staff continue to review and confirm
     Then they cannot continue to review and confirm
      And they see a <message> indicating the application has <mandatory field warnings> that must be resolved before continuing

    Examples:
      | mandatory field warnings | message                  |
      | First Name ommitted      | This is a required field |
      | Phone Number omitted     | This is a required field |

  Scenario: no validation warnings
    Given permit application has no policy validation warnings
     When staff continue to review and confirm
     Then they do not see a warning message indicating the application has violations

  Scenario: permit application has policy validation warnings and staff choose to continue
    Given permit application has policy validation warnings
     When staff continue
     Then they are directed to review and confirm

  Scenario: permit application has policy validation warnings and staff choose to cancel
    Given permit application has policy validation warnings
     When staff cancel

@orv2-4467-4
Rule: staff are shown an additional warning when continuing to review and confirm when the permit application has policy validation warnings

