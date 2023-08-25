Feature:  Amend an active permit 
   As a PPC Clerk I need to be able to amend an active permit by changing the vehicle plate, vehicle and dates, so that I can assist CV Clients.

@orv2-938-1
  Scenario: Change vehicle plate
    Given a PPC Clerk has chosen to change the plate number
     When they update the vehicle plate number
     Then the change is accepted

@orv2-938-2
  Scenario: Extend term duration
    Given a PPC Clerk has chosen to extend the permit duration
     When they extend <permit duration>
     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>

     Examples:
       | permit expiry date | permit duration | amended permit expiry date |
       | March 30, 2023     | 30              | April 29, 2023             |
       | April 13, 2023     | 30              | May 13, 2023               |
  
@orv2-938-3
  Scenario: Shorten term duration
    Given a PPC Clerk has chosen to shorten the permit duration
     When they shorten <permit duration>
     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>  
     
     Examples:
       | permit expiry date | permit duration | amended permit expiry date |
       | March 30, 2023     | 30              | April 29, 2023             |
       | April 13, 2023     | 30              | May 13, 2023               |

@orv2-938-4
  Scenario: Change vehicle
    Given a PPC Clerk has chosen to change the vehicle
     When they update the vehicle
     Then the change is accepted

@orv2-938-5
  Scenario: Save amendment reason
    Given the PPC Staff has recorded an amenment reason
     When they choose to save the permit application or continue to "Review and Confirm Details"
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC Staff username> is saved

   Examples:
     | <PPC Staff username> | <timestamped>             | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8colon23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |

@orv2-938-6
  Scenario: Calculate amendment fee
    Given the  
     When 
     Then 

@orv2-938-7
  Scenario: Display working in company name
    Given A PPC Staff chooses to amend a permit
     When they choose a permit to amend
     Then they see "You are currently working in <Company Name>."

@orv2-938-8
  Scenario: Indicate change made
    Given a PPC staff is at the "Review and Confirm Details" page
     When they review their updates made
     Then the information updated is indicated as "Changed"

@orv2-938-9
  Scenario: Record reason for amendment
    Given they PPC Staff is at "Amend Permit"
     When they 
     Then 

@orv2-938-10
  Scenario: Reason for amendment mandatory
    Given a PPC Staff is at the "Amend Permit" page 
     When they attempt to save or continue
      And they have not entered a reason for amendment
     Then they see "This is a required field"

