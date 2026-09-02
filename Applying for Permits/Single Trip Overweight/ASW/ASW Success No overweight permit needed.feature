@orv2-5527 https://moti-imb.atlassian.net/browse/ORV2-5527
Feature: As a user I want to be informed that I do not require a STOW permit based on my inputted commodity, vehicle configuration and spacings and weights, so that I know why I cannot proceed with purchasing a STOW permit.

users = PC, SA, TRAIN, CTPO, CA, PA

@orv2-5527-1
Rule: If the user inputs a commodity, vehicle configuration and spacings and weights that are compliant with policy and regulations such that a STOW permit is not required, then the user is informed that they do not require a STOW permit

  Scenario: no violations or overload attempt continue
    Given the user is applying for a single trip overweight permit
      And the user inputs a commodity, vehicle configuration and spacings and weights that are compliant with policy and regulations such that a STOW permit is not required
     When the user attempts to continue to review and confirm
     Then they see the modal with the message "This permit type is not required Please note that you may require a different permit type. Refer to the Commercial Transport Procedures Manual, or contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca"
     And the user is informed on the application form "You may require a different permit type Refer to the Commercial Transport Procedures Manual, or contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email: ppcpermit@gov.bc.ca"
      And the user is not able to continue to review and confirm
  
  Scenario: close modal
     When the user closes the modal
     Then the modal is no longer visible
     And they remain on the application form

  Scenario: no violations or overload calculate
    Given the user is applying for a single trip overweight permit
      And the user inputs a commodity, vehicle configuration and spacings and weights that are compliant with policy and regulations such that a STOW permit is not required
     When they choose to calculate the ASW table
     Then the user is informed on the application form "You may require a different permit type Refer to the Commercial Transport Procedures Manual, or contact the Provincial Permit Centre at Toll-free: 1-800-559-9688 or Email:
 




