Feature: Staff Complete Contact Details
    As a PPC SA or PC I need to complete contact details input so that I can ensure valid contacts details form a part of the permit.

@orv2-1384-
Rule: Staff see company profile contact details

  Scenario: View company information
    Given Staff is at the "Permits" page
     When they choose to start a permit
     Then they are directed to the "Permit Application" page
      And they see the following header information:
        | permit type name                          |
        | application number (Empty)                |
        | company name                              |
        | onRouteBC client number                   |
        | company  information confirmation message |
        | doing business as                         |
        | company mailing address                   |

  Scenario: View contact information 
    Given Staff is at "Contact Information" in the application
     When they view "Contact Information"
     Then they see the following read-only contact information from the CV Client profile:
       | company email |
     And they see "The permit will be sent..." information box

@orv-1384-
Rule: Staff can update application contact details

  Scenario: Update contact information 
    Given Staff is at the "Permit Application" page
     When they update "Contact Information":
       | First Name       |
       | Last Name        |
       | Primary Phone    |
       | Ext              |
       | Alternate Phone  |
       | Ext              |
       | Additional Email |
       | Fax              |
     Then the "Contact Information" reflects their changes
     And these changes to "Contact Information" apply only to this permit

@orv-1384-
Rule: Staff must complete mandatory contact details fields

Scenario: Indicate mandatory "Contact Information" fields    
    Given Staff is editing their "Contact Information"
    When they do not enter valid data into a <mandatory field>  
    And they choose to continue  
    Then they see <mandatory field error message>     
    And they cannot save their changes

    Examples:  
      | mandatory field | mandatory field error message | 
      | First Name      | This is a required field      | 
      | Last Name       | This is a required field      |
      | Primary Phone   | This is a required field      | 