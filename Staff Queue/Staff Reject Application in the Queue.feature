Feature: Staff Reject Application in the Queue

Staff = SA, PC, CTPO, Trainee

@orv2-2474-2
Rule: Staff can reject an application

  Scenario: application rejected
    Given A1-72303011-028 is claimed
     When staff approve A1-72303011-028 
     Then they are directed to the queue
      And A1-72303011-028 is not in the queue

  Scenario: reject claimed application
    Given A1-72303011-028 is claimed by John
     When Jane claims A1-72303011-028 
      And John chooses to reject A1-72303011-028
     Then John sees "Application no longer available This application is claimed by Jane"
      And Jane is the idir username      

@orv2-2474-3
Rule: Staff must input a reason for rejection

  Scenario: initiate reject application action
    Given A1-72303011-028 is claimed
     When staff reject A1-72303011-028 
     Then they see the reason for rejection input

  Scenario: cancel reject application
    Given A1-72303011-028 is being rejected
     When staff cancel rejecting A1-72303011-028 
     Then they are directed to review and confirm details for A1-72303011-028   

@orv2-2474-4
Rule: The reason for rejection is date / time stamped when the action is initiated

  Scenario: application rejected
    Given A1-72303011-028 is rejected 
     When staff confirm rejecting A1-72303011-028 at Jun. 13, 2024, 8:23 am PDT
     Then the reason for rejection is date / time stamped as Jun. 13, 2024, 8:23 am PDT

@orv2-2474-5
Rule: The reason for rejection is IDIR username stamped when the action is initiated

 Scenario: application rejected
    Given A1-72303011-028 is rejected 
     When staff confirm rejecting A1-72303011-028
      And the staff IDIR username initiating the reject action is jdoe
     Then the reason for rejection is stamped with the IDIR username jdoe

@orv2-2474-6
Rule: A rejected application becomes an application in progress

  Scenario: application rejected
    Given A1-72303011-028 is claimed
     When staff reject A1-72303011-028 
     Then A1-72303011-028 is an application in progress

@orv2-2474-7
Rule: The CV Client is notified via email when a application is rejected

  Scenario: application rejected
    Given A1-72303011-028 is claimed
     When staff reject A1-72303011-028 
     Then the rejection email is sent to the:
       | information      | description |
       | Company Email    | mandatory   |
       | Additional Email | if inputted |

@orv2-2474-8
Rule: The elapsed time in queue stops counting when a application is rejected

  Scenario: application rejected
    Given A1-72303011-028 is claimed
      And the elapsed time in queue is 01:10
     When staff reject A1-72303011-028
      And the elapsed time in queue is 01:15 when rejection action is initiated
     Then the total elapsed time in queue for A1-72303011-028 is 01:15