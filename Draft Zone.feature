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

