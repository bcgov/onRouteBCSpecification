@e2e3
Feature: Complete Contact Details
    As a CV Client I want to review and update my permit contact details so that I can receive a permit with valid contact information.

  @orv2-549-1
  Scenario: View company information
    Given the CV Client is at the "Permits" page
     When they choose to start a permit
     Then they are directed to the "Permit Application" page
      And they see the following header information:
        | permit type name                          |
        | application number (Empty)                |
        | company name                              |
        | onRouteBC client number                   |
        | company  information confirmation message |
        | company mailing address                   |

  @orv2-549-2
  Scenario: View profile contact information 
    Given the CV Client is at the "Permit Application" page
     When they view "Contact Information"
     Then they see contact details from their company profile:
       | First Name       | from my information      |
       | Last Name        | from my information      |
       | Primary Phone    | from my information      |
       | Ext              | from my information      |
       | Alternate Phone  | from my information      |
       | Ext              | from my information      |
       | Additional Email | from my information      |
       | Fax              | from my information      |
       | company email    | from company information |
     And company email is read only
     And they see "The permit will be sent..." information box
 
  @orv2-549-3
  Rule: CA can edit company email
  
  Scenario: Update contact information 
    Given the CV Client is at the "Permit Application" page
     When they update "Contact Information":
       | First Name      |
       | Last Name       |
       | Primary Phone   |
       | Ext             |
       | Alternate Phone |
       | Ext             |
       | Email           |
       | Fax             |
     Then the "Contact Information" reflects their changes
     And these changes to "Contact Information" apply only to this permit and not the "Contact Information" previously saved in the database

@orv2-549-4
Scenario: Indicate mandatory "Contact Information" fields    
    Given the CV Client Admin or User is editing their "Contact Information"
    When they do not enter valid data into a <mandatory field>  
    And they choose to continue  
    Then they see <mandatory field error message>     
    And they cannot save their changes

    Examples:  
      | mandatory field | mandatory field error message | 
      | First Name      | This is a required field      | 
      | Last Name       | This is a required field      |
      | Primary Phone   | This is a required field      | 
      | Email           | This is a required field      | 