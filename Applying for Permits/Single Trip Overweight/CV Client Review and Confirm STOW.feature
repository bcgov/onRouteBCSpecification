
@orv2-5985 https://onroutebc.atlassian.net/browse/ORV2-5985
Feature: As a CV Client I need to be able to review and confirm my STOW permit application details so that I can submit it for review by the PPC.

CV Client = CA, PA

# Notes
 # see User Review and Confirm STOW.feature for user review and confirm details

# Application Submission
 @orv2-5985-1
 Rule: CV Clients can only submit a STOW permit application for review by the PPC

 @orv2-5985-2
 Rule: CV Clients can submit a STOW permit application with compliance warnings for review by the PPC

   Scenario: compliance warnings
    Given a user has continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they see: "Review Compliance Requirements Wheelbase for Axle Unit X and Axle Unit Y is between 6.2m and 7.2m. Semi-Trailer wheelbase must be within dimensions table found in CTPM 5.3.7.A."
     And they can submit the STOW permit application for review by the PPC

 @orv2-5985-3
 Rule: CV Client cannot submit a STOW permit application with violations for review by the PPC unless an extraordinary load approval number has been inputted

   Scenario: violations and extraordinary load approval number
    Given a user have inputted an extraordinary load approval number
      And the permit application has violations
      And they have continued from the "Permit Application" page
     When they arrive at the "Review and Confirm Details" page
     Then they can submit the STOW permit application for review by the PPC

  Scenario: violations and no extraordinary load approval number
    Given a user is at the "Permit Application" page
      And they have not inputted an extraordinary load approval number
      And the permit application has violations
     When they attempt to continue to the  "Review and Confirm Details" page
     Then they cannot continue to the "Review and Confirm Details" page
      And they see are directed to the first error on the "Permit Application" page

 @orv2-5985-4
 Rule: CV Clients are directed to applications in review after submitting the application for review
