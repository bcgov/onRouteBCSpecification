Feature Route to points of interest
This could include industry sites, rest stops etc...

Rule: Submit updates to points of interest data (lat/long)

  Scenario: 
    Given 
     When 
     Then 
       | Description     | data        |
       | location of poi | lat/long    |
       | name of poi     | proper name |

Rule: Route to front door (lat/long) of point of interest (e.g. Industry Site lat/long) from nearest entry point off the MOTI demographic network

  Scenario: Direction A
    Given 
     When 
     Then 

  Scenario: Direction B
    Given 
     When 
     Then 

  Scenario: No entry off MOTI demo network exists
    Given 
     When 
     Then 

  Scenario: Entry exists but unknown path
    Given 
     When 
     Then 

Rule: Route off MOTI demographic network to front door of destination displays as a dotted line


Rule: Input point of interest name as an origin or destination when attempting to generate a route auto-completes the name 