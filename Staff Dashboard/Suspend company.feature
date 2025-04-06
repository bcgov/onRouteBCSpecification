Feature: Suspend company
As authorized staff I need to be able to suspend a company in onRouteBC so that they cannot purchase permits.

Authorized staff = FIN, SA, CTPO
Not authorized staff = PC, TRAIN, EO, HQA
Users = PC, SA, TRAIN, FIN, CTPO, EO, HQA

@orv2-1856-1 @orv2-3835-20
Rule: only authorized staff can suspend or unsuspend a company

  Scenario: authorized
    Given at active company profile 
     When FIN, SA, CTPO choose to suspend the company
     Then they see the option to suspend
      And it is available

  Scenario: not authorized
    Given at active company profile 
     When PC, TRAIN, EO, HQA choose to suspend the company
     Then they see the option to suspend
      And it is not available

  Scenario: currently active previously suspended
    Given at company profile
     When FIN, SA, CTPO choose to suspend
     Then they see the option to suspend
      And they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date and time of a suspend transaction record in PT        |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  Scenario: suspend confirmation
    Given at suspend details
     When FIN, SA, CTPO suspend a company
     Then they see the option to suspend or cancel
      And they see the option to input a reason for suspension

  Scenario: suspend
    Given at confirm suspension
     When FIN, SA, CTPO input a reason for suspension
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
     When FIN, SA, CTPO choose not to suspend
     Then they are directed to the suspend details

 Scenario: remove company suspension
    Given company is suspended
     When FIN, SA, CTPO choose to remove the company suspension
     Then they see indication the company suspension is removed
      And they see the suspend history table updated with the following information:
       | IDIR   | the idir username of a suspend transaction record                        |
       | Date   | the date and time of a suspend transaction record in PT                  |
       | Reason | the free text reason inputted for a suspend transaction record           |
       | Status | the state change of a suspend transaction record is "Suspension Removed" |


@orv2-1856-2
Rule: Staff must input a reason for suspension

    Given at confirm suspension
     When FIN, SA, CTPO do not input a reason for suspension
      And choose to suspend
     Then they see "This is a required field"
      And reason for suspension is indicated
      And they cannot suspend the company

@orv2-1856-4 @orv2-3835-21
Rule: Users see indication of the CV Client suspension status on all page headers

  Scenario: on any page
    Given at suspended company profile
     When users view any page
     Then they see the indication of company suspension

  Scenario: viewing application in progress
    Given at applications in progress
     When users choose to view or start an application
     Then they see the indication of company suspension

@orv2-1856-5
Rule: the CV Client is sent an email notification when turning the suspension on or off 

  Scenario: company suspended
    Given company has been suspended
     When staff suspend the company
     Then the CV Client is sent the profile suspended email

  Scenario: company suspension removed
    Given company suspension removed
     When staff has removed the company suspension
     Then the CV Client is sent the profile suspension removed email

@orv2-1880-1 @orv2-3835-22
Rule: Users can view the suspension history table

  Scenario: suspended company profile
    Given at company profile
     When users choose to view suspend details
     Then they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date and time of a suspend transaction record in PT        |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  Scenario: currently active but previously suspended
    Given at company profile
     When users choose to view suspend details
     Then they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date and time of a suspend transaction record in PT        |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  # not sure this is true
  Scenario: never suspended
    Given at company profile
     When users choose to view suspend details
     Then they do not see the option to view suspend details

# not sure this is true
@orv2-1880-2
Rule: PC cannot suspend a company

  Scenario: active company
    Given at company profile
     When they choose to view suspension details
     Then they do not see the option to view suspend details

@orv2-1880-4 @orv2-3835-23
Rule: Users suspended cv client profile view and edit permissions are the same as non-suspended cv client profiles



# When a Credit Account (CA) Holder is suspended any CA User of that account will not be able to use the CA Holders CA
# When a Credit Account (CA) User is suspended they will not be able to use the CA Holder CA and are removed from the CA Holder user table

# @orv2-1880-5
# Deprecated
# Rule: SA, CTPO, PC, Trainee can resend a suspended company's active and expired permits

# @orv2-1880-3
# Deprecated
# Rule: PC can not make changes to a suspended company profile

  Scenario: company information
    Given at company information
     When they attempt to make changes
     Then they do not have the option to edit

  Scenario: user management
    Given at user management
     When they attempt to make changes
     Then they do not have the following options available:
       | add users    |
       | edit users   |
       | delete users |

  Scenario: application in progress
    Given at applications in progress
     When they attempt to make changes
     Then they do not have the following options available:
       | start an application           |
       | choose a permit type           |
       | delete applications            |
       | choose application in progress |
       | edit application in progress   |
       | view applications in progress  |

  Scenario: vehicle inventory
    Given at vehicle inventory
     When they attempt to make changes
     Then they do not have the following options available:
       | edit power unit or trailer   |
       | add power unit or trailer    |
       | delete power unit or trailer |
       | choose power unit or trailer |
