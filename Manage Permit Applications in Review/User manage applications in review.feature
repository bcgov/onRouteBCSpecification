Feature: Manage applications in review

User = CA, PA, SA, PC, CTPO, Train
Staff = SA, PC, CTPO, Trainee

@orv2-2394-1 @orv2-3835-3
Rule: only authorized users see a list of application in review with information about each

  Scenario: authorized
     When CA, PA PC, SA, TRAIN, FIN, CTPO are at a cv client permits
     Then they see the option to view applications in review

  Scenario: not authorized
     When Fin, EO, HQA are at a cv client permits
     Then they do not see the option to view applications in review

  Scenario: no applications in review
     When a user chooses to view applications in review
     Then they see "No records found"

  Scenario: application in review exist
     When a user is chooses to view applications in review
     Then they see a list of applications in review with the following information per application:
       | information       | description                                                                            |
       | Application #     | the unique application number generated by onRouteBC                                   |
       | Permit Type       | the type of permit application being applied for                                       |
       | Unit #            | the unit number of the power unit inputted in the application                          |
       | VIN               | the 6 digit VIN of the power unit inputted in the application                          |
       | Plate             | the plate of the power unit inputted in the application                                |
       | Permit Start Date | the start date inputted by the applicant                                               |
       | Last Updated      | the date the application in review was last saved                                      |
       | Applicant         | the first name and last name of the logged in user that started the permit application |     

@orv2-2394-2
Rule: The application in review list default sort is by last updated date, newest at the top in descending order

  Scenario: application in review exist
    Given the following last update dates exist in the application in review list:
      | Sept. 14, 2023, 09:26 pm PDT |
      | Sept. 14, 2023, 03:01 pm PDT |
      | Sept. 16, 2023, 07:01 am PDT |
     When a user chooses to view applications in review
     Then they see applications in review in the following order:
      | Sept. 16, 2023, 07:01 am PDT |
      | Sept. 14, 2023, 09:26 pm PDT |
      | Sept. 14, 2023, 03:01 pm PDT |

@orv2-2394-3
Rule: Last updated date is the date an application in review was claimed or saved

  Scenario: opened no changes made
    Given an application has a last updated date of Sept. 14, 2023, 09:26 pm PDT
     When a user opens the application to edit
      But no changes were made to the application
      And the application is saved at Sept. 23, 2023, 07:15 am PDT
     Then the last updated date is Sept. 23, 2023, 07:15 am PDT

  Scenario: opened changes made
    Given an application has a last updated date of Sept. 14, 2023, 09:26 pm PDT
     When a user makes changes to application data
      And the application is saved at Sept. 23, 2023, 07:15 am PDT
     Then the last updated date is Sept. 23, 2023, 07:15 am PDT

  # Scenario: application claimed by ppc
    Given an application has a last updated date of Sept. 14, 2023, 09:26 pm PDT
     When staff claims an application at Sept. 23, 2023, 07:15 am PDT
     Then the last updated date is Sept. 23, 2023, 07:15 am PDT

  Scenario: closed browser before save
    Given an application has a last updated date of Sept. 14, 2023, 09:26 pm PDT
     When staff opens to edit an application at Sept. 23, 2023, 07:15 am PDT
      And the browser tab is closed before the save action is initiated
     Then the last updated date is Sept. 14, 2023, 09:26 pm PDT

@orv2-2394-9
Rule: The application in review list default pagination is 10 items

@orv2-2394-4
Rule: Users see the reject applications info box

@orv2-2394-5
Rule: An application that is not claimed by staff is "Pending Review"

  Scenario: apps pending review exist 
    Given the following application are pending review:
      | A1-72303011-028 |
      | A1-72503011-100 |
      | A1-74013011-353 |
     When a user chooses to view applications in review
     Then they see the label "Pending Review" next to:
      | A1-72303011-028 |
      | A1-72503011-100 |
      | A1-74013011-353 |

  Scenario: application newly submitted
    Given application A1-72303011-028 is newly submitted for review
     When a user views the application in the list
     Then they see the label "Pending Review" next to A1-72303011-028

@orv2-2394-6
Rule: An application that is claimed by staff is "In Review"

  Scenario: apps in review exist 
    Given the following application are in review:
      | A1-72303011-028 |
      | A1-72503011-100 |
      | A1-74013011-353 |
     When a user chooses to view applications in review
     Then they see the label "In Review" next to:
      | A1-72303011-028 |
      | A1-72503011-100 |
      | A1-74013011-353 |

  Scenario: application claimed
    Given application A1-72303011-028 is claimed by staff
     When a user views the application in the list
     Then they see the label "In Review" next to A1-72303011-028

@orv2-2394-7
Rule: A user can withdraw a submitted permit application in pending review

  Scenario: pending review
    Given A1-72303011-028 is pending review
     When a user chooses to withdraw A1-72303011-028 
     Then A1-72303011-028 becomes an application in progress
      And A1-72303011-028 is removed from the application in review list
      And they see "Withdrawn to Applications in Progress" 

  Scenario: label is pending review app in review
    Given A1-72303011-028 label is "Pending review"
      And A1-72303011-028 is in review
     When a user chooses to withdraw A1-72303011-028 
     Then they see "Application Status Application(s) have either been withdrawn or are in review by the Provincial Permit Centre." 
      And A1-72303011-028 label is "In Review"

  Scenario: label is pending review app is withdrawn
    Given A1-72303011-028 label is "Pending review"
      And A1-72303011-028 has been withdrawn
      And A1-72303011-028 is an application in progress
     When a user chooses to withdraw A1-72303011-028 
     Then they see "Application Status Application(s) have either been withdrawn or are in review by the Provincial Permit Centre." 
      And A1-72303011-028 is removed from the application in review list

  Scenario: in review
    Given A1-72303011-028 is in review
     When a user chooses to withdraw A1-72303011-028
     Then they are unable to withdraw the application

@orv2-2394-8
Rule: A withdrawn submitted permit application is an application in progress

