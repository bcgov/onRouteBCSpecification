Feature Staff close credit account
  As a FIN I need to be able to close a CV Client credit account so that I can ensure the credit account is no longer used.

Staff = FIN

@orv2-2007-1
Rule: Staff can close a credit account

  Scenario: open account
    Given the credit account is open
     When staff choose to close the credit account
     Then they see the close credit account confirmation

  Scenario: closed account
    Given the credit account is closed
     When staff choose to close 
     Then they do not see the option to close the credit account

  Scenario: confirm close
    Given staff have chosen to close a credit account
     When they confirm closing the credit account
     Then they are directed to credit account

@orv2-2007-2
Rule: Staff must input a reason for credit account closure

  Scenario: none inputted
     When staff confirm closing the credit account
     Then they see "This is a required field."
      And they cannot close the account

@orv2-2007-3
Rule: Reason for credit account closure is date/time and username stamped

  Scenario: confirm close
    Given staff have inputted a reason
     When they confirm close
     Then there <IDIR username> and the <date and time> are saved

   Examples:
     | IDIR username | date and time               |
     | jdoe          | Jan. 16, 2024, 10:14 am PDT |


@orv2-2007-4
Rule: Show credit account closed notification

  Scenario: credit account closed
     When Staff confirm closing the credit account
     Then they are directed to credit account
      And they see "Credit Account Closed" notification

@orv2-2007-5, @orv2-2035-8
Rule: Show closed label when the credit account is closed

  Scenario: credit account closed
    Given the credit account is closed
     When Staff view credit account information
     Then they see the "Closed" label

@orv2-2007-6
Rule: All credit account users are removed from the credit account users list when a credit account is closed

  Scenario: credit account users exist
     When Staff confirm closing the credit account
     Then they are directed credit account
      And all users are not shown in the credit account user list
      But the holder is still shown

# Maintain a historical record of credit account users 

@orv2-2007-7
Rule: A closed credit account does not have an available credit

  Scenario: credit account is closed
     When staff are viewing credit account information
     Then available credit is $0

@orv2-2007-8
Rule: Staff cannot add credit account users to a closed credit account

  Scenario: credit account is closed
     When staff choose to add credit account users 
     Then they do not see the option to add credit account users

@orv2-2007-9
Rule: Show close history list

  Scenario: credit account is closed
     When staff close the credit account
     Then they see the close history list that includes the following information:
       | data   | description                                               |
       | IDIR   | the IDIR username saved when the account was closed       |
       | Date   | the date and time in PT saved when the account was closed |
       | Reason | the free-text saved when the account was closed           |
       | Status | Account Closed                                            |

@orv2-2007-10
Rule: Close history list is sorted by newest record at the top in descending order

  Scenario: existing records
    Given the credit account is open
      And an existing close history record date is Jan 18, 2023, 9:07 am PDT
     When staff close the credit account on Feb 10, 2024, 9:00 pm PDT
     Then the close history record Feb 10, 2024, 9:00 pm PDT is at the top of the list

@orv2-2007-11
Rule: Close history header and list is not shown if it is dataless

@orv2-2007-12
Rule: Staff can reopen a credit account

  Scenario: credit account is closed
     When staff choose to reopen the credit account with a $10,000.00 credit limit
     Then they are directed to credit account
      And they available credit is $10,000.00

@orv2-2007-13
Rule: Reopening a credit account creates a status record in the history list

  Scenario: credit account is closed
     When staff reopen the credit account
     Then they see the close history list that includes the following information:
       | data   | description                                                 |
       | IDIR   | the IDIR username saved when the account was reopened       |
       | Date   | the date and time in PT saved when the account was reopened |
       | Reason | empty                                                       |
       | Status | Account Reopened                                            |

@orv2-2007-14
Rule: Show credit account reopened notification

  Scenario: credit account is closed
     When Staff reopen the credit account
     Then they are directed to credit account
      And they see "Credit Account Reopened" notification