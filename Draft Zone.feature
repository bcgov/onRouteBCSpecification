NOTE: This file is not a specification!

User Groups: https://moti-imb.atlassian.net/wiki/spaces/ORV2/pages/102498349/Roles+Services+and+Permissions+Matrix

Data Discovery: 

User = CA, PA, PC, SA, TRAIN, FIN, CTPO, EO, HQA
CV Client = CA, PA
Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA
Auth Staff = PC, SA, TRAIN, CTPO
Non Auth Staff = FIN, EO, HQA


| Permit Type | New Application CV Client                   | Amend Application Staff                                 |
| TROS        | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| TROS        | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| TROW        | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| TROW        | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| STOS        | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| STOS        | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| MFP         | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| MFP         | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| STFR        | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| STFR        | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| QRFR        | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| QRFR        | Any-60 days from now (Editable - Staff)     | Same quarter as Start date-60 days from now (Editable - Staff)  |
| NRSCV       | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| NRSCV       | Any-60 days from now (Editable - Staff)     | Any-60 days from now (Editable - Staff)                         |
| NRQCV       | Now-14 days from now (Editable - CV Client) | N/A                                                             |
| NRQCV       | Any-60 days from now (Editable - Staff)     | Same quarter as Start date- 60 days from now (Editable - Staff) |

Feature: Refund to multiple payment methods credit account

Rule: credit account void and amend with refund permit pdf and receipt are always sent to the credit account holder

  Scenario: credit account holder
    Given 
     When 
     Then they only get one email

  Scenario: credit account user
    Given 
     When 
     Then 

Rule: Maximum 15 characters allowed in Transaction ID

Enter 16 characters
they see "Maximum 15 characters"

In staff shopping cart:

   Scenario: date extension
     Given permit A 
      When 
      Then 
 
   Scenario: km added
     Given 
      When 
      Then 
 
   Scenario: weight increased
     Given 
      When 
      Then 
 
  Scenario: dangerous goods
    Given 
     When 
     Then 


Feature: Basic BCeID CV Client Create a New onRouteBC Profile

Feature: Basic BCeID CV Client Claim a onRouteBC Profile

Feature: Basic BCeID CV Client Invited User Log Into onRouteBC

User = CA, PA

# Rule: credential X must match invited username in onRouteBC

Rule: a user can choose to create a new onRouteBC Profile

Rule: a user can choose to claim an onRouteBC profile

Rule: a user must update mandatory contact details

Rule: 

  Scenario: 
    Given 
     When 
     Then 
     
Stow Return Trip:

Rule: STOW permit default is a one way trip

  Scenario: default trip type new
     Given a user has started a new STOS application
     When they view trip details
     Then they see One Way chosen

Rule: a user can optionally choose to designate the STOW application as a return trip

  Scenario: designate return trip
     Given a user has started a new STOS application
      And they have not designated the application as a return trip
     When they choose to designate the application as a return trip
     Then the return trip is selected

  Scenario: remove return trip designation
     Given a user has chosen to designate the application as a return trip
     When they choose to designate the application as a one way trip
     Then the return trip is not selected

Rule: a return trip multiplies the one way fee by 2

  Scenario: return trip fee calculation
     Given a user has designated the application as a return trip
     When they continue to "Review and Confirm Details" page
     Then the permit fee is calculated as $30

Rule: if chosen a return trip is indicated on the generated permit pdf

  Scenario: return trip pdf
     Given a user has designated the application as a return trip
     When they successfully purchase their permit
     Then the generated permit pdf indicates "Permitted for return trip along the same route." in the trip details section

  Scenario: one way trip pdf
     Given a user has designated the application as a one way trip
     When they successfully purchase their permit
     Then the generated permit pdf does not indicate "Permitted for return trip along the same route." in the trip details section

Rule: the trip type is shown on review and confirm details

  Scenario: return trip
     Given a user has chosen to designate the application as a return trip
     When they continue to "Review and Confirm Details" page
     Then they see the return trip designation
      And they see "Permitted for return trip along the same route."

  Scenario: one way trip
     Given a user has chosen to designate the application as a one way trip
     When they continue to "Review and Confirm Details" page
     Then they see the one way trip designation
      And they do not see "Permitted for return trip along the same route."

Application has violations and/or warnings
 
