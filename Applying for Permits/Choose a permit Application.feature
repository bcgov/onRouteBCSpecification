Feature: Choose a permit application
   As a user I want to choose a permit application so that I can receive the correct permit for my load and vehicle.
  
  @orv2-823-1 @orv2-2574 @orv2-2388
  Scenario: Permit List
    Given a user is at the "Permits" page
     When They choose to select a permit to apply for
     Then they see the following list of permit types categories and permit types
       | permit type categories | permit types |
       | Oversize               | Term         |
       | Overweight             | Term         |
       | Oversize               | Single-trip  |

  @orv2-823-2 @orv2-2574 @orv2-2388
  Scenario: Start Permit Application
    Given a user is at the "Permits" page
      And They have chosen a permit to apply for
     When Start the application
     Then they are directed to the "Permit Application" page

