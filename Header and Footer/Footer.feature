Feature: Footer

Rule: A user can can navigate to various pages

  Scenario: choose a navigation option
    Given a user is at the onRouteBC webapp
     When they choose to navigate to an option in the footer
     Then they are directed to the locations as follows:
        | option        | directs to                                                    |
        | home          | onRouteBC home page                                           |
        | disclaimer    | the Government of British Columbia disclaimer page            |
        | privacy       | the Government of British Columbia privacy page               |
        | accessibility | the Government of British Columbia accessible government page |
        | copyright     | the Government of British Columbia copyright page             |
        | contact us    | the onRouteBC home page                                       |

Rule: Choosing a navigation option opens the linked page in a new browser tab