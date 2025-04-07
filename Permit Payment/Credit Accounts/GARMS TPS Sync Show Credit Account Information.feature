
Feature: GARMS TPS Sync Show Credit Account Information

Staff = FIN

@ORV2-3495-1
Rule: credit account creation in TPS/GARMS creates a credit account in onRouteBC associated to the account holder and users
  
  Scenario: no onRouteBC credit account
     When staff create a credit account in TPS/GARMS
     Then the credit account is created in onRouteBC
      And the account holder and users can pay using the credit account

  Scenario: 
    Given 
     When 
     Then 

@ORV2-3495-2
Rule: users changes in TPS/GARMS updates credit account users in onRouteBC

  Scenario: add users
    Given there are no onRouteBC users
     When staff add a user to TPS/GARMS credit account
     Then the user added in TPS/GARMS credit account is add to the onRouteBC credit account 
      And the credit account user list is updated as follows:
        | data                 | description                      |
        | Company Name         | company name from TPS/GARMS      |
        | DBA                  | doing business as from TPS/GARMS |
        | onRouteBC Client No. | ???                              |

  Scenario: remove users
    Given 
     When 
     Then 

@ORV2-3495-3
Rule: credit limit updates made in TPS/GARMS credit accounts update onRouteBC credit account limit
  
  Scenario: onRouteBC credit account on hold
    Given 
     When 
     Then they see the new credit limit

  Scenario: onRouteBC credit account closed
    Given 
     When 
     Then they see the new credit limit

@ORV2-3495-4
Rule: hold update made in TPS/GARMS credit account holds onRouteBC credit account 
  
  Scenario: not on hold
     When staff place TPS/GARMS credit account on hold
     Then the onRouteBC credit account is on hold
      And the label "On Hold" is shown

@ORV2-3495-5
Rule: remove hold update made in TPS/GARMS credit account removes hold from onRouteBC credit account 

  Scenario: on hold
     When staff remove hold from TPS/GARMS credit account
     Then the onRouteBC credit account is not on hold
      And the label "On Hold" is removed

@ORV2-3495-6
Rule: hold/remove hold updates made in TPS/GARMS credit accounts update onRouteBC credit account hold/close history

  Scenario: hold
    Given onRouteBC credit account is not on hold
     When staff place TPS/GARMS credit account on hold
     Then the onRouteBC credit account is on hold
      And the hold/close history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "On Hold"                                      |

  Scenario: remove hold
    Given onRouteBC credit account is on hold
     When staff remove hold from TPS/GARMS credit account
     Then the onRouteBC credit account hold is removed
      And the hold/close history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Hold Removed"                                 |     

@ORV2-3495-7
Rule: close update made in TPS/GARMS credit accounts closes onrouteBC credit account 

  Scenario: not closed
     When staff close TPS/GARMS credit account
     Then the onRouteBC credit account is closed
      And the label "Closed" is shown

@ORV2-3495-8
Rule: reopen update made in TPS/GARMS credit account reopens onRouteBC credit account 
  
  Scenario: closed
     When staff reopen TPS/GARMS credit account
     Then the onRouteBC credit account reopened
      And the label "Closed" is removed

@ORV2-3495-9
Rule: close/reopen update made in TPS/GARMS credit account updates onRouteBC credit account hold/close history

  Scenario: close
    Given onRouteBC credit account is not closed
     When staff place TPS/GARMS credit account closed
     Then the onRouteBC credit account is closed
      And the hold/close history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Account Closed"                               |

  Scenario: reopen
    Given onRouteBC credit account is closed
     When staff reopen TPS/GARMS credit account
     Then the onRouteBC credit account reopened
      And the hold/close history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Account Reopened"                             |    

@ORV2-3495-10
Rule: close/reopen update made in TPS/GARMS credit account does not update onRouteBC credit account users

 # this means auth users will still see this not cv clients though

  Scenario: onRouteBC credit account not closed
    Given onRouteBC credit account has users
      And it is not closed
     When staff close TPS/GARMS credit account
     Then the account is closed
      And onRouteBC credit account users are ???
 
   Scenario: onRouteBC credit account on hold ??? - can they switch from hold to closed in TPS?
     Given 
      When 
      Then 


