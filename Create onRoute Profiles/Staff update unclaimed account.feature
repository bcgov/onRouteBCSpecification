Feature: Staff update existing onRouteBC profile
 As staff I want to find an unclaimed CV Client profile and update the CV Client contact details prior to viewing the profile, so that I can ensure contacts details are current and I can purchase permits on behalf of the CV Client.

User = PC, SA, Train, CTPO

# if no BCeID and company claimed by staff then a new cv client user goes through the challenge workflow
# can update company name and email address

@orv2-1637-1, @orv2-3228
Rule: A user can update existing onRouteBC profile on behalf of a CV Client

  Scenario: unclaimed profile
    Given staff find an unclaimed onRouteBC profile
     When they choose to view the profile
     Then they are directed to update the profile contact details

  Scenario: mandatory fields
     When a user does not input data into any of the following mandatory fields:
       | contact details   |
       | Client Name       |
       | First Name        |
       | Last Name         |
       | Email             |
       | Primary Phone     |
       | Address (Line 1)  |
       | Country           |
       | Province / State  |
       | City              |
       | Postal / Zip Code |
     Then they see "This is a required field" at each field with invalid data
      And fields with no data are indicated

  Scenario: finish update
    Given a user has completed all mandatory fields
     When they choose to finish
     Then they are directed to the the profile successfully set up page

@orv2-481-10, @orv2-3322-14, @orv2-3228
Rule: users have the option to view the profile or apply for a permit after successful profile completion

 Scenario: choose to apply
      When they choose to apply for a permit
      Then they are directed to applications in progress

  Scenario: choose view profile
     When a user chooses to view the profile
     Then they are directed to the profile page company information tab

