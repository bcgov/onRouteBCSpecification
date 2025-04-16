Feature: Staff view/edit company information
  As a PPC SA or PC I need to manage "Company Information" so that I can maintain my company contact details for CV Clients.

Background: @orv2-354

Staff = PC, SA, TRAIN, FIN, CTPO, EO, HQA

@orv2-1587-0 @orv2-4002-1 @orv2-3835-29
Rule: Staff can view "Company Information"

 Scenario: View "Company Information"
     When staff choose the "Profile" page
     Then they are directed to the "Company Information" tab
      And they only see fields that contain data
      But they always see section headers:
        | Doing Business As (DBA) |
        | Company Mailing Address |
        | Company Contact Details |
        | Company Primary Contact |

@orv2-1587-1 
Rule: BCeID company data is displayed

 Scenario: View BCeID company data
     Given Staff is at "Company Information"
     When they are viewing the "Company Information" page <BCeID data fields>
     Then they see <BCeID Data>

     Examples:
       | BCeID Data fields  | BCeID Data          | 
       | Company Legal Name | bceid_business_name | 
       | Email              | BCeID email         |

@orv2-1587-2 @orv2-1521-2 @orv2-3835-8 @orv2-2315-1
Rule: only authorized staff can edit company profile contact details

  Scenario: authorized
     When PC, SA, TRAIN, CTPO chooses to edit company information
     Then they see the option to edit company information

  Scenario: not authorized
     When FIN, EO, HQA chooses to edit company information
     Then they do not see the option to edit company information

 Scenario: editable information
     Given PC, SA, TRAIN, CTPO chooses to edit a "Company Information"
     And they are at the "Company Information" page
     When they select "Edit"
     Then they are directed to the "Company Information" edit page
     And all <my company fields> are displayed
     And have <editable> restrictions 
   
     Examples: 
       | my company fields    | editable |
       | onRouteBC Client No. | No       |
       | Company Legal Name   | Yes      |
       | DBA                  | Yes      |
       | Address Line 1       | Yes      |
       | Address Line 2       | Yes      |
       | City                 | Yes      |
       | Province/State       | Yes      |
       | Postal Code/Zip Code | Yes      |
       | Country              | Yes      |
       | Phone                | Yes      |
       | Ext                  | Yes      |
       | Fax                  | Yes      |
       | Email                | Yes      |
       | First Name           | Yes      |
       | Last Name            | Yes      |
       | Phone                | Yes      |
       | Ext                  | Yes      |
       | Email                | Yes      |
       | Alternative Phone    | Yes      |
       | City                 | Yes      |
       | Province/State       | Yes      | 

 Scenario: Save edits to "Company Information"
     Given PC, SA, TRAIN, CTPO has saved 
     Then the changes are saved 
     And they are directed to the "Company Information" page
     And their changes are displayed
     And they see "Changed Saved" notification

 Scenario: Edit company information navigate away from "Company Information" page
     Given PC, SA, TRAIN, CTPO is at "Company Information"
     When they make changes to their "Company Information"
     And they navigate away from the "Company Information"
     Then the changes are not saved 

@orv2-1587-3 @orv2-1521-3
Rule: There are mandatory fields

 Scenario: Indicate mandatory fields    
     Given PC, SA, TRAIN, CTPO is editing their "Company Information"
     When they do not enter valid data into a <mandatory field>  
     And they choose to save changes    
     Then they see <mandatory field error message>     
     And they cannot save their changes

     Examples:  
       | mandatory field                        | mandatory field error message |
       | company name                           | This is a required field.     |
       | Address Line 1                         | This is a required field.     |
       | City                                   | This is a required field.     |
       | Province/Sate                          | This is a required field.     |
       | Postal Code/Zip Code                   | This is a required field.     |
       | Country                                | This is a required field.     |
       | Phone                                  | This is a required field.     |
       | Email                                  | This is a required field.     |
       | Primary Contact First Name             | This is a required field.     |
       | Primary Contact Last Name              | This is a required field.     |
       | Primary Contact Primary Phone          | This is a required field.     |
       | Primary Contact Primary Country        | This is a required field.     |
       | Primary Contact Email                  | This is a required field.     |
       | Primary Contact Primary Province/State | This is a required field.     |
       | Primary Contact City                   | This is a required field.     |

@orv2-1587-4 @orv2-3835-9
Rule: only authorized staff can cancel edit company

 Scenario: Cancel edit "Company Information"
     Given PC, SA, TRAIN, CTPO is editing "Company Information"
     When they select "Cancel"
     Then the changes are not saved 
     And they are directed to the "Company Information" page










