Feature: Staff Manage Queue List

Staff = SA, PC, CTPO, Trainee

@orv2-2398
Rule: Staff can see a list of applications submitted for review

@orv2-2398
Rule: Staff can see the elapsed time the submitted application has been in the queue

@orv2-2398
Rule: The list of submitted applications is sorted by thr elapsed time in the queue oldest at the top in descending order

@orv2-2398
Rule: Staff may update the list to show its current state manually

@orv2-2398
Rule: The list is updated every 30 seconds to reflect its current state

@orv2-2398
Rule: Staff may claim an application to review

  Scenario: claim a non claimed
    Given A1-72303011-028 is not claimed
     When staff claim A1-72303011-028
     Then they are directed to review and confirm details
      And attestations are unavailable

@orv2-2398
Rule: Claimed applications are grouped together and shown at the bottom of the list

@orv2-2398
Rule: A claimed application is in review

@orv2-2398
Rule: Staff can claim a claimed application

  Scenario: claim a claimed
    Given 
     When 
     Then 

