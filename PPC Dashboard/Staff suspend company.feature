Feature: Staff suspend company
As staff I need to be able to suspend a company in onRouteBC so that they cannot purchase permits.

Staff = FIN, SA, CTPO

@orv2-1856-1
Rule: Staff can suspend or unsuspend a company

  Scenario: active company never suspended
    Given at active company profile 
     When they choose to suspend the company
     Then they see the only the option to suspend

  Scenario: currently active previously suspended
    Given at company profile
     When they choose to suspend
     Then they see the option to suspend
      And they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date and time of a suspend transaction record in PT        |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  Scenario: suspend confirmation
    Given at suspend details
     When they suspend a company
     Then they see the option to suspend or cancel
      And they see the option to input a reason for suspension

  Scenario: suspend
    Given at confirm suspension
     When they input a reason for suspension
      And choose to suspend
     Then they are directed to the suspend details
      And they see indication the company is suspended
      And they see the suspend history table updated with the following information:
       | IDIR   | the idir username of a suspend transaction record               |
       | Date   | the date and time of a suspend transaction record in PT         |
       | Reason | the free text reason inputted for a suspend transaction record  |
       | Status | the state change of a suspend transaction record is "Suspended" |

  Scenario: cancel suspend
    Given at confirm suspension
     When they choose not to suspend
     Then they are directed to the suspend details

 Scenario: remove company suspension
    Given company is suspended
     When they choose to remove the company suspension
     Then they see indication the company suspension is removed
      And they see the suspend history table updated with the following information:
       | IDIR   | the idir username of a suspend transaction record                        |
       | Date   | the date and time of a suspend transaction record in PT                  |
       | Reason | the free text reason inputted for a suspend transaction record           |
       | Status | the state change of a suspend transaction record is "Suspension Removed" |


@orv2-1856-2
Rule: Staff must input a reason for suspension

    Given at confirm suspension
     When they do not input a reason for suspension
      And choose to suspend
     Then they see "This is a required field"
      And reason for suspension is indicated
      And they cannot suspend the company

@orv2-1856-4
Rule: Staff see indication of the CV Client suspension status on all page headers

  Scenario: on any page
    Given at suspended company profile
     When they view any page
     Then they see the indication of company suspension

  Scenario: viewing application in progress
    Given at applications in progress
     When they choose to view or start an application
     Then they see the indication of company suspension

@orv2-1856-5
Rule: Turning the suspension on/off the CV Client is sent an email notification 

  Scenario: company suspended
    Given company has been suspended
     When staff suspend the company
     Then the CV Client is sent the profile suspended email

  Scenario: company suspension removed
    Given company suspension removed
     When staff has removed the company suspension
     Then the CV Client is sent the profile suspension removed email


# When a Credit Account (CA) Holder is suspended any CA User of that account will not be able to use the CA Holders CA


