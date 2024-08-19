Feature: Staff Approve Application in the Queue

Staff = SA, PC, CTPO, Trainee

@orv2-2473-1
Rule: Staff can approve an application

  Scenario: application approved
    Given A1-72303011-028 is claimed
     When staff approve A1-72303011-028 
     Then they are directed to the queue
      And A1-72303011-028 is not in the queue

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


