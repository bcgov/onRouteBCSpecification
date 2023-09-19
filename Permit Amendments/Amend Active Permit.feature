Feature:  Amend an active TROS permit 
   As PPC staff I need to be able to amend an active TROS permit by changing the vehicle plate, vehicle and dates, so that I can assist CV Clients.

@orv2-938-11
  Scenario: Found permit to amend
    Given the PPC SA has found a valid permit to amend
     When they choose to amend it
     Then they are directed to the amend permit page
      And they see:
         | description           | information                              |
         | page header           | Void Permit                              |
         | cookie crumb location | Void Permit                              |
         | permit type name      | of voiding permit                        |
         | permit number         | of voiding permit                        |
         | permit start date     | of voiding permit                        |
         | permit end date       | of voiding permit                        |
         | vehicle plate         | of voiding permit                        |
         | banner                | company name of voiding permit           |
         | banner                | company client number  of voiding permit |
         | fee summary           | voiding permit description               |
         | fee summary           | total refund amount                      |
         | revoke permit option  | mechanism to revoke permit               |

Rule: PPC SA and PC can change a TROS permit vehicle plate 

@orv2-938-1
  Scenario: Change vehicle plate
    Given a PPC SA or PC has chosen to change the plate number
     When they update the vehicle plate number
     Then the change is accepted

Rule: PPC SA and PC can change a TROS permit's duration 

# @orv2-938-2 (Deprecated for version 1 of this feature)
#  Scenario: Extend term duration
#    Given a PPC SA or PC has chosen to extend the permit duration
#     When they extend <permit duration>
#     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>

#     Examples:
#       | permit expiry date | permit duration | amended permit expiry date |
#       | March 30, 2023     | 30              | April 29, 2023             |
#       | April 13, 2023     | 30              | May 13, 2023               |
  
@orv2-938-3
  Scenario: Shorten term duration
    Given a PPC SA or PC has chosen to shorten the permit duration
     When they shorten <permit duration>
     Then the <amended permit expiry date> displays a future date that is the <permit duration> minus 1 plus the <permit expiry date>  
     
     Examples:
       | permit expiry date | permit duration | amended permit expiry date |
       | April 29, 2023     | 30              | March 30, 2023             |
       | May 13, 2023       | 30              | April 13, 2023             |

Rule: PPC SA and PC can change a TROS permit vehicle 

@orv2-938-4
  Scenario: Change vehicle
    Given a PPC SA or PC has chosen to change the vehicle
     When they update the vehicle
     Then the change is accepted

Rule: PPC SA and PC can add free text amendment Reason 

@orv2-938-5
  Scenario: Save amendment reason
    Given the PPC Staff has recorded an amenment reason
     When they choose to save the permit application or continue to "Review and Confirm Details"
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC Staff username> is saved

   Examples:
     | <PPC Staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8:23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |


@orv2-938-7
  Scenario: Attempt to continue without updating amendment
    Given a PPC SA or PC has not inputted a reasonf ro amendment amendment 
     When they chose to continue to review and confirm details
     Then they see "This is a required field"

Rule: The fee credit or debit is calculated if is is affected by the amendment 

@orv2-938-6
  Scenario: Calculate amendment fee
    Given the  
     When 
     Then 

Rule: Amendment change is indicated 

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

