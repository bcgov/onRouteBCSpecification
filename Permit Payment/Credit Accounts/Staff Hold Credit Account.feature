Feature Staff hold credit account
  As a FIN I need to be able to place a CV Client credit account on hold so that I can manage the authorized use of the credit account.

Staff = FIN

@orv2-2008-1
Rule: Staff can hold a credit account

  Scenario: open account
    Given the credit account is open
     When staff choose to hold the credit account
     Then they see the hold credit account confirmation

  Scenario: closed account
    Given the credit account is closed
     When staff choose to hold the credit account 
     Then they do not see the option to hold the credit account

  Scenario: confirm hold
    Given staff have chosen to hold a credit account
     When they confirm holding the credit account
     Then they are directed to credit account

@orv2-2008-2
Rule: Staff must input a reason for credit account hold

  Scenario: none inputted
     When staff confirm closing the credit account
     Then they see "This is a required field."
      And they cannot hold the credit account

@orv2-2008-3
Rule: Reason for credit account hold is date/time and username stamped

  Scenario: confirm hold
    Given staff have inputted a reason
     When they confirm hold
     Then there <IDIR username> and the <date and time> are saved

   Examples:
     | IDIR username | date and time               |
     | jdoe          | Jan. 16, 2024, 10:14 am PDT |


@orv2-2008-4
Rule: Show credit account on hold notification

  Scenario: credit account on hold
     When Staff confirm credit account hold
     Then they are directed to credit account
      And they see "Credit Account On Hold" notification

@orv2-2008-5, @orv2-2035-9
Rule: Show on hold label when the credit account is on hold

  Scenario: credit account on hold
    Given the credit account is on hold
     When Staff view credit account information
     Then they see the "On Hold" label

@orv2-2008-6
Rule: A credit on hold account maintains its available credit but cannot use it

  Scenario: credit account is on hold
    Given the credit account has a credit limit of $10,000.00
     And a credit balance of $0
     When staff are viewing credit account information
     Then available credit is $10,000.00

@orv2-2008-7
Rule: A credit on hold account maintains its credit balance

  Scenario: credit account is on hold
    Given the credit account has a balance of $5,000.00
     When staff are viewing credit account information
     Then credit balance is $5,000.00

@orv2-2008-8
Rule: Staff can add credit account users to a credit account on hold

  Scenario: credit account is on hold
     When staff choose to add credit account users 
     Then the option to add credit account users is available

@orv2-2008-9
Rule: Show hold history list

  Scenario: credit account is on hold
     When staff hold the credit account
     Then they see the hold history list that includes the following information:
       | data   | description                                                    |
       | IDIR   | the IDIR username saved when the account was put on hold       |
       | Date   | the date and time in PT saved when the account was put on hold |
       | Reason | the free-text saved when the account was put on hold           |
       | Status | On Hold                                                        |

@orv2-2008-10
Rule: Hold history list is sorted by newest record at the top in descending order

  Scenario: existing records
    Given the credit account is open
      And an existing history record date is Jan 18, 2023, 9:07 am PDT
     When staff hold the credit account on Feb 10, 2024, 9:00 pm PDT
     Then the hold history record Feb 10, 2024, 9:00 pm PDT is at the top of the list

@orv2-2008-11
Rule: Hold history header and list is not shown if it is dataless

@orv2-2008-12
Rule: Staff can remove a credit account hold

  Scenario: credit account is on hold
     When staff choose to remove the credit account hold
     Then they are directed to credit account

@orv2-2008-13
Rule: Removing a credit account hold creates a status record in the history list

  Scenario: credit account is on hold
     When staff remove the credit account hold
     Then they see the hold history list that includes the following information:
       | data   | description                                                     |
       | IDIR   | the IDIR username saved when the account hold was removed       |
       | Date   | the date and time in PT saved when the account hold was removed |
       | Reason | empty                                                           |
       | Status | Hold Removed                                                    |

@orv2-2008-14
Rule: Show credit account hold removed notification

  Scenario: credit account is on hold
     When Staff remove the credit account hold
     Then they are directed to credit account
      And they see "Hold Removed" notification