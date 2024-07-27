Feature Staff manage credit account users
  As a FIN I need to be able to manage CV Client credit account users so that I can assist CV Clients with ensuring access to the correct credit account.

Staff = FIN

@orv2-1797-1
Rule Staff can find and add a credit account user to a holder credit account using the exact onRouteBC client number

  Scenario: partial cv client number
     When staff search for a cv client using an incomplete cv client number
     Then they see "Client No. not found"
      And client number is indicated
  
  Scenario: cv client not found
    Given cv client does not exist in onRouteBC
     When staff search for a cv client
     Then they see "Client No. not found"
      And client number is indicated

  Scenario: cv client found
    Given cv client exists in onRouteBC
     When staff search for a cv client
     Then they see the following information about the found cv client:
      | company name            |
      | doing business as (DBA) |
      | onRouteBC client no.    |

  Scenario: cv client found continue add
    Given the correct cv client is found
     When choose to continue
     Then the cv client is added as a credit account user
      And they are shown in the credit account user list
      And they see "account user added" notification

  Scenario: cv client already has a credit account
    Given fin is searching for company A to add to company Bs credit account
      And company A has an active credit account
     When fin finds company A
     Then they cannot add them to company Bs credit account
      And they see the warning "This company already is a holder or user of" and the following:
        | data                 | description                       |
        | Company Name         | legal name of company A           |
        | onRouteBC Client No. | onRouteBC client no. of Company A |
        | Credit Account No.   | credit account no. of company A   |

@orv2-1797-2
Rule Staff can remove a credit account user from a holder credit account

  Scenario: indicate selection
    Given there are users
     When staff choose a one or more user(s) to remove
     Then their selection is indicated
      And the option to remove user(s) is indicated

  Scenario: remove user warning
    Given staff have users chosen
     When staff choose a user to remove
     Then they see "Remove User(s)?" "Are you sure you want to remove credit account user(s)?"

  Scenario: remove user
    Given see the remove users warning
     When staff choose a user to remove
     Then they see "Account Users) Removed" notification
      And the chosen user(s) are not shown in the credit account user list

@orv2-1797-3
Rule Staff cannot remove the credit account holder from their credit account

@orv2-1797-4
Rule: Show credit account information

  Scenario: credit account exists
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account does not exist
     When staff chooses to view credit account
     Then they see the option to add credit account

  Scenario: credit account closed view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account on hold view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account closed view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account on hold view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account suspended view holder
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account suspended view user
     When staff chooses to view credit account
     Then they see the option to view credit account

  Scenario: credit account on hold view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | On Hold                       | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Hold / Close History          | list of credit account hold and close transactions |
       | Credit Account details        | financial details of the credit account            |
       | Add Credit Account User       | option to add a credit account user                |
 
   Scenario: credit account on hold view user
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                                |
       | On Hold                | label describing the credit account status |
       | Credit Account details | financial details of the credit account    |
       | Credit Account Users   | table listing users of the credit account  |

  Scenario: credit account closed view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | Closed                        | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Hold / Close History          | list of credit account hold and close transactions |
       | Credit Account details        | financial details of the credit account            |
 
   Scenario: credit account closed view user
     When staff chooses to view credit account
     Then they see the following information:
       | information            | description                                |
       | Closed                 | label describing the credit account status |
       | Credit Account details | financial details of the credit account    |
       | Credit Account Users   | table listing users of the credit account  |

  Scenario: credit account suspended view holder
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | On Hold                       | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Hold / Close History          | list of credit account hold and close transactions |
       | Credit Account details        | financial details of the credit account            |
       | Add Credit Account User       | option to add a credit account user                |
 
   Scenario: credit account suspended view user
     When staff chooses to view credit account
     Then they see the following information:
       | information                   | description                                        |
       | On Hold                       | label describing the credit account status         |
       | Credit Account Users          | table listing users of the credit account          |
       | Credit Account details        | financial details of the credit account            |

