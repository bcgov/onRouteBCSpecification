Feature:  Amend an active permit 
   As a PPC Clerk I need to be able to amend an active permit by changing the vehicle plate, vehicle and term length, so that I can assist CV Clients.

@orv2-938-1
  Scenario: Change vehicle plate
    Given 
     When 
     Then 

@orv2-938-2
  Scenario: Extend term length
    Given 
     When 
     Then 

@orv2-938-3
  Scenario: Shorten term length
    Given 
     When 
     Then 

@orv2-938-4
  Scenario: Change vehicle
    Given 
     When 
     Then 

@orv2-938-5
  Scenario: Save amendment reason
    Given the PPC Clerk has recorded an amenment reason
     When they choose to save the permit application or continue to "Review and Confirm Details"
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC Clerk username> is saved

   Examples:
     | <PPC Clerk username> | <timestamped>             | <amendment reason>                                |
     | jdoe                 | April 15, 8colon23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |

@orv2-938-6
  Scenario: Calculate amendment fee
    Given the  
     When 
     Then 

@orv2-938-7
  Scenario: Display working in company name
    Given A PPC Clerk chooses to amend a permit
     When they choose a permit to amend
     Then they see "You are currently working in <Company Name>."

@orv2-938-8
  Scenario: Indicate change made
    Given 
     When 
     Then 

@orv2-938-9
  Scenario: Record reason for amendment
    Given they PPC Clerk is at "Amend Permit"
     When they 
     Then 

@orv2-938-10
  Scenario: 
    Given 
     When 
     Then 

