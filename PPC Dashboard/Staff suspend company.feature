Feature: Staff suspend company
As HQ Finance, PPC Admin or PPC CTPO I need to be able to suspend a company in onRouteBC so that they cannot purchase permits.

@orv2-1856-1
Rule: HQ Finance, PPC Admin or PPC CTPO can turn on/off the suspend flag

  Scenario: 
    Given 
     When 
     Then 

@orv2-1856-2
Rule: On successful login a suspended CV Client is directed to a profile suspended page

@orv2-1856-3
Rule: PPC PC staff are directed to a profile suspended page when attempting to view a suspended CV Client profile

@orv2-1856-4
Rule: HQ Finance, PPC Admin or PPC CTPO see indication of the CV Client suspended status on all page headers

@orv2-1856-5
Rule: HQ Finance, PPC Admin or PPC CTPO can input a reason for suspension

@orv2-1856-6
Rule: On successful save of reason for suspension the logged in user id and time and date are saved with the reason

@orv2-1856-7
Rule: On successfully turning the suspension on/off the CV Client is sent an email notification 

# When a Credit Account (CA) Holder is suspended any CA User of that account will not be able to use the CA Holders CA


