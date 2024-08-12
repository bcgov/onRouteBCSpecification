Feature: Staff Edit Application in the Queue

Staff = SA, PC, CTPO, Trainee

@orv2-2472
Rule: Staff can edit an application in the queue

  Scenario: edit claimed application
    Given A1-72303011-028 is claimed by John
      And John is editing it
     When Jane claims A1-72303011-028 
     Then ...
  
  Scenario: changes made save
    Given 
     When 
     Then 

  Scenario: changes not made save
    Given 
     When 
     Then 

@orv2-2472
Rule: Attestations are unselected when a application is chosen to edit

  Scenario: choose edit
    Given A1-72303011-028 is claimed
     When staff choose to edit A1-72303011-028
     Then they are directed to the A1-72303011-028 permit application
      And A1-72303011-028 attestations are unselected

@orv2-2472
Rule: Staff can leave an application being edited

@orv2-2472
Rule: An application opened for edit shows the data inputted by the CV Client