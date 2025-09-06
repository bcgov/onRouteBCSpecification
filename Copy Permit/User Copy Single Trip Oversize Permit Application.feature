Feature: User Copy Single Trip Oversize Permit application Application

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO
cv client = CA, PA

@orv2-4969-4
Rule: There is no association between the copied permit application and the original permit application application

@orv2-4969-5
Rule: Client Information is from the cv client profile

  Scenario: profile client information unchanged
    Given permit application A has the following client information:
      | Doing Business As Name | John Doe Enterprises |
      | Client Mailing Address | 123 Main St          |
      | Country                | Canada               |
      | Province               | British Columbia     |
      | City                   | Vancouver            |
      | Postal Code            | V5K0A1               |
     When a user copies permit application A to create permit application B
     Then they the following client information see: 
      | Doing Business As Name | John Doe Enterprises |
      | Client Mailing Address | 123 Main St          |
      | Country                | Canada               |
      | Province               | British Columbia     |
      | City                   | Vancouver            |

  Scenario: profile client information changed
    Given permit application A has the following client information:
      | Doing Business As Name | John Doe Enterprises |
      | Client Mailing Address | 123 Main St          |
      | Country                | Canada               |
      | Province               | British Columbia     |
      | City                   | Vancouver            |
      | Postal Code            | V5K0A1               |
      And the client information has changed to:
      | Doing Business As Name | John Doe Logistics   |
      | Client Mailing Address | 456 Elm St           |
      | Country                | Canada               |
      | Province               | Ontario              |
      | City                   | Toronto              | 
     When a user copies permit application A to create permit application B
     Then they the following client information see: 
      | Doing Business As Name | John Doe Logistics   |
      | Client Mailing Address | 456 Elm St           |
      | Country                | Canada               |
      | Province               | Ontario              |
      | City                   | Toronto              |

@orv2-4969-6
Rule: Contact Information is from the cv client profile for cv clients only

  Scenario: profile contact information unchanged
    Given permit application A has the following contact information:
      | First Name    | Jane                |
      | Last Name     | Smith               |
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |
     When a cv client copies permit application A to create permit application B
     Then they the following contact information see: 
      | First Name    | Jane                |
      | Last Name     | Smith               |
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |

  Scenario: profile contact information changed
    Given permit application A has the following contact information:
      | First Name    | Jane                |
      | Last Name     | Smith               |        
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |
      And the contact information has changed to:
      | First Name    | Janet               |
      | Last Name     | Johnson             |
      | Primary Phone | 555-987-6543        |
      | Client Email  | client@cvclient.com |
     When a cv client copies permit application A to create permit application B
     Then they the following contact information see: 
      | First Name    | Janet               |
      | Last Name     | Johnson             |
      | Primary Phone | 555-987-6543        |
      | Client Email  | client@cvclient.com |

@orv2-4969-7
Rule: Start date of the copied permit application is the current date

@orv2-4969-8
Rule: Replicate permit application duration from original permit application to copied permit application

@orv2-4969-9
Rule: Permit application expiry date is calculated based on current date and duration of the copied permit application

@orv2-4969-10
Rule: Replicate CVSE forms from original permit application to copied permit application

  Scenario: CVSE form exists
    Given permit application A has CVSE form 1
      And CVSE form 1 exists
     When a user copies permit application A to create permit application B
     Then permit application B has a CVSE form 1

  Scenario: CVSE form doesn't exist
    Given permit application A has CVSE form 1
      And CVSE form 1 no longer exists
     When a user copies permit application A to create permit application B
     Then permit application B does not have a CVSE form 1

  Scenario: new default CVSE form added  
    Given permit application A does not have CVSE form 2
      And CVSE form 2 now exists as a new default form
     When a user copies permit application A to create permit application B
     Then permit application B has CVSE form 2
      And CVSE form 2 is chosen by default 
      And CVSE form 2 cannot be deselected

  Scenario: new CVSE form added
    Given permit application A does not have CVSE form 3
      And CVSE form 3 now exists as a new non-default form
     When a user copies permit application A to create permit application B
     Then permit application B has CVSE form 3
      And CVSE form 3 can be selected if needed