I confirm that I have reviewed the violations and/or warnings associated with this permit application and would like to add it to the cart.

For a Tandem Drive/Single Jeep axle group, if the axle spread from the tandem drive to the single jeep axle is between 2.4 m and 2.99 m, the allowed weight is 28,000 kg. If the axle spread is between 3.0 m and 3.7 m, the allowed weight is 29,000 kg.

@orv2-5553-1
Rule: a rejected application in progress shows a rejected label

  Scenario: rejected application in progress
    Given the CV Client is at the "Applications in Progress" tab 
      And they have a rejected application in progress
     When they view the application in progress
     Then they see "R" (Rejected) label on the application

@orv2-5553-2
Rule: a rejected application in progress can be edited and added to cart for submission by staff only

  Scenario: rejected by staff then added to cart from AIP
    Given the CV Client is at the "Applications in Progress" tab 
      And they have a rejected application in progress
     When they view the application in progress
      And they choose to edit the application 
      And they add the edited rejected application to cart

@orv2-5553-3
Rule: a rejected application from queue shows rejected status in applications in progress

  Scenario: rejected from queue shows R in AIP
    Given the CV Client is at the "Applications in Progress" tab
      And they have an application rejected from queue
    When they view the application in progress
    Then they see "R" (Rejected) label on the application

  Scenario: non-rejected application does not show R in AIP
    Given the CV Client is at the "Applications in Progress" tab
      And they have an application in progress that is not rejected
    When they view the application in progress
    Then they do not see "R" (Rejected) label on the application

@orv2-5553-4
Rule: a rejected application submitted to applications in review shows status by claim state

  Scenario: rejected submitted to AIR shows PR when not claimed
    Given the CV Client has submitted a rejected application to "Applications in Review"
      And the application has not been claimed
    When they view the application in "Applications in Review"
    Then they see "PR" (Pending Review) status on the application

  Scenario: rejected submitted to AIR does not show PR when claimed
    Given the CV Client has submitted a rejected application to "Applications in Review"
      And the application has been claimed
    When they view the application in "Applications in Review"
    Then they do not see "PR" (Pending Review) status on the application
      And they see "IR" (In Review) status on the application

@orv2-5553-5
Rule: a rejected application withdrawn from applications in review back to applications in progress shows rejected label

  Scenario: rejected withdrawn from AIR to AIP shows R
    Given the CV Client has a rejected application in "Applications in Review"
    When the application is withdrawn to "Applications in Progress"
    Then they see "R" (Rejected) label on the application in "Applications in Progress"

  Scenario: withdrawn non-rejected application does not show R
    Given the CV Client has an application in "Applications in Review" that is not rejected
    When the application is withdrawn to "Applications in Progress"
    Then they do not see "R" (Rejected) label on the application in "Applications in Progress"

@orv2-5553-6
Rule: a rejected application approved to cart from queue and then removed from cart maintains rejection history without rejected label in applications in progress

  Scenario: approved to cart then removed keeps history and not R in AIP
    Given the CV Client has a rejected application submitted to "Applications in Review"
      And the application is claimed and approved to cart
    When they remove the approved application from cart
    Then rejection history is maintained on the application
      And they do not see "R" (Rejected) label on the application in "Applications in Progress"
      And they do not see a rejection banner on the application

  Scenario: approved to cart then removed does not lose rejection history
    Given the CV Client has a rejected application submitted to "Applications in Review"
      And the application is claimed and approved to cart
    When they remove the approved application from cart
    Then rejection history is maintained on the application

@orv2-5553-7
Rule: a rejected application added directly to cart by staff and removed from cart maintains rejection state in applications in progress

  Scenario: staff adds rejected application directly to cart and removed shows R in AIP
    Given staff has added a rejected application directly to cart from "Applications in Progress"
    When the application is removed from cart
    Then rejection history is maintained on the application
      And they see "R" (Rejected) label on the application in "Applications in Progress"
      And they see a rejection banner on the application

  Scenario: non-rejected staff direct-to-cart removed does not show rejection indicators
    Given staff has added an application that is not rejected directly to cart from "Applications in Progress"
    When the application is removed from cart
    Then they do not see "R" (Rejected) label on the application in "Applications in Progress"
      And they do not see a rejection banner on the application
