Feature: Staff add LOA(s)
  As staff I need to add a letter of authorization (LOA) to a CV Client profile so that these CV Clients can apply for permits using the special authorizations granted by their LOA(s)

Staff = SA, HQA

@orv2-1152-1
Rule: Staff can add an LOA to a CV Client profile

  Scenario: add an LOA
    Given authenticated staff
     When staff choose to add an LOA
     Then they are directed to the first step of the add LOA workflow

@orv2-1152-2
Rule: Staff must designate at least one permit type to the LOA

  Scenario: none chosen
    Given staff do not choose a permit type
     When they continue to the next step in the workflow
     Then they cannot continue
      And they see "Select at least one item"
      And the mandatory field is indicated

@orv2-1152-3
Rule: Staff must input an LOA start date

  Scenario: no start date
    Given staff has not inputted a start date
     When they continue to the next step in the workflow
      And they see "This is a required field"
      And the mandatory field is indicated

  Scenario: empty expiry
    Given expiry date is empty
     When staff choose a start date
     Then any date is allowed

  Scenario: start date after expiry
    Given expiry date is 01/01/2024
     When staff choose the start date 01/02/2024
     Then they cannot choose the date

  Scenario: never expires
    Given staff have chosen LOA never expires
     When they choose to continue
     Then they see "This is a required field"

@orv2-1152-4
Rule: Staff must input an LOA expiry date that is not before the LOA start date

  Scenario: no expiry date
    Given staff has not inputted a expiry date
     When they continue to the next step in the workflow
      And they see "This is a required field"
      And the mandatory field is indicated

  Scenario: expiry before start date
    Given start date is 01/01/2024
     When staff choose the expiry date 12/31/2023
     Then they cannot choose the date
      And they see "Expiry cannot be before Start Date"

@orv2-1152-5
Rule: Staff can designate an LOA as non-expiring

  Scenario: final step of LOA workflow
     When staff are at the final step of the LOA workflow
     Then they see "LOA never expires"

  Scenario: viewing active LOA's list
    Given active LOA(s) exist
     When LOA is non expiring
     Then Never expires is shown

@orv2-1152-6
Rule: Staff must upload a LOA pdf file

  Scenario: no file uploaded
    Given staff has not uploaded a file
     When they continue to the next step in the workflow
      And they see "The LOA must be uploaded"

  Scenario: upload
     When staff choose to upload a file
     Then they can choose a file from their local file system to upload

@orv2-1152-7
Rule: Staff are shown the uploaded LOA pdf filename and file size  

  Scenario: successful upload
     When staff upload a file
     Then they see the following:
       | filname             |
       | file type extension |
       | filesize in MB      |
       | delete option       |

  Scenario: final step of LOA workflow
     When staff are at the final step of the LOA workflow
     Then they see only the filename and file type extension

@orv2-1152-8
Rule: An LOA pdf file must be uploaded

  Scenario: not pdf
    Given staff are choosing a file to upload
     When they choose a .txt file 
     Then they are directed to the first step of the LOA workflow
      And they see "File format not supported"

@orv2-1152-9
Rule: The max file size for an LOA pdf file is 10MB

  Scenario: larger then 10MB
    Given staff are choosing a file to upload
     When they choose a file that is 11MB
     Then they are directed to the first step of the LOA workflow
      And they see "File exceeds maximum size"

@orv2-1152-10
Rule: Staff can delete an uploaded LOA pdf file

  Scenario: delete file warning
    Given a file is uploaded
     When staff choose delete an uploaded pdf file
     Then they see "Delete item (s)?, Are you sure you want to delete this?"

  Scenario: delete file
     When staff choose to delete file
     Then the file is deleted
      And they are directed to the first step of the workflow
      And they can upload a new file

  Scenario: cancel delete file
     When staff choose to cancel delete file
     Then the file is deleted
      And they are directed to the first step of the workflow

@orv2-1152-11
Rule: Staff can input free text notes

@orv2-1152-12
Rule: Staff are shown the vehicle inventory information box

@orv2-1152-13
Rule: Staff must designate one or more vehicles to the LOA

  Scenario: none chosen
    Given staff do not choose a vehicle
     When they continue to the next step in the workflow
     Then they cannot continue
      And they see "Select at least one item"
      And the mandatory field is indicated

@orv2-1152-14
Rule: Staff can search for a power unit or a trailer in the CV Client vehicle inventory

  Scenario: search power units by VIN
    Given staff choose to search <power units>
     When they input the <VIN>
     Then they see <power units>

   Examples:
   | VIN    | power units |
   | 123    | 123456      |
   | 123456 | 123456      |
   | 456    | 123456      |

  Scenario: search trailers by VIN
    Given staff choose to search <trailers>
     When they input the <VIN>
     Then they see <trailers>

   Examples:
   | VIN    | power units |
   | 123    | 123456      |
   | 123456 | 123456      |
   | 456    | 123456      |

@orv2-1152-15
Rule: A VIN can be designated to one or more LOA(s) 

@orv2-1152-16
Rule: The list of vehicles are paginated

@orv2-1152-17
Rule: Staff are shown all data submitted in the LOA workflow for review 

  Scenario: multiple per types designated
     When staff are at the last step of the LOA workflow
     Then they see the following:
       | data                  | description                                               |
       | permit type(s)        | list of chosen permit type(s) separated by commas         |
       | start date            | the chosen start date                                     |
       | expiry date           | the chosen expiry date or LOA never expires (if chosen)   |
       | LOA                   | the filename and file type extension of the uploaded file |
       | additional notes      | shown only if inputted free text notes exist              |
       | designated vehicle(s) | list of chosen vehicles                                   |

@orv2-1152-18
Rule: The LOA is active when the add LOA workflow is completed

  Scenario: workflow cancelled
    Given staff are at any step in the LOA workflow
     When they choose to cancel
     Then the LOA is not saved
      And they are directed to special authorizations

@orv2-1152-19
Rule: Show LOA added notification

  Scenario: workflow complete
     When staff complete the LOA workflow
     Then they are directed to special authorizations
      And they see "LOA Added" notification
      And the LOA is shown in the active LOA list

