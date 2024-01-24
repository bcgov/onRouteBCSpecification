Feature: Choose a permit application
   As a CV Client I want to choose a permit application that I need to complete and submit so that I can receive the correct permit for my load and vehicle.
  
  @orv2-823-1
  Scenario: Permit List
    Given A CV Client is at the "Permits" page
     When They choose to select a permit to apply for
     Then they see the following list of permit types categories and permit types
       | permit type categories | permit types |
       | Oversize               | Term         |

  @orv2-823-2
  Scenario: Start Permit Application
    Given A CV Client is at the "Permits" page
      And They have choosen a permit to apply for
     When Start the application
     Then they are directed to the "Permit Application" page

