Feature: Complete Contact Details
    As a CV Client I want to review and update my permit contact details so that I can receive a permit with valid contact information.

  @orv2-549
  Scenario: View company information
    Given the CV Client is at the "Permits" page
     When they choose to start a permit
     Then they are directed to the "Permit Application" page
      And they see the following header information:
        | permit type name                          |
        | application number                        |
        | company name                              |
        | onRouteBC client number                   |
        | company  information confirmation message |
        | company mailing address                   |

  @orv2-549  
  Scenario: View contact information 
    Given the CV Client is at the "Permit Application" page
     When they view "Contact Information"
     Then they see contact details from their "My Information" page:
       | First Name      |
       | Last Name       |
       | Primary Phone   |
       | Ext             |
       | Alternate Phone |
       | Ext             |
       | Email           |
       | Fax             |
     And they see "The permit will be sent..." information box

  @orv2-549  
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
     Then these changes to "Contact Information" apply only to this permit and not the "Contact Information" previously saved in the database

  Scenario: ??CV Client changes the email to the email associated with "Company Profile" will it send two emails?
