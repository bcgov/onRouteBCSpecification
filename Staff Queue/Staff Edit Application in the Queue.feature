Feature: Staff Edit Application in the Queue

Staff = PC, SA, TRAIN, CTPO

@orv2-2472-1
Rule: Staff can edit an application in the queue

  Scenario: leave, save or continue claimed application
    Given A1-72303011-028 is claimed by John
      And John is editing it
     When Jane claims A1-72303011-028 
      And John chooses to leave, save or continue A1-72303011-028
     Then John sees "Application no longer available This application is claimed by Jane"
      And Jane is the idir username

  Scenario: confirm close application no longer available
    Given John is editing or reviewing A1-72303011-028 now claimed by Jane
      And John chooses to leave, save or continue A1-72303011-028
     When John confirms closing A1-72303011-028
     Then John is directed to the queue
      And John's edits are not saved
      And A1-72303011-028 is claimed by Jane

  Scenario: changes made continue
    Given A1-72303011-028 is opened for edit
      And edits were made to A1-72303011-028
     When staff choose to continue to review and confirm
     Then edits made to A1-72303011-028 are saved
      And they are directed review and confirm
      And A1-72303011-028 attestations are unselected

  Scenario: changes not made continue
    Given A1-72303011-028 is opened for edit
      And no edits are made to A1-72303011-028
     When staff choose to continue to review and confirm
     Then A1-72303011-028 is saved
      And they are directed review and confirm
      And A1-72303011-028 attestations are unselected

@orv2-2472-2
Rule: Staff can save edits made to an application

  Scenario: changes made save
    Given A1-72303011-028 is opened for edit
      And edits were made to A1-72303011-028
     When staff choose to save
     Then edits to A1-72303011-028 are saved
      And A1-72303011-028  attestations are unselected

  Scenario: changes not made save
    Given A1-72303011-028 is opened for edit
      And no edits are made to A1-72303011-028
     When staff choose to save
     Then A1-72303011-028 is saved
      And they are directed review and confirm
      And A1-72303011-028 attestations are unselected

@orv2-2472-3
Rule: Attestations are unselected when a application is saved

  Scenario: on continue
    Given A1-72303011-028 is opened for edit
     When staff choose to continue to review and confirm
     Then they are directed review and confirm
      And A1-72303011-028 attestations are unselected

  Scenario: on save
    Given A1-72303011-028 is opened for edit
     When staff choose to save
     Then they can continue editing
      And A1-72303011-028 attestations are unselected

@orv2-2472-4
Rule: Staff can leave an application being edited 

  Scenario: at review and confirm
    Given A1-72303011-028 is at review and confirm
     When staff choose to close the browser
     Then edits to A1-72303011-028 are saved
     And A1-72303011-028 attestations are unselected

  Scenario: at edit not saved
    Given A1-72303011-028 is opened for edit
      And staff have not saved
     When staff choose to close the browser
     Then edits to A1-72303011-028 are not saved
     And A1-72303011-028 attestations are selected

  Scenario: at edit warning
    Given an application is opened for edit
     When staff choose leave the application
     Then they see "Are you sure you want to leave? Show more actions for this item If you leave, all your changes will be lost. This action cannot be undone."

  Scenario: at edit warning discard changes
    Given A1-72303011-028 is opened for edit
      And staff choose to leave A1-72303011-028
     When staff choose to discard changes
     Then they are directed to the the queue

  Scenario: at edit warning continue editing
    Given A1-72303011-028 is opened for edit
      And staff choose to leave A1-72303011-028
     When staff choose to continue editing
     Then they are directed to A1-72303011-028
      And they can continue editing

@orv2-2472-5
Rule: An application opened for edit shows the data inputted by the CV Client