Feature: Users edit rejected application(s)

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-2474-10 @orv2-2560-2 @orv2-2561-2 @orv2-4449-19
Rule: Users can view current and past reason(s) for rejection information on the rejected application

  Scenario: never rejected 
    Given A1-72303011-028 is not rejected
     When a user chooses to view A1-72303011-028
     Then they do not see the reason(s) for rejection history

  Scenario: rejected one or more
    Given A1-72303011-028 is rejected
     When a user chooses to view A1-72303011-028
     Then they see the reason for rejection history with the following information:
       | Information          | description                                                                                                        |
       | Reason for Rejection | inputted by staff                                                                                                  |
       | IDIR username        | Only visible to staff. The staff member that inputted the reason for rejection saved with the reason for rejection |
       | Date / Time          | the date and time the staff member that inputted the reason for rejection saved                                    |

@orv2-2474-11 @orv2-2560-3 @orv2-2561-3 @orv2-4449-20
Rule: Users can see the application rejected warning on rejected applications

Scenario: rejected one or more
    Given A1-72303011-028 is rejected
     When a user chooses to view A1-72303011-028
     Then they see the application rejected warning

@orv2-2474-12 @orv2-2560-4 @orv2-2561-4 @orv2-4449-21
Rule: Users can choose to be directed to the reason for rejection history

Scenario: rejected one or more
    Given A1-72303011-028 is rejected
      And a user chooses to view A1-72303011-028
     When chooses to view the reason(s) for rejection
     Then they are directed to the reason(s) for rejection

@orv2-2474-13 @orv2-2560-5 @orv2-2561-5 @orv2-4449-22
Rule: Users can review and confirm the rejection history

  Scenario: review and confirm
    Given A1-72303011-028 is rejected
     When a user chooses to review and confirm A1-72303011-028
     Then they see the reason(s) for rejection

@orv2-2474-14 @orv2-2560-6 @orv2-2561-6 @orv2-4449-23
Rule: Reason for rejection history is sorted newest at top in descending order