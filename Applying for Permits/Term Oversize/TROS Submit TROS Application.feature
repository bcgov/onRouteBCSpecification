
Feature: Complete (submit) TROS Permit Application
   As a CV Client I need to be able to submit my TROS application to move on to the review permit screen.

@orv2-627
Scenario: Clicking Continue in the "TROs Permit Application" form.
    Given The user has filled all mandartory fields in "Application Details", and "Vehicle Details"
    When there are no error notifcation in the application
    Then the user is brought to the "Permit Review" Screen
    And the appliction is saved to "Applications in Progress"

@orv2-627
Scenario: Clicking Continue in the "TROs Permit Application" form.
    Given The user has not filled all mandartory fields in "Application Details", and "Vehicle Details"
    And there are are error notifcation in the application
    Then the user user cannont continue to the "Permit Review" screen and the error notifications for each field remain highlighted in Red until resolved.
