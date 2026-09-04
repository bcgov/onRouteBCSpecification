@orv2-5730
Feature: As a staff permit issuer, I want to see the approval no. column in the applications and claimed tab of the queue, counts for the number of applications and number of claimed applications and a menu item in the sticky side bar to go to the queue, the home button will go to a placeholder page for now.

staff = PC, SA, TRAIN, CTPO

# Approval No. Column
 @orv2-5730-1
 Rule: Approval No. column shows user submitted Approval No.(s) 

  Scenario: no number
     When a user does not submit an approval number with application 123
     Then there is no approval number for application 123 in the queue
 
  Scenario: number
     When a user submits approval number ABC with application 123
     Then staff see approval number ABC for application 123 in the queue

 @orv2-5730-2
 Rule: Approval No. column shows all characters submitted by the user 

  Scenario: multiple approval numbers
     Given a user has submitted the following approval numbers with application 123
       | abc123 |
       | 123abc |
       | 456xyz |
       | xyz456 |
      Then staff see the following approval numbers in the queue for application 123
       | abc123 |
       | 123abc |
       | 456xyz |
       | xyz456 |

# Sticky Side Bar Menu
 @orv2-5730-3
 Rule: Staff can navigate directly to the cue

  Scenario: on global search
     When staff choose to go to the queue
     Then they are directed to the queue

 @orv2-5730-4
 Rule: the queue menu item is indicated as chosen

    Scenario: on queue
       When staff are at the queue
       Then the queue menu item in the sticky side bar is indicated

     Scenario: on home
       When staff ar at home
       Then the home menu item in the sticky side bar is indicated
   
 @orv2-5730-5
 Rule: Staff can navigate directly to the home page
 # placeholder welcome to onroute page for now

# Application and Claimed Count
 @orv2-5730-6
 Rule: Staff can see the number of applications in the queue 

   Scenario: 100 applications
      When there are 100 applications in the queue
      Then staff see 100 in the applications queue counter

  Scenario: 0 applications
     When there are 0 applications in the queue
     Then staff see 0 in the applications queue counter

 @orv2-5730-7
 Rule: Staff can see the number of claimed application in the queue

  Scenario: 50 claimed applications
     When there are 50 claimed applications in the queue
     Then staff see 50 in the claimed applications queue counter

  Scenario: 0 claimed applications
     When there are 0 claimed applications in the queue
     Then staff see 0 in the claimed applications queue counter