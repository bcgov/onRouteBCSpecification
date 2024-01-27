Feature: PC view suspend company
As as PC I need to be able to view a suspended company profile in onRouteBC so that I can be informed of the companies status.

@orv2-1880-1
Rule: PC can view the suspension history table

  Scenario: suspended company profile
    Given at company profile
     When they choose to view suspend details
     Then they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date of a suspend transaction record                       |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  Scenario: currently active but previously suspended
    Given at company profile
     When they choose to view suspend details
     Then they see the suspend history table with the following columns:
       | IDIR   | the idir username of a suspend transaction record              |
       | Date   | the date of a suspend transaction record                       |
       | Reason | the free text reason inputted for a suspend transaction record |
       | Status | the state change of a suspend transaction record               |

  Scenario: never suspended
    Given at company profile
     When they choose to view suspend details
     Then they do not see the option to view suspend details

@orv2-1880-2
Rule: PC can not suspend a company

  Scenario: active company
    Given at company profile
     When they choose to view suspension details
     Then they do not see the option to view suspend details


@orv2-1880-3
Rule: PC can not make changes to a suspended company profile

  Scenario: company information
    Given at company information
     When they attempt to make changes
     Then they do not have the option to edit

  Scenario: user management
    Given at user management
     When they attempt to make changes
     Then they do not have the following options available:
       | add users    |
       | edit users   |
       | delete users |

  Scenario: application in progress
    Given at applications in progress
     When they attempt to make changes
     Then they do not have the following options available:
       | start an application           |
       | choose a permit type           |
       | delete applications            |
       | choose application in progress |
       | edit application in progress   |
       | view applications in progress  |

  Scenario: vehicle inventory
    Given at vehicle inventory
     When they attempt to make changes
     Then they do not have the following options available:
       | edit power unit or trailer   |
       | add power unit or trailer    |
       | delete power unit or trailer |
       | choose power unit or trailer |

@orv2-1880-4
Rule: PC can view a suspended company's active and expired permits


