Feature: Generate Permit Payment Receipt

Rule: Generate unique permit payment receipt number

@orv2-1176-1
  Scenario: 
    Given the CV Client has successfully purchased a permit
     When they are at the "Success" page
     Then the permit payment reciept number is generated that contains the <current date>-<table index/primary key>
      And the <table index/primary key> starts at 00000001
    
     Examples:
     | current date | <table index/primary key> |
     | 20230717     | 00000001                  |
     | 20230717     | 00000002                  |
     | 20230717     | 00000003                  |


Rule: Save permit payment receipt pdf using the generated permit payment receipt number as the filename

@orv2-1066-1
  Scenario: View permit payment receipt
    Given the CV Client has successfully purchased a permit
      And they are at the "Success" page
     When they choose to view the permit payment receipt 
     Then the generated permit payment receipt pdf is displayed
      And the <file name> is the <receipt number>

      Examples:
         | receipt number     | file name              |
         | 20230717-00000001  | 20230717-00000001.pdf  |
         | 20230915-00001000  | 20230915-00001000.pdf  |
         | 202301022-00001500 | 202301022-00001500.pdf |