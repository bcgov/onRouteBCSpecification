Feature:  Amend an issued or active permit 
   As staff I need to be able to amend an issued or active permit by changing the vehicle plate, vehicle and dates, so that I can assist CV Clients.

staff = PC, SA, TRAIN, CTPO
CV Client = CA, PA

@orv2-4140
Rule: an unfinished amending permit application (APA) is created or iterated on when staff continue to review and confirm

  Scenario: no APA
    Given permit A has no unfinished APA
     When staff choose to amend permit A
      And continue to review and confirm
     Then permit A has the first unfinished APA iteration

  Scenario: 1 or more unfinished APA changes
    Given permit A has unfinished APA changes
     When staff choose to amend permit A
      And continue to review and confirm
     Then they see their changes 
      And previous iteration changes that have not been overwritten by them

@orv2-4140
Rule: previous unfinished APA iteration changes can be overwritten by staff

  Scenario: 1 or more APA changes
    Given permit A has latest unfinished APA X
      And plate was changed to ABC123 in unfinished APA X
     When staff choose to amend permit A
      And change plate to XYZ123
     Then XYZ123 is the current iteration of plate for the unfinished APA for permit A
   
@orv2-4140
Rule: unfinished APA are not shown in applications in progress (AIP)

  Scenario: APA created continue
    Given staff initiate an amend on permit A
     When staff continue to review and confirm
     Then there is an APA for permit A

  Scenario: APA fails finish
    Given staff initiate an amend on permit A
      And they are at finish
     When staff choose to finish the APA
      And it fails to finish
     Then there is an APA for permit A

  Scenario: APA canceled
    Given staff initiate an amend on permit A
      And they are at the application form
     When staff choose to cancel 
     Then there is no APA for permit A

# @orv2-4140
# Rule: initiating an edit action on an APA in the shopping cart directs the user to the unfinished APA that contains the current issued or active permit data and any changes made on previous unfinished APA's

  Scenario: 
    Given 
     When 
     Then 

# @orv2-4140
# Rule: editing an APA in the shopping cart are unfinished APA's

  Scenario: 
    Given 
     When 
     Then 

@orv2-4140
Rule: staff must confirm how to proceed when initiating an amend action when the issued or active permit has an unfinished APA 

  Scenario: no unfinished APA
    Given permit A has no unfinished APA
     When staff initiate an amend action on permit A
     Then they are directed to the APA form

  Scenario: unfinished APA
    Given permit A has unfinished APA
     When staff initiate an amend action on permit A
     Then they see the the following:
       | data               | description                                                                                                         |
       | Amending Permit #  | the permit number of the permit they initiated and amend action on                                                  |
       | IDIR               | the username of the last staff member to create an unfinished APA                                                   |
       | Cancel             | option to cancel the amend permit action                                                                            |
       | New Amendment      | option to discard unfinished amendments and start a new one with only current issued or active permit data |
       | Continue Amendment | option to continue the unfinished amendments with all previous APA changes                                          |

@orv2-4140
Rule: staff can optionally choose to cancel the amend permit action

  Scenario: cancel
     When staff choose to cancel the amend action
     Then they are directed to the page they initiated the amend action on
      And an new iteration of the APA is not created

@orv2-4140
Rule: staff can optionally choose to create a new APA which directs them to a new APA that contains only the current issued or active permit data

  Scenario: unfinished APA exists
    Given permit A has unfinished APA
     When staff choose to create a new amendment
     Then previous APA changes are discarded 
      And they are directed to the APA form
      And they see only the current issued or active permit data

@orv2-4140
Rule: staff can optionally choose to continue to amend an unfinished APA which directs them to the unfinished APA that contains the current issued or active permit data and any changes made on previous unfinished APA's

  Scenario: 1 or more APA iterations
    Given permit A has the following unfinished APA changes:
      | APA iteration | data     | changed to |
      | 1             | plate    | ABC123     |
      | 2             | duration | 30         |
      | 3             | VIN      | 987654     |
     When staff change model to Ford
     Then they see the following changes indicated on review and confirm:
      | data     | changed to |
      | plate    | ABC123     |
      | duration | 30         |
      | VIN      | 987654     |
      | model    | Ford       |

