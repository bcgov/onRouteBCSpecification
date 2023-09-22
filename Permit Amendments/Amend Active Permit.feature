Feature:  Amend an active permit 
   As PPC staff I need to be able to amend an active permit by changing the vehicle plate, vehicle and dates, so that I can assist CV Clients.

Rule: PPC SA or PC can amend an issued or active permit


  Scenario: Found permit to amend
    Given the PPC SA has found a valid permit to amend
     When they choose to amend it
     Then they are directed to the amend permit page
      And they see:
         | description           | information                                     |
         | page header           | Amend Permit                                    |
         | cookie crumb location | Amend Permit                                    |
         | permit type name      | of amending permit                              |
         | permit number         | of amending permit                              |
         | date created          | date the amending permit application is created |
         | last updated          | date the amending permit application is created |
         | banner                | company name of amending permit                 |
         | banner                | company client number of amending permit        |
         | company information   | company mailing address of amending permit      |

Rule: PPC SA or PC can view all permit details of the amending permit


Scenario: PPC SA or PC choose to amend a valid permit
    Given the PPC SA or PC has chosen to amend a valid permit
     When they are at the amend permit page
     Then they see all permit application details of the amending permit:
         | description          | information                                     |
         | contact information  | of the amending permit                          |
         | permit details       | of the amending permit                          |
         | vehicle information  | of amending permit                              |
         | revision history     | past reason for amendment free text             |
         | reason for amendment | free text field to capture reason for amendment |


Rule: PPC SA and PC can add free text amendment Reason 


  Scenario: Save amendment reason
    Given the PPC Staff has inputted an amendment reason
     When they choose continue to review and confirm details
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC Staff username> is saved

   Examples:
     | <PPC Staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8:23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |



  Scenario: Attempt to continue without updating amendment reason
    Given a PPC SA or PC has not inputted a reason for amendment 
     When they chose to continue to review and confirm details
     Then they see "This is a required field"
      And they cannot continue


  Scenario: Reason for amendment mandatory
    Given a PPC Staff is at the "Amend Permit" page 
     When they attempt to continue
      And they have not entered a reason for amendment
     Then they see "This is a required field"

Rule: PPC SA or PC can view the permit revision history

  Scenario: Previous permit revisions
    Given an amending permit has previous revisions
     When a PPC SA or PC is amending a permit
     Then they see previous <amendment reason>
      And the <PPC Staff username> of the logged in user that saved the amendment
      And the <timestamp> of when the amendment reason was saved

   Examples:
     | <PPC Staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8:23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |


  Scenario: No previous permit revisions
    Given an amending permit does not have previous revisions
     When a PPC SA or PC is amending a permit
     Then there is no information displayed under revision history

