Feature: Users edit an application in progress
As a user I need to be able to edit an application in progress, so that I can complete my permit application for approval and issuance.

user = CA, PA, PC, SA, TRAIN, CTPO
staff = PC, SA, TRAIN, CTPO

Note: The following rules apply to all permit application types. For rules specific to editing application in progress see related feature files:

- All User apply for permit feature files
- CV Client edit rejected application.feature
- Users edit rejected application.feature


@orv2-4458-2, @orv2-4485-1
Rule: users see information last inputted and saved when editing an application in progress 

  Scenario: edited by a another cv client user
    Given permit application A is in progress by user 1
     When user 2 opens permit application A to edit
     Then user 2 sees information last inputted and saved by user 1

  Scenario: approved from queue in cart
    Given permit application A was created abd submitted for approval by user 1
      And permit A is approved from the queue and in cart
      And permit A was not edited by staff
     When user 1 opens permit application A to edit
     Then user 1 sees information last inputted and saved by user 1

  Scenario: edited rejected from queue
    Given permit application A was created and submitted for approval by user 1
      And permit A is rejected from the queue
      And permit A was edited by staff
     When user 1 opens permit application A to edit
     Then user 1 sees information last inputted and saved by staff

  Scenario: edited by staff
    Given permit application A is in progress by user 1
      And permit A was edited by staff
     When user 1 opens permit application A to edit
     Then user 1 sees information last inputted and saved by staff

  Scenario: edited by self 
    Given permit application A is in progress by user 1
      And permit A was edited by user 1
     When user 1 opens permit application A to edit
     Then user 1 sees information last inputted and saved by user 1









