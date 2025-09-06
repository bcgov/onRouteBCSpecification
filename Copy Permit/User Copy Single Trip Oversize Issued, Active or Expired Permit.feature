Feature: User Copy Single Trip Oversize Issued, Active or Expired Permit

user = PC, SA, TRAIN, CTPO, CA, PA
staff = PC, SA, TRAIN, CTPO
cv client = CA, PA

@orv2-4715
Rule: Client Information is from the cv client profile

  Scenario: profile client information unchanged
    Given permit A has the following client information:
      | Doing Business As Name | John Doe Enterprises |
      | Client Mailing Address | 123 Main St          |
      | Country                | Canada               |
      | Province               | British Columbia     |
      | City                   | Vancouver            |
      | Postal Code            | V5K0A1               |
     When a user copies permit A to create permit B
     Then they the following client information see: 
      | Doing Business As Name | John Doe Enterprises |
      | Client Mailing Address | 123 Main St          |
      | Country                | Canada               |
      | Province               | British Columbia     |
      | City                   | Vancouver            |

  Scenario: profile client information changed
    Given permit A has the following client information:
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
     When a user copies permit A to create permit B
     Then they the following client information see: 
      | Doing Business As Name | John Doe Logistics   |
      | Client Mailing Address | 456 Elm St           |
      | Country                | Canada               |
      | Province               | Ontario              |
      | City                   | Toronto              |

@orv2-4715
Rule: Contact Information is from the cv client profile for cv clients only

  Scenario: profile contact information unchanged
    Given permit A has the following contact information:
      | First Name    | Jane                |
      | Last Name     | Smith               |
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |
     When a cv client copies permit A to create permit B
     Then they the following contact information see: 
      | First Name    | Jane                |
      | Last Name     | Smith               |
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |

  Scenario: profile contact information changed
    Given permit A has the following contact information:
      | First Name    | Jane                |
      | Last Name     | Smith               |        
      | Primary Phone | 555-123-4567        |
      | Client Email  | client@cvclient.com |
      And the contact information has changed to:
      | First Name    | Janet               |
      | Last Name     | Johnson             |
      | Primary Phone | 555-987-6543        |
      | Client Email  | client@cvclient.com |
     When a cv client copies permit A to create permit B
     Then they the following contact information see: 
      | First Name    | Janet               |
      | Last Name     | Johnson             |
      | Primary Phone | 555-987-6543        |
      | Client Email  | client@cvclient.com |

@orv2-4715
Rule: Start date is current date

@orv2-4715
Rule: Replicate permit duration from original permit to copied permit

@orv2-4715
Rule: Permit expiry date is calculated based on current date and duration of the copied permit

@orv2-4715
Rule: Replicate CVSE forms from original permit to copied permit

  Scenario: CVSE form exists
    Given permit A has CVSE form 1
      And CVSE form 1 exists
     When a user copies permit A to create permit B
     Then permit B has a CVSE form 1

  Scenario: CVSE form doesn't exist
    Given permit A has CVSE form 1
      And CVSE form 1 no longer exists
     When a user copies permit A to create permit B
     Then permit B does not have a CVSE form 1

  Scenario: new default CVSE form added  
    Given permit A does not have CVSE form 2
      And CVSE form 2 now exists as a new default form
     When a user copies permit A to create permit B
     Then permit B has CVSE form 2
      And CVSE form 2 is chosen by default 
      And CVSE form 2 cannot be deselected

  Scenario: new CVSE form added
    Given permit A does not have CVSE form 3
      And CVSE form 3 now exists as a new non-default form
     When a user copies permit A to create permit B
     Then permit B has CVSE form 3
      And CVSE form 3 can be selected if needed

@orv2-4715
Rule: Replicate commodity type from original permit to copied permit

  Scenario: commodity type exists
    Given permit A has commodity type 1
      And commodity type 1 exists
     When a user copies permit A to create permit B
     Then permit B has commodity type 1

  Scenario: commodity type doesn't exist
    Given permit A has commodity type 1
      And commodity type 1 no longer exists
     When a user copies permit A to create permit B
     Then permit B does not have commodity type 1
      And permit B has no vehicle information 
      And permit B has no loaded dimensions

  Scenario: commodity type name changed
    Given permit A has commodity type 1
      And commodity type 1 name has changed to commodity type X
     When a user copies permit A to create permit B
     Then permit B has commodity type X

  Scenario: new commodity type added  
    Given commodity type 2 now exists as a new type
     When a user copies permit A to create permit B
     Then permit B has commodity type 2 available to select

@orv2-4715
Rule: Replicate load description from original permit to copied permit

@orv2-4715
Rule: Replicate Loaded Dimensions from original permit to copied permit

@orv2-4715
Rule: Replicate power unit from original permit to copied permit

  Scenario: original permit has power unti from inventory
    Given 
     When 
     Then 






@orv2-4715
Rule: Replicate Trip Details from original permit to copied permit

@orv2-4715
Rule: Replicate Application Notes from original permit to copied permit