@orv2-4969-11
Rule: Replicate commodity type from original permit application to copied permit application

  Scenario: commodity type exists
    Given permit application A has commodity type 1
      And commodity type 1 exists
     When a user copies permit application A to create permit application B
     Then permit application B has commodity type 1

  Scenario: commodity type doesn't exist
    Given permit application A has commodity type 1
      And commodity type 1 no longer exists
     When a user copies permit application A to create permit application B
     Then permit application B does not have commodity type 1
      And permit application B has no vehicle information 
      And permit application B has no loaded dimensions

  Scenario: commodity type name changed
    Given permit application A has commodity type 1
      And commodity type 1 name has changed to commodity type X
     When a user copies permit application A to create permit application B
     Then permit application B has commodity type X

  Scenario: new commodity type added  
    Given commodity type 2 now exists as a new type
     When a user copies permit application A to create permit application B
     Then permit application B has commodity type 2 available to select

@orv2-4969-12
Rule: Replicate load description from original permit application to copied permit application

@orv2-4969-13
Rule: There is no association between the vehicle information on the copied permit application and the cv client vehicle inventory

  Scenario: power unit removed from cv client inventory
    Given permit application A has power unit 1
      And the cv client has removed that power unit 1 from their vehicle inventory
     When a user copies permit application A to create permit application B
     Then permit application B has power unit 1

  Scenario: power unit plate changed
    Given permit application A has power unit with plate ABC123
      And the cv client has changed the plate for that power unit to XYZ789 in their vehicle inventory
     When a user copies permit application A to create permit application B
     Then permit application B has power unit with plate ABC123

@orv2-4969-14
Rule: Replicate power unit from original permit application to copied permit application

  Scenario: no longer LCV cv client
    Given permit application A has power unit type LCV
      And the cv client in no longer LCV carrier
     When a user copies permit application A to create permit application B
     Then permit application B has no vehicle information 
      And permit application B has no loaded dimensions

  Scenario: power unit type name changed
    Given permit application A has power unit type 1
      And power unit type 1 name has changed to power unit type X
     When a user copies permit application A to create permit application B
     Then permit application B has power unit type X

  Scenario: new power unit type added  
    Given power unit type 2 now exists as a new type
     When a user copies permit application A to create permit application B
     Then permit application B has power unit type 2 available to select

  Scenario: power unit type removed
    Given permit application A has power unit type 1
      And power unit type 1 no longer exists
     When a user copies permit application A to create permit application B
     Then permit application B has no vehicle information 
      And permit application B has no loaded dimensions

@orv2-4969-15
Rule: Replicate trailers from original permit application to copied permit application

  Scenario: jeep allowance changed
    Given permit application A has trailer type jeep
      And permit application type application is no longer allowed to use jeep trailers
     When a user copies permit application A to create permit application B
     Then permit application B has no trailers

  Scenario: trailer type name changed
    Given permit application A has trailer type 1
      And trailer type 1 name has changed to trailer type X
     When a user copies permit application A to create permit application B
     Then permit application B has trailer type X
    
  Scenario: booster allowance changed
    Given permit application A has trailer type booster
      And permit application type application is no longer allowed to use booster trailers
     When a user copies permit application A to create permit application B
     Then permit application B has no trailers

  Scenario: new trailer type added  
    Given trailer type 2 now exists as a new type
     When a user copies permit application A to create permit application B
     Then permit application B has trailer type 2 available to select

  Scenario: trailer type removed
    Given permit application A has trailer type 1
      And trailer type 1 no longer exists
     When a user copies permit application A to create permit application B
     Then permit application B has no trailers

@orv2-4969-16
Rule: Replicate Loaded Dimensions from original permit application to copied permit application

@orv2-4969-17
Rule: Replicate Trip Details from original permit application to copied permit application

@orv2-4969-18
Rule: Replicate Application Notes from original permit application to copied permit application