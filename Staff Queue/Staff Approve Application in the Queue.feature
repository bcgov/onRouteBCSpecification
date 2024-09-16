Feature: Staff Approve Application in the Queue

Staff = SA, PC, CTPO, Trainee

@orv2-2473-1
Rule: Staff can approve an application

  Scenario: application approved
    Given A1-72303011-028 is claimed
     When staff approve A1-72303011-028 
     Then they are directed to the queue
      And A1-72303011-028 is not in the queue

  Scenario: approve claimed application
    Given A1-72303011-028 is claimed by John
     When Jane claims A1-72303011-028 
      And John chooses to approve A1-72303011-028
     Then John sees "Application no longer available This application is claimed by Jane"
      And Jane is the idir username

@orv2-2473-2
Rule: Approved applications are added to the shopping cart

  Scenario: application approved
    Given A1-72303011-028 is claimed
     When staff approve A1-72303011-028 
     Then the A1-72303011-028 is added to the shopping cart

@orv2-2473-3
Rule: The elapsed time in queue stops counting when a application is approved

  Scenario: application approved
    Given A1-72303011-028 is claimed
      And the elapsed time in queue is 01:10
     When staff approve A1-72303011-028
      And the elapsed time in queue is 01:15 when approval action is initiated
     Then the total elapsed time in queue for A1-72303011-028 is 01:15

@orv2-2473-4
Rule: The CV Client is notified via email when a application is approved

  Scenario: application approved
    Given A1-72303011-028 is claimed
     When staff approve A1-72303011-028 
     Then the approval email is sent to the:
       | information      | description |
       | Company Email    | mandatory   |
       | Additional Email | if inputted |

@orv2-2473-5
Rule: Start date and/or expiry date can not be in the past

 Scenario: in queue past start date
   When staff claim
   Then staff see "Start Date and/or Permit Expiry Date is in the past."
    And they cannot approve the application

 Scenario: in queue start and expiry in the past
   When staff claim
   Then staff see "Start Date and/or Permit Expiry Date is in the past."
    And they cannot approve the application

 Scenario: in queue past start date edit
   Given staff have claimed the application
    When staff edit the application
    Then staff see "Start Date is in the past."
     And they can continue