Feature: Choose a permit application
   As a user I want to choose a permit application so that I can receive the correct permit for my load and vehicle.

User = CA, PA, SA, PC, CTPO, Trainee

@orv2-823-1 @orv2-2574 @orv2-2388 @orv2-2459
Rule: A user can choose from a list of available permits to apply for of available permits is organized in a hierarchy

  Scenario: first level
     When a user choose to view the permit list
     Then they see the following:
      | Term                    |
      | Single Trip             |
      | Non-resident            |
      | Motive Fuel User Permit |

  Scenario: second level term
     When a user chooses to view term
     Then they see the following:
       | Term Oversize    |
       | Term Overweight  |
       | Highway Crossing |

  Scenario: second level single trip
     When a user chooses to view single trip
     Then they see the following:
       | Single Trip Oversize                   |
       | Single Trip Oversize Overweight        |
       | Single Trip Overweight                 |
       | Extra Provincial Temp Operating Permit |
       | Empty - Single Trip Over Length 27.5   |
       | Increased GVW                          |
       | Rig Move                               |
       | Motive Fuel                            |

  Scenario: second level non-resident
     When a user chooses to view non-resident
     Then they see the following:
       | Quarterly Non-Resident                |
       | Single Trip Non-Resident              |
       | Quarterly ICBC Basic Insurance (FR)   |
       | Single Trip ICBC Basic Insurance (FR) |

@orv2-823-2 @orv2-2574 @orv2-2388 @orv2-2459
Rule: The chosen permit category and type are shown after shown after choosing

  Scenario: permit type and name longer than field space
     When a user chooses a permit category and permit type name
     Then they see the <permit category> and <permit type name> concatenated
     And the <permit type name> is truncated with "..." when the concatenated name is longer than availavle field space

   Examples:
     | permit category | permit type name    |
     | Single Trip     | Extra Provincial... |
     | Non-Resident    | Quarterly ICBC I... |

@orv2-823-2 @orv2-2574 @orv2-2388 @orv2-2459
 Rule: If no application is selected, the user cannot start an application

  Scenario: no permit chosen
    Given a user has not chosen a permit
     When they choose to start an application
     Then they see "Select a permit type."
      And they can not continue
      And the mandatory field is indicated