# @orv2-4140
# Rule: APA in the shopping cart

  Scenario: staff view
    Given 
     When 
     Then 

  Scenario: staff pay
    Given 
     When 
     Then 

  Scenario: staff remove
    Given 
     When 
     Then 

  Scenario: staff edit
    Given 
     When 
     Then           

  Scenario: cv client view
    Given 
     When 
     Then 

  Scenario: cv client pay
    Given 
     When 
     Then 

  Scenario: cv client remove
    Given 
     When 
     Then 



@orv2-938-8 @orv2-4015
Rule: staff can only amend an issued or active permit

  Scenario: Permit is voided
    Given the PPC SA has found a void permit
     When they choose to amend it
     Then they cannot amend it

  Scenario: Permit is issued
    Given the PPC SA has found an issued permit
     When they choose to amend it
     Then they are directed to the amend permit 

  Scenario: Valid permit
    Given the staff have found a valid permit to amend
     When they choose to amend the permit
     Then they are directed to the amend permit page

  Scenario: Found permit to amend
    Given the PPC SA has found a valid permit to amend
     When they choose to amend it
     Then they are directed to the amend permit page
      And they see:
         | description           | information                                                      |
         | page header           | Amend Permit                                                     |
         | cookie crumb location | Amend Permit                                                     |
         | permit type name      | of amending permit                                               |
         | permit number         | of amending permit                                               |
         | date created          | date the amending permit application is created                  |
         | last updated          | date the amending permit application is created                  |
         | banner                | company name of amending permit                                  |
         | banner                | company client number of amending permit                         |
         | company information   | company mailing address of amending permit and DBA if applicable |

@orv2-938-30 @orv2-4015
Rule: staff can view superseded permit and superseded permit receipt pdf  

@orv2-938-9 @orv2-4015
Rule: staff can resend superseded permit documents

@orv2-938-12 @orv2-4015
Rule: staff can see the current issued or active permit data of the permit being amended

 Scenario: staff choose to amend a valid permit
      When they are at the amend permit page
      Then they see all original permit application details of the amending permit

@orv2-938-13 @orv2-4015
Rule: staff must add free text amendment Reason 

  Scenario: Save amendment reason
    Given the PPC staff has inputted an amendment reason
     When they choose continue to review and confirm details
     Then the <amendment reason> is saved
      And the reason is <timestamped> 
      And the logged in <PPC staff username> is saved

   Examples:
     | <PPC staff username> | <timestamped>                  | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8colon23 am PDT | Swapped a Droid Gunship for the Millennium Falcon |

  Scenario: Attempt to continue without updating amendment reason
    Given a staff has not inputted a reason for amendment 
     When they chose to continue to review and confirm details
     Then they see "This is a required field"
      And they cannot continue

  Scenario: Reason for amendment mandatory
    Given a PPC staff is at the "Amend Permit" page 
     When they attempt to continue
      And they have not entered a reason for amendment
     Then they see "This is a required field"

@orv2-938-14 @orv2-4015
Rule: staff can view the permit revision history

  Scenario: Previous permit revisions
    Given an amending permit has previous revisions
     When a staff is amending a permit
     Then they see previous <amendment reason>
      And the <PPC staff username> of the logged in user that saved the amendment
      And the <timestamp> of when the amendment reason was saved

   Examples:
     | <PPC staff username> | <timestamped>              | <amendment reason>                                |
     | jdoe                 | Apr. 15, 2023, 8colon23 am PDT | Swapped a Droid Gunship for the Millennium Falcon | 

  Scenario: No previous permit revisions
    Given an amending permit does not have previous revisions
     When a staff is amending a permit
     Then there is no revision history displayed 

