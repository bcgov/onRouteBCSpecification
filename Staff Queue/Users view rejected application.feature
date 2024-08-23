Feature: Users view rejected application(s)

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-2474-10
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

@orv2-2474-11
Rule: Users can see the application rejected warning on rejected applications

Scenario: rejected one or more
    Given A1-72303011-028 is rejected
     When a user chooses to view A1-72303011-028
     Then they see the application rejected warning

@orv2-2474-12
Rule: Users can choose to be directed to the reason for rejection history

Scenario: rejected one or more
    Given A1-72303011-028 is rejected
      And a user chooses to view A1-72303011-028
     When chooses to view the reason(s) for rejection
     Then they are directed to the reason(s) for rejection

@orv2-2474-13
Rule: Users can review and confirm the rejection history

  Scenario: review and confirm
    Given A1-72303011-028 is rejected
     When a user chooses to review and confirm A1-72303011-028
     Then they see the reason(s) for rejection

