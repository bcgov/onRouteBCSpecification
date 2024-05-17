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