@orv2-938-15 @orv2-4015 
Rule: cancelling an amend permit action returns a user to the screen the amend action was initiated 

  Scenario: cancel permit amendment application search results
    Given staff initiated permit amendment from search results
     When they cancel 
     Then they are directed to the <search results> page
      And they see the <previous search string> results
      And active toggle is off

     Examples:
     | previous search string | search results                                            |
     | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

  Scenario: cancel permit amendment application active permits
    Given staff initiated permit amendment from active permits
     When they cancel 
     Then they are directed to the active permits page

@orv2-938-20 @orv2-4015
Rule: upon finishing $0 permit amendment staff return to page where amend permit was initiated

  Scenario: initiated from search results
    Given the staff has finished the amending permit application
     When they are directed to the <search results> page
     Then they see the <previous search string> results
      And they see "Permit Amended" notification
      And active toggle is off

     Examples:
     | previous search string | search results                                            |
     | P2-00408617            | all permits with matching first 11 characters P2-00408617 |

  Scenario: initiated from active permits
    Given staff initiated permit amendment from active permits
     When they leave 
     Then they are directed to the active permits page

@orv2-938-21 @orv2-4015
Rule: Amending permit is superseded by amended permit

  Scenario: Supersede amending permit
     When they finish the amending permit application
     Then the amending permit is labeled as superseded

@orv2-938-22 @orv2-4015
Rule: Generate amended permit pdf

   Scenario: Generate amended permit pdf
     Given the PPC SA has inputted all mandatory information at finish amendment
      When they choose to finish amending the permit
      Then the amended permit pdf is generated
       And the following information is updated on the generated amended permit pdf:
         | description      | information                                                                |
         | permit details   | reflects amendments made                                                   |
         | revision history | reflects the date/time and free text comment(s) inputted at amended permit |
         | revised on       | date/time updated to reflect the date the amended pdf is generated         |
         | permit number    | permit number reflects the revised number                                  |

@orv2-1491-3 @orv2-4015
Rule: An issued or active permit issued under a no fee designation maintains a $0 fee when amended

  Scenario: cv client issues under no fee flag changes to fee cv client
    Given ABC Co. is a no fee cv client
     And they issue permit A
     And permit A is not expired
     When staff remove ABC Co. no fee designation
     Then permit A has a $0 fee

@orv2-4015
Rule: staff can choose to amend a permit from staff search for permit results and the cv client profile active permits




## OLD

## @orv2-938-10
## Rule: A saved amending permit application is in application in progress

  Scenario: Close browser tab
    Given a staff has started an amending permit application 
      And it is not saved
     When they close the browser tab or window
     Then the amending permit application is not saved

  Scenario: Go back
    Given a staff has started an amending permit application 
      And it is not saved
     When they use the browser to navigate back
     Then the amending permit application is not saved

## @orv2-938-32
## Rule: staff can see saved amending permit applications in applications in progress

#@orv2-938-16
#Rule: staff can view previous financial transaction information for amending permit

 Scenario: Previous financial transactions iterations
     Given the PPC SA is at the finish amendment page
      When they view transaction history
      Then they see the following details of all previous transactions for the amending permit:
        | description                                    | information    |
        | permit number for listed transaction           | Permit #       |
        | payment method used for the listed transaction | Payment Method |
        | transaction id for the listed transaction      | Transaction ID |
        | total fee for the listed transaction           | Amount         |

#@orv2-938-17
#Rule: Amemndment with refurn default to previous payment method card type

   Scenario: Choose a refund method
     Given the PPC SA has completed mandatory field at review and confirm details
      When they choose to continue
      Then they are directed to finish amendment
       And the previous payment method <consolidated payment method> is used

       Examples:
         | card type                | PPC prefix               |
         | ICEPAY - Visa            | ICEPAY - Visa            |
         | ICEPAY - Mastercard      | ICEPAY - Mastercard      |
         | Web - Visa               | Web - Visa               |
         | Web - Mastercard (Debit) | Web - Mastercard (Debit) |

#@orv2-938-18
#Rule: Choose cheque payment method