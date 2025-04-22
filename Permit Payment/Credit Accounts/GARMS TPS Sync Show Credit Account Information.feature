Feature: GARMS TPS Sync Show Credit Account Information

Staff = FIN
User = CA, PC, SA, CTPO, HQA

@ORV2-3495-1
Rule: a migrated credit account in TPS/GARMS creates a unverified credit account in onRouteBC associated to the account holder and users and matches the status of the credit account in TPS/GARMS
  
  Scenario: no onRouteBC credit account
     When staff create a credit account in TPS/GARMS
     Then the credit account is created in onRouteBC
      And the the credit account is unverified

  Scenario: no onRouteBC credit account on Hold
    Given the TPS/GARMS credit account A is on hold
     When credit account A is migrated to onRouteBC
     Then credit account A is on hold
      And credit account A is unverified

  Scenario: no onRouteBC credit account closed
    Given the TPS/GARMS credit account A is closed
     When credit account A is migrated to onRouteBC
     Then credit account A is closed
      And credit account A is unverified

@ORV2-3495-11
Rule: the account history is updated when a credit account is migrated to onRouteBC from TPS/GARMS

  Scenario: new migrated TPS/GARMS account
    Given credit account A does not exist in onRouteBC
     When credit account A is migrated to onRouteBC
     Then the account history for credit account A is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Migrated from TPS"                            |
        | Status | "Migrated"                                     |

@ORV2-3495-2
Rule: users changes in TPS/GARMS updates credit account users in onRouteBC

  Scenario: add users
    Given there are no onRouteBC users
     When staff add user A to TPS/GARMS credit account
     Then user A is added to the onRouteBC credit account 
      And the credit account user list is updated to include the following information about user A:
        | data                 | description    |
        | Company Name         | from onRouteBC |
        | DBA                  | from onRouteBC |
        | onRouteBC Client No. | from onRouteBC |

  Scenario: remove users
    Given there are onRouteBC users
     When staff remove user A in TPS/GARMS credit account
     Then user A is removed from the onRouteBC credit account 
      And the credit account user list is updated to remove the following information about user A:
        | data                 | description    |
        | Company Name         | from onRouteBC |
        | DBA                  | from onRouteBC |
        | onRouteBC Client No. | from onRouteBC |

@ORV2-3495-3
Rule: credit limit updates made in TPS/GARMS credit accounts update onRouteBC credit account limit
  
  Scenario: onRouteBC credit account on hold
     When staff update the credit limit in TPS/GARMS credit account
     Then they see the new credit limit in onRouteBC

  Scenario: onRouteBC credit account closed
     When staff update the credit limit in TPS/GARMS credit account
     Then they see the new credit limit in onRouteBC

@ORV2-3495-4
Rule: hold update made in TPS/GARMS credit account holds onRouteBC credit account 
  
  Scenario: not on hold verified
     When staff place TPS/GARMS credit account on hold
     Then the onRouteBC credit account is on hold
      And the label "On Hold" is shown

  Scenario: not on hold unverified
     When staff place TPS/GARMS credit account on hold
     Then the onRouteBC credit account is on hold
      And the label "On Hold" is shown
      And the label "Unverified" is shown

@ORV2-3495-5
Rule: remove hold update made in TPS/GARMS credit account removes hold from onRouteBC credit account 

  Scenario: remove on hold verified
     When staff remove hold on TPS/GARMS credit account
     Then the onRouteBC credit account is not on hold
      And the label "On Hold" is removed

  Scenario: remove on hold unverified
     When staff remove hold on TPS/GARMS credit account
     Then the onRouteBC credit account is not on hold
      And the label "On Hold" is removed
      And the label "Unverified" is shown

@ORV2-3495-6
Rule: hold/remove hold updates made in TPS/GARMS credit accounts update onRouteBC credit account account history

  Scenario: hold
    Given onRouteBC credit account is not on hold
     When staff place TPS/GARMS credit account on hold
     Then the onRouteBC credit account is on hold
      And the account history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "On Hold"                                      |

  Scenario: remove hold
    Given onRouteBC credit account is on hold
     When staff remove hold from TPS/GARMS credit account
     Then the onRouteBC credit account hold is removed
      And the account history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Hold Removed"                                 |     

@ORV2-3495-7
Rule: close update made in TPS/GARMS credit accounts closes onRouteBC credit account 

  Scenario: not closed verified
     When staff close TPS/GARMS credit account
     Then the onRouteBC credit account is closed
      And the label "Closed" is shown

  Scenario: not closed unverified
     When staff close TPS/GARMS credit account
     Then the onRouteBC credit account is closed
      And the label "Closed" is shown
      And the label "Unverified" is shown

@ORV2-3495-8
Rule: reopen update made in TPS/GARMS credit account reopens onRouteBC credit account 
  
  Scenario: closed verified
     When staff reopen TPS/GARMS credit account
     Then the onRouteBC credit account reopened
      And the label "Closed" is removed

  Scenario: closed unverified
     When staff reopen TPS/GARMS credit account
     Then the onRouteBC credit account is reopened
      And the label "Closed" is removed
      And the label "Unverified" is shown 

@ORV2-3495-9
Rule: close/reopen update made in TPS/GARMS credit account updates onRouteBC credit account account history

  Scenario: close
    Given onRouteBC credit account is not closed
     When staff place TPS/GARMS credit account closed
     Then the onRouteBC credit account is closed
      And the account history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Account Closed"                               |

  Scenario: reopen
    Given onRouteBC credit account is closed
     When staff reopen TPS/GARMS credit account
     Then the onRouteBC credit account reopened
      And the account history is updated with a new record as follows:
        | data   | description                                    |
        | IDIR   | no data                                        |
        | Date   | date/time the data was migrated into onRouteBC |
        | Reason | "Action initiated in TPS"                      |
        | Status | "Account Reopened"                             |    

@ORV2-3495-10
Rule: close/reopen update made in TPS/GARMS credit account updates onRouteBC credit account users

 # this means auth users will still see this not cv clients though
 # need to confirm what is possible, the desire is to hide users on close

  Scenario: onRouteBC credit account not closed
    Given onRouteBC credit account has users
      And it is not closed
     When staff close TPS/GARMS credit account
     Then the account is closed
      And onRouteBC credit account users are hidden in onRouteBC

  Scenario: onRouteBC credit account not closed
    Given onRouteBC credit account has users
      And it is not closed
     When staff close TPS/GARMS credit account
     Then the account is closed
      And onRouteBC credit account users are hidden in onRouteBC 
 
   Scenario: onRouteBC credit account on hold ??? - can they switch from hold to closed in TPS?
     Given 
      When 
      Then 

@orv2-3495-12
Rule: PC, CTPO can see available credit on credit account holder and credit account user profiles