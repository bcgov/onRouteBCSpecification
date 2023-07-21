Feature: Generate Permit Payment Receipt

Rule: Generate unique permit payment receipt number

@orv2-1176
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